//
//  main.m
//  helloworld
//

#import "Other.h"

int main(int argc, const char * argv[]) {

    @autoreleasepool {
        int c = 0;
        if (argc == 1) {
            c = 1; 
        } else if (argc == 1) {
            c = 2;
        } else {
        }
        Other *object = [[Other alloc] init];
        [object sayHello];
    }
    return 0;
}

