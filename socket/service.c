/*************************************************************************
	> File Name: service.c
	> Author: 
	> Mail: 
	> Created Time: 2018年06月10日 星期日 15时27分33秒
 ************************************************************************/

#include<stdio.h>
#include"head.h"
#define MAXLIFE 4096

int socket_create(int port) {
    int sockfd;
    struct sockaddr_in sock_addr;
    if((sockfd = socket(AF_INET,SOCK_STREAM,0)) < 0) {
        perror("socket_create");
        return -1;
    }

    sock_addr.sin_family = AF_INET;
    sock_addr.sin_port = htons(port);
    sock_addr.sin_addr.s_addr = htonl(INADDR_ANY);

    if (bind(sockfd, (struct sockaddr *)&sock_addr,sizeof(sock_addr)) < 0) {
        perror("bind");
        return -1;
    }

    if(listen(sockfd,10) < 0) {
        perror("linsten");
        return -1;
    }

    return sockfd;


}
int socket_connect(int port, char *host) {
    int sockfd;
    struct sockaddr_in dest_addr;

    if ((sockfd = socket(AF_INET, SOCK_STREAM,0)) < 0) {
        perror("socket_create");
        return -1;
    }
    dest_addr.sin_family = AF_INET;
    dest_addr.sin_port = htons(port);
    dest_addr.sin_addr.s_addr = inet_addr(host);



    if(connect(sockfd,(struct sockaddr *)&dest_addr,sizeof(dest_addr)) < 0){
        perror("connect");
        return -1;
    }

    return sockfd;
}


int main() {
    int connfd,sockfd;
    char buff[4096];
    int n;
    sockfd = socket_create(1111);
    int a;
    while(1) {
        if((connfd = accept(sockfd, (struct sockaddr *)NULL, NULL)) < 0) {
            perror("error");
            close(connfd);
            break;
        }
        n = recv(connfd, buff, MAXLIFE, 0);
        buff[n] = '\0';
        printf("recv msg : %s\n",buff);
	close(connfd);
    }
   

    return 0;
}
