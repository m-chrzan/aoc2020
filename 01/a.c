#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <unistd.h>

#define BUF_SIZE 2000

char buf[BUF_SIZE];
int input[200];
int length;

void read_input() {
    int fd = open("input.txt", O_RDONLY);
    ssize_t bytes_read = read(fd, buf, BUF_SIZE-1);
    if (bytes_read <= 0) {
        printf("Error reading input\n");
        exit(1);
    }
    buf[bytes_read] = '\0';
}

void parse_input() {
    int offset = 0;
    int done = 0;
    int buf_offset = 0;
    int i = 0;
    char current[10];

    while (!done) {
        int current_offset = 0;
        while (buf[buf_offset] != '\n' && buf[buf_offset] != '\0') {
            current[current_offset++] = buf[buf_offset++];
        }
        if (buf[buf_offset] == '\0') {
            done = 1;
        } else {
            buf_offset++;
            current[current_offset] = '\0';
            input[i++] = atoi(current);
            length = i;
        }
    }
}

int int_less(const void *a, const void *b) {
    return *(int *)a - *(int *)b;
}

void sort_input() {
    qsort(input, length, sizeof(int), int_less);
}

int search_2020() {
    int small_pointer = 0;
    int large_pointer = length - 1;
    int sum = input[small_pointer] + input[large_pointer];
    while (sum != 2020 && small_pointer != large_pointer) {
        if (sum > 2020) {
            large_pointer--;
        } else {
            small_pointer++;
        }
        sum = input[small_pointer] + input[large_pointer];
    }
    return input[small_pointer] * input[large_pointer];
}

void print_input() {
    for (int i = 0; i < length; i++) {
        printf("%d\n", input[i]);
    }
}

int main() {
    read_input();
    parse_input(); 
    sort_input();
    printf("%d\n", search_2020());
}
