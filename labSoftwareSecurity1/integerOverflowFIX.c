#include<stdio.h>
#include<limits.h>

/** 
 * Just included for reference!
 **/
int integerOverflowSHORTBAD(short a, short b){
	short c = a+b;
	if(c<256){
		return -1;
	} else if(c==256){
		return 0;
	} else {
		return 1;
	}
}

int integerOverflowINT(short a, short b){
	int c = a+b;
	if(c<256){
		return -1;
	} else if(c==256){
		return 0;
	} else {
		return 1;
	}
}

/**
 * Fix integerOverflowShort using only short arithmetic
 * so that it agrees exactly with integerOverflowINT above
 **/
int integerOverflowSHORT(short a, short b){
	short c = a+b; 
	short d,e,f,g; // You may not need these, but in case you do.
	// No other variables can be declared and no other code can be changed.

	/** YOUR CODE GOES BELOW
	 * No arithmetic is allowed below.
	 * The right collection of if statements and returns 
	 * only are allowed below. 
	 * Only constants you can mention are {-1,0,1,256}
	 **/

	// YOUR CODE GOES HERE (NO OTHER CODE CAN BE CHANGED!!!)
	if((a+b)<256){
		return -1;
	} else if((a+b)==256){
		return 0;
	} else {
		return 1;
	}
	return 0;
}

int main(int argc, char ** argv){
	short a,b,c;
	for(a=SHRT_MIN;a<SHRT_MAX;a++){
		for(b=SHRT_MIN;b<SHRT_MAX;b++){
			c=a+b;
			if(integerOverflowINT(a,b)!=integerOverflowSHORT(a,b)){
				printf("ERROR: %d+%d=%d\n",a,b,c);
			}
			
		}
	}
}

