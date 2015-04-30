#ifndef NATIVEDIALOGS_H
#define NATIVEDIALOGS_H


namespace nativedialogs {

    static void textDialog_Impl( const char* title
                          , const char* dialogText
                          , const char* preValue
                          , const char* okText
                          , bool withCancel
                          , const char* cancelText);
}


#endif