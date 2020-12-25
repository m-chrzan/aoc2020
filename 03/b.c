#include <unistd.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>

#define BUF_SIZE 8192
#define NUM_SLOPES 5

char buffer[BUF_SIZE];

struct Pair {
    int x;
    int y;
};

struct Pair slopes[NUM_SLOPES];

ssize_t read_to_buffer() {
    ssize_t bytes = read(0, buffer, BUF_SIZE);
    return bytes;
}

int tree(int position) {
    if (buffer[position] == '.') {
        return 0;
    } else if (buffer[position] == '#') {
        return 1;
    }
}

int file_position(int x, int y, int line_length) {
    return (line_length + 2) * y + x;
}

int buffer_position(struct Pair pos, int line_length, int buffer_start) {
    return file_position(pos.x % line_length, pos.y, line_length) - buffer_start;
}

long long int find_trees() {
    int trees_hit[NUM_SLOPES];
    struct Pair next_check[NUM_SLOPES];
    for (int i = 0; i < NUM_SLOPES; i++) {
        trees_hit[i] = 0;
        next_check[i].x = slopes[i].x;
        next_check[i].y = slopes[i].y;
    }

    int y = 0;

    ssize_t bytes = read_to_buffer();
    int buffer_start = 0;
    int line_length = 0;
    while (buffer[line_length] != '\r') {
        line_length++;
    }

    while (bytes) {
        int checked = 5;
        while (checked == 5) {
            checked = 0;
            for (int i = 0; i < NUM_SLOPES; i++) {
                int position = buffer_position(next_check[i], line_length, buffer_start);
                if (position < bytes && position >= 0 && y == next_check[i].y) {
                    trees_hit[i] += tree(position);

                    next_check[i].x += slopes[i].x;
                    next_check[i].x %= line_length;
                    next_check[i].y += slopes[i].y;
                        
                    checked++;
                } else if (position < 0 || y < next_check[i].y) {
                    checked++;
                }
            }

            if (checked == NUM_SLOPES) {
                y++;
            }
        }

        buffer_start += bytes;
        bytes = read_to_buffer();
    }

    long long int res = 1;
    for (int i = 0; i < NUM_SLOPES; i++) {
        res *= trees_hit[i];
    }

    return res;
}

int main() {
    slopes[0].x = 1;
    slopes[0].y = 1;
    slopes[1].x = 3;
    slopes[1].y = 1;
    slopes[2].x = 5;
    slopes[2].y = 1;
    slopes[3].x = 7;
    slopes[3].y = 1;
    slopes[4].x = 1;
    slopes[4].y = 2;
    printf("%lld\n", find_trees());
}
