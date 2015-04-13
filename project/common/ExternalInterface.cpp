#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif


#include <hx/CFFI.h>
#include "Utils.h"


namespace nativedialogs {

	AutoGCRoot *okCallback = 0;
	AutoGCRoot *cancelCallback = 0;

	static value textDialog(value title, value prevValue, value okText, value okCb, value withCancel, value cancelText, value cancelCb) {
		okCallback = new AutoGCRoot(okCallback);
		cancelCallback = new AutoGCRoot(cancelCallack);
		showTextDialog(title, prevValue, okText, withCancel, cancelText);
		return alloc_null();

	}
	DEFINE_PRIM (textDialog, 8);
}


extern "C" void nativedialogs_main () {
	
	val_int(0); // Fix Neko init
	
}
DEFINE_ENTRY_POINT (nativedialogs_main);



extern "C" int nativedialogs_register_prims () { return 0; }
