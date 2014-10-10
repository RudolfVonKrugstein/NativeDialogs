package;

#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#end

#if (android && openfl)
import openfl.utils.JNI;
#end


class NativeDialogs {
	
	
	public static function sampleMethod (inputValue:Int):Int {
		
		#if (android && openfl)
		
		var resultJNI = nativedialogs_sample_method_jni(inputValue);
		var resultNative = nativedialogs_sample_method(inputValue);
		
		if (resultJNI != resultNative) {
			
			throw "Fuzzy math!";
			
		}
		
		return resultNative;
		
		#else
		
		return nativedialogs_sample_method(inputValue);
		
		#end
		
	}
	
	
	private static var nativedialogs_sample_method = Lib.load ("nativedialogs", "nativedialogs_sample_method", 1);
	
	#if (android && openfl)
	private static var nativedialogs_sample_method_jni = JNI.createStaticMethod ("org.haxe.extension.NativeDialogs", "sampleMethod", "(I)I");
	#end
	
	
}