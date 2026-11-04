#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int prefixcomun(char* str1, char* str2, int l1, int l2);

//13. Se dau trei siruri de caractere. Sa se afiseze cel mai lung sufix comun pentru fiecare din cele trei perechi de 
//cate doua siruri ce se pot forma.
}
                  
int main() {

    int lungimesufix;

    char str1[] = "brteeereze";

    char str2[] = "btdpeze";

    char str3[] = "brtcssssswwereze";

    lungimesufix = prefixcomun(str1, str2, strlen(str1)-1, strlen(str2) - 1);
    printf("Cel mai lung sufix a lui str1 si str 2: %.*s\n", lungimesufix, str1 + (strlen(str1) - lungimesufix));

    lungimesufix = prefixcomun(str1, str3, strlen(str1) - 1, strlen(str3) - 1);

    printf("Cel mai lung sufix a lui str1 si str 3: %.*s\n", lungimesufix, str1 + (strlen(str1) - lungimesufix));

    lungimesufix = prefixcomun(str2, str3, strlen(str2) - 1, strlen(str3) - 1);
    printf("Cel mai lung sufix a lui str2 si str 3: %.*s\n", lungimesufix, str2 + (strlen(str2) - lungimesufix));

    return 0;
}