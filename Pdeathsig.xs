#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "ppport.h"

#include <sys/prctl.h>

#include "const-c.inc"

MODULE = Linux::Pdeathsig		PACKAGE = Linux::Pdeathsig		

INCLUDE: const-xs.inc
