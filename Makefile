#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: banthony <banthony@students.42.fr>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/11/23 16:22:07 by banthony          #+#    #+#              #
#    Updated: 2018/01/22 18:37:14 by banthony         ###   ########.fr        #
#                                                                              #
#******************************************************************************#

NAME = libfts.a

TEST = my_test

SRC += hello_world.s

OBJ = $(SRC:.s=.o)

UNAME := $(shell uname)

ifeq ($(UNAME), Linux)
NFLAGS = -f elf64 -DLINUX -p ./syscall_macro.s
FLAGS = -Wall -Wextra -Werror -g3
endif

ifeq ($(UNAME), Darwin)
NFLAGS = -f macho64 -DOSX --prefix _ -p ./syscall_macro.s
FLAGS = -Wall -Wextra -Werror -g3 -Weverything
endif

all: $(NAME) $(TEST)

$(NAME): $(SRC) $(OBJ)
	ar rc $(NAME) $(OBJ)
	ranlib $(NAME)

$(TEST): $(NAME) main.c main.o
	gcc $(FLAGS) -c main.c
	gcc -o $(TEST) $(FLAGS) main.o $(NAME)

%.o: %.s
	nasm $(NFLAGS) $< -o $@

clean:
	rm -f $(OBJ) main.o

fclean: clean
	rm -f $(NAME) $(TEST) Makefile~ note.txt~ ./*.s~

re: fclean all