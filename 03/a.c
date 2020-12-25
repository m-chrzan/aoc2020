#include <unistd.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>

#define BUF_SIZE 8192

char buffer[BUF_SIZE];

ssize_t read_to_buffer() {
    ssize_t bytes = read(0, buffer, BUF_SIZE);
    if (bytes < 0) {
        printf("failed to read\n");
        exit(1);
    }
    return bytes;
}

int tree(int position) {
    if (buffer[position] == '.') {
        return 0;
    } else if (buffer[position] == '#') {
        return 1;
    } else {
        printf("unknown character\n");
        exit(1);
    }
}

int file_position(int x, int y, int line_length) {
    return (line_length + 2) * y + x;
}

int buffer_position(int x, int y, int line_length, int buffer_start) {
    return file_position(x % line_length, y, line_length) - buffer_start;
}

int find_trees() {
    int buffer_start = 0;
    int line_length = 0;
    int x = 0;
    int y = 0;
    ssize_t bytes = read_to_buffer();
    int trees_hit = tree(0);

    while (buffer[line_length] != '\r') {
        line_length++;
    }

    int i = 2;
    while (bytes) {
        while (buffer_position(x + 3, y + 1, line_length, buffer_start) < bytes) {
            y += 1;
            x += 3;

            trees_hit += tree(buffer_position(x, y, line_length, buffer_start));
        }

        buffer_start += bytes;
        bytes = read_to_buffer();
    }

    return trees_hit;
}

int main() {
    printf("%d\n", find_trees());
}
