#include <iostream>
#include <cstdlib>
#include <cstring>
#include "functions.h"

void print_usage(const char *prog_name) {
    std::cerr << "Usage: " << prog_name << " <command> [options]\n";
    std::cerr << "Commands:\n";
    std::cerr << "  copy <input_file> <output_file> [block_size] [count] [skip] [seek]\n";
    std::cerr << "  iso <source_dir> <output_file>\n";
    std::cerr << "  burn <device> <image_file>\n";
    std::cerr << "  usb <input_file> <usb_device> [block_size] [count] [skip] [seek]\n";
    std::cerr << "  dmg <image_file> <device>\n";
    std::cerr << "  app <source_dir> <output_file> <volume_name> <size_mb>\n";
    std::cerr << "  installmedia <installer_path> <volume>\n";
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
        int block_size = (argc > 4) ? std::atoi(argv[4]) : 512;
        int count = (argc > 5) ? std::atoi(argv[5]) : 0;
        int skip = (argc > 6) ? std::atoi(argv[6]) : 0;
        int seek = (argc > 7) ? std::atoi(argv[7]) : 0;

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
        int block_size = (argc > 4) ? std::atoi(argv[4]) : 512;
        int count = (argc > 5) ? std::atoi(argv[5]) : 0;
        int skip = (argc > 6) ? std::atoi(argv[6]) : 0;
        int seek = (argc > 7) ? std::atoi(argv[7]) : 0;

        copy_file(input_file, usb_device, block_size, count, skip, seek);
    } else if (strcmp(argv[1], "dmg") == 0) {
        if (argc < 4) {
            print_usage(argv[0]);
            exit(EXIT_FAILURE);
        }
        const char *image_file = argv[2];
        const char *device = argv[3];

        burn_dmg(image_file, device);
    } else if (strcmp(argv[1], "app") == 0) {
        if (argc < 6) {
            print_usage(argv[0]);
            exit(EXIT_FAILURE);
        }
        const char *source_dir = argv[2];
        const char *output_file = argv[3];
        const char *volume_name = argv[4];
        int size_mb = std::atoi(argv[5]);

        create_app_image(source_dir, output_file, volume_name, size_mb);
    } else if (strcmp(argv[1], "installmedia") == 0) {
        if (argc < 4) {
            print_usage(argv[0]);
            exit(EXIT_FAILURE);
        }
        const char *installer_path = argv[2];
        const char *volume = argv[3];

        create_install_media(installer_path, volume);
    } else {
        std::cerr << "Unknown command: " << argv[1] << "\n";
        print_usage(argv[0]);
        exit(EXIT_FAILURE);
    }

    return 0;
}
