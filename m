From: "Charles Martel" <SingerIsland-KK0ffGbhmjU@public.gmane.org>
Subject: Re: Change MODE, CS, BUS, and SPEED using SPI-DEV driver?
Date: Mon, 04 Oct 2010 17:02:13 -0400
Message-ID: <20101004210503.147160@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

----- Original Message -----
From: David Brownell
Sent: 10/01/10 08:02 PM
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Charles Martel
Subject: Re: Change MODE, CS, BUS, and SPEED using SPI-DEV driver?

--- On Fri, 10/1/10, Charles Martel <SingerIsland-KK0ffGbhmjU@public.gmane.org> wrote: >> >> The question I have is how do I modify these settings? > Evidently you haven't yet looked at the > documentation. Try that. There's a sample > program which will be informative.

Thank you for your reply.

1) I have read numerous documents but don't see where they
explain what I need considering that only the following SPI driver
files are built:
 built-in.o, hspi-s3c64xx.o, spi.o, and spi-dev.o.

I had built a kernel for the s3c6410 using linux-2.6.24.
I noticed that there are drivers for the s3c24xx but only the
"S3C6410 High Speed SPI Driver" is specific to the s3c6410.
I do not believe that the the s3c24xx series drivers are
compatible with the s3c6410. Am I wrong?
The problem I am having would go away if I could use the
s3c24xx drivers since they result in the spidev.c file being
built.

2) The following all return 0 (debug message: "Invalid ioctl option"):
 ret = ioctl(fd, SPI_IOC_WR_MODE, &spiMode);
 ret = ioctl(fd, SPI_IOC_WR_BITS_PER_WORD, &bitsPerWord);
 ret = ioctl(fd, SPI_IOC_WR_MAX_SPEED_HZ, &spiSpeed);
 These ioctl functions are supported by the spidev_ioctl function in spidev.c.
 However, as mentioned above, the "S3C6410 High Speed SPI Driver"
 does not build spidev.c.

 The same result happens when I use the following ioctl call:
 ret = ioctl(fd, SPI_IOC_MESSAGE(1), &tr);
 where tr structure (spi_ioc_transfer) contains the following:
 tr.tx_buf = txBuf;
 tr.rx_buf = rxBuf;
 tr.delay_usecs = delay;
 tr.speed_hz = speed;
 tr.bits_per_word = 8;
 tr.pad = 0;
 tr.cs_change = 0;

 This is what I expect since spi-dev.c does not handle these ioctl requests.
 The spidev_ioctl function in spi-dev.c only handles the following:
 SET_SPI_FLAGS, SET_SPI_RETRIES, and SET_SPI_TIMEOUT.

3) The following always succeeds:
 ret = write(fd, txBuf, xLen);
------------------------------------------------------------------------------
Virtualization is moving to the mainstream and overtaking non-virtualized
environment for deploying applications. Does it make network security 
easier or more difficult to achieve? Read this whitepaper to separate the 
two and get a better understanding.
http://p.sf.net/sfu/hp-phase2-d2d
