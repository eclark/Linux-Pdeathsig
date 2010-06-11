#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <sys/syscall.h>
#include <sys/prctl.h>

#include "const-c.inc"

MODULE = Linux::Pdeathsig		PACKAGE = Linux::Pdeathsig		

INCLUDE: const-xs.inc

int
set_pdeathsig(signum)
    unsigned long signum
  CODE:
    RETVAL = prctl(PR_SET_PDEATHSIG,signum);
  OUTPUT:
    RETVAL 

SV *
get_pdeathsig()
  INIT:
    int rv;
    int signum;
  CODE:
    rv = prctl(PR_GET_PDEATHSIG,&signum);
    if (rv == 0) {
        RETVAL = newSVnv(signum); 
    } else {
        RETVAL = newSVnv(errno);
    }
  OUTPUT:
    RETVAL
