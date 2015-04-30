#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif


#include <hx/CFFI.h>
#include "Utils.h"


using namespace nativedialogs;

namespace nativedialogs {
AutoGCRoot *okCallback = 0;
AutoGCRoot *cancelCallback = 0;
}

static void textDialog( value title
                      , value dialogText
                      , value preValue
                      , value okText
                      , value okCb
                      , bool withCancel
                      , value cancelText
                      , value cancelCb ) {
    okCallback = new AutoGCRoot(okCb);
    cancelCallback = new AutoGCRoot(cancelCb);
    textDialog_Impl(val_string(title), val_string(dialogText), val_string(preValue), val_string(okText), withCancel, val_string(cancelText));
}
DEFINE_PRIM (textDialog, 8);



extern "C" void nativedialogs_main () {
	
	val_int(0); // Fix Neko init
	
}
DEFINE_ENTRY_POINT (nativedialogs_main);



extern "C" int nativedialogs_register_prims () { return 0; }