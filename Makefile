#******************************************************************************#
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: banthony <banthony@students.42.fr>         +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2015/11/23 16:22:07 by banthony          #+#    #+#              #
#    Updated: 2018/03/05 19:28:24 by banthony         ###   ########.fr        #
#                                                                              #
#******************************************************************************#

NAME = libfts.a

MYTEST = my_test
QPTEST = qp_test

SRC += hello_world.s

SRC += ft_bzero.s
SRC += ft_strcat.s
SRC += ft_isalpha.s
SRC += ft_isdigit.s
SRC += ft_isalnum.s
SRC += ft_isascii.s
SRC += ft_isprint.s
SRC += ft_toupper.s
SRC += ft_tolower.s
SRC += ft_puts.s

SRC += ft_strlen.s
SRC += ft_memset.s
SRC += ft_memcpy.s
SRC += ft_strdup.s

SRC += ft_cat.s

OBJ = $(SRC:.s=.o)

UNAME := $(shell uname)

ifeq ($(UNAME), Linux)
NFLAGS = -f elf64 -DLINUX -p ./syscall_macro.s
FLAGS = -Wall -Wextra -Werror -g3
endif

ifeq ($(UNAME), Darwin)
NFLAGS = -f macho64 -DOSX --prefix _ -p ./syscall_macro.s
FLAGS = -Wall -Wextra -Werror -g3
endif

all: $(NAME) $(QPTEST) $(MYTEST)

$(NAME): $(SRC) $(OBJ)
	@ar rc $(NAME) $(OBJ)
	@ranlib $(NAME)

$(MYTEST): $(NAME) main.c main.o
	@gcc $(FLAGS) -Weverything -c main.c
	@gcc -o $(MYTEST) $(FLAGS) -Weverything main.o $(NAME)
	./$(MYTEST)

$(QPTEST): $(NAME) main_qperez.c main_qperez.o
	@gcc $(FLAGS) -c main_qperez.c
	@gcc -o $(QPTEST) $(FLAGS) main_qperez.o $(NAME)
	./$(QPTEST)

%.o: %.s
	@nasm $(NFLAGS) $< -o $@

clean:
	@rm -f $(OBJ) main_qperez.o main.o

fclean: clean
	@rm -f $(NAME) $(MYTEST) $(QPTEST) Makefile~ note.txt~ ./*.s~ ./*.c~ ./*.h~

re: fclean all
