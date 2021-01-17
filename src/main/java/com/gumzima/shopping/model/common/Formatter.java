package com.gumzima.shopping.model.common;

import java.text.DecimalFormat;
import java.util.Currency;
import java.util.Locale;

public class Formatter {
	//숫자를 해당 시스템의 통화로 변환하여 반환하는 메서드, 3자리마다 쉽표 처리
	
	public static String getCurrency(long number) {
		String currency=Currency.getInstance(Locale.KOREA).getSymbol();//해당 국의 통화 반환
		DecimalFormat df=new DecimalFormat("###,###.###");
		String result=currency+df.format(number);
		return result;
	}
}
