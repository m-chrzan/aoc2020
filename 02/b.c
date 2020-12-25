#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#define BUF_SIZE (32*8192)

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
    char pos1;
    char pos2;
    char current_pos;
    char matches;
};

char buffer[BUF_SIZE];

void parse_byte(struct state *state, char c) {
    switch (state->s) {
    case PASSWORD:
password:
        state->current_pos++;
        if (c == '\n') {
            state->s = EOL;
        } else if (state->letter == c && (state->current_pos == state->pos1 || state->current_pos == state->pos2)) {
            state->matches++;
        }
        
        break;
    case FIRST_NUMBER:
        if (c == '-') {
            state->s = DASH;
        } else {
            int digit = c-'0';
            state->pos1 *= 10;
            state->pos1 += digit;
        }
        break;
    case DASH:
        state->s = SECOND_NUMBER;
    case SECOND_NUMBER:
        if (c == ' ') {
            state->s = SPACE;
        } else {
            int digit = c-'0';
            state->pos2 *= 10;
            state->pos2 += digit;
        }
        break;
    case SPACE:
        state->letter = c;
        state->s = LETTER;
        break;
    case LETTER:
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
    state.pos1 = 0;
    state.pos2 = 0;
    state.letter = '\0';
    state.current_pos = 0;
    state.matches = 0;
    int count = 0;

    while (state.s != EOI) {
        ssize_t bytes = read(fd, buffer, BUF_SIZE);

        if (bytes == 0) {
            state.s = EOI;
        }

        for (int i = 0; i < bytes; i++) {
            parse_byte(&state, buffer[i]);
            if (state.s == EOL) {
                if (state.matches == 1) {
                    count++;
                }
                state.s = FIRST_NUMBER;
                state.pos1 = 0;
                state.pos2 = 0;
                state.letter = '\0';
                state.current_pos = 0;
                state.matches = 0;
            }
        }
    }
    return count;
}

int main() {
    printf("%d\n", count_correct());
}
