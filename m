From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] SPI: driver for the 400EPx
Date: Mon, 21 Jan 2008 18:26:55 -0800
Message-ID: <200801211826.56030.david-b@pacbell.net>
References: <20080114145837.16331f9d@peedub.jennejohn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	gary.jennejohn-KuiJ5kEpwI6ELgA04lAiVw@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080114145837.16331f9d-f7AvneZ2CE0iXleZOAq1AWD2FQJk+8+b@public.gmane.org>
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

On Monday 14 January 2008, Gary Jennejohn wrote:
> 
> From: Gary Jennejohn <garyj-ynQEQJNshbs@public.gmane.org>
> 
> commit d8af1d29fdbd0a6614c01582ea09115b7c51e773
> Author: Gary Jennejohn <garyj-ynQEQJNshbs@public.gmane.org>
> Date:   Thu Jan 10 13:25:48 2008 +0100
> 
>     Add a driver for the SPI controller in the 440EPx. The driver works
>     with both arch/ppc and arch/powerpc.
>     
>     Add hardware resources for SPI and GPIO (GPIO for powerpc only).
>     
>     Block use of IIC1 when the SPI controller is used because they share
>     a configuration register.
>     
>     Signed-off-by: Gary Jennejohn <garyj-ynQEQJNshbs@public.gmane.org>
> ---

 arch/powerpc/boot/dts/sequoia.dts  |   23
 arch/ppc/platforms/4xx/ppc440epx.c |   28 +
 drivers/spi/spi_ppc4xx.c           |  882 ++++++++++++++++++++++++++++++++++++-
 drivers/i2c/busses/i2c-ibm_of.c    |   11
 drivers/spi/Kconfig                |    7
 drivers/spi/Makefile               |    1
 6 files changed, 949 insertions(+), 3 deletions(-)

I'm not keen to sign off on patches touching arch/* or drivers/i2c;
this should get split into three patches, then I can handle the
one that only touches SPI.  Make sure to run checkpatch.pl of course;
you may have done that already, I didn't check.

Also, a general comment for this code is that it seems to have way
too much GPIO stuff.  That can be reduced even if there's some delay
getting both PPC and PowerPC trees to handle that generically.

Other than that, the main techical issues I see with this code is
that the platform bus and OF bus glue should share a lot more code;
and that you're not using dev_dbg() and friends anywhere near enough.


> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -160,6 +160,13 @@ config SPI_OMAP24XX
>  	  SPI master controller for OMAP24xx Multichannel SPI
>  	  (McSPI) modules.
>  
> +config SPI_PPC4xx
> +	tristate "PPC4xx SPI Controller"
> +	depends on 440EPX && SPI_MASTER
> +	select SPI_BITBANG
> +	help
> +	  This selects a driver for the 440EPx SPI Controller.
> +
>  config SPI_PXA2XX
>  	tristate "PXA2xx SSP SPI master"
>  	depends on SPI_MASTER && ARCH_PXA && EXPERIMENTAL

It's unfortunately a pleasant surprise to find patches which
properly retain alphabetical order ...


> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_SPI_S3C24XX_GPIO)		+= spi_s
>  obj-$(CONFIG_SPI_S3C24XX)		+= spi_s3c24xx.o
>  obj-$(CONFIG_SPI_TXX9)			+= spi_txx9.o
>  obj-$(CONFIG_SPI_XILINX)		+= xilinx_spi.o
> +obj-$(CONFIG_SPI_PPC4xx)		+= spi_ppc4xx.o
>  # 	... add above this line ...
>  
>  # SPI protocol drivers (device/link on bus)

... *everywhere* it's supposed to be used.  ;)


> --- /dev/null
> +++ b/drivers/spi/spi_ppc4xx.c
> @@ -0,0 +1,880 @@
> +/*
> + * SPI_PPC4XX SPI controller driver.
> + * Copyright (C) 2008 Gary Jenneohn <garyj-ynQEQJNshbs@public.gmane.org>
> + *
> + * Based in part on drivers/spi/spi_s3c24xx.c
> + *
> + * Copyright (c) 2006 Ben Dooks
> + * Copyright (c) 2006 Simtec Electronics
> + *	Ben Dooks <ben-Y5A6D6n0/KfQXOPxS62xeg@public.gmane.org>
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.
> + */
> +
> +#undef DEBUG

We need to get rid of such stuff.  Kconfig and the Makefile manage
that particular setting.


> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/sched.h>
> +#include <linux/errno.h>
> +#include <linux/wait.h>
> +#ifdef CONFIG_PPC_OF
> +#include <asm/of_platform.h>
> +#else
> +#include <asm/ocp.h> /* deprecated */
> +#include <linux/platform_device.h>
> +#endif
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +
> +#include <linux/spi/spi.h>
> +#include <linux/spi/spi_bitbang.h>
> +
> +#include <asm/io.h>
> +#include <asm/dcr-native.h>
> +
> +/* Attention! These may be 440EPx specific. */
> +struct spi_ppc4xx_regs {
> +	u8	mode;
> +	u8	rxd;
> +	u8	txd;
> +	u8	cr;
> +	u8	sr;
> +	u8	dummy;
> +	/*
> +	 * Clock divisor modulus register
> +	 * This uses the follwing formula:
> +	 *    SCPClkOut = OPBCLK/(4(CDM + 1))
> +	 * or
> +	 *    CDM = (OPBCLK/4*SCPClkOut) - 1
> +	 */
> +	u8	cdm;
> +};
> +
> +/* bits in mode register - bit 0 ist MSb */

Mixing languages within one sentence is a bit much ... "is MSb".  :)


> +/* data latched on leading edge of clock, else trailing edge */
> +#define SPI_PPC4XX_MODE_SCP	(0x80 >> 3)
> +/* port enabled */
> +#define SPI_PPC4XX_MODE_SPE	(0x80 >> 4)
> +/* MSB first, else LSB first */
> +#define SPI_PPC4XX_MODE_RD	(0x80 >> 5)
> +/* clock invert - idle clock = 1, active clock = 0; else reversed */
> +#define SPI_PPC4XX_MODE_CI	(0x80 >> 6)
> +/* loopback enable */
> +#define SPI_PPC4XX_MODE_IL	(0x80 >> 7)
> +/* bits in control register */
> +/* starts a transfer when set */
> +#define SPI_PPC4XX_CR_STR	(0x80 >> 7)
> +/* bits in status register */
> +/* port is busy with a transfer */
> +#define SPI_PPC4XX_SR_BSY	(0x80 >> 6)
> +/* RxD ready */
> +#define SPI_PPC4XX_SR_RBR	(0x80 >> 7)
> +
> +/* the spi->mode bits understood by this driver */
> +#define MODEBITS (SPI_CPHA | SPI_CPOL | SPI_CS_HIGH | SPI_LSB_FIRST)
> +
> +/* clock settings (SCP and CI) for various SPI modes */
> +#define SPI_CLK_MODE0		SPI_PPC4XX_MODE_SCP
> +#define SPI_CLK_MODE1		0
> +#define SPI_CLK_MODE2		SPI_PPC4XX_MODE_CI
> +#define SPI_CLK_MODE3		(SPI_PPC4XX_MODE_SCP | SPI_PPC4XX_MODE_CI)

Some hardware designer didn't like the CPOL/CPHA model!
I confess that when I explain it I do so in these terms, even
though it looks a it odd when expressed as *these* bitmasks.

> +
> +#ifdef CONFIG_PPC_OF
> +#define DRIVER_NAME		"spi_ppc4xx_of"
> +static struct device_node *gpio0np;
> +#else
> +#define DRIVER_NAME		"spi_ppc4xx"

Urk ... must you change the driver name?  Why not
just use the same name at all times?


> +#ifndef GPIO0_BASE
> +#define GPIO0_BASE		0x1EF600B00ULL
> +#define GPIO1_BASE		0x1EF600C00ULL
> +#define GPIOx_SIZE		0x44
> +#endif
> +#endif
> +
> +#ifndef SDR0_CFGADDR
> +#define SDR0_CFGADDR		0x00E
> +#define SDR0_CFGDATA		0x00F
> +#endif
> +#define SDR0_PFC1		0x4101
> +
> +/*
> + * Offsets - these don't seem to be in any standard header,
> + * but these values may be true only for 440EPx.
> + */
> +#define GPIOx_TCR		0x04
> +#define GPIOx_OSRL		0x08
> +#define GPIOx_OSRH		0x0C
> +#define GPIOx_TSRL		0x10
> +#define GPIOx_TSRH		0x14
> +#define GPIOx_ODR		0x18
> +
> +/* may be true only for 440EPx */
> +/* number of pins per GPIO controller */
> +#define GPIO_NUMPINS		32
> +/* total number of pins in all GPIO controllers */
> +#define GPIO_TOTPINS		64

Could you try packaging this instead so that <asm/gpio.h> will
just give you access to the standard GPIO calls?  And so other
drivers can use them too?

It looks to me like you should be able to just define simple
inline functions for gpio_set_value() and gpio_get_value(),
also the direction setting calls ... making it easy to swap
in platform-wide replacements when CONFIG_GENERIC_GPIO != n.

The main *technical* obstacle being that it looks like these
registers all need read/modify/write to prevent two activities
from stomping all over each other.  Which implies at least
blocking IRQs while you do that, if not also (for SMP) using
a spinlock that all those GPIO users (implicitly) share.


> +
> +struct ppc4xx_spi {
> +	/* bitbang has to be first */
> +	struct spi_bitbang	bitbang;

Is that still true?  Sigh.


> +	struct completion	done;
> +
> +	void __iomem		*gpio0;
> +	void __iomem		*gpio1;
> +	u64			mapbase;
> +	u64			mapsize;
> +	int			irqnum;
> +	/* need this to set the SPI clock */
> +	unsigned int		opb_freq;
> +
> +	/* for transfers */
> +	int			len;
> +	int			count;
> +	/* data buffers */
> +	const unsigned char	*tx;
> +	unsigned char		*rx;
> +	/* pointer to the registers */
> +	struct spi_ppc4xx_regs __iomem *regs;
> +	struct spi_master	*master;
> +	struct device		*dev;
> +
> +	/* flags to record whether a GPIO pin has been set up as an output */
> +	u8			gpio0_flags[GPIO_NUMPINS];
> +	u8			gpio1_flags[GPIO_NUMPINS];

This should also not be driver-specific.  I take it the hardware
is quite strange and you can't just test a bit in a register to
see how it's set up?   Regardless, this driver shouldn't need
to *test* whether it's been set up that way...


> +};
> +
> +/* need this so we can set the clock in the chipselect routine */
> +struct spi_ppc4xx_cs {
> +	/* speed in hertz */
> +	u32	speed_hz;
> +	/* bits per word - must be 8! */
> +	u8	bpw;

If it must be 8, then why bother recording it and managing the
associated state??


> +};
> +
> +static int spi_ppc4xx_txrx(struct spi_device *spi, struct spi_transfer *t)
> +{
> +	struct ppc4xx_spi *hw;
> +	u8 data;
> +
> +	dev_dbg(&spi->dev, "txrx: tx %p, rx %p, len %d\n",
> +		t->tx_buf, t->rx_buf, t->len);
> +
> +	hw = spi_master_get_devdata(spi->master);
> +
> +	hw->tx = t->tx_buf;
> +	hw->rx = t->rx_buf;
> +	hw->len = t->len;
> +	hw->count = 0;
> +
> +	/* send the first byte */
> +	data = hw->tx ? hw->tx[0] : 0;
> +	out_8(&hw->regs->txd, data);
> +	out_8(&hw->regs->cr, SPI_PPC4XX_CR_STR);

	/* let PIO IRQs handle all the other bytes */

> +	wait_for_completion(&hw->done);
> +
> +	return hw->count;
> +}
> +
> +static int spi_ppc4xx_setupxfer(struct spi_device *spi, struct spi_transfer *t)
> +{
> +	struct ppc4xx_spi *hw;
> +	struct spi_ppc4xx_cs *cs = spi->controller_state;
> +
> +	hw = spi_master_get_devdata(spi->master);
> +
> +	cs->bpw = t ? t->bits_per_word : spi->bits_per_word;
> +	cs->speed_hz  = t ? t->speed_hz : spi->max_speed_hz;
> +
> +	if (cs->bpw != 8) {
> +		dev_err(&spi->dev, "invalid bits-per-word (%d)\n", cs->bpw);
> +		return -EINVAL;
> +	}
> +
> +	spin_lock(&hw->bitbang.lock);
> +	if (!hw->bitbang.busy)
> +		hw->bitbang.chipselect(spi, BITBANG_CS_INACTIVE);
> +	spin_unlock(&hw->bitbang.lock);
> +
> +	return 0;
> +}
> +
> +static int spi_ppc4xx_setup(struct spi_device *spi)
> +{
> +	int ret;
> +	struct spi_ppc4xx_cs *cs = spi->controller_state;
> +
> +	if (!spi->bits_per_word)
> +		spi->bits_per_word = 8;
> +
> +	if (spi->mode & ~MODEBITS) {
> +		dev_dbg(&spi->dev, "setup: unsupported mode bits %x\n",
> +			spi->mode & ~MODEBITS);
> +		return -EINVAL;
> +	}
> +
> +	if (cs == NULL) {
> +		cs = kzalloc(sizeof(*cs), GFP_KERNEL);
> +		if (!cs)
> +			return -ENOMEM;
> +		spi->controller_state = cs;
> +	}
> +	cs->speed_hz = spi->max_speed_hz;
> +	cs->bpw = spi->bits_per_word;
> +
> +	ret = spi_ppc4xx_setupxfer(spi, NULL);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "setupxfer returned %d\n", ret);
> +		return ret;
> +	}
> +
> +	dev_dbg(&spi->dev, "%s: mode %d, %u bpw, %d hz\n",
> +		__FUNCTION__, spi->mode, spi->bits_per_word,
> +		spi->max_speed_hz);
> +
> +	return 0;
> +}
> +
> +/*
> + * The next two routines are very 440EPx specific!

You repeat that comment many times.  If that's so important,
shouldn't this be the "spi_ppc400epx.c" driver?


> + * They should really be in a platform-specific file or be handled by
> + * generic GPIO handlers. They can go away once gnereic GPIO support is
> + * available for 4xx.

Is there some holdup on generic (spelling!) GPIO support for
this chip?  ISTR seeing some patches not that long ago.  But
maybe folk are waiting for "gpiolib", which should help make
it easy even if the hardware is particularly odd.


> + * NOTE: chipsel must be zero-based.
> + */
> +
> +/*
> + * Check whether a GPIO pin (used as chip select) is set up as an output.
> + * If not, set it up and note it in the appropriate flags array.
> + *
> + * NOTE: this assumes that the specified pin is really not needed for one
> + * of the alternate configurations and just blasts it.

The general policy should be that board setup code does the pin muxing;
that is, the setting up the platform_device did it.  And even if maybe
the OF framework doesn't handle that, it should certainly ensure that
there are no conflicts over the use of any given pin ...


> + */
> +static void spi_ppc4xx_gpio_check(struct ppc4xx_spi *hw, u8 pin)
> +{
> +	u8 *flags;
> +	void __iomem *gpio = hw->gpio0;
> +	/*
> +	 * Most of this code lifted from u-boot.
> +	 * Thanks go to Stefan Roese.
> +	 */
> +	u32 mask;
> +	u32 mask2;
> +	u32 val;
> +	u32 offs = 0;
> +	u32 offs2 = 0;
> +	int pin2 = pin << 1;
> +
> +	flags = hw->gpio0_flags;
> +	if (pin >= GPIO_NUMPINS) {
> +		offs = 0x100;
> +		pin -= GPIO_NUMPINS;
> +		flags = hw->gpio1_flags;
> +	}
> +	/* already set up for output */
> +	if (flags[pin])
> +		return;

Already set up by *this* code as output.  What happens
when other code works with GPIOs?  You shouldn't
actually need to record that you did this.  Nobody
else should be touching "your" GPIOs, and you shouldn't
be doing this more than once anyway.  And even if you
did ... what's the harm in re-doing it?

> +
> +	if (pin >= GPIO_NUMPINS/2) {
> +		/* point at OSRH/TSRH */
> +		offs2 = 0x04;
> +		pin2 = (pin - GPIO_NUMPINS/2) << 1;
> +	}
> +
> +	mask = 0x80000000 >> pin;
> +	mask2 = 0xc0000000 >> (pin2 << 1);
> +
> +	/* first set TCR to 0 */
> +	val = in_be32(gpio + GPIOx_TCR + offs) & ~mask;
> +	out_be32(gpio + GPIOx_TCR + offs, val);

Such read/modify/write idioms need locking to protect against
other code doing the same thing.  (That is, assuming you even
need to change those bit fields...)

> +
> +	/* always want to set up the pin for output */
> +	/* clear GPIOx_OSRL/H */
> +	val = in_be32(gpio + GPIOx_OSRL + offs + offs2) & ~mask2;
> +	out_be32(gpio + GPIOx_OSRL + offs + offs2, val);

Here too ...

> +	/* clear GPIOx_TSRL/H */
> +	val = in_be32(gpio + GPIOx_TSRL + offs + offs2) & ~mask2;
> +	out_be32(gpio + GPIOx_TSRL + offs + offs2, val);

... again ...

> +	/* clear GPIOx_ODR */
> +	val = in_be32(gpio + GPIOx_ODR + offs) & ~mask;
> +	out_be32(gpio + GPIOx_ODR + offs, val);

... again ...

> +
> +	/* now configure TCR to drive output if selected */
> +	val = in_be32(gpio + GPIOx_TCR + offs) | mask;
> +	out_be32(gpio + GPIOx_TCR + offs, val);

... again.


> +
> +	flags[pin] = 1;
> +}
> +
> +/*
> + * Set the chip select as a GPIO.
> + */
> +static void spi_ppc4xx_gpio(struct ppc4xx_spi *hw, u8 chipsel, u8 pol)
> +{
> +	void __iomem *gpio = hw->gpio0;
> +	u32 val;
> +
> +	/* check whether the pin is set up for output */
> +	spi_ppc4xx_gpio_check(hw, chipsel);
> +
> +	if (chipsel >= GPIO_NUMPINS) {
> +		gpio = hw->gpio1;
> +		chipsel -= GPIO_NUMPINS;
> +	}
> +
> +	val = in_be32(gpio);
> +	if (pol)
> +		val |= (0x80000000 >> chipsel);
> +	else
> +		val &= ~(0x80000000 >> chipsel);
> +	out_be32(gpio, val);

More missing locking ...


> +}
> +
> +static void spi_ppc4xx_chipsel(struct spi_device *spi, int value)
> +{
> +	struct ppc4xx_spi *hw;
> +	struct spi_ppc4xx_cs *cs = spi->controller_state;
> +	unsigned int cspol = spi->mode & SPI_CS_HIGH ? 1 : 0;
> +	unsigned char mode;
> +	unsigned char cdm, oldcdm;
> +	int scr;
> +
> +	hw = spi_master_get_devdata(spi->master);
> +
> +	/* disable the controller here? */
> +
> +	switch (value) {
> +	case BITBANG_CS_INACTIVE:
> +		spi_ppc4xx_gpio(hw, spi->chip_select, cspol^1);
> +		break;
> +
> +	case BITBANG_CS_ACTIVE:
> +		mode = in_8(&hw->regs->mode);
> +
> +		/* clear the CLK bits */
> +		mode &= ~SPI_CLK_MODE3;
> +		switch (spi->mode & (SPI_CPHA|SPI_CPOL)) {
> +		case SPI_MODE_0:
> +			mode |= SPI_CLK_MODE0;
> +			break;
> +		case SPI_MODE_1:
> +			mode |= SPI_CLK_MODE1;
> +			break;
> +		case SPI_MODE_2:
> +			mode |= SPI_CLK_MODE2;
> +			break;
> +		case SPI_MODE_3:
> +			mode |= SPI_CLK_MODE3;
> +			break;
> +		}
> +
> +		if (spi->mode & SPI_LSB_FIRST)
> +			mode |= SPI_PPC4XX_MODE_RD;
> +		else
> +			mode &= ~SPI_PPC4XX_MODE_RD;
> +
> +		mode |= SPI_PPC4XX_MODE_SPE;
> +
> +		/* set the clock */
> +		cdm = 0;
> +		/* opb_freq was already divided by 4 */
> +		scr = (hw->opb_freq/cs->speed_hz) - 1;
> +
> +		if (scr <= 0)
> +			goto cdm_done;
> +
> +		cdm = scr & 0xff;
> +
> +cdm_done:
> +		dev_dbg(&spi->dev, "setting pre-scaler to %d (hz %d)\n", cdm,
> +			cs->speed_hz);
> +		oldcdm = in_8(&hw->regs->cdm);

Again, this is more read/modify/write logic that's done without
locking ... since these registers are reserved for this SPI master
controller, this mostly just *looks* dicey.  It's only called when
working on a transfer with this specific device.


> +		if (oldcdm != cdm)
> +			out_8(&hw->regs->cdm, cdm);
> +		/* write new configration */
> +		out_8(&hw->regs->mode, mode);
> +
> +		spi_ppc4xx_gpio(hw, spi->chip_select, cspol);
> +
> +		break;
> +	}
> +}
> +
> +static irqreturn_t spi_ppc4xx_int(int irq, void *dev_id)
> +{
> +	struct ppc4xx_spi *hw;
> +	u8 status;
> +	u8 data;
> +	unsigned int count;
> +
> +	hw = dev_id;
> +
> +	if (irq != hw->irqnum) {
> +		printk(KERN_WARNING
> +		       "spi_ppc4xx_int : "
> +		       "Received wrong int %d. Waiting for %d\n", irq,
> +			hw->irqnum);
> +		return IRQ_NONE;
> +	}
> +
> +	status = in_8(&hw->regs->sr);
> +
> +	/* should never happen but check anyway */
> +	if (status & SPI_PPC4XX_SR_BSY) {
> +		dev_dbg(hw->dev, "got interrupt but spi still busy?\n");
> +		complete(&hw->done);
> +		return IRQ_HANDLED;
> +	}
> +
> +	count = hw->count;
> +	hw->count++;
> +
> +	if (status & SPI_PPC4XX_SR_RBR) {
> +		/* Data Ready */
> +		data = in_8(&hw->regs->rxd);
> +		if (hw->rx)
> +			hw->rx[count] = data;
> +	}
> +
> +	count++;
> +
> +	if (count < hw->len) {
> +		data = hw->tx ? hw->tx[count] : 0;
> +		out_8(&hw->regs->txd, data);
> +		out_8(&hw->regs->cr, SPI_PPC4XX_CR_STR);

So this is byte-at-a-time PIO, and it's IRQ-driven.
Probably fine for light-duty devices, but not for
stuff like filesystems sitting on SPI flash.


> +	} else {
> +		complete(&hw->done);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void spi_ppc4xx_cleanup(struct spi_device *spi)
> +{
> +	kfree(spi->controller_state);
> +}
> +
> +static void spi_ppc4xx_enable(struct ppc4xx_spi *hw)
> +{
> +	unsigned long pfc1;
> +	uint osrh, tsrh;
> +
> +	mtdcr(SDR0_CFGADDR, SDR0_PFC1);
> +	pfc1 = mfdcr(SDR0_CFGDATA);
> +	/* need to clear bit 14 to enable SPC */
> +	pfc1 &= ~(1 << 17);
> +	mtdcr(SDR0_CFGADDR, SDR0_PFC1);
> +	mtdcr(SDR0_CFGDATA, pfc1);
> +
> +	/* enable SPCDO */
> +	osrh = in_be32((void *)((u32)hw->gpio0 + GPIOx_OSRH));
> +	tsrh = in_be32((void *)((u32)hw->gpio0 + GPIOx_TSRH));
> +	/* need to set bits 14:15 in OSRH to 0x01 */
> +	osrh &= ~(0x03 << 16);
> +	osrh |= (0x01 << 16);
> +	out_be32((void *)((u32)hw->gpio0 + GPIOx_OSRH), osrh);
> +
> +	/* need to set bits 14:15 in TSRH to 0x01 */
> +	tsrh &= ~(0x03 << 16);
> +	tsrh |= (0x01 << 16);
> +	out_be32((void *)((u32)hw->gpio0 + GPIOx_TSRH), tsrh);
> +}
> +
> +#ifdef CONFIG_PPC_OF
> +static int __init spi_ppc4xx_of_probe(struct of_device *op,
> +	const struct of_device_id *match)
> +{
> +	struct ppc4xx_spi *hw;
> +	struct spi_master *master;
> +	struct spi_bitbang *bbp;
> +	struct resource resource;
> +	struct device_node *np = op->node;
> +	struct device *dev = &op->dev;
> +	struct device_node *gpionp;
> +	const u32 *regaddr;
> +	u64 addr64, size64;
> +	int ret;
> +	const unsigned int *clk;
> +

A lot of this code isn't OF-specific, so you should probably package
it in a common routine to be called by the non-OF code paths.  The
basic approach would be fetching the resources first (from OF or the
platform code), then passing them down to the code which sets the
driver up to use them.

Not sharing is a set of bugs waiting to happen.  Someone will change
something on one path, not the other ... which then breaks on some
hardware they don't have.


> +	master = spi_alloc_master(dev, sizeof(*hw));
> +	if (master == NULL)
> +		return -ENOMEM;
> +	dev_set_drvdata(dev, master);
> +	hw = spi_master_get_devdata(master);
> +	memset(hw, 0, sizeof(*hw));

That memory was allocated with kzalloc(), so memset isn't needed.

> +
> +	hw->master = spi_master_get(master);
> +	hw->dev = dev;
> +
> +	init_completion(&hw->done);
> +
> +	/* setup the state for the bitbang driver */
> +	bbp = &hw->bitbang;
> +	bbp->master = hw->master;
> +	bbp->setup_transfer = spi_ppc4xx_setupxfer;
> +	bbp->chipselect = spi_ppc4xx_chipsel;
> +	bbp->txrx_bufs = spi_ppc4xx_txrx;
> +	bbp->use_dma = 0;

Pre-zeroed.

> +	bbp->master->setup = spi_ppc4xx_setup;
> +	bbp->master->cleanup = spi_ppc4xx_cleanup;
> +	/* only one SPI controller */
> +	bbp->master->bus_num = 0;

That'd be 400EPx-specific though, yes?  :)

> +	if (bbp->master->num_chipselect == 0)
> +		bbp->master->num_chipselect = GPIO_TOTPINS;
> +
> +	dev_dbg(dev, "bitbang at %p\n", bbp);

None of that was OF-specific ...


But here's some OF-specific logic:

> +
> +	/* get the clock for the OPB */
> +	gpionp = of_find_compatible_node(NULL, NULL, "ibm,opb");
> +	if (gpionp == NULL) {
> +		dev_warn(dev, "OPB: cannot find node\n");
> +		ret = -ENODEV;
> +		goto free_master;
> +	}
> +	/* get the clock (Hz) for the OPB */
> +	clk = of_get_property(gpionp, "clock-frequency", NULL);
> +	if (clk == NULL) {
> +		dev_warn(dev, "OPB: no clock-frequency property set\n");
> +		of_node_put(gpionp);
> +		ret = -ENODEV;
> +		goto free_master;
> +	}
> +	hw->opb_freq = *clk;
> +	hw->opb_freq >>= 2;
> +	of_node_put(gpionp);
> +
> +	ret = of_address_to_resource(np, 0, &resource);
> +	if (ret) {
> +		printk(KERN_ERR "Error while parsing device node resource\n");
> +		goto free_master;
> +	}

Once you have this resource, code using it should be generic.  Like:

> +	hw->mapbase = resource.start;
> +	hw->mapsize = resource.end - resource.start + 1;
> +
> +	/* sanity check */
> +	if (hw->mapsize < sizeof(struct spi_ppc4xx_regs)) {
> +		dev_warn(dev, "too small to map registers\n");
> +		/* XXXX */

What's this XXXX thing indicate?  You could have checked that
before doing all the work above, and eliminated the need to do
any cleanup.  :)

> +		ret = -EINVAL;
> +		goto free_master;
> +	}
> +

Here's one non-generic line:

> +	hw->irqnum = irq_of_parse_and_map(np, 0);

Likewise, once you have the resource, the relevant code should be
generic.  (And use the same driver name...)  Like:

> +	ret = request_irq(hw->irqnum, spi_ppc4xx_int,
> +			  IRQF_DISABLED, "spi_ppc4xx_of", (void *)hw);
> +	if (ret) {
> +		dev_warn(dev, "unable to allocate interrupt\n");
> +		goto free_master;
> +	}
> +
> +	if (!request_mem_region(hw->mapbase, hw->mapsize, DRIVER_NAME)) {
> +		dev_warn(dev, "resource unavailable\n");
> +		ret = -EBUSY;
> +		goto request_mem_error;
> +	}
> +
> +	hw->regs = ioremap(hw->mapbase, sizeof(struct spi_ppc4xx_regs));
> +
> +	if (!hw->regs) {
> +		dev_warn(dev, "unable to memory map registers\n");
> +		ret = -ENXIO;
> +		goto map_io_error;
> +	}

None of that was OF-specific.


Here's some OF-specific GPIO support though:

> +
> +	/* since there's no GPIO driver we have to do it ourselves */
> +	/* find the entry for GPIO0 */
> +	gpionp = of_find_compatible_node(NULL, NULL, "ibm,gpio");
> +	if (gpionp == NULL) {
> +		dev_warn(dev, "unable to find node for GPIO0\n");
> +		ret = -ENODEV;
> +		goto unmap_regs;
> +	}
> +	regaddr = of_get_address(gpionp, 0, &size64, NULL);
> +	if (regaddr == NULL) {
> +		dev_warn(dev, "unable to get address for GPIO0\n");
> +		of_node_put(gpionp);
> +		ret = -ENODEV;
> +		goto unmap_regs;
> +	}
> +	addr64 = of_translate_address(gpionp, regaddr);
> +
> +	hw->gpio0 = ioremap(addr64, size64);
> +	if (!hw->gpio0) {
> +		dev_warn(dev, "unable to memory map gpio0\n");
> +		of_node_put(gpionp);
> +		ret = -ENOMEM;
> +		goto unmap_regs;
> +	}
> +	gpio0np = gpionp;
> +
> +	/* find the entry for GPIO1 */
> +	/* note that this will of_node_put gpio0np! */
> +	gpionp = of_find_compatible_node(gpio0np, NULL, "ibm,gpio");
> +	if (gpionp == NULL) {
> +		dev_warn(dev, "unable to find node for GPIO1\n");
> +		ret = -ENODEV;
> +		goto unmap_gpio0;
> +	}
> +	regaddr = of_get_address(gpionp, 0, &size64, NULL);
> +	if (regaddr == NULL) {
> +		dev_warn(dev, "unable to get address for GPIO1\n");
> +		of_node_put(gpionp);
> +		ret = -ENODEV;
> +		goto unmap_gpio0;
> +	}
> +	addr64 = of_translate_address(gpionp, regaddr);
> +
> +	/* possibly needed for CS */
> +	hw->gpio1 = ioremap(addr64, size64);
> +	if (!hw->gpio1) {
> +		dev_warn(dev, "unable to memory map gpio1\n");
> +		of_node_put(gpionp);
> +		ret = -ENOMEM;
> +		goto unmap_gpio0;
> +	}
> +	of_node_put(gpionp);

Whew!  Wouldn't it have been easier to just implement the generic
GPIO calls once, for all platforms?  ;)


More generic code follows:

> +
> +	spi_ppc4xx_enable(hw);
> +
> +	/* register our spi controller */
> +	ret = spi_bitbang_start(bbp);
> +	if (ret) {
> +		dev_err(dev, "Failed to register SPI master\n");
> +		goto unmap_gpio0;
> +	}
> +
> +	printk(KERN_INFO "SPI: SPI_PPC4XX OF SPI driver\n");

Make that a dev_info().  

> +
> +	return 0;
> +
> +unmap_gpio0:
> +	iounmap(hw->gpio0);
> +unmap_regs:
> +	iounmap(hw->regs);
> +map_io_error:
> +	release_mem_region(hw->mapbase, hw->mapsize);
> +request_mem_error:
> +	free_irq(hw->irqnum, hw);
> +free_master:
> +	dev_set_drvdata(dev, NULL);
> +	spi_master_put(master);
> +
> +	dev_err(dev, "initialization failed\n");
> +	return ret;
> +}
> +
> +static int __exit spi_ppc4xx_of_remove(struct of_device *op)
> +{
> +	struct spi_master *master = dev_get_drvdata(&op->dev);
> +	struct ppc4xx_spi *hw;

Most of this doesn't look OF-specific either; other than the obvious
bit with parameters, and needing your own private GPIO framework.


> +
> +	hw = spi_master_get_devdata(master);
> +	spi_bitbang_stop(&hw->bitbang);
> +	spi_unregister_master(hw->master);
> +	dev_set_drvdata(&op->dev, NULL);
> +	release_mem_region(hw->mapbase, hw->mapsize);
> +	free_irq(hw->irqnum, hw);
> +	iounmap(hw->regs);
> +	iounmap(hw->gpio0);
> +	iounmap(hw->gpio1);
> +
> +	return 0;
> +}
> +
> +static struct of_device_id spi_ppc4xx_of_match[] = {
> +	{ .type = "spi", .compatible = "ibm,spi", },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, spi_ppc4xx_of_match);
> +
> +static struct of_platform_driver spi_ppc4xx_of_driver = {
> +	.owner = THIS_MODULE,
> +	.name = DRIVER_NAME,
> +	.match_table = spi_ppc4xx_of_match,
> +	.probe = spi_ppc4xx_of_probe,
> +	.remove = __exit_p(spi_ppc4xx_of_remove),
> +	.driver = {
> +		.name = DRIVER_NAME,
> +		.owner = THIS_MODULE,
> +	},
> +};
> +
> +static int __init spi_ppc4xx_init(void)
> +{
> +	return of_register_platform_driver(&spi_ppc4xx_of_driver);
> +}
> +
> +static void __exit spi_ppc4xx_exit(void)
> +{
> +	of_unregister_platform_driver(&spi_ppc4xx_of_driver);
> +}
> +
> +#else /* not OF-type probe */
> +
> +static int __devinit spi_ppc4xx_probe(struct platform_device *pdev)
> +{
> +	struct ppc4xx_spi *hw;
> +	struct spi_master *master;
> +	struct spi_bitbang *bbp;
> +	struct device *dev = &pdev->dev;
> +	struct resource *mem_io, *irqres;
> +	int ret = -ENODEV;
> +

Yep, large parts of this were cut'n'paste.  There should be
some shared core routines.  The bus glue (OF vs platform)
can be limited to fetching resources.  


> +	master = spi_alloc_master(dev, sizeof(*hw));
> +	if (master == NULL)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, master);
> +	hw = spi_master_get_devdata(master);
> +	memset(hw, 0, sizeof(*hw));
> +
> +	hw->master = spi_master_get(master);
> +	hw->dev = dev;
> +
> +	platform_set_drvdata(pdev, hw);
> +	init_completion(&hw->done);
> +
> +	/* setup the state for the bitbang driver */
> +	bbp = &hw->bitbang;
> +	bbp->master = hw->master;
> +	bbp->setup_transfer = spi_ppc4xx_setupxfer;
> +	bbp->chipselect = spi_ppc4xx_chipsel;
> +	bbp->txrx_bufs = spi_ppc4xx_txrx;
> +	bbp->use_dma = 0;
> +	bbp->master->setup = spi_ppc4xx_setup;
> +	bbp->master->cleanup = spi_ppc4xx_cleanup;
> +	/* only one SPI controller */
> +	bbp->master->bus_num = 0;
> +	if (bbp->master->num_chipselect == 0)
> +		bbp->master->num_chipselect = GPIO_TOTPINS;
> +
> +	dev_dbg(dev, "bitbang at %p\n", bbp);
> +
> +	/* get the clock (Hz) for the OPB. Set in sequoia_setup_arch() */
> +	hw->opb_freq = ocp_sys_info.opb_bus_freq >> 2;
> +


Your own GPIO framework again...

> +	/* needed to set SCPD0 */
> +	hw->gpio0 = ioremap(GPIO0_BASE, GPIOx_SIZE);
> +	if (hw->gpio0 == NULL) {
> +		printk(KERN_ERR DRIVER_NAME " unable to ioremap GPIO0\n");
> +		ret = -ENOMEM;
> +		goto free_master;
> +	}
> +	/* possibly needed for CS */
> +	hw->gpio1 = ioremap(GPIO1_BASE, GPIOx_SIZE);
> +	if (hw->gpio1 == NULL) {
> +		printk(KERN_ERR DRIVER_NAME " unable to ioremap GPIO1\n");

More printk abuse.  Throughout this driver, assume that
you should use dev_dbg() for the diagnostics instead
of printk.  Runtime errors may deserve dev_err() or
dev_warn(), but probe errors basically don't happen
after the platform is set up properly, so most of the
messages in probe paths should be dev_dbg.


> +		iounmap(hw->gpio0);
> +		ret = -ENOMEM;
> +		goto free_master;
> +	}
> +

... intermingled with otherwise sharable code to use the resources
that come in different glue-specific packaging ... 


> +	mem_io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	irqres = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +

... and from here on down, nothing much should be non-sharable.
(Except some parts of the cleanup paths.)


> +	if ((!mem_io) | (!irqres))
> +		goto out_err;
> +	/* save value for release_mem_region use */
> +	hw->mapbase = mem_io->start;
> +	hw->mapsize = mem_io->end - mem_io->start + 1;
> +	/* sanity check */
> +	if (hw->mapsize < sizeof(struct spi_ppc4xx_regs)) {
> +		dev_warn(dev, "too small to map registers\n");
> +		/* XXXX */
> +		ret = -EINVAL;
> +		goto out_err;
> +	}
> +
> +	hw->irqnum = irqres->start;
> +	ret = request_irq(hw->irqnum, spi_ppc4xx_int,
> +			  IRQF_DISABLED, "spi_ppc4xx", (void *)hw);
> +	if (ret)
> +		goto out_err;
> +
> +	if (!request_mem_region(hw->mapbase, hw->mapsize, DRIVER_NAME)) {
> +		printk(KERN_ERR DRIVER_NAME " - resource unavailable\n");

dev_err(), or better yet dev_dbg()

> +		ret = -EBUSY;
> +		goto request_mem_error;
> +	}
> +
> +	hw->regs = ioremap(hw->mapbase, sizeof(struct spi_ppc4xx_regs));
> +
> +	if (!hw->regs) {
> +		printk(KERN_ERR DRIVER_NAME " - failed to map spi regs\n");

dev_err() at best, but I'd make it dev_dbg().

> +		ret = -ENXIO;
> +		goto map_io_error;
> +	}
> +
> +	spi_ppc4xx_enable(hw);
> +
> +	/* register our spi controller */
> +	ret = spi_bitbang_start(bbp);
> +	if (ret) {
> +		dev_err(dev, "Failed to register SPI master\n");
> +		goto map_io_error;
> +	}
> +
> +	return 0;
> +
> +map_io_error:
> +	release_mem_region(hw->mapbase, hw->mapsize);
> +request_mem_error:
> +	free_irq(hw->irqnum, hw);
> +out_err:
> +	iounmap(hw->gpio0);
> +	iounmap(hw->gpio1);
> +free_master:
> +	platform_set_drvdata(pdev, NULL);
> +	dev_set_drvdata(dev, NULL);
> +	spi_master_put(master);
> +
> +	printk(KERN_ERR "SPI: SPI_PPC4XX SPI init FAILED !!!\n");

Again, dev_err() ... but since this would be abnormal, and could
well be reported by the caller, I'd go for dev_dbg().

> +	return ret;
> +}
> +
> +static int __devexit spi_ppc4xx_remove(struct platform_device *dev)
> +{
> +	struct ppc4xx_spi *hw;
> +

All but identical to the OF code path.  Share one common routine.


> +	hw = platform_get_drvdata(dev);
> +	spi_bitbang_stop(&hw->bitbang);
> +	spi_unregister_master(hw->master);
> +	dev_set_drvdata(&dev->dev, NULL);
> +	platform_set_drvdata(dev, NULL);
> +	release_mem_region(hw->mapbase, hw->mapsize);
> +	free_irq(hw->irqnum, hw);
> +	iounmap(hw->regs);
> +	iounmap(hw->gpio0);
> +	iounmap(hw->gpio1);
> +
> +	return 0;
> +}
> +
> +static struct platform_driver spi_ppc4xx_platform_driver = {
> +	.probe = spi_ppc4xx_probe,
> +	.remove = __exit_p(spi_ppc4xx_remove),
> +	.driver = {
> +		   .name = "spi_ppc4xx",
> +		   .owner = THIS_MODULE,
> +	},
> +};
> +
> +static int __init spi_ppc4xx_init(void)
> +{
> +	printk(KERN_INFO "SPI: SPI_PPC4XX SPI driver\n");

I'm no fan of such banner messages.  But if you insist on having
one PLEASE DON'T SCREAM, and be consistent:  The OF code doesn't
have such a message.


> +	return platform_driver_register(&spi_ppc4xx_platform_driver);

I prefer platform_driver_probe() myself, but maybe you can't use
that on these systems.

> +}
> +
> +static void __exit spi_ppc4xx_exit(void)
> +{
> +	platform_driver_unregister(&spi_ppc4xx_platform_driver);
> +}
> +#endif /* CONFIG_PPC_OF */
> +
> +module_init(spi_ppc4xx_init);
> +module_exit(spi_ppc4xx_exit);
> +
> +MODULE_LICENSE("GPL");
> 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
