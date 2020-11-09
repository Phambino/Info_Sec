#include<stdio.h>
char c;
short s;
int i;
long l;
float f;
double d;

int sumNums(int n, int m){
        int i;
        int sum=0;
        char c[16];
	// C is declare before use
	// n,m,sum are all initialized 
	// i and c are uninitialized, they can be referred to
	// even before we give decide what value they should have

        printf("uninitialized i=%d\n",i);
        // i=n; // say we forgot to do this...explain the behaviour
        while(i<m){
                sum=sum+i;
                i=i+1;
        }

        return sum;
}
void f1(int a, int b, int c, int d){

}
void hacked(){
        printf("I've been hacked\n");
}
int main(int argc, char ** argv){
        printf("return from sumNums(3,7)=%d\n",sumNums(3,7));
        f1(1,2,3,4);
        f1(1,2,3,4);
}

