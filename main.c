/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: banthony <banthony@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2017/12/28 20:43:53 by banthony          #+#    #+#             */
/*   Updated: 2018/03/05 19:28:02 by banthony         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>
#include <string.h>
#include "libfta.h"

typedef enum	e_functions
{
	BZERO, STRCAT, ISALPHA, ISDIGIT, ISALNUM, ISASCII, ISPRINT, TOUPPER, TOLOWER, PUTS, END_ONE,
	STRLEN, END_TWO,
	END,
}				t_functions;

# define WHITE "\033[0m"
# define RED "\033[31m"
# define GREEN "\033[32m"
# define YELLOW "\033[33m"
# define PINK "\033[35m"
# define BLUE "\033[34m"

int		my_test(int function);
void 	my_print_memory(void *addr, size_t size);

void	hello_world(void);

/*
void	ft_bzero(void *data, int n);
char	*ft_strcat(char *dest, const char *src);
int		ft_isdigit(int c);
int		ft_isalpha(int c);
int		ft_isalnum(int c);
int		ft_isascii(int c);
int		ft_isprint(int c);
int		ft_toupper(int c);
int		ft_tolower(int c);
int		ft_puts(const char *s);

size_t ft_strlen(const char *s);
*/
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

int main(void)
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

		if (!(ret = my_test(i)))
			my_putstrcol(RED, "KO\n");
		else if (ret == 84)
			my_putstrcol(YELLOW, "YOU HAVE TO CHECK OUTPUTS\n\n");
		else if (ret != 42)
			my_putstrcol(GREEN, "OK\n");
		i++;
	}
	return (0);
}

/* TEST */

int my_test(int function)
{
	if (function == BZERO)
	{
		my_putstrcol(YELLOW, "ft_bzero: str = \n");
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
		my_putstrcol(YELLOW, "ft_strcat: str = ");
		char str[48] = {0};
		char *retour = NULL;
		strncpy(str, "0123456789", 10);
		my_putstr(str);
		my_putchar('\n');

		my_putstrcol(YELLOW, "ft_strcat(str, salut):\n");
		ft_strcat(str, "salut");
		my_putstr(str);
		my_putchar('\n');

		if (!(retour = ft_strcat(NULL, str)))
			my_putstrcol(YELLOW, "ft_strcat(NULL, str) return NULL\n");

		if (!(retour = ft_strcat(str, NULL)))
			my_putstrcol(YELLOW, "ft_strcat(str, NULL) return NULL\n");

		my_putstrcol(YELLOW, "ft_strcat(str, --BONJOUR--):\n");
		ft_strcat(str, "--BONJOUR--");
		my_putstr(str);
		my_putchar('\n');

		my_putstrcol(YELLOW, "ft_strcat(str, LAST CALL):\n");
		retour = ft_strcat(str, "LAST CALL");
		my_putstr(retour);
		my_putchar('\n');

		my_putstrcol(YELLOW, "ft_strcat: ");
		return (84);
	}

	if (function == ISALPHA)
	{
		my_putstrcol(YELLOW, "ft_isalpha: ");
		if (!(ft_isalpha('A')))
			return (0);
		if (!(ft_isalpha('Z')))
			return (0);
		if (!(ft_isalpha('a')))
			return (0);
		if (!(ft_isalpha('z')))
			return (0);
		if (ft_isalpha('@'))
			return (0);
		if (ft_isalpha('['))
			return (0);
		if (ft_isalpha('`'))
			return (0);
		if (ft_isalpha('{'))
			return (0);
		return (1);
	}

	if (function == ISDIGIT)
	{
		my_putstrcol(YELLOW, "ft_isdigit: ");
		if (!(ft_isdigit('0')))
			return (0);
		if (!(ft_isdigit('9')))
			return (0);
		if (ft_isdigit('/'))
			return (0);
		if (ft_isdigit(':'))
			return (0);
		return (2);
	}

	if (function == ISALNUM)
	{
		my_putstrcol(YELLOW, "ft_isalnum: ");
		if (!(ft_isalnum('0')))
			return (0);
		if (!(ft_isalnum('9')))
			return (0);
		if (!(ft_isalpha('a')))
			return (0);
		if (!(ft_isalpha('Z')))
			return (0);
		if (ft_isalnum('/'))
			return (0);
		if (ft_isalnum(':'))
			return (0);
		if (ft_isalnum('@'))
			return (0);
		if (ft_isalnum('['))
			return (0);
		if ((ft_isalnum('*')))
			return (0);
		return (3);
	}

	if (function == ISASCII)
	{
		my_putstrcol(YELLOW, "ft_isascii: ");
		if (!(ft_isascii(0)))
			return (0);
		if (!(ft_isascii(127)))
			return (0);
		if ((ft_isascii(128)))
			return (0);
		if ((ft_isascii(-1)))
			return (0);
		if ((ft_isascii(42000)))
			return (0);
		return (4);
	}

	if (function == ISPRINT)
	{
		my_putstrcol(YELLOW, "ft_isprint: ");
		if (!(ft_isprint(' ')))
			return (0);
		if (!(ft_isprint('~')))
			return (0);
		if ((ft_isprint(31)))
			return (0);
		if ((ft_isprint(127)))
			return (0);
		return (5);
	}

	if (function == TOUPPER)
	{
		my_putstrcol(YELLOW, "ft_toupper:\n");
		char *str = "1 - salut LES amis CouCou !";
		size_t len = my_strlen(str);
		char result[100] = {0};
		size_t i = 0;

		while (i < len)
		{
			result[i] = (char)ft_toupper((int)str[i]);
			i++;
		}
		my_putstr("\t");
		my_putstrcol(BLUE, str);
		my_putstr("\n\t");
		my_putstrcol(BLUE, result);
		my_putstrcol(YELLOW, "\nft_toupper: ");
		return (84);
	}

	if (function == TOLOWER)
	{
		my_putstrcol(YELLOW, "ft_tolower:\n");
		char *str = "*42 - SALUT les @MIS cOUCOU !*   [.\t.]";
		size_t len = my_strlen(str);
		char result[100] = {0};
		size_t i = 0;

		while (i < len)
		{
			result[i] = (char)ft_tolower((int)str[i]);
			i++;
		}
		my_putstr("\t");
		my_putstrcol(BLUE, str);
		my_putstr("\n\t");
		my_putstrcol(BLUE, result);
		my_putstrcol(YELLOW, "\nft_tolower: ");
		return (84);
	}

	if (function == PUTS)
	{
		my_putstrcol(YELLOW, "ft_puts:\n");

		int ret = 0;
		ret = ft_puts("TEST1 - coucou les amis !");
		my_putnbr(ret);
		ft_puts("\nTEST2 - NULL");
		ret = ft_puts(NULL);
		my_putnbr(ret);
		ft_puts("\nTEST3 - chaine vide - retour: ");
		ret = ft_puts("");
		my_putnbr(ret);
		my_putchar('\n');

		my_putstrcol(YELLOW, "\nft_puts:\n");
		return (84);
	}

	//------ LIB PART TWO ------

	if (function == STRLEN)
	{
		my_putstrcol(YELLOW, "ft_strlen:\n");

		char *str = "123456";

		ft_strlen(NULL);

		my_putstr(str);
		my_putstr("--> lenght:");
		my_putnbr((int)ft_strlen(str));
		my_putchar('\n');

		char *str2 = "";
		my_putstr(str2);
		my_putstr("--> lenght:");
		my_putnbr((int)ft_strlen(str2));
		my_putchar('\n');

		my_putstrcol(YELLOW, "\nft_strlen: ");
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
