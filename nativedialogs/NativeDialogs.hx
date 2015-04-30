package nativedialogs;

#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#end

#if (android && openfl)
import openfl.utils.JNI;
#end


class NativeDialogs {
  #if android
  private static inline var javaString = "Ljava/lang/String;";
  private static inline var javaHaxe   = "Lorg/haxe/lime/HaxeObject;";
  #end

  #if mobile
  public static function textDialog(title : String, dialogText : String, preValue : String, okText : String, okCb : String -> Void, withCancel = true, cancelText : String = "Cancel", cancelCb : Void -> Void = null) {
    if (cancelCb == null) {
      cancelCb = function() {};
    }
    if (okCb == null) {
      okCb = function(s) {};
    }
    #if android
    var signature = "(" + javaString + javaString + javaString + javaString + javaHaxe + "Z" + javaString + javaHaxe + ")V";
    var method = JNI.createStaticMethod("org/haxe/extension/NativeDialogs", "textDialog",signature);
    method(title, dialogText, preValue, okText, new StringCallbackHolder(okCb), withCancel, cancelText, new CallbackHolder(cancelCb));
    #else
    var method = Lib.load("nativedialogs","textDialog",8);
    method(title,dialogText,preValue,okText,okCb,withCancel,cancelText,cancelCb);
    #end
	}
	#end
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
