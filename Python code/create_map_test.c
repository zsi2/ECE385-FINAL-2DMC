#include <stdio.h>

int main(void)
{
    unsigned int map0[100][5];
    for (int i = 0; i < 100; i++)
    {
        for (int j = 0; j < 5; j++)
        {
            if (i == 50)
            {
                map0[i][j] = 2;
            }
            else if (i > 50)
            {
                map0[i][j] = 1;
            }
            else
            {
                map0[i][j] = 0;
            }
        }
    }
    for (int i = 0; i < 100; i++)
    {
        for (int j = 0; j < 5; j++)
        {
            printf("%d", map0[i][j]);
        }
    }
    return 0;
}