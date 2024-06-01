#include <iostream>
#include <fstream>
#include <cstring>
#include <fcntl.h>
#include <unistd.h>
#include <sys/stat.h>
#include <sys/mount.h>
#include <libisofs/libisofs.h>
#include <libburn/libburn.h>
#include "functions.h"

#ifdef __APPLE__
#include <TargetConditionals.h>
#endif

void copy_file(const char *input_file, const char *output_file, int block_size, int count, int skip, int seek) {
    int input_fd = open(input_file, O_RDONLY);
    if (input_fd < 0) {
        perror("Failed to open input file");
        exit(EXIT_FAILURE);
    }

    int output_fd = open(output_file, O_WRONLY | O_CREAT | O_TRUNC, 0644);
    if (output_fd < 0) {
        perror("Failed to open output file");
        close(input_fd);
        exit(EXIT_FAILURE);
    }

    char *buffer = new char[block_size];
    if (buffer == nullptr) {
        perror("Failed to allocate buffer");
        close(input_fd);
        close(output_fd);
        exit(EXIT_FAILURE);
    }

    lseek(input_fd, skip * block_size, SEEK_SET);
    lseek(output_fd, seek * block_size, SEEK_SET);

    for (int i = 0; i < count || count == 0; i++) {
        ssize_t bytes_read = read(input_fd, buffer, block_size);
        if (bytes_read < 0) {
            perror("Failed to read input file");
            break;
        } else if (bytes_read == 0) {
            break;  // End of file reached
        }

        ssize_t bytes_written = write(output_fd, buffer, bytes_read);
        if (bytes_written < 0) {
            perror("Failed to write output file");
            break;
        }
    }

    delete[] buffer;
    close(input_fd);
    close(output_fd);
}

void create_iso(const char *source_dir, const char *output_file) {
    struct iso_write_opts *opts = iso_write_opts_new();
    struct iso_tree_node *root = iso_tree_node_new("root");

    iso_tree_add_dir(root, source_dir, nullptr);

    struct iso_image *image = iso_image_new(opts);
    iso_image_set_root(image, root);

    struct burn_source *burn_source = burn_fd_source_new(open(output_file, O_WRONLY | O_CREAT, 0644));
    struct burn_drive *drive = nullptr;
    struct burn_write_opts *write_opts = burn_write_opts_new(drive);

    burn_write_image(write_opts, burn_source, image);

    iso_image_unref(image);
    iso_tree_node_unref(root);
    iso_write_opts_unref(opts);
}

void burn_cd_dvd(const char *device, const char *image) {
    struct burn_drive_info *drive_info;
    struct burn_drive *drive;
    struct burn_write_opts *opts;

    burn_initialize();
    burn_drive_scan(&drive_info, 0);

    drive = burn_drive_grab(drive_info->drive, 1);
    opts = burn_write_opts_new(drive);

    struct burn_source *src = burn_fd_source_new(open(image, O_RDONLY));
    burn_write_image(opts, src, drive);

    burn_finish();
}

void burn_dmg(const char *image_file, const char *device) {
    copy_file(image_file, device, 512, 0, 0, 0);
}

void create_app_image(const char *source_dir, const char *output_file, const char *volume_name, int size_mb) {
    #ifdef __APPLE__
    char command[1024];

    snprintf(command, sizeof(command), "hdiutil create -size %dm -fs HFS+ -volname %s -ov %s", size_mb, volume_name, output_file);
    if (system(command) != 0) {
        std::cerr << "Failed to create disk image" << std::endl;
        return;
    }

    snprintf(command, sizeof(command), "hdiutil attach %s -mountpoint /Volumes/%s", output_file, volume_name);
    if (system(command) != 0) {
        std::cerr << "Failed to mount disk image" << std::endl;
        return;
    }

    snprintf(command, sizeof(command), "rsync -av %s /Volumes/%s", source_dir, volume_name);
    if (system(command) != 0) {
        std::cerr << "Failed to copy files to disk image" << std::endl;
        return;
    }

    snprintf(command, sizeof(command), "hdiutil detach /Volumes/%s", volume_name);
    if (system(command) != 0) {
        std::cerr << "Failed to unmount disk image" << std::endl;
        return;
    }
    #else
    std::cerr << "create_app_image is only supported on macOS." << std::endl;
    #endif
}
