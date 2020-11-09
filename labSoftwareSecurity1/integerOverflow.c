#include<stdio.h>
#include<limits.h>

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

int integerOverflowSHORT(short a, short b){
	short c = a+b;
	if(c<256){
		return -1;
	} else if(c==256){
		return 0;
	} else {
		return 1;
	}
}

/**
 * Notice how the above two functions don't agree.
 * integerOverflowINT is actually correct.
 * Fix integerOverflowSHORT in integerOverflowFIX.c
 **/

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
