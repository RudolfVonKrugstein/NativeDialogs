#include "Utils.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>




AutoGCRoot* g_okCallback;
AutoGCRoot* g_cancelCallback;

namespace nativedialogs {
void textDialog_Impl( const char* title
                  , const char* dialogText
                  , const char* preValue
                  , const char* okText
                  , AutoGCRoot* okCallback
                  , bool withCancel
                  , const char* cancelText
                  , AutoGCRoot* cancelCallback) {
  g_okCallback = okCallback;
  g_cancelCallback = cancelCallback;
  //val_call1(okCallback->get(),alloc_string(preValue));
  //val_call0(cancelCallback->get());
  NSString *ns_title = [NSString stringWithUTF8String:title];
  NSString *ns_dialogText = [NSString stringWithUTF8String:dialogText];
  NSString *ns_preValue = [NSString stringWithUTF8String:preValue];
  NSString *ns_okText = [NSString stringWithUTF8String:okText];
  NSString *ns_cancelText = [NSString stringWithUTF8String:cancelText];

  UIAlertController * alert=   [UIAlertController
                                   alertControllerWithTitle:ns_title
                                   message:ns_dialogText
                                   preferredStyle:UIAlertControllerStyleAlert];

     UIAlertAction* ok = [UIAlertAction
                          actionWithTitle:ns_okText
                          style:UIAlertActionStyleDefault
                          handler:^(UIAlertAction * action)
                          {
                              NSString *ns_result = ((UITextField*)(alert.textFields[0])).text;

                              [alert dismissViewControllerAnimated:YES completion:nil];
                              val_call1(g_okCallback->get(),alloc_string([ns_result UTF8String]));

                          }];
     UIAlertAction* cancel = [UIAlertAction
                             actionWithTitle:ns_cancelText
                             style:UIAlertActionStyleDefault
                             handler:^(UIAlertAction * action)
                             {
                                 [alert dismissViewControllerAnimated:YES completion:nil];
                                 val_call0(g_cancelCallback->get());

                             }];

     [alert addAction:ok];
     if (withCancel) {
         [alert addAction:cancel];
     }
     [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
             textField.text = ns_preValue;
         }];

     [[[[UIApplication sharedApplication] keyWindow] rootViewController]  presentModalViewController:alert animated:YES];

}

}
