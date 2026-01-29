#include <stdio.h>
#include "bindings_v1.h"
#include "bindings_v2.h"

int main() {
  printf("Calling v1_repro()...\n");
  v1_repro();
  printf("Calling v2_repro()...\n");
  v2_repro();
  printf("Done!\n");
  return 0;
}
