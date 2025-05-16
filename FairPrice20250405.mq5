//+------------------------------------------------------------------+
//|                                                  FairPrice.mq4/5 |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025 HaoWei"
#property version "1.0"
#property strict


#property indicator_chart_window
#property indicator_plots 1
#property indicator_buffers 1






enum SymbolGroup{EURUSD_USDCHF_EURCHF=0};
input SymbolGroup SymbolSet=0;
input string SymbolPostFix="";

input color Level0Color=clrWhite;
input color Level1Color=clrSilver;




long ChartIDLong;
string SymbolA;
string SymbolB;
string SymbolC;
void OnInit(){
	
	ChartIDLong=ChartID();
	
	switch(SymbolSet){
		case 0:
			SymbolSelect("EURUSD"+SymbolPostFix,true);
			SymbolSelect("USDCHF"+SymbolPostFix,true);
			SymbolSelect("EURCHF"+SymbolPostFix,true);
			
			SymbolA="EURUSD"+SymbolPostFix;
			SymbolB="USDCHF"+SymbolPostFix;
			SymbolC="EURCHF"+SymbolPostFix;
			break;
		
	}
}


void OnDeinit(const int reason){
	
	ObjectDelete(ChartIDLong,"High1");
	ObjectDelete(ChartIDLong,"Low1");
	ObjectDelete(ChartIDLong,"High0");
	ObjectDelete(ChartIDLong,"Low0");
}


void DrawHorizontalLine(string myName,string myText,double myPrice,color myColor,int myStyle,int myWidth){
	
	ObjectCreate(ChartIDLong,myName,OBJ_HLINE,0,TimeCurrent(),myPrice);
	ObjectSetString(ChartIDLong,myName,OBJPROP_TEXT,myText);
	ObjectSetInteger(ChartIDLong,myName,OBJPROP_COLOR,myColor);
	ObjectSetInteger(ChartIDLong,myName,OBJPROP_STYLE,myStyle);
	ObjectSetInteger(ChartIDLong,myName,OBJPROP_WIDTH,myWidth);
	
	ObjectSetInteger(ChartIDLong,myName,OBJPROP_SELECTABLE,false);
	ObjectSetInteger(ChartIDLong,myName,OBJPROP_SELECTED,false);
	
	ObjectSetInteger(ChartIDLong,myName,OBJPROP_HIDDEN,true);
	ObjectSetInteger(ChartIDLong,myName,OBJPROP_BACK,false);
}


double DistHighA;
double DistLowA;
double DistHighB;
double DistLowB;
double DistHighC;
double DistLowC;
double High1A;
double Low1A;
double High0A;
double Low0A;
double High1B;
double Low1B;
double High0B;
double Low0B;
double High1C;
double Low1C;
double High0C;
double Low0C;
string High1AStr;
string Low1AStr;
string High0AStr;
string Low0AStr;
string High1BStr;
string Low1BStr;
string High0BStr;
string Low0BStr;
string High1CStr;
string Low1CStr;
string High0CStr;
string Low0CStr;
int OnCalculate(const int rates_total,const int prev_calculated,const datetime& time[],const double& open[],const double& high[],const double& low[],const double& close[],const long& tick_volume[],const long& volume[],const int& spread[]){
	
	High1A=iOpen(SymbolA,PERIOD_D1,0);
	Low1A=iOpen(SymbolA,PERIOD_D1,0);
	High0A=iOpen(SymbolA,PERIOD_D1,0);
	Low0A=iOpen(SymbolA,PERIOD_D1,0);
	
	High1B=iOpen(SymbolB,PERIOD_D1,0);
	Low1B=iOpen(SymbolB,PERIOD_D1,0);
	High0B=iOpen(SymbolB,PERIOD_D1,0);
	Low0B=iOpen(SymbolB,PERIOD_D1,0);
	
	High1C=iOpen(SymbolC,PERIOD_D1,0);
	Low1C=iOpen(SymbolC,PERIOD_D1,0);
	High0C=iOpen(SymbolC,PERIOD_D1,0);
	Low0C=iOpen(SymbolC,PERIOD_D1,0);
	
	DistHighA=iHigh(SymbolA,PERIOD_D1,0)-iOpen(SymbolA,PERIOD_D1,0);
	DistLowA=iOpen(SymbolA,PERIOD_D1,0)-iLow(SymbolA,PERIOD_D1,0);
	
	DistHighB=iHigh(SymbolB,PERIOD_D1,0)-iOpen(SymbolB,PERIOD_D1,0);
	DistLowB=iOpen(SymbolB,PERIOD_D1,0)-iLow(SymbolB,PERIOD_D1,0);
	
	DistHighC=iHigh(SymbolC,PERIOD_D1,0)-iOpen(SymbolC,PERIOD_D1,0);
	DistLowC=iOpen(SymbolC,PERIOD_D1,0)-iLow(SymbolC,PERIOD_D1,0);
	
	
	High1A+=DistHighC;
	Low1A-=DistLowC;
	
	High1A+=DistLowB;
	Low1A-=DistHighB;
	
	if(DistHighB>DistHighC){
		Low0A-=(DistHighB-DistHighC);
	}else{
		High0A+=(DistHighC-DistHighB);
	}
	
	if(DistLowB>DistLowC){
		High0A+=(DistLowB-DistLowC);
	}else{
		Low0A-=(DistLowC-DistLowB);
	}
	
	
	High1B+=DistLowA;
	Low1B-=DistHighA;
	
	High1B+=DistHighC;
	Low1B-=DistLowC;
	
	if(DistLowA>DistLowC){
		High0B+=(DistLowA-DistLowC);
	}else{
		Low0B-=(DistLowC-DistLowA);
	}
	
	if(DistHighA>DistHighC){
		Low0B-=(DistHighA-DistHighC);
	}else{
		High0B+=(DistHighC-DistHighA);
	}
	
	
	High1C+=DistHighA;
	Low1C-=DistLowA;
	
	High1C+=DistHighB;
	Low1C-=DistLowB;
	
	if(DistHighA>DistLowB){
		High0C+=(DistHighA-DistLowB);
	}else{
		Low0C-=(DistLowB-DistHighA);
	}
	
	if(DistLowA>DistHighB){
		High0C+=(DistLowA-DistHighB);
	}else{
		Low0C-=(DistHighB-DistLowA);
	}
	
	if(StringFind(Symbol(),SymbolA,0)>-1){
		
		High1AStr=DoubleToString((High1A-iOpen(SymbolA,PERIOD_D1,0))/SymbolInfoDouble(SymbolA,SYMBOL_POINT),0);
		Low1AStr=DoubleToString((Low1A-iOpen(SymbolA,PERIOD_D1,0))/SymbolInfoDouble(SymbolA,SYMBOL_POINT),0);
		
		High0AStr=DoubleToString((High0A-iOpen(SymbolA,PERIOD_D1,0))/SymbolInfoDouble(SymbolA,SYMBOL_POINT),0);
		Low0AStr=DoubleToString((Low0A-iOpen(SymbolA,PERIOD_D1,0))/SymbolInfoDouble(SymbolA,SYMBOL_POINT),0);
		
		if(ObjectFind(ChartIDLong,"High1")>-1){
			ObjectMove(ChartIDLong,"High1",0,TimeCurrent(),High1A);
			ObjectSetString(ChartIDLong,"High1",OBJPROP_TEXT,High1AStr);
		}else{
			DrawHorizontalLine("High1",High1AStr,High1A,Level1Color,STYLE_SOLID,1);
		}
		if(ObjectFind(ChartIDLong,"Low1")>-1){
			ObjectMove(ChartIDLong,"Low1",0,TimeCurrent(),Low1A);
			ObjectSetString(ChartIDLong,"Low1",OBJPROP_TEXT,Low1AStr);
		}else{
			DrawHorizontalLine("Low1",Low1AStr,Low1A,Level1Color,STYLE_SOLID,1);
		}
		
		if(ObjectFind(ChartIDLong,"High0")>-1){
			ObjectMove(ChartIDLong,"High0",0,TimeCurrent(),High0A);
			ObjectSetString(ChartIDLong,"High0",OBJPROP_TEXT,High0AStr);
		}else{
			DrawHorizontalLine("High0",High0AStr,High0A,Level0Color,STYLE_SOLID,1);
		}
		if(ObjectFind(ChartIDLong,"Low0")>-1){
			ObjectMove(ChartIDLong,"Low0",0,TimeCurrent(),Low0A);
			ObjectSetString(ChartIDLong,"Low0",OBJPROP_TEXT,Low0AStr);
		}else{
			DrawHorizontalLine("Low0",Low0AStr,Low0A,Level0Color,STYLE_SOLID,1);
		}
		
		if(DistHighA+DistLowA>DistHighB+DistLowB && DistHighA+DistLowA>DistHighC+DistLowC){
			ObjectSetInteger(ChartIDLong,"High1",OBJPROP_WIDTH,3);
			ObjectSetInteger(ChartIDLong,"Low1",OBJPROP_WIDTH,3);
			ObjectSetInteger(ChartIDLong,"High0",OBJPROP_WIDTH,3);
			ObjectSetInteger(ChartIDLong,"Low0",OBJPROP_WIDTH,3);
		}else{
			ObjectSetInteger(ChartIDLong,"High1",OBJPROP_WIDTH,1);
			ObjectSetInteger(ChartIDLong,"Low1",OBJPROP_WIDTH,1);
			ObjectSetInteger(ChartIDLong,"High0",OBJPROP_WIDTH,1);
			ObjectSetInteger(ChartIDLong,"Low0",OBJPROP_WIDTH,1);
		}
	}
	
	if(StringFind(Symbol(),SymbolB,0)>-1){
		
		High1BStr=DoubleToString((High1B-iOpen(SymbolB,PERIOD_D1,0))/SymbolInfoDouble(SymbolB,SYMBOL_POINT),0);
		Low1BStr=DoubleToString((Low1B-iOpen(SymbolB,PERIOD_D1,0))/SymbolInfoDouble(SymbolB,SYMBOL_POINT),0);
		
		High0BStr=DoubleToString((High0B-iOpen(SymbolB,PERIOD_D1,0))/SymbolInfoDouble(SymbolB,SYMBOL_POINT),0);
		Low0BStr=DoubleToString((Low0B-iOpen(SymbolB,PERIOD_D1,0))/SymbolInfoDouble(SymbolB,SYMBOL_POINT),0);
		
		if(ObjectFind(ChartIDLong,"High1")>-1){
			ObjectMove(ChartIDLong,"High1",0,TimeCurrent(),High1B);
			ObjectSetString(ChartIDLong,"High1",OBJPROP_TEXT,High1BStr);
		}else{
			DrawHorizontalLine("High1",High1BStr,High1B,Level1Color,STYLE_SOLID,1);
		}
		if(ObjectFind(ChartIDLong,"Low1")>-1){
			ObjectMove(ChartIDLong,"Low1",0,TimeCurrent(),Low1B);
			ObjectSetString(ChartIDLong,"Low1",OBJPROP_TEXT,Low1BStr);
		}else{
			DrawHorizontalLine("Low1",Low1BStr,Low1B,Level1Color,STYLE_SOLID,1);
		}
		
		if(ObjectFind(ChartIDLong,"High0")>-1){
			ObjectMove(ChartIDLong,"High0",0,TimeCurrent(),High0B);
			ObjectSetString(ChartIDLong,"High0",OBJPROP_TEXT,High0BStr);
		}else{
			DrawHorizontalLine("High0",High0BStr,High0B,Level0Color,STYLE_SOLID,1);
		}
		if(ObjectFind(ChartIDLong,"Low0")>-1){
			ObjectMove(ChartIDLong,"Low0",0,TimeCurrent(),Low0B);
			ObjectSetString(ChartIDLong,"Low0",OBJPROP_TEXT,Low0BStr);
		}else{
			DrawHorizontalLine("Low0",Low0BStr,Low0B,Level0Color,STYLE_SOLID,1);
		}
		
		if(DistHighB+DistLowB>DistHighA+DistLowA && DistHighB+DistLowB>DistHighC+DistLowC){
			ObjectSetInteger(ChartIDLong,"High1",OBJPROP_WIDTH,3);
			ObjectSetInteger(ChartIDLong,"Low1",OBJPROP_WIDTH,3);
			ObjectSetInteger(ChartIDLong,"High0",OBJPROP_WIDTH,3);
			ObjectSetInteger(ChartIDLong,"Low0",OBJPROP_WIDTH,3);
		}else{
			ObjectSetInteger(ChartIDLong,"High1",OBJPROP_WIDTH,1);
			ObjectSetInteger(ChartIDLong,"Low1",OBJPROP_WIDTH,1);
			ObjectSetInteger(ChartIDLong,"High0",OBJPROP_WIDTH,1);
			ObjectSetInteger(ChartIDLong,"Low0",OBJPROP_WIDTH,1);
		}
	}
	
	if(StringFind(Symbol(),SymbolC,0)>-1){
		
		High1CStr=DoubleToString((High1C-iOpen(SymbolC,PERIOD_D1,0))/SymbolInfoDouble(SymbolC,SYMBOL_POINT),0);
		Low1CStr=DoubleToString((Low1C-iOpen(SymbolC,PERIOD_D1,0))/SymbolInfoDouble(SymbolC,SYMBOL_POINT),0);
		
		High0CStr=DoubleToString((High0C-iOpen(SymbolC,PERIOD_D1,0))/SymbolInfoDouble(SymbolC,SYMBOL_POINT),0);
		Low0CStr=DoubleToString((Low0C-iOpen(SymbolC,PERIOD_D1,0))/SymbolInfoDouble(SymbolC,SYMBOL_POINT),0);
		
		if(ObjectFind(ChartIDLong,"High1")>-1){
			ObjectMove(ChartIDLong,"High1",0,TimeCurrent(),High1C);
			ObjectSetString(ChartIDLong,"High1",OBJPROP_TEXT,High1CStr);
		}else{
			DrawHorizontalLine("High1",High1CStr,High1C,Level1Color,STYLE_SOLID,1);
		}
		if(ObjectFind(ChartIDLong,"Low1")>-1){
			ObjectMove(ChartIDLong,"Low2",0,TimeCurrent(),Low1C);
			ObjectSetString(ChartIDLong,"Low1",OBJPROP_TEXT,Low1CStr);
		}else{
			DrawHorizontalLine("Low1",Low1CStr,Low1C,Level1Color,STYLE_SOLID,1);
		}
		
		if(ObjectFind(ChartIDLong,"High0")>-1){
			ObjectMove(ChartIDLong,"High0",0,TimeCurrent(),High0C);
			ObjectSetString(ChartIDLong,"High0",OBJPROP_TEXT,High0CStr);
		}else{
			DrawHorizontalLine("High0",High0CStr,High0C,Level0Color,STYLE_SOLID,1);
		}
		if(ObjectFind(ChartIDLong,"Low0")>-1){
			ObjectMove(ChartIDLong,"Low0",0,TimeCurrent(),Low0C);
			ObjectSetString(ChartIDLong,"Low0",OBJPROP_TEXT,Low0CStr);
		}else{
			DrawHorizontalLine("Low0",Low0CStr,Low0C,Level0Color,STYLE_SOLID,1);
		}
		
		if(DistHighC+DistLowC>DistHighA+DistLowA && DistHighC+DistLowC>DistHighB+DistLowB){
			ObjectSetInteger(ChartIDLong,"High1",OBJPROP_WIDTH,3);
			ObjectSetInteger(ChartIDLong,"Low1",OBJPROP_WIDTH,3);
			ObjectSetInteger(ChartIDLong,"High0",OBJPROP_WIDTH,3);
			ObjectSetInteger(ChartIDLong,"Low0",OBJPROP_WIDTH,3);
		}else{
			ObjectSetInteger(ChartIDLong,"High1",OBJPROP_WIDTH,1);
			ObjectSetInteger(ChartIDLong,"Low1",OBJPROP_WIDTH,1);
			ObjectSetInteger(ChartIDLong,"High0",OBJPROP_WIDTH,1);
			ObjectSetInteger(ChartIDLong,"Low0",OBJPROP_WIDTH,1);
		}
	}
	
	return(rates_total);
}