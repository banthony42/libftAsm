/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: banthony <banthony@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2017/12/28 20:43:53 by banthony          #+#    #+#             */
/*   Updated: 2018/03/02 18:07:04 by banthony         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>
#include <string.h>

typedef enum	e_functions
{
	ISALPHA, ISDIGIT, ISALNUM, ISASCII, ISPRINT, END_ONE, END_TWO, END,
}				t_functions;

# define WHITE "\033[0m"
# define RED "\033[31m"
# define GREEN "\033[32m"
# define YELLOW "\033[33m"
# define PINK "\033[35m"

int		my_test(int function);
void	hello_world(void);

int		ft_isdigit(int c);
int		ft_isalpha(int c);
int		ft_isalnum(int c);
int		ft_isascii(int c);
int		ft_isprint(int c);

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

static void my_putstr(char *str)
{
	write(1, str, my_strlen(str));
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
		else if (ret != 42)
			my_putstrcol(GREEN, "OK\n");
		i++;
	}
	return (0);
}

/* TEST */

int my_test(int function)
{
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

	if (function == END_ONE || function == END_TWO || function == END)
		return (42);
	return (0);
}










