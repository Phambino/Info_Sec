#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "shellcode.h"

int foo(char *arg) {
	char a='a';
	char buf[110];
	char b='b';
  	strcpy(buf, arg);
  	return 0;
}
void hacked(){
	printf("Hacked!!\n");
}
int main(int argc, char *argv[]) {
  	printf("Target1 running.\n");
  	foo(shellcode);

  	return 0;
}
