#include "Utils.h"
#import <Foundation/Foundation.h>

namespace nativedialogs {

	 extern "C" void okCallback(const char*);
	 extern "C" void cancelCallback();
	
	static void textDialog_Impl( const char* title
                      , const char* dialogText
                      , const char* preValue
                      , const char* okText
                      , bool withCancel
                      , const char* cancelText) {
                      nativedialogs::okCallback(preValue);
                      }
	
	
}