From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 01/12] misc: add driver for sequencer serial port
Date: Fri, 15 Oct 2010 23:00:55 -0600
Message-ID: <20101016050055.GH21170@angua.secretlab.ca>
References: <1287081535-2864-1-git-send-email-cyril@ti.com>
	<1287081535-2864-2-git-send-email-cyril@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
        broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org
To: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1287081535-2864-2-git-send-email-cyril-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Oct 14, 2010 at 02:38:44PM -0400, Cyril Chemparathy wrote:
> TI's sequencer serial port (TI-SSP) is a jack-of-all-trades type of serial port
> device.  It has a built-in programmable execution engine that can be programmed
> to operate as almost any serial bus (I2C, SPI, EasyScale, and others).
> 
> This patch adds a driver for this controller device.  The driver does not
> expose a user-land interface.  Protocol drivers built on top of this layer are
> expected to remain in-kernel.
> 
> Signed-off-by: Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>

Hi Cyril,

Overall the driver looks pretty clean, but I have an issue with the
usage model (see below).

> ---
>  arch/arm/mach-davinci/include/mach/ti_ssp.h |   92 ++++++
>  drivers/misc/Kconfig                        |   11 +
>  drivers/misc/Makefile                       |    1 +
>  drivers/misc/ti_ssp.c                       |  443 +++++++++++++++++++++++++++
>  4 files changed, 547 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-davinci/include/mach/ti_ssp.h
>  create mode 100644 drivers/misc/ti_ssp.c
> 
> diff --git a/arch/arm/mach-davinci/include/mach/ti_ssp.h b/arch/arm/mach-davinci/include/mach/ti_ssp.h
> new file mode 100644
> index 0000000..8365101
> --- /dev/null
> +++ b/arch/arm/mach-davinci/include/mach/ti_ssp.h
> @@ -0,0 +1,92 @@
> +/*
> + * Sequencer Serial Port (SSP) driver for Texas Instruments' SoCs
> + *
> + * Copyright (C) 2010 Texas Instruments Inc
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#ifndef __TI_SSP_H__
> +#define __TI_SSP_H__
> +
> +struct ti_ssp_data {
> +	unsigned long		out_clock;
> +};
> +
> +struct ti_ssp_port_data {
> +	const char	*ssp_dev_name;
> +	int		port;
> +	unsigned long	iosel; /* see note below */
> +	unsigned long	config;
> +};
> +
> +struct ti_ssp_port;
> +
> +/*
> + * Sequencer port IO pin configuration bits.  These do not correlate 1-1 with
> + * the hardware.  The iosel field in the port data combines iosel1 and iosel2,
> + * and is therefore not a direct map to register space.  It is best to use the
> + * macros below to construct iosel values.
> + *
> + * least significant 16 bits --> iosel1
> + * most significant 16 bits  --> iosel2
> + */
> +
> +#define SSP_IN			0x0000
> +#define SSP_DATA		0x0001
> +#define SSP_CLOCK		0x0002
> +#define SSP_CHIPSEL		0x0003
> +#define SSP_OUT			0x0004
> +#define SSP_PIN_SEL(pin, v)	((v) << ((pin) * 3))
> +#define SSP_PIN_MASK(pin)	SSP_PIN_SEL(pin, 0x7)
> +#define SSP_INPUT_SEL(pin)	((pin) << 16)
> +
> +/* Sequencer port config bits */
> +#define SSP_EARLY_DIN		BIT(8)
> +#define SSP_DELAY_DOUT		BIT(9)
> +
> +/* Sequence map definitions */
> +#define SSP_CLK_HIGH		BIT(0)
> +#define SSP_CLK_LOW		0
> +#define SSP_DATA_HIGH		BIT(1)
> +#define SSP_DATA_LOW		0
> +#define SSP_CS_HIGH		BIT(2)
> +#define SSP_CS_LOW		0
> +#define SSP_OUT_MODE		BIT(3)
> +#define SSP_IN_MODE		0
> +#define SSP_DATA_REG		BIT(4)
> +#define SSP_ADDR_REG		0
> +
> +#define SSP_OPCODE_DIRECT	((0x0) << 5)
> +#define SSP_OPCODE_TOGGLE	((0x1) << 5)
> +#define SSP_OPCODE_SHIFT	((0x2) << 5)
> +#define SSP_OPCODE_BRANCH0	((0x4) << 5)
> +#define SSP_OPCODE_BRANCH1	((0x5) << 5)
> +#define SSP_OPCODE_BRANCH	((0x6) << 5)
> +#define SSP_OPCODE_STOP		((0x7) << 5)
> +#define SSP_BRANCH(addr)	((addr) << 8)
> +#define SSP_COUNT(cycles)	((cycles) << 8)
> +
> +struct ti_ssp_port *ti_ssp_open(const struct ti_ssp_port_data *data);
> +int ti_ssp_close(struct ti_ssp_port *dev);
> +int ti_ssp_dumpregs(struct ti_ssp_port *dev);
> +int ti_ssp_raw_read(struct ti_ssp_port *dev);
> +int ti_ssp_raw_write(struct ti_ssp_port *dev, u32 val);
> +int ti_ssp_load(struct ti_ssp_port *dev, int offs, u32* prog, int len);
> +int ti_ssp_run(struct ti_ssp_port *dev, u32 pc, u32 input, u32 *output);
> +int ti_ssp_set_mode(struct ti_ssp_port *dev, int mode);
> +int ti_ssp_set_iosel(struct ti_ssp_port *dev, u32 iosel);
> +
> +#endif /* __TI_SSP_H__ */
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index b743312..9fb8470 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -390,6 +390,17 @@ config BMP085
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called bmp085.
>  
> +config TI_SSP
> +	depends on ARCH_DAVINCI_TNETV107X
> +	tristate "Sequencer Serial Port support"
> +	default y
> +	---help---
> +	  Say Y here if you want support for the Sequencer Serial Port
> +	  in a Texas Instruments TNETV107X SoC.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ti_ssp.
> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 42eab95..7568100 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -28,6 +28,7 @@ obj-$(CONFIG_SENSORS_TSL2550)	+= tsl2550.o
>  obj-$(CONFIG_EP93XX_PWM)	+= ep93xx_pwm.o
>  obj-$(CONFIG_DS1682)		+= ds1682.o
>  obj-$(CONFIG_TI_DAC7512)	+= ti_dac7512.o
> +obj-$(CONFIG_TI_SSP)		+= ti_ssp.o
>  obj-$(CONFIG_C2PORT)		+= c2port/
>  obj-$(CONFIG_IWMC3200TOP)      += iwmc3200top/
>  obj-$(CONFIG_HMC6352)		+= hmc6352.o
> diff --git a/drivers/misc/ti_ssp.c b/drivers/misc/ti_ssp.c
> new file mode 100644
> index 0000000..edbc94d
> --- /dev/null
> +++ b/drivers/misc/ti_ssp.c
> @@ -0,0 +1,443 @@
> +/*
> + * Sequencer Serial Port (SSP) driver for Texas Instruments' SoCs
> + *
> + * Copyright (C) 2010 Texas Instruments Inc
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/wait.h>
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/device.h>
> +#include <linux/spinlock.h>
> +#include <linux/platform_device.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +
> +#include <mach/ti_ssp.h>
> +
> +/* Register Offsets */
> +#define SSP_REG_REV		0x00
> +#define SSP_REG_IOSEL_1		0x04
> +#define SSP_REG_IOSEL_2		0x08
> +#define SSP_REG_PREDIV		0x0c
> +#define SSP_REG_INTR_STAT	0x10
> +#define SSP_REG_INTR_EN		0x14
> +#define SSP_REG_TEST_CTRL	0x18
> +
> +/* Per port registers */
> +#define SSP_PORT_REG_CFG_2	0x00
> +#define SSP_PORT_REG_ADDR	0x04
> +#define SSP_PORT_REG_DATA	0x08
> +#define SSP_PORT_REG_CFG_1	0x0c
> +#define SSP_PORT_REG_STATE	0x10
> +
> +#define SSP_PORT_CONFIG_MASK	(SSP_EARLY_DIN | SSP_DELAY_DOUT)
> +#define SSP_PORT_CLKRATE_MASK	0x0f
> +
> +#define SSP_SEQRAM_WR_EN	BIT(4)
> +#define SSP_SEQRAM_RD_EN	BIT(5)
> +#define SSP_START		BIT(15)
> +#define SSP_BUSY		BIT(10)
> +#define SSP_PORT_ASL		BIT(7)
> +#define SSP_PORT_CFO1		BIT(6)
> +
> +#define SSP_PORT_SEQRAM_SIZE	32
> +
> +static const int ssp_port_base[]   = {0x040, 0x080};
> +static const int ssp_port_seqram[] = {0x100, 0x180};
> +
> +/* Register Access Macros */
> +#define ssp_read(ssp, reg)	 __raw_readl((ssp)->regs + SSP_REG_##reg)
> +#define ssp_write(ssp, reg, val) __raw_writel(val, (ssp)->regs + SSP_REG_##reg)
> +
> +#define ssp_rmw(ssp, reg, mask, bits)				\
> +	ssp_write(ssp, reg, (ssp_read(ssp, reg) & ~(mask)) | (bits))
> +
> +#define ssp_port_read(ssp, port, reg)				\
> +	__raw_readl((ssp)->regs + ssp_port_base[port] +		\
> +		    SSP_PORT_REG_##reg)
> +
> +#define ssp_port_write(ssp, port, reg, val)			\
> +	__raw_writel(val, (ssp)->regs + ssp_port_base[port] +	\
> +		     SSP_PORT_REG_##reg)
> +
> +#define ssp_port_rmw(ssp, port, reg, mask, bits)		\
> +	ssp_port_write(ssp, port, reg,				\
> +		       (ssp_port_read(ssp, port, reg) & ~(mask)) | (bits))
> +
> +#define ssp_port_clr_bits(ssp, port, reg, bits)	\
> +	ssp_port_rmw(ssp, port, reg, bits, 0)
> +
> +#define ssp_port_set_bits(ssp, port, reg, bits)	\
> +	ssp_port_rmw(ssp, port, reg, 0, bits)

Consider programming in c rather than preprocessor.  You could use
static inlines here.

> +
> +struct ti_ssp {
> +	struct resource			*res;
> +	void __iomem			*regs;
> +	struct timer_list		timer;
> +	struct ti_ssp_port		*ports[2];
> +	spinlock_t			lock;
> +	struct clk			*clk;
> +	struct device			*dev;
> +};
> +
> +struct ti_ssp_port {
> +	int		num;
> +	struct ti_ssp	*ssp;
> +	spinlock_t	lock;
> +};
> +
> +struct ti_ssp_port *ti_ssp_open(const struct ti_ssp_port_data *data)
> +{
> +	struct ti_ssp		*ssp;
> +	struct ti_ssp_port	*port;
> +	struct device		*dev;
> +	int			error = 0;
> +
> +	dev = bus_find_device_by_name(&platform_bus_type, NULL,
> +				      data->ssp_dev_name);
> +	if (!dev || !dev->driver)
> +		return ERR_PTR(-ENODEV);
> +
> +	if (!get_device(dev))
> +		return ERR_PTR(-ENODEV);
> +
> +	ssp = platform_get_drvdata(to_platform_device(dev));
> +	if (!ssp) {
> +		error = -ENODEV;
> +		goto error_put;
> +	}
> +
> +	port = kzalloc(sizeof(*port), GFP_KERNEL);
> +	if (!port) {
> +		error = -ENOMEM;
> +		goto error_put;
> +	}
> +
> +	port->num = data->port;
> +	port->ssp = ssp;
> +	spin_lock_init(&port->lock);
> +
> +	spin_lock(&ssp->lock);
> +
> +	if (ssp->ports[port->num]) {
> +		error = -EBUSY;
> +		goto error_unlock;
> +	}
> +
> +	ssp->ports[port->num] = port;
> +
> +	spin_unlock(&ssp->lock);
> +
> +	ti_ssp_set_iosel(port, data->iosel);
> +
> +	spin_lock(&port->lock);
> +	ssp_port_rmw(ssp, port->num, CFG_1, SSP_PORT_CONFIG_MASK,
> +		     data->config);
> +	ssp_port_rmw(ssp, port->num, CFG_2, SSP_PORT_CLKRATE_MASK, 0);
> +	spin_unlock(&port->lock);
> +
> +	return port;
> +
> +error_unlock:
> +	spin_unlock(&ssp->lock);
> +error_put:
> +	put_device(dev);
> +	return ERR_PTR(error);
> +}
> +EXPORT_SYMBOL(ti_ssp_open);

I'm not thrilled with the ti_ssp_open()/ti_ssp_close() usage model.
It appears that the usage model is the board code registers an pile
of platform_devices, one for the ssp, and one for each of the
behaviours on top of it.  Then the various driver instances have to
figure out how to find each other and whether or not they are related.
Am I correct?

Rather than doing an end-run around the Linux driver model, I strongly
recommend using the model to solve your problem.  Register only the
ssp platform_device in the board support code and pass it data about
the intended behaviour (via platform data).  When it gets probed, it
can then register additional platform devices which will get probed by
the requested driver.  That way the specific ssp device instance data
can be passed reliably to the spi/i2c/whatever driver without any
ambiguity, without any uncertainty about whether a port is 'busy', and
without the need of these open/close routines.

(Hint: The trick is to set the platform_device's pdev->dev.parent
pointer to make use of the Linux device model's hierarchy).

> +
> +int ti_ssp_close(struct ti_ssp_port *port)
> +{
> +	if (!port || !port->ssp)
> +		return -EINVAL;
> +	port->ssp->ports[port->num] = NULL;
> +	put_device(port->ssp->dev);
> +	kfree(port);
> +	return 0;
> +}
> +EXPORT_SYMBOL(ti_ssp_close);
> +
> +int ti_ssp_set_mode(struct ti_ssp_port *port, int mode)
> +{
> +	if (!port || !port->ssp)
> +		return -EINVAL;
> +
> +	spin_lock(&port->lock);
> +	mode &= SSP_PORT_CONFIG_MASK;
> +	ssp_port_rmw(port->ssp, port->num, CFG_1, SSP_PORT_CONFIG_MASK, mode);
> +	spin_unlock(&port->lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(ti_ssp_set_mode);
> +
> +int ti_ssp_set_iosel(struct ti_ssp_port *port, u32 iosel)
> +{
> +	unsigned int		val;
> +
> +	if (!port || !port->ssp)
> +		return -EINVAL;
> +
> +	spin_lock(&port->lock);
> +
> +	/* IOSEL1 gets the least significant 16 bits */
> +	val = ssp_read(port->ssp, IOSEL_1);
> +	val &= 0xffff << (port->num ? 0 : 16);
> +	val |= (iosel & 0xffff) << (port->num ? 16 : 0);
> +	ssp_write(port->ssp, IOSEL_1, val);
> +
> +	/* IOSEL2 gets the most significant 16 bits */
> +	val = ssp_read(port->ssp, IOSEL_2);
> +	val &= 0x0007 << (port->num ? 0 : 16);
> +	val |= (iosel & 0x00070000) >> (port->num ? 0 : 16);
> +	ssp_write(port->ssp, IOSEL_2, val);
> +
> +	spin_unlock(&port->lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(ti_ssp_set_iosel);
> +
> +int ti_ssp_load(struct ti_ssp_port *port, int offs, u32* prog, int len)
> +{
> +	int i;
> +
> +	if (!port || !port->ssp)
> +		return -EINVAL;
> +
> +	if (len > SSP_PORT_SEQRAM_SIZE)
> +		return -ENOSPC;
> +
> +	spin_lock(&port->lock);
> +
> +	/* Enable SeqRAM access */
> +	ssp_port_set_bits(port->ssp, port->num, CFG_2, SSP_SEQRAM_WR_EN);
> +
> +	/* Copy code */
> +	for (i = 0; i < len; i++) {
> +		__raw_writel(prog[i], port->ssp->regs + offs + 4*i +
> +			     ssp_port_seqram[port->num]);
> +	}
> +
> +	/* Disable SeqRAM access */
> +	ssp_port_clr_bits(port->ssp, port->num, CFG_2, SSP_SEQRAM_WR_EN);
> +
> +	spin_unlock(&port->lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(ti_ssp_load);
> +
> +int ti_ssp_raw_read(struct ti_ssp_port *port)
> +{
> +	u32 val;
> +
> +	if (!port || !port->ssp)
> +		return -EINVAL;
> +
> +	val = ssp_read(port->ssp, IOSEL_2);
> +	val >>= (port->num ? 27 : 11);
> +
> +	return val & 0x0f;
> +}
> +EXPORT_SYMBOL(ti_ssp_raw_read);
> +
> +int ti_ssp_raw_write(struct ti_ssp_port *port, u32 val)
> +{
> +	u32 mask;
> +
> +	if (!port || !port->ssp)
> +		return -EINVAL;
> +
> +	spin_lock(&port->ssp->lock);
> +	val &= 0x0f;
> +	val <<= (port->num ? 22 : 6);
> +	mask = 0x0f;
> +	mask <<= (port->num ? 22 : 6);
> +	ssp_rmw(port->ssp, IOSEL_2, mask, val);
> +	spin_unlock(&port->ssp->lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(ti_ssp_raw_write);
> +
> +int ti_ssp_run(struct ti_ssp_port *port, u32 pc, u32 input, u32 *output)
> +{
> +	struct ti_ssp *ssp;
> +	int count;
> +
> +	if (!port || !port->ssp)
> +		return -EINVAL;
> +	ssp = port->ssp;
> +
> +	if (pc & ~(0x3f))
> +		return -EINVAL;
> +
> +	ssp_port_write(ssp, port->num, ADDR, input >> 16);
> +	ssp_port_write(ssp, port->num, DATA, input & 0xffff);
> +	ssp_port_rmw(ssp, port->num, CFG_1, 0x3f, pc);
> +
> +	ssp_port_set_bits(ssp, port->num, CFG_1, SSP_START);
> +
> +	for (count = 10000; count; count--) {
> +		if ((ssp_port_read(ssp, port->num, CFG_1) & SSP_BUSY) == 0)
> +			break;
> +		udelay(1);
> +	}
> +
> +	if (output) {
> +		*(output) = (ssp_port_read(ssp, port->num, ADDR) << 16) |
> +			    (ssp_port_read(ssp, port->num, DATA) &  0xffff);
> +	}
> +
> +	if (!count) {
> +		dev_err(ssp->dev, "timed out waiting for SSP operation\n");
> +		return -EIO;
> +	}
> +
> +	/* return stop address */
> +	return ssp_port_read(ssp, port->num, STATE) & 0x3f;
> +}
> +EXPORT_SYMBOL(ti_ssp_run);
> +
> +static int __devinit ti_ssp_probe(struct platform_device *pdev)
> +{
> +	static struct ti_ssp *ssp;
> +	const struct ti_ssp_data *pdata = pdev->dev.platform_data;
> +	int ret = 0, prediv = 0xff;
> +	unsigned long sysclk;
> +	struct device *dev = &pdev->dev;
> +
> +	ssp = kzalloc(sizeof(*ssp), GFP_KERNEL);
> +	if (!ssp) {
> +		dev_err(dev, "cannot allocate device info\n");
> +		return -ENOMEM;
> +	}
> +
> +	ssp->dev = dev;
> +	platform_set_drvdata(pdev, ssp);
> +
> +	ret = -ENODEV;
> +	ssp->res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!ssp->res) {
> +		dev_err(dev, "cannot determine register area\n");
> +		goto error_res;
> +	}
> +
> +	ret = -EINVAL;
> +	if (!request_mem_region(ssp->res->start, resource_size(ssp->res),
> +				pdev->name)) {
> +		dev_err(dev, "cannot claim register memory\n");
> +		goto error_res;
> +	}
> +
> +	ret = -ENOMEM;
> +	ssp->regs = ioremap(ssp->res->start, resource_size(ssp->res));
> +	if (!ssp->regs) {
> +		dev_err(dev, "cannot map register memory\n");
> +		goto error_map;
> +	}
> +
> +	ret = -EINVAL;
> +	ssp->clk = clk_get(dev, NULL);
> +	if (IS_ERR(ssp->clk)) {
> +		dev_err(dev, "cannot claim device clock\n");
> +		goto error_clk;
> +	}
> +
> +	spin_lock_init(&ssp->lock);
> +
> +	platform_set_drvdata(pdev, ssp);
> +
> +	/* Power on and initialize SSP */
> +	ret = clk_enable(ssp->clk);
> +	if (ret)
> +		goto error_enable;
> +
> +	/* Reset registers to a sensible known state */
> +	ssp_write(ssp, IOSEL_1, 0);
> +	ssp_write(ssp, IOSEL_2, 0);
> +	ssp_write(ssp, INTR_EN, 0);
> +	ssp_write(ssp, TEST_CTRL, 0);
> +	ssp_port_write(ssp, 0, CFG_1, SSP_PORT_ASL);
> +	ssp_port_write(ssp, 1, CFG_1, SSP_PORT_ASL);
> +	ssp_port_write(ssp, 0, CFG_2, SSP_PORT_CFO1);
> +	ssp_port_write(ssp, 1, CFG_2, SSP_PORT_CFO1);
> +
> +	sysclk = clk_get_rate(ssp->clk);
> +	if (pdata && pdata->out_clock)
> +		prediv = (sysclk / pdata->out_clock) - 1;
> +	prediv = clamp(prediv, 0, 0xff);
> +	ssp_rmw(ssp, PREDIV, 0xff, prediv);
> +
> +	return 0;
> +
> +error_enable:
> +	clk_put(ssp->clk);
> +error_clk:
> +	iounmap(ssp->regs);
> +error_map:
> +	release_mem_region(ssp->res->start, resource_size(ssp->res));
> +error_res:
> +	kfree(ssp);
> +	return ret;
> +}
> +
> +static int __devexit ti_ssp_remove(struct platform_device *pdev)
> +{
> +	struct ti_ssp *ssp = platform_get_drvdata(pdev);
> +
> +	clk_disable(ssp->clk);
> +	clk_put(ssp->clk);
> +	iounmap(ssp->regs);
> +	release_mem_region(ssp->res->start, resource_size(ssp->res));
> +	kfree(ssp);
> +	platform_set_drvdata(pdev, NULL);
> +	return 0;
> +}
> +
> +static struct platform_driver ti_ssp_driver = {
> +	.probe		= ti_ssp_probe,
> +	.remove		= __devexit_p(ti_ssp_remove),
> +	.driver.name	= "ti-ssp",
> +	.driver.owner	= THIS_MODULE,
> +};

Personally, I prefer the following form (comment goes for the whole series):

static struct platform_driver ti_ssp_driver = {
	.probe		= ti_ssp_probe,
	.remove		= __devexit_p(ti_ssp_remove),
	.driver = {
		.name	= "ti-ssp",
		.owner	= THIS_MODULE,
	},
};

> +
> +static int __init ti_ssp_init(void)
> +{
> +	return platform_driver_register(&ti_ssp_driver);
> +}
> +
> +static void __exit ti_ssp_exit(void)
> +{
> +	platform_driver_unregister(&ti_ssp_driver);
> +}
> +
> +arch_initcall_sync(ti_ssp_init);

Keep the initicall line together with the ti_ssp_init definition (goes
for the whole series).

> +module_exit(ti_ssp_exit);
> +
> +MODULE_AUTHOR("Cyril Chemparathy");
> +MODULE_DESCRIPTION("Sequencer Serial Port (SSP) Driver");
> +MODULE_ALIAS("platform:ti_ssp");
> +MODULE_LICENSE("GPL");
> -- 
> 1.7.0.4
> 
> 
> ------------------------------------------------------------------------------
> Beautiful is writing same markup. Internet Explorer 9 supports
> standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
> Spend less time writing and  rewriting code and more time creating great
> experiences on the web. Be a part of the beta today.
> http://p.sf.net/sfu/beautyoftheweb
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
