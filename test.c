#include<stdio.h>
int gcd(int a,int b) {
        if(a%b==0) 
            return b;
	    else 
            return (gcd(b,a%b));
}
int main()
{
    int a[10],b[10];
    for(int i=0;i<10;i++)
    {
        scanf("%d %d",&a[i],&b[i]);
    }
    printf("%d",gcd(a[0],b[0]));
}
