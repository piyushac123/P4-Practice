#ifndef _ACTIONS_
#define _ACTIONS_

#include "headers.p4"

action drop(){
	mark_to_drop(standard_metadata);
}

#endif