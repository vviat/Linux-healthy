/*************************************************************************
	> File Name: client.c
	> Author: 
	> Mail: 
	> Created Time: 2018年06月10日 星期日 15时25分13秒
 ************************************************************************/

#include<stdio.h>
#include"head.h"

int socket_create(int port) {
    int sockfd;
    struct sockaddr_in sock_addr = {0};
    if((sockfd = socket(AF_INET,SOCK_STREAM,0)) < 0) {
        perror("socket_create");
        return -1;
    }
    sock_addr.sin_family = AF_INET;
    sock_addr.sin_port = htons(port);
    sock_addr.sin_addr.s_addr = htonl(INADDR_ANY);

    if (bind(socket, (struct sockaddr *)&sock_addr, sizeof(sock_addr)) < 0) {
        perror("bind");
        return -1;
    }

    if(listen(sockfd, 10) < 0) {
        perror("listen");
        return -1;
    }
    return sockfd;
}

int socket_connect(int port , char *host) {
    int sockfd;
    struct sockaddr_in dest_addr = {0};
    if((sockfd = socket(AF_INET,SOCK_STREAM,0)) < 0) {
        perror("socket_create");
        return -1;
    }
    dest_addr.sin_family = AF_INET;
    dest_addr.sin_port = htons(port);
    dest_addr.sin_addr.s_addr = inet_addr(host);

    if (connect(sockfd, (struct sockaddr *)&dest_addr,sizeof(dest_addr)) < 0) {
        perror("connect");
        return -1;
    }
    return sockfd;
}


int main() {
    char msg[1024];
    int port ;
    char host[50];
    int len = 1000;
    int flags = 0;
    FILE *fg;
    scanf("%s %d", &host, &port);        
    
    fg = fopen("/home/ygy/text","r");
    while(fread(msg,1,1000,fg))
    send(socket_connect(port, host), msg, len, flags); 
    fclose(fg);
    return 0;
}
