/*
 *      $Id: plottree.h,v 1.2 1999-10-13 17:15:50 dbrown Exp $
 */
/************************************************************************
*									*
*			     Copyright (C)  1996			*
*	     University Corporation for Atmospheric Research		*
*			     All Rights Reserved			*
*									*
************************************************************************/
/*
 *	File:		plottree.h
 *
 *	Author:		David I. Brown
 *			National Center for Atmospheric Research
 *			PO 3000, Boulder, Colorado
 *
 *	Date:		Thu Apr 24 14:37:14 MDT 1997
 *
 *	Description:	
 */
#ifndef	_NG_PLOTTREE_H
#define	_NG_PLOTTREE_H

#include <ncarg/ngo/go.h>
#include <ncarg/ngo/dataprofile.h>

#ifndef _NCL_H_
#include <ncarg/ncl/defs.h>
#include <ncarg/ncl/NclDataDefs.h>
#include <ncarg/ncl/ApiRecords.h>
#include <ncarg/ncl/NclApi.h>
#define _NCL_H_
#endif

/*
 * Public api
 */

typedef void (*ptGeoNotifyFunc) (
        NhlPointer data
        );

typedef struct _NgPlotTree 
{
        Widget		tree;
        ptGeoNotifyFunc	geo_notify;
        NhlPointer	geo_data;
	int		*hlu_ids;	/* read-only pointer into plotpage */
	NhlBoolean	first_vpon;
} NgPlotTree;
                
extern NgPlotTree *NgCreatePlotTree
(
        NgGO			go,
        Widget			parent,
	int			wk_id,
        NrmQuark 		qname,
	NgDataProfile		data_profile
        );

extern NhlErrorTypes NgUpdatePlotTree
(
        NgPlotTree		*plot_tree,
	int			wk_id,
        NrmQuark		qname,
	NgDataProfile		data_profile
        );

extern NgPlotTree *NgDupPlotTree
(
        NgGO			go,
        Widget			parent,
	int			wk_id,
        NrmQuark		qname,
	NgDataProfile		data_profile,
	NgPlotTree		*to_plot_tree,
        NgPlotTree		*from_plot_tree
        );

extern void NgDestroyPlotTree
(
        NgPlotTree		*plot_tree
        );
        

extern int NgPlotTreeAddResList
(
        int		nclstate,
        NhlPointer	res_data,
        int		block_id
        );

typedef struct _NgPlotTreeResDataRec
{
	NgPlotTree	*plot_tree;
	NrmQuark	qname;
}NgPlotTreeResDataRec, *NgPlotTreeResData;
	
		

#endif	/* _NG_PLOTTREE_H */
