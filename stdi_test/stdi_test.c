
#include <stdio.h>

int main()
{
    char str[100]; /*Ojo que el tamaño del array que guarde los carácteres debe ser MAYOR
                    al tamaño de carácteres esperados, sino, 'stack smashing detected'
                    queda la zorra, errores de memoria varios"*/
    int i;

    printf("Enter a value: ");
    scanf("%s  %d", str, &i);

    printf("\n You entered: %s, %d", str, i);

    return 0;
}
