#include "include/raylib.h"
#include "include/raymath.h"
#include <math.h>
#include <stdio.h>
#include <time.h>

int main() {
    SetWindowMonitor(0);
    InitWindow(500, 500, "Hello, raylib!");

    SetWindowPosition(600,200);
    SetTargetFPS(1200);

    int draw = 0;
    double x = 0, y = 0;
    double temp = 0;

    srand(time(0));

    while (!WindowShouldClose()) {
        BeginDrawing();

        for (int j = -250; j < 250; j++) {
            for (int i = -250; i < 250; i++) {
                draw = 1;
                x = 0;
                y = 0;
                for (int k = 0; k < 100; k++){
                    temp = x;
                    x = x*x - y*y + i/200.;
                    y = 2.*temp*y + j/200.;
                    if ( (x*x + y*y) >= 4.) {
                        draw = 0;
                        break;
                    }
                }
                if (draw==1) {
                    DrawPixel(i+250, j+250, WHITE);
                }
            }
        }
        
        EndDrawing();
    }

    CloseWindow();

    return 0;
}
