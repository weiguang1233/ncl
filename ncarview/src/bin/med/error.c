/*
 *	$Id: error.c,v 1.6 2000-08-22 15:11:13 haley Exp $
 */
/************************************************************************
*                                                                       *
*                Copyright (C)  2000                                    *
*        University Corporation for Atmospheric Research                *
*                All Rights Reserved                                    *
*                                                                       *
* This file is free software; you can redistribute it and/or modify     *
* it under the terms of the GNU General Public License as published     *
* by the Free Software Foundation; either version 2 of the License, or  *
* (at your option) any later version.                                   *
*                                                                       *
* This software is distributed in the hope that it will be useful, but  *
* WITHOUT ANY WARRANTY; without even the implied warranty of            *
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU     *
* General Public License for more details.                              *
*                                                                       *
* You should have received a copy of the GNU General Public License     *
* along with this software; if not, write to the Free Software         *
* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307   *
* USA.                                                                  *
*                                                                       *
************************************************************************/


/*
 *	error.c
 *
 *	Author		John Clyne
 *
 *	Date		Fri Feb  2 13:44:17 MST 1990
 *
 *	This is the error module for med. If med commands are not from 
 *	a terminal then any error results in med terminating
 */
#include	<stdio.h>
#include	<string.h>
#include	"med.h"

static	char	buf[80];

/*
 * command_error_message
 * [exported]
 *
 * print a error message generated by a med command. If the error is fatal
 * or if we're in batch mode then exit
 *
 * on entry: 
 *	*med_data	: will contain a pointer to the offended command
 *	errno		: if set then call perror with message
 *	do_usage	: if set then print a usage message
 *	*message	: pointer to message to append to error message
 *	severity	: on of (MED_FATAL, MED_WARN)
 */
command_error_message(med_data, errno, do_usage, message, severity)
	MedData	*med_data;
	int	errno;
	int	do_usage;
	char	*message;
	int	severity;
{

	(void) strcpy(buf, "med: ");
	(void) strcat(buf, "command failed <");
	(void) strcat(buf, med_data->c->c_name);
	(void) strcat(buf, "> "); 
	if (message)
		(void) strcat(buf, message);


	if (errno) {
		perror(buf);
	} 
	else {
		(void) fprintf(stderr, "%s\n", buf);
	}

	if (do_usage) {
		(void) fprintf(stderr, "med <%s> usage: %s\n",
			med_data->c->c_name, med_data->c->c_usage);
	
	}

	/*
	 * if the error was fatal or if we're in batch mode exit
	 */
	if (severity == MED_FATAL || !med_data->fromatty) {
		exit(1);
	}
}



/*
 * error_message
 * [exported]
 *
 * print a general error message. If the error is fatal
 * or if we're in batch mode then exit
 *
 * on entry: 
 *	errno		: if set then call perror with message
 *	*message	: pointer to message to append to error message
 *	severity	: on of (MED_FATAL, MED_WARN)
 */
error_message(med_data, errno, message, severity)
	MedData	*med_data;
	int	errno;
	char	*message;
	int	severity;
{

	(void) strcpy(buf, "med: ");
	if (message)
		(void) strcat(buf, message);


	if (errno) {
		perror(buf);
	} else if (message) {
		(void) fprintf(stderr, "%s\n", buf);
	}

	/*
	 * if the error was fatal or if we're in batch mode exit
	 */
	if (severity == MED_FATAL || !med_data->fromatty) {
		exit(1);
	}
}
