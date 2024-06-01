#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "functions.h"

void print_usage(const char *prog_name) {
    fprintf(stderr, "Usage: %s <command> [options]\n", prog_name);
    fprintf(stderr, "Commands:\n");
    fprintf(stderr, "  copy <input_file> <output_file> [block_size] [count] [skip] [seek]\n");
    fprintf(stderr, "  iso <source_dir> <output_file>\n");
    fprintf(stderr, "  burn <device> <image_file>\n");
    fprintf(stderr, "  usb <input_file> <usb_device> [block_size] [count] [skip] [seek]\n");
    fprintf(stderr, "  dmg <image_file> <device>\n");
}

int main(int argc, char *argv[]) {
    if (argc < 2) {
        print_usage(argv[0]);
        exit(EXIT_FAILURE);
    }

    if (strcmp(argv[1], "copy") == 0) {
        if (argc < 4) {
            print_usage(argv[0]);
            exit(EXIT_FAILURE);
        }
        const char *input_file = argv[2];
        const char *output_file = argv[3];
        int block_size = (argc > 4) ? atoi(argv[4]) : 512;
        int count = (argc > 5) ? atoi(argv[5]) : 0;
        int skip = (argc > 6) ? atoi(argv[6]) : 0;
        int seek = (argc > 7) ? atoi(argv[7]) : 0;

        copy_file(input_file, output_file, block_size, count, skip, seek);
    } else if (strcmp(argv[1], "iso") == 0) {
        if (argc < 4) {
            print_usage(argv[0]);
            exit(EXIT_FAILURE);
        }
        const char *source_dir = argv[2];
        const char *output_file = argv[3];

        create_iso(source_dir, output_file);
    } else if (strcmp(argv[1], "burn") == 0) {
        if (argc < 4) {
            print_usage(argv[0]);
            exit(EXIT_FAILURE);
        }
        const char *device = argv[2];
        const char *image_file = argv[3];

        burn_cd_dvd(device, image_file);
    } else if (strcmp(argv[1], "usb") == 0) {
        if (argc < 4) {
            print_usage(argv[0]);
            exit(EXIT_FAILURE);
        }
        const char *input_file = argv[2];
        const char *usb_device = argv[3];
        int block_size = (argc > 4) ? atoi(argv[4]) : 512;
        int count = (argc > 5) ? atoi(argv[5]) : 0;
        int skip = (argc > 6) ? atoi(argv[6]) : 0;
        int seek = (argc > 7) ? atoi(argv[7]) : 0;

        copy_file(input_file, usb_device, block_size, count, skip, seek);
    } else if (strcmp(argv[1], "dmg") == 0) {
        if (argc < 4) {
            print_usage(argv[0]);
            exit(EXIT_FAILURE);
        }
        const char *image_file = argv[2];
        const char *device = argv[3];

        burn_dmg(image_file, device);
    } else {
        fprintf(stderr, "Unknown command: %s\n", argv[1]);
        print_usage(argv[0]);
        exit(EXIT_FAILURE);
    }

    return 0;
}
