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
    private inline var javaString = "Ljava/lang/String;";
    private inline var javaHaxe   = "Lorg/haxe/lime/HaxeObject;";
	
	public static function textDialog(title : String, dialogText : String, preValue : String, okText : String, okCb : String -> Void, withCancel = true, cancelText : String = "Cancel", cancelCb : Void -> Void = null) {
      if (cancelCb == null) {
        cancelCb = function() {};
      }
      if (okCb == null) {
        okCb = function(s) {};
      }
      var method = JNI.createStaticMethod("org/haxe/extension/NativeDialogs", "textDialog",
                             "(" + javaString + javaString + javaStirng + javaHaxe + "Z" + javaHaxe ")V");
      method(title, dialogText, preValue, okText, new CallbackHolder(okCb), withCancel, cancelText, new StringCallbackHolder(cancelCb));
	}
	
	
	private static var nativedialogs_sample_method = Lib.load ("nativedialogs", "nativedialogs_sample_method", 1);
	
	#if (android && openfl)
	private static var nativedialogs_sample_method_jni = JNI.createStaticMethod ("org.haxe.extension.NativeDialogs", "sampleMethod", "(I)I");
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
      cb(val);
  }
}
