
/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: banthony <banthony@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2017/12/28 20:43:53 by banthony          #+#    #+#             */
/*   Updated: 2018/03/08 18:55:20 by banthony         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <fcntl.h>
#include "libfta.h"

typedef enum	e_functions
{
	BZERO, STRCAT, ISALPHA, ISDIGIT, ISALNUM, ISASCII, ISPRINT, TOUPPER, TOLOWER, PUTS, END_ONE,
	STRLEN, MEMSET, MEMCPY, STRDUP, END_TWO,
	CAT, END,
}				t_functions;

# define WHITE "\033[0m"
# define RED "\033[31m"
# define GREEN "\033[32m"
# define YELLOW "\033[33m"
# define PINK "\033[35m"

int		my_test(int function, const char **av);
void 	my_print_memory(void *addr, size_t size);
void	hello_world(void);

static size_t	my_strlen(const char *s)
{
	size_t i;

	i = 0;
	if (s)
	{
		while (s[i])
			i++;
	}
	return (i);
}

static void my_putchar(char c)
{
	write(1, &c, 1);
}

static void my_putnbr(int nb)
{
	if (nb < 0)
	{
		my_putchar('-');
		nb = -nb;
	}
	if (nb >= 10)
	{
		my_putnbr(nb / 10);
		my_putnbr(nb % 10);
	}
	else
		my_putchar((char)(nb + '0'));
}

static void my_putstr(char *str)
{
	write(1, str, my_strlen(str));
}

static void my_putchar_base(unsigned char c, unsigned int base, char *tab)
{
	if (!tab || !base)
		return ;
	my_putchar(tab[c / base]);
	my_putchar(tab[c % base]);
}

static void my_putstrcol(char *color, char *str)
{
	my_putstr(color);
	my_putstr(str);
	my_putstr(WHITE);
}

/* MAIN */

int main(int ac, const char **av)
{
	int i = 0;
	int ret = 0;

	hello_world();
	my_putstrcol(PINK, "/// LIBASM PART ONE \\\\\\\n");
	while (i < END)
	{
		if (i == END_ONE)
			my_putstrcol(PINK, "/// LIBASM PART TWO \\\\\\\n");
		if (i == END_TWO)
			my_putstrcol(PINK, "/// LIBASM END PART  \\\\\\\n");

		if (!(ret = my_test(i, av)))
			my_putstrcol(RED, "KO\n");
		else if (ret == 84)
			my_putstrcol(YELLOW, "YOU HAVE TO CHECK OUTPUTS\n");
		else if (ret != 42)
			my_putstrcol(GREEN, "OK\n");
		i++;
	}
	(void)ac;
	(void)av;
	return (0);
}

/* TEST */

int my_test(int function, const char **av)
{
	if (function == BZERO)
	{
		my_putstrcol(YELLOW, "ft_bzero: str:\n");
		char str[10] = "0123456789";
		my_print_memory((void*)str, 10);

		my_putstrcol(YELLOW, "ft_bzero(&str[8], 1):\n");
		ft_bzero((void*)&str[8], 1);
		my_print_memory((void*)str, 10);

		my_putstrcol(YELLOW, "ft_bzero(&str[3], 4):\n");
		ft_bzero((void*)&str[3], 4);
		my_print_memory((void*)str, 10);

		ft_bzero(NULL, 10);

// CAS VICIEUX OU L'UTILISATEUR DECLARE: void ft_bzero(void *data, int n)
/*		my_putstrcol(YELLOW, "ft_bzero(&str[9], -2):\n");
		ft_bzero((void*)&str[9], -25654);
		my_print_memory((void*)str, 10);
*/
		my_putstrcol(YELLOW, "ft_bzero(str, 10):\n");
		ft_bzero((void*)str, 10);
		my_print_memory((void*)str, 10);

		my_putstrcol(YELLOW, "ft_bzero: ");
		return (84);
	}

	if (function == STRCAT)
	{
		my_putstrcol(YELLOW, "ft_strcat: ");
		char str[48] = {0};
		char str2[48] = {0};
		char *retour2 = NULL;
		char *retour = NULL;

		strncpy(str, "0123456789", 10);
		strncpy(str2, "0123456789", 10);

		ft_strcat(str, "salut");
		strcat(str2, "salut");

		if (memcmp(str, str2, 15) == 0)
			my_putstrcol(GREEN, ".");
		else
			return (0);

		if (!(retour = ft_strcat(NULL, str)))
			my_putstrcol(GREEN, ".");

		if (!(retour = ft_strcat(str, NULL)))
			my_putstrcol(GREEN, ".");


		retour2 = strcat(str2, "--BONJOUR--");
		retour = ft_strcat(str, "--BONJOUR--");
		if ((memcmp(str, str2, 26) == 0) && (memcmp(retour, retour2, 26) == 0))
			my_putstrcol(GREEN, ".");
		else
			return (0);

		retour2 = strcat(str2, "LAST CALL");
		retour = ft_strcat(str, "LAST CALL");
		if ((memcmp(str, str2, 35) == 0) && (memcmp(retour, retour2, 35) == 0))
			my_putstrcol(GREEN, ".");
		else
			return (0);


		return (1);
	}

	if (function == ISALPHA)
	{
		my_putstrcol(YELLOW, "ft_isalpha: ");
		if (!(ft_isalpha('A')))
			return (0);
		my_putstrcol(GREEN, ".");
		if (!(ft_isalpha('Z')))
			return (0);
		my_putstrcol(GREEN, ".");
		if (!(ft_isalpha('a')))
			return (0);
		my_putstrcol(GREEN, ".");
		if (!(ft_isalpha('z')))
			return (0);
		my_putstrcol(GREEN, ".");
		if (ft_isalpha('@'))
			return (0);
		my_putstrcol(GREEN, ".");
		if (ft_isalpha('['))
			return (0);
		my_putstrcol(GREEN, ".");
		if (ft_isalpha('`'))
			return (0);
		my_putstrcol(GREEN, ".");
		if (ft_isalpha('{'))
			return (0);
		my_putstrcol(GREEN, ".");
		return (1);
	}

	if (function == ISDIGIT)
	{
		my_putstrcol(YELLOW, "ft_isdigit: ");
		if (!(ft_isdigit('0')))
			return (0);
		my_putstrcol(GREEN, ".");
		if (!(ft_isdigit('9')))
			return (0);
		my_putstrcol(GREEN, ".");
		if (ft_isdigit('/'))
			return (0);
		my_putstrcol(GREEN, ".");
		if (ft_isdigit(':'))
			return (0);
		my_putstrcol(GREEN, ".");
		return (1);
	}

	if (function == ISALNUM)
	{
		my_putstrcol(YELLOW, "ft_isalnum: ");
		if (!(ft_isalnum('0')))
			return (0);
		my_putstrcol(GREEN, ".");
		if (!(ft_isalnum('9')))
			return (0);
		my_putstrcol(GREEN, ".");
		if (!(ft_isalpha('a')))
			return (0);
		my_putstrcol(GREEN, ".");
		if (!(ft_isalpha('Z')))
			return (0);
		my_putstrcol(GREEN, ".");
		if (ft_isalnum('/'))
			return (0);
		my_putstrcol(GREEN, ".");
		if (ft_isalnum(':'))
			return (0);
		my_putstrcol(GREEN, ".");
		if (ft_isalnum('@'))
			return (0);
		my_putstrcol(GREEN, ".");
		if (ft_isalnum('['))
			return (0);
		my_putstrcol(GREEN, ".");
		if ((ft_isalnum('*')))
			return (0);
		my_putstrcol(GREEN, ".");
		return (1);
	}

	if (function == ISASCII)
	{
		my_putstrcol(YELLOW, "ft_isascii: ");
		if (!(ft_isascii(0)))
			return (0);
		my_putstrcol(GREEN, ".");
		if (!(ft_isascii(127)))
			return (0);
		my_putstrcol(GREEN, ".");
		if ((ft_isascii(128)))
			return (0);
		my_putstrcol(GREEN, ".");
		if ((ft_isascii(-1)))
			return (0);
		my_putstrcol(GREEN, ".");
		if ((ft_isascii(42000)))
			return (0);
		my_putstrcol(GREEN, ".");
		return (1);
	}

	if (function == ISPRINT)
	{
		my_putstrcol(YELLOW, "ft_isprint: ");
		if (!(ft_isprint(' ')))
			return (0);
		my_putstrcol(GREEN, ".");
		if (!(ft_isprint('~')))
			return (0);
		my_putstrcol(GREEN, ".");
		if ((ft_isprint(31)))
			return (0);
		my_putstrcol(GREEN, ".");
		if ((ft_isprint(127)))
			return (0);
		my_putstrcol(GREEN, ".");
		return (1);
	}

	if (function == TOUPPER)
	{
		my_putstrcol(YELLOW, "ft_toupper: ");
		char *str = "1 - salut LES amis CouCou !";
		size_t len = my_strlen(str);
		char result[100] = {0};
		char result2[100] = {0};
		size_t i = 0;

		while (i < len)
		{
			result[i] = (char)ft_toupper((int)str[i]);
			result2[i] = (char)toupper((int)str[i]);
			i++;
		}
		if (memcmp(result, result2, 100) == 0)
			my_putstrcol(GREEN, ".");
		else
			return (0);
		return (1);
	}

	if (function == TOLOWER)
	{
		my_putstrcol(YELLOW, "ft_tolower: ");
		char *str = "*42 - SALUT les @MIS cOUCOU !*   [.\t.]";
		size_t len = my_strlen(str);
		char result[100] = {0};
		char result2[100] = {0};
		size_t i = 0;

		while (i < len)
		{
			result[i] = (char)ft_tolower((int)str[i]);
			result2[i] = (char)tolower((int)str[i]);
			i++;
		}
		if (memcmp(result, result2, 100) == 0)
			my_putstrcol(GREEN, ".");
		else
			return (0);
		return (1);
	}

	if (function == PUTS)
	{
		my_putstrcol(YELLOW, "ft_puts:\n");

		int ret = 0;

		ret = puts("TEST1 - coucou les amis !");
		ret = ft_puts("TEST1 - coucou les amis !");

		ret = puts(NULL);
		my_putnbr(ret);
		my_putchar('\n');
		ret = ft_puts(NULL);
		my_putnbr(ret);
		my_putchar('\n');

		ret = puts("");
		my_putnbr(ret);
		my_putchar('\n');
		ret = ft_puts("");
		my_putnbr(ret);
		my_putchar('\n');

		my_putstrcol(YELLOW, "ft_puts: ");
		return (84);
	}

	//------ LIB PART TWO ------

	if (function == STRLEN)
	{
		my_putstrcol(YELLOW, "ft_strlen: ");

		char *str = "123456";
		size_t ret = 0;
		size_t ret2 = 0;

		ret = ft_strlen(NULL);
		if (ret == 0)
			my_putstrcol(GREEN, ".");
		else
			return (0);

		ret = ft_strlen("");
		ret2 = strlen("");
		if (ret == ret2)
			my_putstrcol(GREEN, ".");
		else
			return (0);

		ret = ft_strlen(str);
		ret2 = strlen(str);
		if (ret == ret2)
			my_putstrcol(GREEN, ".");
		else
			return (0);

		ret = ft_strlen("salut les amis\tcomment ca va ?\n");
		ret2 = strlen("salut les amis\tcomment ca va ?\n");
		if (ret == ret2)
			my_putstrcol(GREEN, ".");
		else
			return (0);
		return (1);
	}

	if (function == MEMSET)
	{
		my_putstrcol(YELLOW, "ft_memset: ");
		char str[10] = "0123456789";
		char str2[10] = "0123456789";

		ft_memset((void*)&str[8], '-', 1);
		memset((void*)&str2[8], '-', 1);
		if (memcmp(str, str2, 10) == 0)
			my_putstrcol(GREEN, ".");
		else
			return (0);

		ft_memset((void*)&str[3], '-', 4);
		memset((void*)&str2[3], '-', 4);
		if (memcmp(str, str2, 10) == 0)
			my_putstrcol(GREEN, ".");
		else
			return (0);

		ft_memset(NULL, '-', 10);
		my_putstrcol(GREEN, ".");

		ft_memset((void*)str, '-', 10);
		memset((void*)str2, '-', 10);
		if (memcmp(str, str2, 10) == 0)
			my_putstrcol(GREEN, ".");
		else
			return (0);
		return (1);
	}

	if (function == MEMCPY)
	{
		my_putstrcol(YELLOW, "ft_memcpy: ");
		char str1[64] = {0};
		char str2[64] = {0};
		char *mem = NULL;
		char *mem2 = NULL;

		mem = ft_memcpy((void*)str1, "begin", 5);
		mem2 = memcpy((void*)str2, "begin", 5);

		if (memcmp(mem, mem2, 64) == 0)
			my_putstrcol(GREEN, ".");
		else
			return (0);

		mem = ft_memcpy((void*)&str1[6],"bonjour les amis\n", 17);
		mem2 = memcpy((void*)&str2[6], "bonjour les amis\n", 17);

		if (memcmp(mem, mem2, 64 - 6) == 0)
			my_putstrcol(GREEN, ".");
		else
			return (0);

		if (memcmp(str1, str2, 64) == 0)
			my_putstrcol(GREEN, ".");
		else
			return (0);

		ft_memcpy((void*)str1, "", 1);
		memcpy((void*)str2, "", 1);

		ft_memcpy((void*)str1, NULL, 1);
		my_putstrcol(GREEN, ".");
		ft_memcpy(NULL, "a", 1);
		my_putstrcol(GREEN, ".");

		if (memcmp(str1, str2, 64) == 0)
			my_putstrcol(GREEN, ".");
		else
			return (0);

		ft_memcpy((void*)&str1[6], NULL, 4);
		ft_memcpy(NULL, "then", 4);

		return (1);
	}

	if (function == STRDUP)
	{
		my_putstrcol(YELLOW, "ft_strdup: ");
		char *str = NULL;
		char *str2 = NULL;

		str = strdup("salut les amis");
		str2 = ft_strdup("salut les amis");
		if (strcmp(str, str2) == 0)
			my_putstrcol(GREEN, ".");
		else
			return (0);
		free(str);
		free(str2);

		str = strdup("");
		str2 = ft_strdup("");
		if (strcmp(str, str2) == 0)
			my_putstrcol(GREEN, ".");
		else
			return (0);
		free(str);
		free(str2);

		str = strdup("a");
		str2 = ft_strdup("a");
		if (strcmp(str, str2) == 0)
			my_putstrcol(GREEN, ".");
		else
			return (0);
		free(str);
		free(str2);

		if (!(ft_strdup(NULL)))
			my_putstrcol(GREEN, ".");
		else
			return (0);

		return (1);
	}

	//------ LIB PART THREE ------

	if (function == CAT)
	{
		my_putstrcol(YELLOW, "ft_cat:\n");

		ft_cat(0);
		ft_cat(open(__FILE__, O_RDONLY));
		ft_cat(open(av[0], O_RDONLY));
		ft_cat(open(av[1], O_RDONLY));
		ft_cat(-42);
		ft_cat(42);

		(void)av;
		return (84);
	}

	if (function == END_ONE || function == END_TWO || function == END)
		return (42);
	return (0);
}


static void print_char(unsigned char *adr, size_t i, size_t size)
{
	size_t n;
	size_t max;

	n = i;
	max = i + 16;
	while (n < max)
	{
		if (n < size)
		{
			if (adr[n] > 31 && adr[n] < 127)
				my_putchar((char)adr[n]);
			else
				my_putchar('.');
		}
		n++;
	}
}

static void print_hex(unsigned char *adr, size_t i, size_t size)
{
	size_t n;

	n = i;
	while (n < i + 16)
	{
		if (n < size)
			my_putchar_base(adr[n], 16, "0123456789abcdef");
		else
			my_putstr("  ");
		if ((n % 2))
			my_putchar(' ');
		n++;
	}
}

void my_print_memory(void *addr, size_t size)
{
	unsigned char *adr;
	size_t i;

	adr = (unsigned char*)addr;
	i = 0;
	while (i < size)
	{
		print_hex(adr, i, size);
		print_char(adr, i, size);
		my_putchar('\n');
		i += 16;
	}
}
