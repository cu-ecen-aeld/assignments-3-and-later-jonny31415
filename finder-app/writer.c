#include <syslog.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <string.h>

int main(int argc, char* argv[]){
	
        // Configure syslog
        openlog("[writer.c]", LOG_PID|LOG_CONS, LOG_USER);
	
	// Raises error if argc !=2
	if(argc != 3){
		printf("ERROR: You must provide exactly 2 arguments to the script, as follows:\n\t 1) Filepath to a file on the filesystem; \n\t 2) Text string which will be written within the especified file.");
		syslog(LOG_ERR, "Number of command line arguments different of two!");
		return 1;
	}
	
	// Executes program normally
	char* writefile = argv[1];
	char* writestr = argv[2];
	int fd;
	ssize_t nr;
	
	fd = open(writefile, O_WRONLY|O_CREAT, 777);
	printf("%d", fd);
	// Open file error
	if(fd == -1){
		syslog(LOG_ERR, "Error opening file!");
		return 1;
	}
	
	nr = write(fd, writestr, strlen(writestr));
	syslog(LOG_DEBUG, "Writing %s to %s", writestr, writefile);
	// Write file error
	if(nr == -1){
		syslog(LOG_ERR, "Error writing to file!");
		return 1;
	}
	
	// Close file error
	if(close(fd) == -1){
		syslog(LOG_ERR, "Error closing file!");
		return 1;
	}
	
	closelog();

	return 0;
}


