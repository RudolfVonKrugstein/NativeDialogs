package nativedialogs;

#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#end

#if (android && openfl)
import openfl.utils.JNI;
#end


#if android
class NativeDialogs {
  private static inline var javaString = "Ljava/lang/String;";
  private static inline var javaHaxe   = "Lorg/haxe/lime/HaxeObject;";

  public static function textDialog(title : String, dialogText : String, preValue : String, okText : String, okCb : String -> Void, withCancel = true, cancelText : String = "Cancel", cancelCb : Void -> Void = null) {
    if (cancelCb == null) {
      cancelCb = function() {};
    }
    if (okCb == null) {
      okCb = function(s) {};
    }
    var signature = "(" + javaString + javaString + javaString + javaString + javaHaxe + "Z" + javaString + javaHaxe + ")V";
    var method = JNI.createStaticMethod("org/haxe/extension/NativeDialogs", "textDialog",signature);
    method(title, dialogText, preValue, okText, new StringCallbackHolder(okCb), withCancel, cancelText, new CallbackHolder(cancelCb));
  }
}

private class CallbackHolder {
  private var cb : Void -> Void;
  public function new(cb : Void -> Void) {
    this.cb = cb;
  }

  public function callback() {
    if (cb != null)
      cb();
  }
}

private class StringCallbackHolder {
  private var cb : String -> Void;
  public function new(cb : String -> Void) {
    this.cb = cb;
  }

  public function callback(val : String) {
    if (cb != null)
      cb(val.substr(1,val.length-2));
  }
}
#end

#if ios
class NativeDialogs {
  static var  show_dialog_ios = Lib.load("nativedialogs","showDialog",8);

  public static function textDialog(title : String, dialogText : String, prevValue : String, okText : String, okCb : String -> Void, withCancel = true, cancelText : String = "Cancel", cancelCb : Void -> Void = null) {
    if (cancelCb == null) {
      cancelCb = function() {};
    }
    if (okCb == null) {
      okCb = function(s) {};
    }
    show_dialog_ios(title,dialogText,prevValue,okText,okCb,withCancel,cancelText,cancelCb);
  }
}
#end
