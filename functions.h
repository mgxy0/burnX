#ifndef FUNCTIONS_H
#define FUNCTIONS_H

void copy_file(const char *input_file, const char *output_file, int block_size, int count, int skip, int seek);
void create_iso(const char *source_dir, const char *output_file);
void burn_cd_dvd(const char *device, const char *image);
void burn_dmg(const char *image_file, const char *device);

#endif // FUNCTIONS_H
