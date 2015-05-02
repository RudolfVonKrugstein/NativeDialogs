#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif

 #include <hx/CFFI.h>
#include "Utils.h"


using namespace nativedialogs;


AutoGCRoot *okCallback = 0;
AutoGCRoot *cancelCallback = 0;

static void nativedialogs_textdialog(value *pars, int count) {
    const char *title = val_string(pars[0]);
    const char *dialogText = val_string(pars[1]);
    const char *preValue = val_string(pars[2]);
    const char *okText = val_string(pars[3]);
    okCallback = new AutoGCRoot(pars[4]);
    bool withCancel = val_bool(pars[5]);
    const char *cancelText = val_string(pars[6]);
    cancelCallback = new AutoGCRoot(pars[7]);
    textDialog_Impl(title, dialogText, preValue, okText, okCallback, withCancel, cancelText, cancelCallback);
}
DEFINE_PRIM_MULT (nativedialogs_textdialog);

extern "C" void nativedialogs_main () {
	
	val_int(0); // Fix Neko init
	
}
DEFINE_ENTRY_POINT (nativedialogs_main);



extern "C" int nativedialogs_register_prims () { return 0; }