package demo.util;

import org.apache.commons.codec.digest.DigestUtils;

import java.security.MessageDigest;

public class MD5 {
   
    public static String md5(String text) throws Exception {
        //加密后的字符串
        String encodeStr=DigestUtils.md5Hex(text);
        return encodeStr;
        }

    
    public static boolean verify(String text, String md5) throws Exception {
        String md5Text = md5(text);
        if(md5Text.equalsIgnoreCase(md5))
        {
            return true;
        }
            return false;
    }
}