#include <stdio.h>
#include<string.h>

/**
 * Remember this program was run setuid root in last weeks lecture.
 * Below is a modification of the program.
 *
 * Definition: vulnerabilities are a weakness in software systems
 * Definition: exploits are attacks made to take advantage of vulnerabilities
 * 
 * Vulnerability 1: Improper input validation: argv[1] 
 * Exploit: Path/Directory Traversal: 
 * The attacker can provide command line arguments like ../../../file1 etc. which result in accessing the file without permissions
 *
 * 	YOUR ANSWER GOES HERE. PROVIDE EXAMPLE AND CONSEQUENCE.
 *
 * Fix (description): Whitelist inputs that you want to see like regex and check all inputs 
 *
 * 	YOUR ANSWER GOES HERE
 *
 * Vulnerability 2: Format string attack: argv[1]
 * Exploit: The attacker can provide command line arguements like ./fetchfile file1 %s%s%s%s%s%s
 *
 * 	YOUR ANSWER GOES HERE. PROVIDE EXAMPLE AND CONSEQUENCE.
 *
 * Fix (description): instead of sprintf, you can use snprintf(buf, sizeof buf, "%s", argv[1])
 *
 * 	YOUR ANSWER GOES HERE
 *
 * Vulnerability 3: Bufferoverrun
 *
 * 	YOUR ANSWER GOES HERE
 *
 * Exploit: strcpy may include information that may be needed to keep hidden in a file
 *
 * 	YOUR ANSWER GOES HERE. PROVIDE EXAMPLE AND CONSEQUENCE.
 *
 * Fix: use strncpy instead to specify how much information is required to release
 *
 * 	YOUR ANSWER GOES HERE
 *
 **/

int main(int argc, char * argv[]) {
        char fileName[100]="/root/data/";
	char output[100];
        char c;
        FILE *file;

	sprintf(output,"Contents of: %s\n",argv[1]);
	printf(output);

        strcat(fileName, argv[1]);

        file = fopen(fileName, "r");

        if(file==NULL) {
                printf("Error: can't open file.\n");
                /* fclose(file); DON'T PASS A NULL POINTER TO fclose !! */
                return 1;
        } else {
                while((c=fgetc(file))!=EOF) {
                        putchar(c);
                }
                fclose(file);
                return 0;
        }
}

