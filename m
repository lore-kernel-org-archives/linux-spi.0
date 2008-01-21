From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] spi: add support for SPI over
	SuperH SCI pins
Date: Mon, 21 Jan 2008 14:29:29 -0800
Message-ID: <200801211429.29906.david-b@pacbell.net>
References: <20080121104913.11908.50319.sendpatchset@clockwork.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org,
	linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080121104913.11908.50319.sendpatchset-oNevn9JCO/nrQWrVbqIkupgxem/jg0Vn@public.gmane.org>
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

On Monday 21 January 2008, Magnus Damm wrote:
> spi: add support for SPI over SuperH SCI pins
> 
> This patch adds support for SPI over SCI pins. SCI is a very simple serial
> controller block that can be found on older SuperH processors. In theory it
> is possible to use the SCI hardware block in syncronous mode, but this version
> of the driver simply hooks up the bit banging code on the SCI pins.
> 
> Signed-off-by: Magnus Damm <damm-AlSX/UN32fvPDbFq/vQRIQ@public.gmane.org>
> ---
> 
>  drivers/spi/Kconfig      |    7 +
>  drivers/spi/Makefile     |    1 
>  drivers/spi/spi_sh_sci.c |  217 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 225 insertions(+)
> 
> --- 0001/drivers/spi/Kconfig
> +++ work/drivers/spi/Kconfig	2008-01-21 16:59:39.000000000 +0900
> @@ -175,6 +175,13 @@ config SPI_S3C24XX_GPIO
>  	  the inbuilt hardware cannot provide the transfer mode, or
>  	  where the board is using non hardware connected pins.
>  
> +config SPI_SH_SCI
> +	tristate "SuperH SCI SPI controller"
> +	depends on SPI_MASTER && SUPERH
> +	select SPI_BITBANG
> +	help
> +	  SPI driver for SuperH SCI blocks.
> +
>  config SPI_TXX9
>  	tristate "Toshiba TXx9 SPI controller"
>  	depends on SPI_MASTER && GENERIC_GPIO && CPU_TX49XX
> --- 0001/drivers/spi/Makefile
> +++ work/drivers/spi/Makefile	2008-01-21 16:59:39.000000000 +0900
> @@ -27,6 +27,7 @@ obj-$(CONFIG_SPI_S3C24XX_GPIO)		+= spi_s
>  obj-$(CONFIG_SPI_S3C24XX)		+= spi_s3c24xx.o
>  obj-$(CONFIG_SPI_TXX9)			+= spi_txx9.o
>  obj-$(CONFIG_SPI_XILINX)		+= xilinx_spi.o
> +obj-$(CONFIG_SPI_SH_SCI)		+= spi_sh_sci.o
>  # 	... add above this line ...
>  
>  # SPI protocol drivers (device/link on bus)
> --- /dev/null
> +++ work/drivers/spi/spi_sh_sci.c	2008-01-21 17:04:02.000000000 +0900
> @@ -0,0 +1,217 @@
> +/* linux/drivers/spi/spi_sh_sci.c

The general policy is to not include the whole driver pathname,
since paths change over time.  Better yet, I don't see any need
for a pathname here ... just remove it.

> + *
> + * SH SCI SPI interface
> + *
> + * Based on S3C24XX GPIO based SPI driver
> + *
> + * Copyright (c) 2006 Ben Dooks
> + * Copyright (c) 2006 Simtec Electronics

I see a missing copyright there:  yours!

I'd be relatively certain Ben and Simtek don't want to be
maintain a driver they never had anything to do with, so
please make sure it doesn't look like they wrote it.

You should consider adding yourself to MAINTAINERS for
this driver...


> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> +*/
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/delay.h>
> +#include <linux/spinlock.h>
> +#include <linux/workqueue.h>
> +#include <linux/platform_device.h>
> +
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi_bitbang.h>
> +
> +#include <asm/spi.h>
> +#include <asm/io.h>
> +
> +struct sh_sci_spi {
> +	struct spi_bitbang bitbang;
> +
> +	unsigned long mapbase;

Not "void __iomem *mapbase"?

I notice that you're not doing an ioremap() to get this address.
Is the platform device properly registering a *physical* address
in the IORESOURCE_MEM record for the device?


> +	struct sh_spi_info *info;
> +	struct platform_device *dev;
> +};
> +
> +#define SCSPTR(sg) (sg->mapbase + 0x1c)
> +#define PIN_SCK (1 << 2)
> +#define PIN_TXD (1 << 0)
> +#define PIN_RXD PIN_TXD
> +#define PIN_INIT ((1 << 1) | (1 << 3))
> +
> +static inline struct sh_sci_spi *spidev_to_sg(struct spi_device *spi)
> +{
> +	return spi->controller_data;
> +}
> +
> +static inline void setbits(struct sh_sci_spi *sg, int bits, int on)
> +{
> +	unsigned char val;
> +
> +	val = ctrl_inb(SCSPTR(sg));
> +	if (on)
> +		val |= bits;
> +	else
> +		val &= ~bits;
> +	ctrl_outb(val, SCSPTR(sg));

I notice there are no locks around this read/modify/write operation.

As a rule that's unsafe for GPIO registers -- since another activity
(IRQ handler or whatever) can do the same thing, and then you'd have
one stomping all over the other.  Is there something that would make
it safe in this case?  If not, fix; if so, comment.


> +}
> +
> +static inline unsigned char getbits(struct sh_sci_spi *sg, int bits)
> +{
> +	return ctrl_inb(SCSPTR(sg)) & bits;
> +}
> +
> +static inline void setsck(struct spi_device *dev, int on)
> +{
> +	setbits(spidev_to_sg(dev), PIN_SCK, on);
> +}
> +
> +static inline void setmosi(struct spi_device *dev, int on)
> +{
> +	setbits(spidev_to_sg(dev), PIN_TXD, on);
> +}
> +
> +static inline u32 getmiso(struct spi_device *dev)
> +{
> +	return getbits(spidev_to_sg(dev), PIN_RXD) ? 1 : 0;

I worry about all those spidev_to_sg(dev) calls ... did you look
at the generated code to make sure they get pulled out of the
inner loops?  Declaring some stuff "const" might help if that's
an issue.

Ideally the setsck(), setmosi(), and getmiso() calls optimize
to a couple instructions each, at least inside the I/O loops
below.  It works that way on some systems, and I'd think it
might be possible on this one too.


> +}
> +
> +#define spidelay(x) ndelay(x)
> +
> +#define	EXPAND_BITBANG_TXRX
> +#include <linux/spi/spi_bitbang.h>
> +
> +static u32 sh_sci_spi_txrx_mode0(struct spi_device *spi,
> +				      unsigned nsecs, u32 word, u8 bits)
> +{
> +	return bitbang_txrx_be_cpha0(spi, nsecs, 0, word, bits);
> +}
> +
> +static u32 sh_sci_spi_txrx_mode1(struct spi_device *spi,
> +				      unsigned nsecs, u32 word, u8 bits)
> +{
> +	return bitbang_txrx_be_cpha1(spi, nsecs, 0, word, bits);
> +}
> +
> +static u32 sh_sci_spi_txrx_mode2(struct spi_device *spi,
> +				      unsigned nsecs, u32 word, u8 bits)
> +{
> +	return bitbang_txrx_be_cpha0(spi, nsecs, 1, word, bits);
> +}
> +
> +static u32 sh_sci_spi_txrx_mode3(struct spi_device *spi,
> +				      unsigned nsecs, u32 word, u8 bits)
> +{
> +	return bitbang_txrx_be_cpha1(spi, nsecs, 1, word, bits);
> +}
> +
> +
> +static void sh_sci_spi_chipselect(struct spi_device *dev, int value)
> +{
> +	struct sh_sci_spi *sg = spidev_to_sg(dev);
> +
> +	if (sg->info && sg->info->chip_select)
> +		(sg->info->chip_select)(sg->info, dev->chip_select, value);
> +}
> +
> +static int sh_sci_spi_probe(struct platform_device *dev)
> +{
> +	struct resource	*r;
> +	struct sh_spi_info *info;
> +	struct spi_master *master;
> +	struct sh_sci_spi *sp;
> +	int ret;
> +	int i;
> +
> +	master = spi_alloc_master(&dev->dev, sizeof(struct sh_sci_spi));
> +	if (master == NULL) {
> +		dev_err(&dev->dev, "failed to allocate spi master\n");
> +		ret = -ENOMEM;
> +		goto err0;
> +	}
> +
> +	sp = spi_master_get_devdata(master);
> +
> +	platform_set_drvdata(dev, sp);
> +
> +	/* copy in the platform data */
> +	info = sp->info = dev->dev.platform_data;
> +
> +	/* setup spi bitbang adaptor */
> +	sp->bitbang.master = spi_master_get(master);
> +	sp->bitbang.master->bus_num = info->bus_num;
> +	sp->bitbang.master->num_chipselect = info->num_chipselect;
> +	sp->bitbang.chipselect = sh_sci_spi_chipselect;
> +
> +	sp->bitbang.txrx_word[SPI_MODE_0] = sh_sci_spi_txrx_mode0;
> +	sp->bitbang.txrx_word[SPI_MODE_1] = sh_sci_spi_txrx_mode1;
> +	sp->bitbang.txrx_word[SPI_MODE_2] = sh_sci_spi_txrx_mode2;
> +	sp->bitbang.txrx_word[SPI_MODE_3] = sh_sci_spi_txrx_mode3;
> +
> +	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
> +	if (r == NULL) {
> +		ret = -ENOENT;
> +		goto err1;
> +	}
> +	sp->mapbase = r->start;
> +	setbits(sp, PIN_INIT, 1);
> +
> +	ret = spi_bitbang_start(&sp->bitbang);
> +	if (ret)
> +		goto err2;
> +
> +	/* register the chips to go with the board */
> +
> +	for (i = 0; i < sp->info->board_size; i++) {
> +		dev_info(&dev->dev, "registering %p: %s\n",
> +			 &sp->info->board_info[i],
> +			 sp->info->board_info[i].modalias);
> +
> +		sp->info->board_info[i].controller_data = sp;
> +		spi_new_device(master, sp->info->board_info + i);

NO -- this doesn't belong here at all.  Such registration is handled
by the SPI core code, according to what the board init code told it.


> +	}
> +	return 0;
> + err2:
> +	setbits(sp, PIN_INIT, 0);
> + err1:
> +	spi_master_put(sp->bitbang.master);
> + err0:
> +	return ret;
> +}
> +
> +static int sh_sci_spi_remove(struct platform_device *dev)
> +{
> +	struct sh_sci_spi *sp = platform_get_drvdata(dev);
> +
> +	spi_bitbang_stop(&sp->bitbang);
> +	setbits(sp, PIN_INIT, 0);
> +	spi_master_put(sp->bitbang.master);
> +	return 0;
> +}
> +
> +static struct platform_driver sh_sci_spi_drv = {
> +	.probe		= sh_sci_spi_probe,
> +	.remove		= sh_sci_spi_remove,
> +	.driver		= {
> +		.name	= "spi_sh_sci",
> +		.owner	= THIS_MODULE,
> +	},
> +};
> +
> +static int __init sh_sci_spi_init(void)
> +{
> +	return platform_driver_register(&sh_sci_spi_drv);
> +}
> +
> +static void __exit sh_sci_spi_exit(void)
> +{
> +	platform_driver_unregister(&sh_sci_spi_drv);
> +}
> +
> +module_init(sh_sci_spi_init);
> +module_exit(sh_sci_spi_exit);
> +
> +MODULE_DESCRIPTION("SH SCI SPI Driver");
> +MODULE_AUTHOR("Magnus Damm");
> +MODULE_LICENSE("GPL");
> 



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
