
/*
 *      $Id: Machine.c,v 1.2 1993-10-06 22:54:22 ethan Exp $
 */
/************************************************************************
*									*
*			     Copyright (C)  1993			*
*	     University Corporation for Atmospheric Research		*
*			     All Rights Reserved			*
*									*
************************************************************************/
/*
 *	File:		Machine.c
 *
 *	Author:		Ethan Alpert
 *			National Center for Atmospheric Research
 *			PO 3000, Boulder, Colorado
 *
 *	Date:		Wed Jul 7 09:08:34 MDT 1993
 *
 *	Description:	Contains functions for manipulating stacks, frames
 *			and the instruction list.
 */
#include <stdio.h>
#include <ncarg/hlu/hlu.h>
#include <defs.h>
#include <Symbol.h>
#include <errno.h>
#include <OpsList.h>
#include <Machine.h>

/*
* This is done so stack size and machine size can be configured at 
* compile time
*/
#ifndef NCL_STACK_SIZE
#define NCL_STACK_SIZE 2048
#endif

#ifndef NCL_MACHINE_SIZE
#define NCL_MACHINE_SIZE 4096
#endif

/*
* Making this smaller because functions will generally be smaller than 
* whole programs.
*/
#ifndef NCL_FUNC_MACHINE_SIZE
#define NCL_FUNC_MACHINE_SIZE 512
#endif

NclStackEntry thestack[NCL_STACK_SIZE];

char *ops_strings[NUM_OPERATORS];

_NclMachineStack *mstk;

NclFrame *fp;
NclStackEntry *sb;
unsigned int current_scope_level = 0;

static SetUpOpsStrings() {
	ops_strings[NOOP] = "NOOP";
	ops_strings[STOPSEQ] = "STOPSEQ";
	ops_strings[JMP] = "JMP";
	ops_strings[JMPFALSE] = "JMPFALSE";
	ops_strings[IF_OP] = "IF_OP";
	ops_strings[CREATE_OBJ_OP] = "CREATE_OBJ_OP";
	ops_strings[SET_OBJ_OP] = "SET_OBJ_OP";
	ops_strings[GET_OBJ_OP] = "GET_OBJ_OP";
	ops_strings[PUSH_STRING_LIT_OP] = "PUSH_STRING_LIT_OP";
	ops_strings[PUSH_VAR_OP] = "PUSH_VAR_OP";
	ops_strings[DO_FROM_TO_OP] = "DO_FROM_TO_OP";
	ops_strings[DO_FROM_TO_STRIDE_OP] = "DO_FROM_TO_STRIDE_OP";
	ops_strings[ASSIGN_OP] = "ASSIGN_OP";
	ops_strings[NAMED_INT_SUBSCRIPT_OP] = "NAMED_INT_SUBSCRIPT_OP";
	ops_strings[INT_SUBSCRIPT_OP] = "INT_SUBSCRIPT_OP";
	ops_strings[NAMED_COORD_SUBSCRIPT_OP] = "NAMED_COORD_SUBSCRIPT_OP";
	ops_strings[COORD_SUBSCRIPT_OP] = "COORD_SUBSCRIPT_OP";
	ops_strings[SINGLE_INDEX_OP] = "SINGLE_INDEX_OP";
	ops_strings[DEFAULT_RANGE_OP] = "DEFAULT_RANGE_OP";
	ops_strings[RETURN_OP] = "RETURN_OP";
	ops_strings[IF_THEN_OP] = "IF_THEN_OP";
	ops_strings[RANGE_INDEX_OP] = "RANGE_INDEX_OP";
	ops_strings[NEG_OP] = "NEG_OP";
	ops_strings[NOT_OP] = "NOT_OP";
	ops_strings[MOD_OP] = "MOD_OP";
	ops_strings[OR_OP] = "OR_OP";
	ops_strings[AND_OP] = "AND_OP";
	ops_strings[XOR_OP] = "XOR_OP";
	ops_strings[LTSEL_OP] = "LTSEL_OP";
	ops_strings[GTSEL_OP] = "GTSEL_OP";
	ops_strings[PLUS_OP] = "PLUS_OP";
	ops_strings[MINUS_OP] = "MINUS_OP";
	ops_strings[MUL_OP] = "MUL_OP";
	ops_strings[MAT_OP] = "MAT_OP";
	ops_strings[DIV_OP] = "DIV_OP";
	ops_strings[EXP_OP] = "EXP_OP";
	ops_strings[LE_OP] = "LE_OP";
	ops_strings[GE_OP] = "GE_OP";
	ops_strings[GT_OP] = "GT_OP";
	ops_strings[LT_OP] = "LT_OP";
	ops_strings[EQ_OP] = "EQ_OP";
	ops_strings[NE_OP] = "NE_OP";
	ops_strings[PUSH_REAL_LIT_OP] = "PUSH_REAL_LIT_OP";
	ops_strings[PUSH_INT_LIT_OP] = "PUSH_INT_LIT_OP";
	ops_strings[ARRAY_LIT_OP] = "ARRAY_LIT_OP";
	ops_strings[DO_WHILE_OP] = "DO_WHILE_OP";
	ops_strings[SUBSCRIPTED_VAR_OP] = "SUBSCRIPTED_VAR_OP";
	ops_strings[PUSH_FILE_OP] = "PUSH_FILE_OP";
	ops_strings[SUBSCRIPTED_FILE_VAR_OP] = "SUBSCRIPTED_FILE_VAR_OP";
	ops_strings[PUSH_FILE_VAR_OP] = "PUSH_FILE_VAR_OP";
	ops_strings[FILE_DIMNUM_OP] = "FILE_DIMNUM_OP";
	ops_strings[FILE_DIMNAME_OP] = "FILE_DIMNAME_OP";
	ops_strings[FILE_ATT_OP] = "FILE_ATT_OP";
	ops_strings[SUBSCRIPTED_FILE_ATT_OP] = "SUBSCRIPTED_FILE_ATT_OP";
	ops_strings[SUBSCRIPTED_VARATT_OP] = "SUBSCRIPTED_VARATT_OP";
	ops_strings[VAR_DIMNUM_OP]= "VAR_DIMNUM_OP";
	ops_strings[VARATT_OP] = "VARATT_OP";
	ops_strings[VAR_DIMNAME_OP] = "VAR_DIMNAME_OP";
	ops_strings[VAR_COORD_OP] = "VAR_COORD_OP";
	ops_strings[SUBSCRIPTED_VAR_COORD_OP] = "SUBSCRIPTED_VAR_COORD_OP";
	ops_strings[LINE] = "LINE";
	ops_strings[FPDEF] = "FPDEF";
	ops_strings[NEW_FRAME_OP] = "NEW_FRAME_OP";
	ops_strings[BREAK_OP] = "BREAK_OP";
	ops_strings[CONTINUE_OP] = "CONTINUE_OP";
	ops_strings[ENDSTMNT_OP] = "ENDSTMNT_OP";
	ops_strings[FUNC_CALL_OP] = "FUNC_CALL_OP";
	ops_strings[PROC_CALL_OP] = "PROC_CALL_OP";
	ops_strings[BFUNC_CALL_OP] = "BFUNC_CALL_OP";
	ops_strings[BPROC_CALL_OP] = "BPROC_CALL_OP";
}

void _NclNewMachine
#if __STDC__
(void)
#else
()
#endif
{
	_NclMachineStack* tmp;
	tmp = (_NclMachineStack*)NclMalloc((unsigned)sizeof(_NclMachineStack));
	tmp->themachine = (NclValue*)NclCalloc(NCL_FUNC_MACHINE_SIZE,sizeof(NclValue));
	tmp->thefiles = (char**)NclCalloc(NCL_FUNC_MACHINE_SIZE,sizeof(char*));
	tmp->thelines = (int*)NclCalloc(NCL_FUNC_MACHINE_SIZE,sizeof(int));
	if(tmp->themachine == NULL ){
		NhlPError(FATAL,errno,"_NhlNewMachine: Can't allocate space for new machine");
		return;
	}
	tmp->pc = tmp->themachine;
	tmp->lc = tmp->thelines;
	tmp->fn = tmp->thefiles;
	tmp->pcoffset = 0;
	tmp->current_machine_size = NCL_FUNC_MACHINE_SIZE;
	tmp->next = mstk;
	mstk = tmp;
}

void *_NclPopMachine
#if __STDC__
(void)
#else
()
#endif
{
	_NclMachineStack* tmp;

	tmp = mstk;
	mstk = mstk->next;
	tmp->next = NULL;
	return((void*)tmp);
}
void _NclPushMachine
#if __STDC__
(void * the_mach_rec)
#else
(the_mach_rec)
	void * the_mach_rec;
#endif
{
	_NclMachineStack* tmp;

	tmp = mstk;
	mstk = the_mach_rec;
	mstk->next = tmp;
	return;
}

void _NclResetMachine
#if __STDC__
(void)
#else
()
#endif
{
	fp = NULL;
	if(sb != thestack) {
		NhlPError(WARNING,E_UNKNOWN,"ResetMachine: reseting non-empty stack, memory may leak!");
	}
	sb = thestack;
	mstk->pcoffset = 0;
	mstk->pc = mstk->themachine;
	mstk->lc = mstk->thelines;
	mstk->fn = mstk->thefiles;
	return;
}

static NhlErrorTypes IncreaseMachineSize
#if __STDC__
(void)
#else 
()
#endif
{
	mstk->themachine = (NclValue*)NclRealloc(mstk->themachine,mstk->current_machine_size*2);
	mstk->thefiles = (char**)NclRealloc(mstk->themachine,mstk->current_machine_size*2);
	mstk->thelines = (int*)NclRealloc(mstk->themachine,mstk->current_machine_size*2);
	mstk->current_machine_size *=2;
	if(mstk->themachine == NULL) {
		NhlPError(FATAL,errno,"IncreaseMachineSize: Unable to increase the size of the machine");
		return(FATAL);

	}
/*
* Since a new pointer is possible here a new value of pc needs to be computed
* from the current pcoffset value
*/
	mstk->pc = &(mstk->themachine[mstk->pcoffset]);
	return(NOERROR);
}
	

NhlErrorTypes _NclInitMachine
#if __STDC__
(void)
#else
()
#endif
{
	fp = NULL;
	sb = thestack;
	mstk = (_NclMachineStack*)NclMalloc((unsigned)sizeof(_NclMachineStack));
	mstk->themachine = (NclValue*)NclCalloc(NCL_MACHINE_SIZE,sizeof(NclValue));
	mstk->thefiles = (char**)NclCalloc(NCL_MACHINE_SIZE,sizeof(char*));
	mstk->thelines = (int*)NclCalloc(NCL_MACHINE_SIZE,sizeof(int));
	if(mstk->themachine == NULL ){
		NhlPError(FATAL,errno,"_NhlInitMachine: Can't allocate space for machine");
		return(FATAL);
	}
	mstk->pc = mstk->themachine;
	mstk->lc = mstk->thelines;
	mstk->fn = mstk->thefiles;
	mstk->pcoffset = 0;
	mstk->current_machine_size = NCL_MACHINE_SIZE;
	mstk->next = NULL;
	SetUpOpsStrings();
	return(NOERROR);
}

void _NclPushFrame
#if __STDC__
(NclSymTableListNode *new_scope,unsigned long next_instr_offset)
#else
(new_scope,next_instr_offset)
	NclSymTableListNode *new_scope;
	unsigned long next_instr_offset;
#endif
{
	NclFrame *tmp; 
	NclFrame *previous; 
	NclStackEntry* stmp;
	int i;

	previous = (NclFrame*)fp;	

	tmp = (NclFrame*)(sb);
	tmp->func_ret_value.kind = NclStk_NOVAL;
	tmp->func_ret_value.u.other = NULL;
	if(new_scope->level == current_scope_level+1) {
		tmp->static_link.u.offset  = (unsigned long)((NclStackEntry*)previous - (NclStackEntry*)thestack);
		tmp->static_link.kind = NclStk_OFFSET;
	} else if(new_scope->level == current_scope_level) {
		tmp->static_link = previous->static_link;
	} else  {
		i = current_scope_level - new_scope->level;
		while(i-- >= 0) {
			previous = (NclFrame*)((NclStackEntry*)thestack + previous->static_link.u.offset);
		}
		tmp->static_link.u.offset = (unsigned long)((NclStackEntry*)previous - (NclStackEntry*)thestack);
		tmp->static_link.kind = NclStk_OFFSET;
	}
	tmp->dynamic_link.u.offset  = (unsigned long)((NclStackEntry*)previous - (NclStackEntry*)thestack);

/*
* Maybe should be pcoffset + 1???
*/
	tmp->return_pcoffset.u.offset = next_instr_offset ;
	tmp->return_pcoffset.kind = NclStk_OFFSET;

	fp = tmp;
	
	tmp++;
	sb = (NclStackEntry*)tmp;

	current_scope_level = new_scope->level;
	return;
}

void _NclLeaveFrame
#if __STDC__
(void)
#else
()
#endif
{
/*
* --------> Need code to free local variables here <----------
*/
	sb = &(fp->func_ret_value);
	fp = (NclFrame*)(thestack + fp->dynamic_link.u.offset);
}

void _NclPush
#if __STDC__
(NclStackEntry data)
#else
(data)
	NclStackEntry data;
#endif
{
	*(sb) = data;
	sb++;
	if((sb) >= &(thestack[NCL_STACK_SIZE -1]) ) {
		NhlPError(FATAL,E_UNKNOWN,"Push: Stack overflow");
	}
	return;
}

NclStackEntry _NclPop
#if __STDC__
(void)
#else
()
#endif
{
	NclStackEntry tmp;
	if(sb <= thestack) {
		NhlPError(FATAL,E_UNKNOWN,"Pop: Stack underflow");
		tmp.kind = 0;
		return(tmp);
	} else {
		tmp = (*(sb));
		sb--;
		return(tmp);
	}
}


int _NclPutRealInstr
#if __STDC__
(float val,int line,char* file)
#else
(val,line,file)
	float val;
	int line;
	char *file;
#endif
{
/* 
* Sometimes the parser needs to know the offset of the instruction it put
* into the instruction list (i.e. function return addresses, loops and 
* conditionals. Therefore it is necessary to return the offset of the instruct
* being placed in the list.
*/
	int old_offset = (int)(mstk->pc - mstk->themachine);

/*
* Check for overflow
*/
	if(mstk->pc >= &(mstk->themachine[mstk->current_machine_size -1])) {
/*
* Will take care of updating mstk->pc
*/
		IncreaseMachineSize();
	}
	*((float*)mstk->pc++) = val;
	*(mstk->lc++) = line;
	*(mstk->fn++) = file;
	mstk->pcoffset = (int)(mstk->pc - mstk->themachine);

	return(old_offset);
}
int _NclPutInstr
#if __STDC__
(NclValue val,int line, char* file)
#else
(val,line,file)
	NclValue val;
	int line;
	char *file;
#endif
{
/* 
* Sometimes the parser needs to know the offset of the instruction it put
* into the instruction list (i.e. function return addresses, loops and 
* conditionals. Therefore it is necessary to return the offset of the instruct
* being placed in the list.
*/
	int old_offset = (int)(mstk->pc - mstk->themachine);

/*
* Check for overflow
*/
	if(mstk->pc >= &(mstk->themachine[mstk->current_machine_size -1])) {
/*
* Will take care of updating mstk->pc
*/
		IncreaseMachineSize();
	}
	*(mstk->pc++) = val;
	*(mstk->lc++) = line;
	*(mstk->fn++) = file;
	mstk->pcoffset = (int)(mstk->pc - mstk->themachine);

	return(old_offset);
}

int _NclGetCurrentOffset
#if __STDC__
(void)
#else
()
#endif
{
	return(mstk->pcoffset);
}

int _NclPutInstrAt
#if __STDC__
(int offset,NclValue val,int line, char* file)
#else 
(offset, val, line, file)
	int offset;
	NclValue val;
	int line;
	char *file;
#endif
{
	NclValue *ptr;
	int *lptr;
	char **fptr;

	ptr = (NclValue*)(mstk->themachine + offset);
	lptr = (int*)(mstk->thelines + offset);
	fptr = (char**)(mstk->thefiles+ offset);

	*ptr = val;
	*lptr = line;
	*fptr = file;

	return(offset);
}



int _NclPrintMachine
#if  __STDC__
(int from, int to,FILE* fp)
#else
(from,to,fp)
	int from;
	int to;
	FILE *fp;
#endif
{
	NclValue *ptr;
	NclValue *eptr;
	int	*lptr;
	char **fptr;

	if(from == -1){
		from = 0;
	}
	if(to == -1) {
		to = mstk->pcoffset;
	}

	ptr = (NclValue*)(mstk->themachine + from);
	eptr = (NclValue*)(mstk->themachine + to);
	lptr = (int*)(mstk->thelines+from);		
	fptr = (char**)(mstk->thefiles+from);
	
	while(ptr != eptr) {
		if(*fptr != NULL) {
			fprintf(fp,"(%d,%d,%s)\t",(int)(ptr-mstk->themachine),*lptr,*fptr);
		} else {
			fprintf(fp,"(%d,%d)\t",(int)(ptr-mstk->themachine),*lptr);
		}
		switch(*ptr) {
			case LINE:
				fprintf(fp,"%s\n",ops_strings[*ptr]);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t%d\n",*ptr);
				break;
			case NOOP :
			case STOPSEQ:
			case RETURN_OP :
			case IF_OP :
			case ASSIGN_OP :
			case NAMED_COORD_SUBSCRIPT_OP :
			case INT_SUBSCRIPT_OP :
			case NAMED_INT_SUBSCRIPT_OP :
			case COORD_SUBSCRIPT_OP :
			case SINGLE_INDEX_OP :
			case DEFAULT_RANGE_OP :
			case RANGE_INDEX_OP :
			case NEG_OP :
			case NOT_OP :
			case MOD_OP :
			case OR_OP :
			case AND_OP :
			case XOR_OP :
			case LTSEL_OP :
			case GTSEL_OP :
			case PLUS_OP :
			case MINUS_OP :
			case MUL_OP :
			case MAT_OP :
			case DIV_OP :
			case EXP_OP :
			case LE_OP :
			case GE_OP :
			case GT_OP :
			case LT_OP :
			case EQ_OP :
			case NE_OP :
			case BREAK_OP:
			case CONTINUE_OP:
			case ENDSTMNT_OP:
				fprintf(fp,"%s\n",ops_strings[*ptr]);
				break;
			case JMP :
			case JMPFALSE :
			case CREATE_OBJ_OP :
			case SET_OBJ_OP :
			case GET_OBJ_OP :
			case PUSH_INT_LIT_OP :
			case ARRAY_LIT_OP :
				fprintf(fp,"%s\n",ops_strings[*ptr]);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t%d\n",*ptr);
				break;
			case PUSH_STRING_LIT_OP :
				fprintf(fp,"%s\n",ops_strings[*ptr]);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t%s\n",(char*)*ptr);
				break;
			case PUSH_VAR_OP :
				fprintf(fp,"%s\n",ops_strings[*ptr]);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t");
				_NclPrintSymbol((NclSymbol*)*ptr,fp);
				break;
			case NEW_FRAME_OP:
				fprintf(fp,"%s\n",ops_strings[*ptr]);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t");
				_NclPrintSymbol((NclSymbol*)*ptr,fp);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t%d\n",*ptr);
				break;
			case PROC_CALL_OP:
			case BPROC_CALL_OP:
			case FUNC_CALL_OP:
			case BFUNC_CALL_OP:
				fprintf(fp,"%s\n",ops_strings[*ptr]);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t");
				_NclPrintSymbol((NclSymbol*)*ptr,fp);
				break;
			case DO_FROM_TO_OP :
			case DO_FROM_TO_STRIDE_OP :
				fprintf(fp,"%s\n",ops_strings[*ptr]);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t%d\n",*ptr);
				break;
			case PUSH_REAL_LIT_OP :
				fprintf(fp,"%s\n",ops_strings[*ptr]);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t%g\n",*(float*)ptr);
				break;
			case DO_WHILE_OP :
				fprintf(fp,"%s\n",ops_strings[*ptr]);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t%d\n",*ptr);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t%d\n",*ptr);
				break;
			case SUBSCRIPTED_FILE_VAR_OP :
				fprintf(fp,"%s\n",ops_strings[*ptr]);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t");
				_NclPrintSymbol((NclSymbol*)*ptr,fp);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t");
				_NclPrintSymbol((NclSymbol*)*ptr,fp);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t%d",*ptr);
				break;
			case PUSH_FILE_OP :
				fprintf(fp,"%s\n",ops_strings[*ptr]);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t");
				_NclPrintSymbol((NclSymbol*)*ptr,fp);
				break;
			case SUBSCRIPTED_VAR_OP :
				fprintf(fp,"%s\n",ops_strings[*ptr]);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t");
				_NclPrintSymbol((NclSymbol*)*ptr,fp);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t%d\n",*ptr);
				break;
			case PUSH_FILE_VAR_OP :
				fprintf(fp,"%s\n",ops_strings[*ptr]);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t");
				_NclPrintSymbol((NclSymbol*)*ptr,fp);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t");
				_NclPrintSymbol((NclSymbol*)*ptr,fp);
				break;
			case FILE_DIMNUM_OP :
				fprintf(fp,"%s\n",ops_strings[*ptr]);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t");
				_NclPrintSymbol((NclSymbol*)*ptr,fp);	
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t%d\n",*ptr);
				break;
			case FILE_DIMNAME_OP :
				fprintf(fp,"%s\n",ops_strings[*ptr]);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t");
				_NclPrintSymbol((NclSymbol*)*ptr,fp);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t%s\n",(char*)*ptr);
				break;
			case FILE_ATT_OP :
				fprintf(fp,"%s\n",ops_strings[*ptr]);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t");
				_NclPrintSymbol((NclSymbol*)*ptr,fp);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t%s\n",(char*)*ptr);
				break;
			case SUBSCRIPTED_FILE_ATT_OP:
				fprintf(fp,"%s\n",ops_strings[*ptr]);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t");
				_NclPrintSymbol((NclSymbol*)*ptr,fp);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t%s\n",(char*)*ptr);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t%d\n",*ptr);
				break;
			case FPDEF:
				fprintf(fp,"%s\n",ops_strings[*ptr]);
				ptr++;lptr++;fptr++;
				fprintf(fp,"\t");
				_NclPrintSymbol((NclSymbol*)*ptr,fp);
				_NclPushMachine(((NclSymbol*)*ptr)->u.procfunc->mach_rec_ptr);
				_NclPrintMachine(-1,-1,fp);
				(void)_NclPopMachine();
				break;
			
			default:
				break;
		}
		ptr++;lptr++;fptr++;
	}
}

