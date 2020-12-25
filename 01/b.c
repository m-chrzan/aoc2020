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

int bin_search(int small_pointer, int large_pointer) {
    int small = input[small_pointer];
    int big = input[large_pointer];
    int mid = (large_pointer + small_pointer) / 2;
    int sum = small + big + input[mid];
    while (sum != 2020 && small_pointer < large_pointer) {
        if (sum > 2020) {
            large_pointer = mid - 1;
            mid = (large_pointer + small_pointer) / 2;
        } else {
            small_pointer = mid + 1;
            mid = (large_pointer + small_pointer) / 2;
        }
        sum = small + big + input[mid];
    }

    if (sum == 2020) {
        return mid;
    } else {
        return -1;
    }
}

int search_2020() {
    int small_pointer = 0;
    int large_pointer = length - 1;
    int sum_small = input[small_pointer] + input[small_pointer + 1] + input[large_pointer];
    int sum_large = input[small_pointer] + input[large_pointer] + input[large_pointer - 1];
    int done = 0;
    int mid;
    while (sum_large != 2020 && sum_small != 2020 && small_pointer + 1 != large_pointer && !done) {
        if (sum_small > 2020) {
            large_pointer--;
        } else if (sum_large < 2020) {
            small_pointer++;
        } else {
            mid = bin_search(small_pointer, large_pointer);
            if (mid > 0) {
                done = 1;
            } else {
                mid = bin_search(small_pointer + 1, large_pointer);
                if (mid > 0) {
                    done = 1;
                } else {
                    mid = bin_search(small_pointer, large_pointer - 1);
                    if (mid > 0) {
                        done = 1;
                    } else {
                        small_pointer++;
                        large_pointer--;
                    }
                }
            }
        }

        sum_small = input[small_pointer] + input[small_pointer + 1] + input[large_pointer];
        sum_large = input[small_pointer] + input[large_pointer] + input[large_pointer - 1];
    }
    return input[small_pointer] * input[large_pointer] * input[mid];
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

