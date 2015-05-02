#ifndef NATIVEDIALOGS_H
#define NATIVEDIALOGS_H

 #include <hx/CFFI.h>

namespace nativedialogs {

    void textDialog_Impl( const char* title
                          , const char* dialogText
                          , const char* preValue
                          , const char* okText
                          , AutoGCRoot* okCallback
                          , bool withCancel
                          , const char* cancelText
                          , AutoGCRoot* cancelCallback);
}

#endif