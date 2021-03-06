#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#define BUF_SIZE 8192

enum State {
    FIRST_NUMBER,
    DASH,
    SECOND_NUMBER,
    SPACE,
    LETTER,
    COLON,
    SPACE2,
    PASSWORD,
    EOL,
    EOI
};

struct state {
    enum State s;
    char letter;
    int min;
    int max;
    int count;
};

char buffer[BUF_SIZE];

int get_digit(char c) {
    if (c <= '9' && c >= '0') {
        return c-'0';
    }
}

void parse_byte(struct state *state, char c) {
    switch (state->s) {
    case PASSWORD:
password:
        if (c == state->letter) {
            state->count++;
        } else if (c == '\n') {
            state->s = EOL;
        }
        break;
    case FIRST_NUMBER:
        if (c == '-') {
            state->s = DASH;
        } else {
            int digit = get_digit(c);
            state->min *= 10;
            state->min += digit;
        }
        break;
    case DASH:
        state->s = SECOND_NUMBER;
    case SECOND_NUMBER:
        if (c == ' ') {
            state->s = SPACE;
        } else {
            int digit = get_digit(c);
            state->max *= 10;
            state->max += digit;
        }
        break;
    case SPACE:
        state->letter = c;
        state->s = COLON;
        break;
    case COLON:
        state->s = SPACE2;
        break;
    case SPACE2:
        state->s = PASSWORD;
        goto password;
    }
}

int count_correct() {
    int fd = open("input.txt", O_RDONLY);
    struct state state;
    state.s = FIRST_NUMBER;
    state.min = 0;
    state.max = 0;
    state.letter = '\0';
    state.count = 0;
    int count = 0;

    while (state.s != EOI) {
        ssize_t bytes = read(fd, buffer, BUF_SIZE);
        if (bytes < 0) {
            printf("failed to read!\n");
            exit(1);
        } else if (bytes == 0) {
            state.s = EOI;
        }

        for (int i = 0; i < bytes; i++) {
            parse_byte(&state, buffer[i]);
            if (state.s == EOL) {
                if (state.count >= state.min && state.count <= state.max) {
                    count++;
                }
                state.s = FIRST_NUMBER;
                state.min = 0;
                state.max = 0;
                state.letter = '\0';
                state.count = 0;
            }
        }
    }
    return count;
}

int main() {
    printf("%d\n", count_correct());
}
