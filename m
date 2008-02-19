From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] documentation: move spidev_fdx
	example to its own source file
Date: Mon, 18 Feb 2008 18:14:24 -0800
Message-ID: <200802181814.25463.david-b@pacbell.net>
References: <20080218162625.1b4bd079.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	akpm <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080218162625.1b4bd079.randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Monday 18 February 2008, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
> 
> cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> 
> Move sample source code to its own source file so that it can be used
> easier and build-tested/check/maintained by anyone.
> 
> (Makefile changes are in a separate patch for all of Documentation/.)
> 
> Signed-off-by: Randy Dunlap <randy.dunlap-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

Acked-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

> ---
>  Documentation/spi/spidev       |  168 -------------------------------
>  Documentation/spi/spidev_fdx.c |  158 +++++++++++++++++++++++++++++
>  2 files changed, 160 insertions(+), 166 deletions(-)
> 
> --- linux-2625-rc2-docsrc.orig/Documentation/spi/spidev
> +++ linux-2625-rc2-docsrc/Documentation/spi/spidev
> @@ -126,8 +126,8 @@ NOTES:
>  FULL DUPLEX CHARACTER DEVICE API
>  ================================
>  
> -See the sample program below for one example showing the use of the full
> -duplex programming interface.  (Although it doesn't perform a full duplex
> +See the spidev_fdx.c sample program for one example showing the use of the
> +full duplex programming interface.  (Although it doesn't perform a full duplex
>  transfer.)  The model is the same as that used in the kernel spi_sync()
>  request; the individual transfers offer the same capabilities as are
>  available to kernel drivers (except that it's not asynchronous).
> @@ -141,167 +141,3 @@ and bitrate for each transfer segment.)
>  
>  To make a full duplex request, provide both rx_buf and tx_buf for the
>  same transfer.  It's even OK if those are the same buffer.
> -
> -
> -SAMPLE PROGRAM
> -==============
> -
> ---------------------------------	CUT HERE
> -#include <stdio.h>
> -#include <unistd.h>
> -#include <stdlib.h>
> -#include <fcntl.h>
> -#include <string.h>
> -
> -#include <sys/ioctl.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -
> -#include <linux/types.h>
> -#include <linux/spi/spidev.h>
> -
> -
> -static int verbose;
> -
> -static void do_read(int fd, int len)
> -{
> -	unsigned char	buf[32], *bp;
> -	int		status;
> -
> -	/* read at least 2 bytes, no more than 32 */
> -	if (len < 2)
> -		len = 2;
> -	else if (len > sizeof(buf))
> -		len = sizeof(buf);
> -	memset(buf, 0, sizeof buf);
> -
> -	status = read(fd, buf, len);
> -	if (status < 0) {
> -		perror("read");
> -		return;
> -	}
> -	if (status != len) {
> -		fprintf(stderr, "short read\n");
> -		return;
> -	}
> -
> -	printf("read(%2d, %2d): %02x %02x,", len, status,
> -		buf[0], buf[1]);
> -	status -= 2;
> -	bp = buf + 2;
> -	while (status-- > 0)
> -		printf(" %02x", *bp++);
> -	printf("\n");
> -}
> -
> -static void do_msg(int fd, int len)
> -{
> -	struct spi_ioc_transfer	xfer[2];
> -	unsigned char		buf[32], *bp;
> -	int			status;
> -
> -	memset(xfer, 0, sizeof xfer);
> -	memset(buf, 0, sizeof buf);
> -
> -	if (len > sizeof buf)
> -		len = sizeof buf;
> -
> -	buf[0] = 0xaa;
> -	xfer[0].tx_buf = (__u64) buf;
> -	xfer[0].len = 1;
> -
> -	xfer[1].rx_buf = (__u64) buf;
> -	xfer[1].len = len;
> -
> -	status = ioctl(fd, SPI_IOC_MESSAGE(2), xfer);
> -	if (status < 0) {
> -		perror("SPI_IOC_MESSAGE");
> -		return;
> -	}
> -
> -	printf("response(%2d, %2d): ", len, status);
> -	for (bp = buf; len; len--)
> -		printf(" %02x", *bp++);
> -	printf("\n");
> -}
> -
> -static void dumpstat(const char *name, int fd)
> -{
> -	__u8	mode, lsb, bits;
> -	__u32	speed;
> -
> -	if (ioctl(fd, SPI_IOC_RD_MODE, &mode) < 0) {
> -		perror("SPI rd_mode");
> -		return;
> -	}
> -	if (ioctl(fd, SPI_IOC_RD_LSB_FIRST, &lsb) < 0) {
> -		perror("SPI rd_lsb_fist");
> -		return;
> -	}
> -	if (ioctl(fd, SPI_IOC_RD_BITS_PER_WORD, &bits) < 0) {
> -		perror("SPI bits_per_word");
> -		return;
> -	}
> -	if (ioctl(fd, SPI_IOC_RD_MAX_SPEED_HZ, &speed) < 0) {
> -		perror("SPI max_speed_hz");
> -		return;
> -	}
> -
> -	printf("%s: spi mode %d, %d bits %sper word, %d Hz max\n",
> -		name, mode, bits, lsb ? "(lsb first) " : "", speed);
> -}
> -
> -int main(int argc, char **argv)
> -{
> -	int		c;
> -	int		readcount = 0;
> -	int		msglen = 0;
> -	int		fd;
> -	const char	*name;
> -
> -	while ((c = getopt(argc, argv, "hm:r:v")) != EOF) {
> -		switch (c) {
> -		case 'm':
> -			msglen = atoi(optarg);
> -			if (msglen < 0)
> -				goto usage;
> -			continue;
> -		case 'r':
> -			readcount = atoi(optarg);
> -			if (readcount < 0)
> -				goto usage;
> -			continue;
> -		case 'v':
> -			verbose++;
> -			continue;
> -		case 'h':
> -		case '?':
> -usage:
> -			fprintf(stderr,
> -				"usage: %s [-h] [-m N] [-r N] /dev/spidevB.D\n",
> -				argv[0]);
> -			return 1;
> -		}
> -	}
> -
> -	if ((optind + 1) != argc)
> -		goto usage;
> -	name = argv[optind];
> -
> -	fd = open(name, O_RDWR);
> -	if (fd < 0) {
> -		perror("open");
> -		return 1;
> -	}
> -
> -	dumpstat(name, fd);
> -
> -	if (msglen)
> -		do_msg(fd, msglen);
> -
> -	if (readcount)
> -		do_read(fd, readcount);
> -
> -	close(fd);
> -	return 0;
> -}
> --- /dev/null
> +++ linux-2625-rc2-docsrc/Documentation/spi/spidev_fdx.c
> @@ -0,0 +1,158 @@
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <fcntl.h>
> +#include <string.h>
> +
> +#include <sys/ioctl.h>
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +
> +#include <linux/types.h>
> +#include <linux/spi/spidev.h>
> +
> +
> +static int verbose;
> +
> +static void do_read(int fd, int len)
> +{
> +	unsigned char	buf[32], *bp;
> +	int		status;
> +
> +	/* read at least 2 bytes, no more than 32 */
> +	if (len < 2)
> +		len = 2;
> +	else if (len > sizeof(buf))
> +		len = sizeof(buf);
> +	memset(buf, 0, sizeof buf);
> +
> +	status = read(fd, buf, len);
> +	if (status < 0) {
> +		perror("read");
> +		return;
> +	}
> +	if (status != len) {
> +		fprintf(stderr, "short read\n");
> +		return;
> +	}
> +
> +	printf("read(%2d, %2d): %02x %02x,", len, status,
> +		buf[0], buf[1]);
> +	status -= 2;
> +	bp = buf + 2;
> +	while (status-- > 0)
> +		printf(" %02x", *bp++);
> +	printf("\n");
> +}
> +
> +static void do_msg(int fd, int len)
> +{
> +	struct spi_ioc_transfer	xfer[2];
> +	unsigned char		buf[32], *bp;
> +	int			status;
> +
> +	memset(xfer, 0, sizeof xfer);
> +	memset(buf, 0, sizeof buf);
> +
> +	if (len > sizeof buf)
> +		len = sizeof buf;
> +
> +	buf[0] = 0xaa;
> +	xfer[0].tx_buf = (__u64) buf;
> +	xfer[0].len = 1;
> +
> +	xfer[1].rx_buf = (__u64) buf;
> +	xfer[1].len = len;
> +
> +	status = ioctl(fd, SPI_IOC_MESSAGE(2), xfer);
> +	if (status < 0) {
> +		perror("SPI_IOC_MESSAGE");
> +		return;
> +	}
> +
> +	printf("response(%2d, %2d): ", len, status);
> +	for (bp = buf; len; len--)
> +		printf(" %02x", *bp++);
> +	printf("\n");
> +}
> +
> +static void dumpstat(const char *name, int fd)
> +{
> +	__u8	mode, lsb, bits;
> +	__u32	speed;
> +
> +	if (ioctl(fd, SPI_IOC_RD_MODE, &mode) < 0) {
> +		perror("SPI rd_mode");
> +		return;
> +	}
> +	if (ioctl(fd, SPI_IOC_RD_LSB_FIRST, &lsb) < 0) {
> +		perror("SPI rd_lsb_fist");
> +		return;
> +	}
> +	if (ioctl(fd, SPI_IOC_RD_BITS_PER_WORD, &bits) < 0) {
> +		perror("SPI bits_per_word");
> +		return;
> +	}
> +	if (ioctl(fd, SPI_IOC_RD_MAX_SPEED_HZ, &speed) < 0) {
> +		perror("SPI max_speed_hz");
> +		return;
> +	}
> +
> +	printf("%s: spi mode %d, %d bits %sper word, %d Hz max\n",
> +		name, mode, bits, lsb ? "(lsb first) " : "", speed);
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int		c;
> +	int		readcount = 0;
> +	int		msglen = 0;
> +	int		fd;
> +	const char	*name;
> +
> +	while ((c = getopt(argc, argv, "hm:r:v")) != EOF) {
> +		switch (c) {
> +		case 'm':
> +			msglen = atoi(optarg);
> +			if (msglen < 0)
> +				goto usage;
> +			continue;
> +		case 'r':
> +			readcount = atoi(optarg);
> +			if (readcount < 0)
> +				goto usage;
> +			continue;
> +		case 'v':
> +			verbose++;
> +			continue;
> +		case 'h':
> +		case '?':
> +usage:
> +			fprintf(stderr,
> +				"usage: %s [-h] [-m N] [-r N] /dev/spidevB.D\n",
> +				argv[0]);
> +			return 1;
> +		}
> +	}
> +
> +	if ((optind + 1) != argc)
> +		goto usage;
> +	name = argv[optind];
> +
> +	fd = open(name, O_RDWR);
> +	if (fd < 0) {
> +		perror("open");
> +		return 1;
> +	}
> +
> +	dumpstat(name, fd);
> +
> +	if (msglen)
> +		do_msg(fd, msglen);
> +
> +	if (readcount)
> +		do_read(fd, readcount);
> +
> +	close(fd);
> +	return 0;
> +}
> 



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
