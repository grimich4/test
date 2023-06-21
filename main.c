#include <stdio.h>
extern int mygetpid(void);

int main()
{
    printf("PID: %d\n", mygetpid());
    return 0;
}