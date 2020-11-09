#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>
/**

You are doing a code review on the following credit trading system...

As root, on the RH7.2 Virtual Machine

	cd /vulnerable
	# replace the account.c with this one!!!!
	# chmod +x setup.bash
	./setup.bash

NOTE: Make sure the permssions are correct after you recompile account!

Make sure permissions are as follows: ls -al 

total 52
drwxr-xr-x    3 root     root         4096 Oct  4 22:02 .
drwxr-xr-x   20 root     root         4096 Oct  4 20:35 ..
-rwsr-sr-x    1 root     root        17459 Oct  4 21:58 account
-rw-------    1 root     root         4317 Oct  4 22:02 account.c
drwx------    2 root     root         4096 Oct  4 21:59 accounts
-rw-------    1 root     root          105 Oct  4 22:00 log
-rw-------    1 root     root           27 Oct  4 21:59 passwords
-rwx------    1 root     root          176 Oct  4 21:30 setup

Each user can now execute

/vulnerable/account myPassword   # to create my account with 100 credits, initialized with myPassword
/vulnerable/account myPassword 20 otherUser # give 20 credits to otherUser

1) Identify any bufferoverrun, integer overflow, canonical naming, priviledge escalation, denial of service etc.
   issues in this code. Submit a copy of the code annotated with the issues. To make it easier to
   find your annotations write ISSUE: before each issue you identify.
2) Demonstrate that the above vulnerabilities can be exploited and list the potential outcomes.
3) Fix the code so that the vulnerabilities are eliminated, or describe how the vulnerability/exploit
   should be addressed.


*/

// The user is not in the system, so add them and their password
int addUser(char * user, char * password){
	FILE * file;
	char fileName[100];
	fileName[0] = '\0';

	file=fopen("/vulnerable/passwords","a");
	fprintf(file, "%s %s\n", user, password);
	fclose(file);

	setAccount(user,100);

	return 0;
}
unsigned int getAccount(char * user){
	FILE * file;
	char fileName[100];
	fileName[0] = '\0';
	
	unsigned int amount=0;

	strncpy(fileName, "/vulnerable/accounts/",100);
	strncat(fileName, user, 100);
	if(file=fopen(fileName, "r")){
		fscanf(file, "%u", &amount);
		fclose(file);
	} else {
		return -1; // to signify that an account does not exist
	}
	return amount;
}
int setAccount(char * user, unsigned amount){
	FILE * file;
	char fileName[100], amountStr[100];
	fileName[0] = '\0';
	amountStr[0] = '\0';
	strncpy(fileName, "/vulnerable/accounts/",100);
	strncat(fileName, user, 100);
	file=fopen(fileName, "w");
	chmod(fileName, 0600);
	sprintf(amountStr, "%u", amount);
	fputs(amountStr,file);
	fclose(file);

}
int logTransaction(char * transaction){
	FILE * file;
	file=fopen("/vulnerable/log","a");
	fprintf(file, "%s\n", transaction);
	fclose(file);
	return 0;
}

int authenticate(char *user, char *password){
	FILE * file;
	char u[100], p[100];
	u[0] = '\0';
	p[0] = '\0';
	file=fopen("/vulnerable/passwords","r+");
	while(!feof(file)){
		fscanf(file,"%100s %100s\n",u, p);
		if(strncmp(user,u,100)==0){
			if(strncmp(password, p, 100)==0)return 1;
			else return 0;
		}
	}
	fclose(file);
	return 2;
}
int report(char * user){
	int c;
	FILE * file;
	char fileName[100], amountStr[100];
	fileName[0] = '\0';
	amountStr[0] = '\0';
	strncpy(fileName, "/vulnerable/accounts/",100);
	strncat(fileName, user, 100);
	file=fopen(fileName, "r");
	while((c=fgetc(file))!=-1){
		putchar(c);
	}
	fclose(file);
	printf("\n");
}

int main(int argc, char *argv[]){

	char user[100];
	char password[100];
	char transaction[2048];
	int auth;
	
	int i,j;

	password[0] = '\0';
	user[0] = '\0';

	if(argc!=2 && argc!=4){
		printf("account password (to setup/report on your account)\n");
		printf("account password amount targetAccount (to transfer)\n");
		return 0;
	}
	strncpy(user,getenv("USER"),100); // determine who is running this
	user[99] = '\0';

	/* for auditing purposes */
	transaction[0]='\0';
	strncat(transaction,user,2048);
	strncat(transaction,": ",2048);
	for(i=1;i<argc;i++){
		strncat(transaction,argv[i],2048);
		strncat(transaction," ",2048);
	}
	transaction[2047] = '\0';
	j = 0;
	while(j < len(user)){
		if (isalnum(user[j]) == 0){
			printf("Invalid username\n.");
			report(transaction);
			return 0;
		}
		j++;
	}
	
	strncpy(password,argv[1],99);
	password[99]='\0';

	auth=authenticate(user, password);

	if(argc==2){ 
	
		if(auth==2){
			addUser(user, password);
			printf("Your account has:\n");
			report(user);
		} else if(auth==1){
			printf("Your account has:\n");
			report(user);
		} else {
			printf("You have not been authenticated\n");
		}
	} else if(argc==4){ // perform a transfer to another account
		if(auth==1){
			j = 0;
			while(j < len(argv[3])){
				if (isalnum(argv[3][j]) == 0){
					printf("Invalid username\n.");
					report(transaction);
					return 0;
				}
				j++;
			}
			unsigned int fromAmount, amount, toAmount;
			amount=atoi(argv[2]);
			fromAmount=getAccount(user);
			toAmount=getAccount(argv[3]);
			if (amount < 0){
				printf("Cannot pass negative integer");

			} else if(toAmount==-1){
				printf("account %s does not exist\n",argv[3]);
			} else if(fromAmount-amount>0){
				printf("Your account had:\n");
				report(user);

				fromAmount=fromAmount-amount;
				toAmount=toAmount+amount;
				setAccount(user,fromAmount);
				setAccount(argv[3],toAmount);

				printf("Your account now has:\n");
				report(user);
			} else {
				printf("You do not have sufficient credits.\n");
			}
		} else { 
			printf("You have not been authenticated\n");
		} 
	}

	/* in any case, log the attempt */
	logTransaction(transaction);

	return 0;
}

