/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main_cat.c                                         :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: banthony <banthony@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/03/08 12:43:21 by banthony          #+#    #+#             */
/*   Updated: 2018/03/08 18:48:47 by banthony         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>

#define BUF_SIZE 4096

static void ft_cat(int fd)
{
	char *buf[BUF_SIZE + 1];
	ssize_t ret = 0;

	if (fd >= 0)
	{
		while ((ret = read(fd, buf, BUF_SIZE)) > 0)
		{
			buf[ret] = 0;
			write(1, buf, (size_t)ret);
		}
		if (ret < 0)
			write(1, "Error on fd\n", 12);
	}
	else
		write(1, "Bad file descriptor\n", 20);
}

int main (int ac, const char **av)
{
	printf("char:%lu - ssize_t:%lu - int%lu\n", sizeof(char), sizeof(ssize_t), sizeof(int));
	write(1, "---TEST-1---\n", 13);
	ft_cat(0);
	write(1, "---TEST-2---\n", 13);
	ft_cat(open(__FILE__, O_RDONLY));
	write(1, "---TEST-3---\n", 13);
	ft_cat(open(av[0], O_RDONLY));
	write(1, "\n---TEST-4---\n", 14);
	ft_cat(-42);
	write(1, "---TEST-5---\n", 13);
	ft_cat(open(av[1], O_RDONLY));
	write(1, "---TEST-6---\n", 13);
	ft_cat(42);
	(void)ac;
	(void)av;
}
