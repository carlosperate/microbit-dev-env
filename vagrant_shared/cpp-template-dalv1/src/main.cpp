#include "MicroBit.h"

void app_main() {
    uBit.display.print("Hello World!");
    uBit.sleep(1000);
    uBit.display.scroll("end");
}
