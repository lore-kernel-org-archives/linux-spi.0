From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH v3 1/2] spi: implemented driver for Cirrus EP93xx SPI
	controller
Date: Sat, 17 Apr 2010 14:00:36 +0300
Message-ID: <20100417110036.GC19534@gw.healthdatacare.com>
References: <cover.1271156934.git.mika.westerberg@iki.fi>
	<e0e5dc30af89f0b65fd2e5e52f9e7fe9f162516b.1271156934.git.mika.westerberg@iki.fi>
	<n2jfa686aa41004162330qae611a0u87be76ca08bfb52a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general@lists.sourceforge.net, martinwguy@gmail.com,
	linux-arm-kernel@lists.infradead.org
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <n2jfa686aa41004162330qae611a0u87be76ca08bfb52a@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Fri, Apr 16, 2010 at 11:30:45PM -0700, Grant Likely wrote:
> Thanks for the patch.  Comments below.

Thanks for the comments. See below my replies.

> g.
> =

> On Tue, Apr 13, 2010 at 7:10 AM, Mika Westerberg <mika.westerberg@iki.fi>=
 wrote:
> > This patch adds an SPI master driver for the Cirrus EP93xx SPI controll=
er found
> > in EP93xx chips (EP9301, EP9302, EP9307, EP9312 and EP9315).
> >
> > Driver supports polling and interrupt based transfer methods. This can =
be
> > selected with module parameter 'transfer_method'.
> >
> > Signed-off-by: Mika Westerberg <mika.westerberg@iki.fi>
> > ---
> > =A0arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h | =A0 34 +
> > =A0drivers/spi/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0| =A0 11 +
> > =A0drivers/spi/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 | =A0 =A01 +
> > =A0drivers/spi/ep93xx_spi.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 | 1113 ++++++++++++++++++++++++
> > =A04 files changed, 1159 insertions(+), 0 deletions(-)
> > =A0create mode 100644 arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h
> > =A0create mode 100644 drivers/spi/ep93xx_spi.c
> >
> > diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h b/arch/arm/=
mach-ep93xx/include/mach/ep93xx_spi.h
> > new file mode 100644
> > index 0000000..fe93d2e
> > --- /dev/null
> > +++ b/arch/arm/mach-ep93xx/include/mach/ep93xx_spi.h
> > @@ -0,0 +1,34 @@
> > +#ifndef __ASM_MACH_EP93XX_SPI_H
> > +#define __ASM_MACH_EP93XX_SPI_H
> > +
> > +/**
> > + * struct ep93xx_spi_info - EP93xx specific SPI descriptor
> > + * @num_chipselect: number of chip select GPIOs on this board
> > + * @cs_control: chip select control function
> > + * @data: pointer to data that is passed to @cs_control function.
> > + * =A0 =A0 =A0 =A0Can be %NULL if not needed.
> > + *
> > + * This structure is passed from board support files to EP93xx SPI con=
troller
> > + * driver. It provides callback hook to control chip select GPIOs that=
 are
> > + * allocated in board support files during board initialization.
> > + */
> > +struct ep93xx_spi_info {
> > + =A0 =A0 =A0 int =A0 =A0 num_chipselect;
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* cs_control() - control board chipselect GPIO lines
> > + =A0 =A0 =A0 =A0* @cs: chip select to control
> > + =A0 =A0 =A0 =A0* @value: value to set the chip select line to
> > + =A0 =A0 =A0 =A0* @data: optional data
> > + =A0 =A0 =A0 =A0*
> > + =A0 =A0 =A0 =A0* This function is used to control board specific GPIO=
 lines that
> > + =A0 =A0 =A0 =A0* are allocated as SPI chipselects. @value is either %=
0 or %1. It
> > + =A0 =A0 =A0 =A0* is possibled to pass additional information using @d=
ata.
> > + =A0 =A0 =A0 =A0*
> > + =A0 =A0 =A0 =A0* This function is called from thread context and can =
sleep if
> > + =A0 =A0 =A0 =A0* necessary.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 void =A0 =A0(*cs_control)(unsigned cs, unsigned value, vo=
id *data);
> > + =A0 =A0 =A0 void =A0 =A0*data;
> > +};
> > +
> > +#endif /* __ASM_MACH_EP93XX_SPI_H */
> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> > index a191fa2..5852340 100644
> > --- a/drivers/spi/Kconfig
> > +++ b/drivers/spi/Kconfig
> > @@ -117,6 +117,17 @@ config SPI_DAVINCI
> > =A0 =A0 =A0 =A0help
> > =A0 =A0 =A0 =A0 =A0SPI master controller for DaVinci and DA8xx SPI modu=
les.
> >
> > +config SPI_EP93XX
> > + =A0 =A0 =A0 tristate "Cirrus Logic EP93xx SPI controller"
> > + =A0 =A0 =A0 depends on ARCH_EP93XX
> > + =A0 =A0 =A0 help
> > + =A0 =A0 =A0 =A0 This enables using the Cirrus EP93xx SPI controller i=
n master
> > + =A0 =A0 =A0 =A0 mode. This driver supports EP9301, EP9302, EP9307, EP=
9312 and EP9315
> > + =A0 =A0 =A0 =A0 chips.
> > +
> > + =A0 =A0 =A0 =A0 To compile this driver as a module, choose M here. Th=
e module will be
> > + =A0 =A0 =A0 =A0 called ep93xx_spi.
> > +
> > =A0config SPI_GPIO
> > =A0 =A0 =A0 =A0tristate "GPIO-based bitbanging SPI Master"
> > =A0 =A0 =A0 =A0depends on GENERIC_GPIO
> > diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> > index d7d0f89..377f845 100644
> > --- a/drivers/spi/Makefile
> > +++ b/drivers/spi/Makefile
> > @@ -21,6 +21,7 @@ obj-$(CONFIG_SPI_DAVINCI) =A0 =A0 =A0 =A0 =A0 =A0 +=
=3D davinci_spi.o
> > =A0obj-$(CONFIG_SPI_DESIGNWARE) =A0 =A0 =A0 =A0 =A0 +=3D dw_spi.o
> > =A0obj-$(CONFIG_SPI_DW_PCI) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D dw_spi_pci=
.o
> > =A0obj-$(CONFIG_SPI_DW_MMIO) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D dw_spi_mmi=
o.o
> > +obj-$(CONFIG_SPI_EP93XX) =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D ep93xx_spi.o
> > =A0obj-$(CONFIG_SPI_GPIO) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D spi_gpio=
.o
> > =A0obj-$(CONFIG_SPI_IMX) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D spi_im=
x.o
> > =A0obj-$(CONFIG_SPI_LM70_LLP) =A0 =A0 =A0 =A0 =A0 =A0 +=3D spi_lm70llp.o
> > diff --git a/drivers/spi/ep93xx_spi.c b/drivers/spi/ep93xx_spi.c
> > new file mode 100644
> > index 0000000..7273611
> > --- /dev/null
> > +++ b/drivers/spi/ep93xx_spi.c
> > @@ -0,0 +1,1113 @@
> > +/*
> > + * Driver for Cirrus Logic EP93xx SPI controller.
> > + *
> > + * Copyright (c) 2010 Mika Westerberg
> > + *
> > + * Explicit FIFO handling code was inspired by amba-pl022 driver.
> > + *
> > + * For more information about the SPI controller see documentation on =
Cirrus
> > + * Logic web site:
> > + * =A0 =A0 http://www.cirrus.com/en/pubs/manual/EP93xx_Users_Guide_UM1=
.pdf
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + */
> > +
> > +#include <linux/io.h>
> > +#include <linux/clk.h>
> > +#include <linux/err.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/bitops.h>
> > +#include <linux/module.h>
> > +#include <linux/moduleparam.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/workqueue.h>
> > +#include <linux/sched.h>
> > +#include <linux/spi/spi.h>
> > +
> > +#include <mach/ep93xx_spi.h>
> > +
> > +#define SSPCR0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0000
> > +#define SSPCR0_MODE_SHIFT =A0 =A0 =A06
> > +#define SSPCR0_SCR_SHIFT =A0 =A0 =A0 8
> > +
> > +#define SSPCR1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0004
> > +#define SSPCR1_RIE =A0 =A0 =A0 =A0 =A0 =A0 BIT(0)
> > +#define SSPCR1_TIE =A0 =A0 =A0 =A0 =A0 =A0 BIT(1)
> > +#define SSPCR1_RORIE =A0 =A0 =A0 =A0 =A0 BIT(2)
> > +#define SSPCR1_LBM =A0 =A0 =A0 =A0 =A0 =A0 BIT(3)
> > +#define SSPCR1_SSE =A0 =A0 =A0 =A0 =A0 =A0 BIT(4)
> > +#define SSPCR1_MS =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(5)
> > +#define SSPCR1_SOD =A0 =A0 =A0 =A0 =A0 =A0 BIT(6)
> > +
> > +#define SSPDR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0008
> > +
> > +#define SSPSR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x000c
> > +#define SSPSR_TFE =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(0)
> > +#define SSPSR_TNF =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(1)
> > +#define SSPSR_RNE =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(2)
> > +#define SSPSR_RFF =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(3)
> > +#define SSPSR_BSY =A0 =A0 =A0 =A0 =A0 =A0 =A0BIT(4)
> > +#define SSPCPSR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0010
> > +
> > +#define SSPIIR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0014
> > +#define SSPIIR_RIS =A0 =A0 =A0 =A0 =A0 =A0 BIT(0)
> > +#define SSPIIR_TIS =A0 =A0 =A0 =A0 =A0 =A0 BIT(1)
> > +#define SSPIIR_RORIS =A0 =A0 =A0 =A0 =A0 BIT(2)
> > +#define SSPICR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SSPIIR
> > +
> > +/* timeout in milliseconds */
> > +#define SPI_TIMEOUT =A0 =A0 =A0 =A0 =A0 =A0100
> > +/* maximum depth of RX/TX FIFO */
> > +#define SPI_FIFO_SIZE =A0 =A0 =A0 =A0 =A08
> > +
> > +enum {
> > + =A0 =A0 =A0 EP93XX_SPI_METHOD_POLL,
> > + =A0 =A0 =A0 EP93XX_SPI_METHOD_INTERRUPT,
> > + =A0 =A0 =A0 /* TODO: waiting for DMA support */
> > +};
> > +
> > +static int transfer_method =3D EP93XX_SPI_METHOD_INTERRUPT;
> > +module_param(transfer_method, int, S_IRUGO);
> > +MODULE_PARM_DESC(transfer_method,
> > + =A0 =A0 =A0 "Used transfer method (0=3Dpoll, 1=3Dinterrupt [default])=
");
> =

> Should this really be a module parameter?  Would it be better to
> expose this knob as part of pdata or in sysfs?  (Assuming there even
> is a real need to manipulate this control)

Hard to say. At least it was easier to test both modes by just
loading the module with correct parameter but it could possibly be
placed in pdata also, if required.

> =

> > +
> > +/**
> > + * struct ep93xx_spi - EP93xx SPI controller structure
> > + * @lock: spinlock that protects concurrent accesses to fields @runnin=
g,
> > + * =A0 =A0 =A0 =A0@current_msg and @msg_queue
> > + * @pdev: pointer to platform device
> > + * @info: platform specific info
> > + * @clk: clock for the controller
> > + * @regs_base: pointer to ioremap()'d registers
> > + * @irq: IRQ number used by the driver. If @irq is %0, we are in polle=
d mode.
> > + * @min_rate: minimum clock rate (in Hz) supported by the controller
> > + * @max_rate: maximum clock rate (in Hz) supported by the controller
> > + * @running: is the queue running
> > + * @msg_queue: queue for the messages
> > + * @wq: workqueue used by the driver
> > + * @msg_work: work that is queued for the driver
> > + * @wait: wait here until given transfer is completed
> > + * @current_msg: message that is currently processed (or %NULL if none)
> > + * @spi_dev: pointer to device that was previously selected
> > + * @tx: current byte in transfer to transmit
> > + * @rx: current byte in transfer to receive
> > + * @fifo_level: how full is FIFO (%0..%SPI_FIFO_SIZE - %1). Receiving =
one
> > + * =A0 =A0 =A0 =A0 =A0 =A0 =A0frame decreases this level and sending o=
ne frame increases it.
> > + * @transfer: method that performs the actual data transfer
> > + *
> > + * This structure holds EP93xx SPI controller specific information. Wh=
en
> > + * @running is %true, driver accepts transfer requests from protocol d=
rivers.
> > + * @current_msg is used to hold pointer to the message that is current=
ly
> > + * processed. If @current_msg is %NULL, it means that no processing is=
 going
> > + * on.
> > + *
> > + * Most of the fields are only written once and they can be accessed w=
ithout
> > + * taking the @lock. Fields that are accessed concurrently are: @curre=
nt_msg,
> > + * @running and @msg_queue.
> > + */
> > +struct ep93xx_spi {
> > + =A0 =A0 =A0 spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0loc=
k;
> > + =A0 =A0 =A0 const struct platform_device =A0 =A0*pdev;
> > + =A0 =A0 =A0 const struct ep93xx_spi_info =A0 =A0*info;
> =

> You probably don't need to keep the info pointer around.  It isn't
> interesting once you've extracted the data out of it.

Ok.

> =

> > + =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*cl=
k;
> > + =A0 =A0 =A0 void __iomem =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*regs=
_base;
> > + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 irq;
> > + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 min_rat=
e;
> > + =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 max_rat=
e;
> > + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0running;
> > + =A0 =A0 =A0 struct workqueue_struct =A0 =A0 =A0 =A0 *wq;
> > + =A0 =A0 =A0 struct work_struct =A0 =A0 =A0 =A0 =A0 =A0 =A0msg_work;
> > + =A0 =A0 =A0 struct completion =A0 =A0 =A0 =A0 =A0 =A0 =A0 wait;
> > + =A0 =A0 =A0 struct list_head =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0msg_queue;
> > + =A0 =A0 =A0 struct spi_message =A0 =A0 =A0 =A0 =A0 =A0 =A0*current_ms=
g;
> > + =A0 =A0 =A0 size_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0tx;
> > + =A0 =A0 =A0 size_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0rx;
> > + =A0 =A0 =A0 size_t =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0fifo_level;
> > + =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0(*transfer)(struct ep93xx_spi *);
> > +};
> > +
> > +/**
> > + * struct ep93xx_spi_chip - SPI device hardware settings
> > + * @rate: max rate in hz this chip supports
> > + * @div_cpsr: cpsr (pre-scaler) divider
> > + * @div_scr: scr divider
> > + * @dss: bits per word (4 - 16 bits)
> > + * @mode: chip SPI mode (see also &struct spi_device)
> > + *
> > + * This structure is used to store hardware register specific settings=
 for each
> > + * SPI device. Settings are written to hardware by function
> > + * ep93xx_spi_chip_setup().
> > + */
> > +struct ep93xx_spi_chip {
> > + =A0 =A0 =A0 unsigned long =A0 rate;
> > + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0div_cpsr;
> > + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0div_scr;
> > + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0dss;
> > + =A0 =A0 =A0 u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0mode;
> > +};
> > +
> > +/* converts bits per word to CR0.DSS value */
> > +#define bits_per_word_to_dss(bpw) =A0 =A0 =A0((bpw) - 1)
> > +
> > +static inline void
> > +ep93xx_spi_write_u8(const struct ep93xx_spi *espi, u16 reg, u8 value)
> > +{
> > + =A0 =A0 =A0 __raw_writeb(value, espi->regs_base + reg);
> > +}
> > +
> > +static inline u8
> > +ep93xx_spi_read_u8(const struct ep93xx_spi *spi, u16 reg)
> > +{
> > + =A0 =A0 =A0 return __raw_readb(spi->regs_base + reg);
> > +}
> > +
> > +static inline void
> > +ep93xx_spi_write_u16(const struct ep93xx_spi *espi, u16 reg, u16 value)
> > +{
> > + =A0 =A0 =A0 __raw_writew(value, espi->regs_base + reg);
> > +}
> > +
> > +static inline u16
> > +ep93xx_spi_read_u16(const struct ep93xx_spi *spi, u16 reg)
> > +{
> > + =A0 =A0 =A0 return __raw_readw(spi->regs_base + reg);
> > +}
> > +
> > +/**
> > + * ep93xx_spi_enable() - enables the SPI controller and clock
> > + * @espi: ep93xx SPI controller struct
> > + *
> > + * This function enables the SPI controller and its clock. Returns %0 =
in case
> > + * of success and negative error in case if failure.
> > + */
> > +static int ep93xx_spi_enable(const struct ep93xx_spi *espi)
> > +{
> > + =A0 =A0 =A0 u8 regval;
> > + =A0 =A0 =A0 int err;
> > +
> > + =A0 =A0 =A0 err =3D clk_enable(espi->clk);
> > + =A0 =A0 =A0 if (err)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> > +
> > + =A0 =A0 =A0 regval =3D ep93xx_spi_read_u8(espi, SSPCR1);
> > + =A0 =A0 =A0 regval |=3D SSPCR1_SSE;
> > + =A0 =A0 =A0 ep93xx_spi_write_u8(espi, SSPCR1, regval);
> > +
> > + =A0 =A0 =A0 return 0;
> > +}
> > +
> > +/**
> > + * ep93xx_spi_disable() - disables the SPI controller and clock
> > + * @espi: ep93xx SPI controller struct
> > + *
> > + * Function disables SPI controller and its clock.
> > + */
> > +static void ep93xx_spi_disable(const struct ep93xx_spi *espi)
> > +{
> > + =A0 =A0 =A0 u8 regval;
> > +
> > + =A0 =A0 =A0 regval =3D ep93xx_spi_read_u8(espi, SSPCR1);
> > + =A0 =A0 =A0 regval &=3D ~SSPCR1_SSE;
> > + =A0 =A0 =A0 ep93xx_spi_write_u8(espi, SSPCR1, regval);
> > +
> > + =A0 =A0 =A0 clk_disable(espi->clk);
> > +}
> > +
> > +/**
> > + * ep93xx_spi_enable_interrupts() - enables all SPI interrupts
> > + * @espi: ep93xx SPI controller struct
> > + *
> > + * Enables all SPI interrupts: receive overrun (ROR), transmit and rec=
eive.
> > + */
> > +static inline void
> > +ep93xx_spi_enable_interrupts(const struct ep93xx_spi *espi)
> > +{
> > + =A0 =A0 =A0 u8 regval;
> > +
> > + =A0 =A0 =A0 regval =3D ep93xx_spi_read_u8(espi, SSPCR1);
> > + =A0 =A0 =A0 regval |=3D (SSPCR1_RORIE | SSPCR1_TIE | SSPCR1_RIE);
> > + =A0 =A0 =A0 ep93xx_spi_write_u8(espi, SSPCR1, regval);
> > +}
> > +
> > +/**
> > + * ep93xx_spi_disable_interrupts() - disables all SPI interrupts
> > + * @espi: ep93xx SPI controller struct
> > + *
> > + * Disables all SPI interrupts.
> > + */
> > +static inline void
> > +ep93xx_spi_disable_interrupts(const struct ep93xx_spi *espi)
> > +{
> > + =A0 =A0 =A0 u8 regval;
> > +
> > + =A0 =A0 =A0 regval =3D ep93xx_spi_read_u8(espi, SSPCR1);
> > + =A0 =A0 =A0 regval &=3D ~(SSPCR1_RORIE | SSPCR1_TIE | SSPCR1_RIE);
> > + =A0 =A0 =A0 ep93xx_spi_write_u8(espi, SSPCR1, regval);
> > +}
> > +
> > +/**
> > + * ep93xx_spi_flush() - flushes SPI RX FIFO
> > + * @espi: ep93xx SPI controller struct
> > + * @msecs: timeout in milliseconds to wait
> > + *
> > + * This function flushes RX FIFO. Returns %0 in case of success and %-=
ETIMEDOUT
> > + * when timeout occured. Wait is implemented in busylooping so this fu=
nction can
> > + * also be called from atomic context.
> > + */
> > +static int ep93xx_spi_flush(const struct ep93xx_spi *espi, unsigned lo=
ng msecs)
> > +{
> > + =A0 =A0 =A0 unsigned long timeout =3D jiffies + msecs_to_jiffies(msec=
s);
> > +
> > + =A0 =A0 =A0 while (ep93xx_spi_read_u16(espi, SSPSR) & SSPSR_RNE) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (time_after(jiffies, timeout))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ETIMEDOUT;
> =

> Ouch.  With the current code the driver could busy wait for 100ms!  If
> flushing takes time, then don't busywait.  Bail out to some form of
> deferred work.  Let the kernel get on with something else.

I've never witnessed flushing to take this whole 100ms. Timeout is
there just to make sure that this ends eventually. I can change it
to some lower value (say few msecs or something like that).

> =

> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep93xx_spi_read_u16(espi, SSPDR);
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 return 0;
> > +}
> =

> This function is only called in one place; should it just be made a
> part of ep93xx_spi_process_message?

Yes. I'll do that.

> =

> > +
> > +/**
> > + * ep93xx_spi_calc_divisors() - calculates SPI clock divisors
> > + * @espi: ep93xx SPI controller struct
> > + * @chip: divisors are calculated for this chip
> > + * @rate: desired SPI output clock rate
> > + *
> > + * Function calculates cpsr (clock pre-scaler) and scr divisors based =
on
> > + * given @rate and places them to @chip->div_cpsr and @chip->div_scr. =
If,
> > + * for some reason, divisors cannot be calculated nothing is stored and
> > + * %-EINVAL is returned.
> > + */
> > +static int ep93xx_spi_calc_divisors(const struct ep93xx_spi *espi,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s=
truct ep93xx_spi_chip *chip,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u=
nsigned long rate)
> > +{
> > + =A0 =A0 =A0 unsigned long spi_clk_rate =3D clk_get_rate(espi->clk);
> > + =A0 =A0 =A0 int cpsr, scr;
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Make sure that max value is between values supported=
 by the
> > + =A0 =A0 =A0 =A0* controller. Note that minimum value is already check=
ed in
> > + =A0 =A0 =A0 =A0* ep93xx_spi_transfer().
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 rate =3D clamp(rate, espi->min_rate, espi->max_rate);
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Calculate divisors so that we can get speed accordin=
g the
> > + =A0 =A0 =A0 =A0* following formula:
> > + =A0 =A0 =A0 =A0* =A0 =A0 =A0rate =3D spi_clock_rate / (cpsr * (1 + sc=
r))
> > + =A0 =A0 =A0 =A0*
> > + =A0 =A0 =A0 =A0* cpsr must be even number and starts from 2, scr can =
be any number
> > + =A0 =A0 =A0 =A0* between 0 and 255.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 for (cpsr =3D 2; cpsr <=3D 254; cpsr +=3D 2) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (scr =3D 0; scr <=3D 255; scr++) {
> =

> Non-deterministic.  Big nested loops mean a lot of calculations within
>  ep93xx_spi_process_transfer, and calculated values aren't cached if
> they get replaced.  If you can, it would be better if you can
> algebraically calculate the factors instead of an iterative loop.
> It's requires more thinking at the outset, but it is worth the effort.

Is it normal to change speed per transfer? ep93xx_spi_process_transfer()
only calls this if speed changes. That's why I used those loops
here; the assumption is that it is only called at setup time (and
even there only when speed changes).

For example in my test system using mmc_spi it was called total 3 times.

> =

> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((spi_clk_rate / (cpsr=
 * (scr + 1))) <=3D rate) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->div=
_scr =3D (u8)scr;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->div=
_cpsr =3D (u8)cpsr;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 return -EINVAL;
> > +}
> > +
> > +/**
> > + * ep93xx_spi_select_device() - select given SPI device
> > + * @espi: ep93xx SPI controller struct
> > + * @spi: SPI device to select
> > + *
> > + * Function asserts GPIO chipselect line as specified in @spi->chip_se=
lect in
> > + * board specific manner (calls @info->cs_control()).
> > + *
> > + * Note that this function is called from a thread context and can sle=
ep.
> > + */
> > +static void ep93xx_spi_select_device(const struct ep93xx_spi *espi,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0struct spi_device *spi)
> > +{
> > + =A0 =A0 =A0 const struct ep93xx_spi_info *info =3D espi->info;
> > + =A0 =A0 =A0 unsigned value =3D (spi->mode & SPI_CS_HIGH) ? 1 : 0;
> > +
> > + =A0 =A0 =A0 info->cs_control(spi->chip_select, value, info->data);
> > +}
> > +
> > +/**
> > + * ep93xx_spi_deselect_device() - deselects given SPI device
> > + * @espi: ep93xx SPI controller struct
> > + * @spi: SPI device to deselect
> > + *
> > + * Function deasserts GPIO chipselect line as specified in @spi->chip_=
select in
> > + * board specific manner (calls @info->cs_control()).
> > + *
> > + * Note that this function is called from a thread context and can sle=
ep.
> > + */
> > +static void ep93xx_spi_deselect_device(const struct ep93xx_spi *espi,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0struct spi_device *spi)
> > +{
> > + =A0 =A0 =A0 const struct ep93xx_spi_info *info =3D espi->info;
> > + =A0 =A0 =A0 unsigned value =3D (spi->mode & SPI_CS_HIGH) ? 0 : 1;
> > +
> > + =A0 =A0 =A0 info->cs_control(spi->chip_select, value, info->data);
> > +}
> =

> These 2 functions are identical, other than the test being reversed.
> The code can be a lot more concise here.

Ok.

> =

> > +
> > +/**
> > + * ep93xx_spi_setup() - setup an SPI device
> > + * @spi: SPI device to setup
> > + *
> > + * This function sets up SPI device mode, speed etc. Can be called mul=
tiple
> > + * times for a single device. Returns %0 in case of success, negative =
error in
> > + * case of failure. When this function returns success, the device is
> > + * deselected.
> > + */
> > +static int ep93xx_spi_setup(struct spi_device *spi)
> > +{
> > + =A0 =A0 =A0 struct ep93xx_spi *espi =3D spi_master_get_devdata(spi->m=
aster);
> > + =A0 =A0 =A0 struct ep93xx_spi_chip *chip;
> > +
> > + =A0 =A0 =A0 if (spi->bits_per_word < 4 || spi->bits_per_word > 16) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&espi->pdev->dev, "invalid bits p=
er word %d\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->bits_per_word);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 chip =3D spi_get_ctldata(spi);
> > + =A0 =A0 =A0 if (!chip) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip =3D kzalloc(sizeof(*chip), GFP_KERNE=
L);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!chip)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_set_ctldata(spi, chip);
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 if (spi->max_speed_hz !=3D chip->rate) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int err;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D ep93xx_spi_calc_divisors(espi, ch=
ip, spi->max_speed_hz);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err !=3D 0) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_set_ctldata(spi, NULL=
);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(chip);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->rate =3D spi->max_speed_hz;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 chip->mode =3D spi->mode;
> > + =A0 =A0 =A0 chip->dss =3D bits_per_word_to_dss(spi->bits_per_word);
> =

> Why is mode and dss getting copied into chip?  chip should probable
> instead have a reference back to its assigned spi device and the
> original values should be used.

This is done because if there are transfer specific settings (for
example bits per word changes) we can just make temporary copy of
chip and change those values and then restore back the original,
once the transfer is finished (see ep93xx_spi_process_transfer()).

Mode, however is redundant as it cannot be changed per transfer (or
even per message). I will drop that from the struct.

> =

> > +
> > + =A0 =A0 =A0 ep93xx_spi_deselect_device(espi, spi);
> > + =A0 =A0 =A0 return 0;
> > +}
> > +
> > +/**
> > + * ep93xx_spi_transfer() - queue message to be transferred
> > + * @spi: target SPI device
> > + * @msg: message to be transferred
> > + *
> > + * This function is called by SPI device drivers when they are going t=
o transfer
> > + * a new message. It simply puts the message in the queue and schedules
> > + * workqueue to perform the actual transfer later on.
> > + *
> > + * Returns %0 on success and negative error in case of failure.
> > + */
> > +static int ep93xx_spi_transfer(struct spi_device *spi, struct spi_mess=
age *msg)
> > +{
> > + =A0 =A0 =A0 struct ep93xx_spi *espi =3D spi_master_get_devdata(spi->m=
aster);
> > + =A0 =A0 =A0 struct spi_transfer *t;
> > + =A0 =A0 =A0 unsigned long flags;
> > +
> > + =A0 =A0 =A0 if (!msg || !msg->complete)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> > +
> > + =A0 =A0 =A0 spin_lock_irqsave(&espi->lock, flags);
> > + =A0 =A0 =A0 if (!espi->running) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&espi->lock, flags=
);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ESHUTDOWN;
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 spin_unlock_irqrestore(&espi->lock, flags);
> =

> The spin lock isn't protecting anything here.  The value of running
> can change either immediately before or immediately after the critical
> region.  Reading espi->running without the spinlock will have exactly
> the same behaviour.
> =

> If the value of running matters when processing this function, then
> the function needs to continue to hold the spin lock while the message
> is being processed and then added to the message queue at the end of
> the function.

Ah, you are right. Motivation here was to make sure that the driver isn't
shutting down.

> However, the for_each_entry loop below is safe to process before
> grabbing the lock, so you can defer grabbing the lock and checking
> ->running until just before the message is enqueued.

Ok. Thanks.

> =

> > +
> > + =A0 =A0 =A0 /* first validate each transfer */
> > + =A0 =A0 =A0 list_for_each_entry(t, &msg->transfers, transfer_list) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->bits_per_word) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->bits_per_word < 4 =
|| t->bits_per_word > 16)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -E=
INVAL;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->speed_hz && t->speed_hz < espi->mi=
n_rate)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -E=
INVAL;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Now that we own the message, let's initialize it so =
that it is
> > + =A0 =A0 =A0 =A0* suitable for us. We use @msg->status to signal wheth=
er there was
> > + =A0 =A0 =A0 =A0* error in transfer and @msg->state is used to hold po=
inter to the
> > + =A0 =A0 =A0 =A0* current transfer (or %NULL if no active current tran=
sfer).
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 msg->state =3D NULL;
> > + =A0 =A0 =A0 msg->status =3D 0;
> > + =A0 =A0 =A0 msg->actual_length =3D 0;
> > +
> > + =A0 =A0 =A0 spin_lock_irqsave(&espi->lock, flags);
> > + =A0 =A0 =A0 list_add_tail(&msg->queue, &espi->msg_queue);
> > + =A0 =A0 =A0 queue_work(espi->wq, &espi->msg_work);
> > + =A0 =A0 =A0 spin_unlock_irqrestore(&espi->lock, flags);
> > +
> > + =A0 =A0 =A0 return 0;
> > +}
> > +
> > +/**
> > + * ep93xx_spi_cleanup() - cleans up master controller specific state
> > + * @spi: SPI device to cleanup
> > + *
> > + * This function releases master controller specific state for given @=
spi
> > + * device.
> > + */
> > +static void ep93xx_spi_cleanup(struct spi_device *spi)
> > +{
> > + =A0 =A0 =A0 struct ep93xx_spi_chip *chip;
> > +
> > + =A0 =A0 =A0 chip =3D spi_get_ctldata(spi);
> > + =A0 =A0 =A0 if (chip) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_set_ctldata(spi, NULL);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(chip);
> > + =A0 =A0 =A0 }
> > +}
> > +
> > +/**
> > + * ep93xx_spi_chip_setup() - configures hardware according to given @c=
hip
> > + * @espi: ep93xx SPI controller struct
> > + * @chip: chip specific settings
> > + *
> > + * This function sets up the actual hardware registers with settings g=
iven in
> > + * @chip. Note that no validation is done so make sure that callers va=
lidate
> > + * settings before calling this.
> > + */
> > +static void ep93xx_spi_chip_setup(const struct ep93xx_spi *espi,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const=
 struct ep93xx_spi_chip *chip)
> > +{
> > + =A0 =A0 =A0 u16 cr0;
> > +
> > + =A0 =A0 =A0 cr0 =3D chip->div_scr << SSPCR0_SCR_SHIFT;
> > + =A0 =A0 =A0 cr0 |=3D (chip->mode & (SPI_CPHA | SPI_CPOL)) << SSPCR0_M=
ODE_SHIFT;
> > + =A0 =A0 =A0 cr0 |=3D chip->dss;
> > +
> > + =A0 =A0 =A0 dev_dbg(&espi->pdev->dev, "setup: mode %d, cpsr %d, scr %=
d, dss %d\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->mode, chip->div_cpsr, chip->div_scr=
, chip->dss);
> > + =A0 =A0 =A0 dev_dbg(&espi->pdev->dev, "setup: cr0 %#x", cr0);
> > +
> > + =A0 =A0 =A0 ep93xx_spi_write_u8(espi, SSPCPSR, chip->div_cpsr);
> > + =A0 =A0 =A0 ep93xx_spi_write_u16(espi, SSPCR0, cr0);
> > +}
> > +
> > +static void u8_writer(struct ep93xx_spi *espi,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct spi_transfer *t)
> > +{
> > + =A0 =A0 =A0 u8 tx_val =3D 0;
> > +
> > + =A0 =A0 =A0 if (t->tx_buf)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_val =3D ((u8 *)t->tx_buf)[espi->tx];
> > + =A0 =A0 =A0 ep93xx_spi_write_u8(espi, SSPDR, tx_val);
> > + =A0 =A0 =A0 espi->tx +=3D sizeof(tx_val);
> > +}
> > +
> > +static void u8_reader(struct ep93xx_spi *espi,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct spi_transfer *t)
> > +{
> > + =A0 =A0 =A0 u8 rx_val;
> > +
> > + =A0 =A0 =A0 rx_val =3D ep93xx_spi_read_u8(espi, SSPDR);
> > + =A0 =A0 =A0 if (t->rx_buf)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((u8 *)t->rx_buf)[espi->rx] =3D rx_val;
> > + =A0 =A0 =A0 espi->rx +=3D sizeof(rx_val);
> > +}
> > +
> > +static void u16_writer(struct ep93xx_spi *espi,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const struct spi_transfer =
*t)
> > +{
> > + =A0 =A0 =A0 u16 tx_val =3D 0;
> > +
> > + =A0 =A0 =A0 if (t->tx_buf)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 tx_val =3D ((u16 *)t->tx_buf)[espi->tx];
> > + =A0 =A0 =A0 ep93xx_spi_write_u16(espi, SSPDR, tx_val);
> > + =A0 =A0 =A0 espi->tx +=3D sizeof(tx_val);
> > +}
> > +
> > +static void u16_reader(struct ep93xx_spi *espi,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct spi_transfer *t)
> > +{
> > + =A0 =A0 =A0 u16 rx_val;
> > +
> > + =A0 =A0 =A0 rx_val =3D ep93xx_spi_read_u16(espi, SSPDR);
> > + =A0 =A0 =A0 if (t->rx_buf)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((u16 *)t->rx_buf)[espi->rx] =3D rx_val;
> > + =A0 =A0 =A0 espi->rx +=3D sizeof(rx_val);
> > +}
> =

> These 4 functions are only used once each.  Just merge them into the call=
er.

Will do.

> =

> > +
> > +/**
> > + * bits_per_word() - returns bits per word for current message
> > + */
> > +static inline int bits_per_word(const struct ep93xx_spi *espi)
> > +{
> > + =A0 =A0 =A0 struct spi_message *msg =3D espi->current_msg;
> > + =A0 =A0 =A0 struct spi_transfer *t =3D msg->state;
> > +
> > + =A0 =A0 =A0 return t->bits_per_word ? t->bits_per_word : msg->spi->bi=
ts_per_word;
> > +}
> > +
> > +static void ep93xx_do_write(struct ep93xx_spi *espi,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct spi_transf=
er *t)
> > +{
> > + =A0 =A0 =A0 if (bits_per_word(espi) > 8)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16_writer(espi, t);
> > + =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8_writer(espi, t);
> > +}
> > +
> > +static void ep93xx_do_read(struct ep93xx_spi *espi,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct spi_transfe=
r *t)
> > +{
> > + =A0 =A0 =A0 if (bits_per_word(espi) > 8)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u16_reader(espi, t);
> > + =A0 =A0 =A0 else
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8_reader(espi, t);
> > +}
> > +
> > +/**
> > + * ep93xx_spi_read_write() - perform next RX/TX transfer
> > + * @espi: ep93xx SPI controller struct
> > + *
> > + * This function transfers next bytes (or words) to/from RX/TX FIFOs. =
If called
> > + * several times, the whole transfer will be completed. Returns %0 whe=
n current
> > + * transfer was not yet completed otherwise length of the transfer (>%=
0). When
> > + * this function is finished, RX FIFO should be empty and TX FIFO shou=
ld be
> > + * full.
> > + *
> > + * Can be called from any context.
> > + */
> > +static int ep93xx_spi_read_write(struct ep93xx_spi *espi)
> > +{
> > + =A0 =A0 =A0 struct spi_message *msg;
> > + =A0 =A0 =A0 struct spi_transfer *t;
> > + =A0 =A0 =A0 unsigned long flags;
> > +
> > + =A0 =A0 =A0 spin_lock_irqsave(&espi->lock, flags);
> > + =A0 =A0 =A0 msg =3D espi->current_msg;
> > + =A0 =A0 =A0 spin_unlock_irqrestore(&espi->lock, flags);
> =

> Again, this spin lock isn't protecting anything.  Plain single reads
> can always be considered to be atomic.  Review the locking model, but
> I suspect the lock needs to be held over the entire function.

Ok. I'll re-check the locking model. But see also my explanation below.

> =

> > +
> > + =A0 =A0 =A0 t =3D msg->state;
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* We explicitly handle FIFO level here. This way we do=
n't have to check
> > + =A0 =A0 =A0 =A0* TX FIFO status using %SSPSR_TNF bit which may cause =
RX FIFO overruns.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 if (espi->tx =3D=3D 0 && espi->rx =3D=3D 0)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 espi->fifo_level =3D 0;
> > +
> > + =A0 =A0 =A0 /* read all received data */
> > + =A0 =A0 =A0 while ((ep93xx_spi_read_u8(espi, SSPSR) & SSPSR_RNE) &&
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 espi->rx < t->len) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep93xx_do_read(espi, t);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 espi->fifo_level--;
> > + =A0 =A0 =A0 }
> =

> Another busywait loop.  Could end up burning an awful lot of cycles
> here.  A state machine might be more suitable for this driver so that
> processing can be punted to deferred work when the FIFO gets either
> empty or full.

FIFO size is max 8 frames so there should be 8 iterations when the
FIFO is full. So is it enought to to add check that we only read
max 8 frames from the FIFO?

> > +
> > + =A0 =A0 =A0 /* write as long as FIFO has room */
> > + =A0 =A0 =A0 while (espi->fifo_level < SPI_FIFO_SIZE && espi->tx < t->=
len) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep93xx_do_write(espi, t);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 espi->fifo_level++;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 /* are we done yet? */
> > + =A0 =A0 =A0 if (espi->tx =3D=3D t->len && espi->rx =3D=3D t->len) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg->actual_length +=3D t->len;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return t->len;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 return 0;
> > +}
> > +
> > +/**
> > + * ep93xx_spi_polling_transfer() - implement polling mode transfer
> > + * @espi: ep93xx SPI controller struct
> > + *
> > + * Function performs one polling mode transfer. When this function is =
finished,
> > + * the whole transfer should be completed, or failed in case of error.
> > + */
> > +static void ep93xx_spi_polling_transfer(struct ep93xx_spi *espi)
> > +{
> > + =A0 =A0 =A0 while (!ep93xx_spi_read_write(espi))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpu_relax();
> =

> And if it never finishes?  No exit path on error.

Well with current implementation of ep93xx_spi_read_write() it
cannot fail.  I guess some sort of timeout could be used here. Also
we can take ROR (receive overrun) interrupt and report that back.

> =

> > +}
> > +
> > +/**
> > + * ep93xx_spi_polling_transfer() - implement interrupt based transfer
> =

> Comment doesn't match

Copy paste error, will fix.

> =

> > + * @espi: ep93xx SPI controller struct
> > + *
> > + * Function performs one interrupt based transfer. When this function =
is
> > + * finished, the whole transfer should be completed, or failed in case=
 of error.
> > + */
> > +static void ep93xx_spi_interrupt_transfer(struct ep93xx_spi *espi)
> > +{
> > + =A0 =A0 =A0 ep93xx_spi_enable_interrupts(espi);
> > + =A0 =A0 =A0 wait_for_completion(&espi->wait);
> > +}
> > +
> > +/**
> > + * ep93xx_spi_process_transfer() - processes one SPI transfer
> > + * @espi: ep93xx SPI controller struct
> > + * @msg: current message
> > + * @t: transfer to process
> > + *
> > + * This function processes one SPI transfer given in @t. Function wait=
s until
> > + * transfer is complete (may sleep) and updates @msg->status based on =
whether
> > + * transfer was succesfully processed or not.
> > + */
> > +static void ep93xx_spi_process_transfer(struct ep93xx_spi *espi,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 struct spi_message *msg,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 struct spi_transfer *t)
> > +{
> > + =A0 =A0 =A0 struct ep93xx_spi_chip *chip =3D spi_get_ctldata(msg->spi=
);
> > +
> > + =A0 =A0 =A0 msg->state =3D t;
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Handle any transfer specific settings if needed. We =
use
> > + =A0 =A0 =A0 =A0* temporary chip settings here and restore original la=
ter when
> > + =A0 =A0 =A0 =A0* the transfer is finished.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 if (t->speed_hz || t->bits_per_word) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct ep93xx_spi_chip tmp_chip =3D *chip;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->speed_hz) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int err;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D ep93xx_spi_calc_d=
ivisors(espi, &tmp_chip,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0t->speed_hz);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&=
espi->pdev->dev,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 "failed to adjust speed\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg->stat=
us =3D err;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->bits_per_word)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp_chip.dss =3D bits_per=
_word_to_dss(t->bits_per_word);
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Set up temporary new hw settings for=
 this transfer.
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep93xx_spi_chip_setup(espi, &tmp_chip);
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 espi->rx =3D 0;
> > + =A0 =A0 =A0 espi->tx =3D 0;
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Now everything is set up for the current transfer. P=
erform the actual
> > + =A0 =A0 =A0 =A0* transfer depending on the method.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 espi->transfer(espi);
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* In case of error during transmit, we bail out from p=
rocessing
> > + =A0 =A0 =A0 =A0* the message.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 if (msg->status)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* After this transfer is finished, perform any possible
> > + =A0 =A0 =A0 =A0* post-transfer actions requested by the protocol driv=
er.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 if (t->delay_usecs)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(t->delay_usecs);
> =

> Consider sleeping instead.  busywaits increase latency.

Ok.

> =

> > + =A0 =A0 =A0 if (t->cs_change) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* In case protocol driver is asking us=
 to drop the
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* chipselect briefly, we let the sched=
uler to handle
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* any "delay" here.
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!list_is_last(&t->transfer_list, &msg=
->transfers)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep93xx_spi_deselect_devic=
e(espi, msg->spi);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cond_resched();
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep93xx_spi_select_device(=
espi, msg->spi);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 if (t->speed_hz || t->bits_per_word)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep93xx_spi_chip_setup(espi, chip);
> > +}
> > +
> > +/*
> > + * ep93xx_spi_process_message() - process one SPI message
> > + * @espi: ep93xx SPI controller struct
> > + * @msg: message to process
> > + *
> > + * This function processes a single SPI message. We go through all tra=
nsfers in
> > + * the message and pass them to ep93xx_spi_process_transfer(). Chipsel=
ect is
> > + * asserted during the whole message (unless per transfer cs_change is=
 set).
> > + *
> > + * @msg->status contains %0 in case of success or negative error code =
in case of
> > + * failure.
> > + */
> > +static void ep93xx_spi_process_message(struct ep93xx_spi *espi,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0struct spi_message *msg)
> > +{
> > + =A0 =A0 =A0 struct spi_transfer *t;
> > + =A0 =A0 =A0 int err;
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Enable the SPI controller and its clock.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 err =3D ep93xx_spi_enable(espi);
> > + =A0 =A0 =A0 if (err) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&espi->pdev->dev, "failed to enab=
le SPI controller\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg->status =3D err;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Just to be sure: flush any data from RX FIFO.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 err =3D ep93xx_spi_flush(espi, SPI_TIMEOUT);
> > + =A0 =A0 =A0 if (err) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&espi->pdev->dev, "timeout while=
 flushing RX fifo\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg->status =3D err;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Update SPI controller registers according to spi dev=
ice and assert
> > + =A0 =A0 =A0 =A0* the chipselect.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 ep93xx_spi_chip_setup(espi, spi_get_ctldata(msg->spi));
> > + =A0 =A0 =A0 ep93xx_spi_select_device(espi, msg->spi);
> > +
> > + =A0 =A0 =A0 list_for_each_entry(t, &msg->transfers, transfer_list) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cond_resched();
> =

> Why is this necessary?

Well it isn't strictly necessary. This is just one of the places where we c=
an
voluntarily relinguish the cpu for a while. I can remove that if necessary.

> =

> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ep93xx_spi_process_transfer(espi, msg, t);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (msg->status)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Now the whole message is transferred (or failed for =
some reason). We
> > + =A0 =A0 =A0 =A0* deselect the device and disable the SPI controller.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 ep93xx_spi_deselect_device(espi, msg->spi);
> > + =A0 =A0 =A0 ep93xx_spi_disable(espi);
> > +}
> > +
> > +#define work_to_espi(work) (container_of((work), struct ep93xx_spi, ms=
g_work))
> > +
> > +/**
> > + * ep93xx_spi_work() - EP93xx SPI workqueue worker function
> > + * @work: work struct
> > + *
> > + * Workqueue worker function. This function is called when there are n=
ew
> > + * SPI messages to be processed. Message is taken out from the queue a=
nd then
> > + * passed to ep93xx_spi_process_message().
> > + *
> > + * After message is transferred, protocol driver is notified by calling
> > + * @msg->complete(). In case of error, @msg->status is set to negative=
 error
> > + * number, otherwise it contains zero (and @msg->actual_length is upda=
ted).
> > + */
> > +static void ep93xx_spi_work(struct work_struct *work)
> > +{
> > + =A0 =A0 =A0 struct ep93xx_spi *espi =3D work_to_espi(work);
> > + =A0 =A0 =A0 struct spi_message *msg;
> > +
> > + =A0 =A0 =A0 spin_lock_irq(&espi->lock);
> > + =A0 =A0 =A0 if (!espi->running || espi->current_msg ||
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_empty(&espi->msg_queue)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&espi->lock);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 msg =3D list_first_entry(&espi->msg_queue, struct spi_mes=
sage, queue);
> > + =A0 =A0 =A0 list_del_init(&msg->queue);
> > + =A0 =A0 =A0 espi->current_msg =3D msg;
> > + =A0 =A0 =A0 spin_unlock_irq(&espi->lock);
> =

> I'm nervous about the locking.  I'm not convinced that it covers all
> the important cases.  Are you able to describe what the locks protect,
> and why they are taken when they are?  That would help me evaluate
> what the driver should be doing.

Ok. here is a description of the locking model (sorry if this is
bit messy):

Lock should protect following fields:
 	running
 	current_msg
	msg_queue

(rest of the fields are basically only set once, except rx, tx and
fifo_level)

espi->msg_queue needs protection because there might be multiple
threads adding to the queue.

espi->running signals whether the driver is processing messages or
not. It can be changed when module is unloading, hence it needs
protection.

espi->current_msg is used to hold pointer to currently processed
message. This message has been removed from the espi->msg_queue.
It also indicates whether we can proceed with the next message. If
it is NULL we are allowed to process the next message.

Assumption is that when espi->current_msg is not NULL, message is
processed and we won't call ep93xx_spi_process_message(). This
allows us to use espi->rx, espi->tx, and espi->fifo_level without
locks.

Thanks,
MW

> =

> > +
> > + =A0 =A0 =A0 ep93xx_spi_process_message(espi, msg);
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Update the current message and re-schedule ourselves=
 if there are
> > + =A0 =A0 =A0 =A0* more messages in the queue.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 spin_lock_irq(&espi->lock);
> > + =A0 =A0 =A0 espi->current_msg =3D NULL;
> > + =A0 =A0 =A0 if (espi->running && !list_empty(&espi->msg_queue))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 queue_work(espi->wq, &espi->msg_work);
> > + =A0 =A0 =A0 spin_unlock_irq(&espi->lock);
> > +
> > + =A0 =A0 =A0 /* notify the protocol driver that we are done with this =
message */
> > + =A0 =A0 =A0 msg->complete(msg->context);
> > +}
> > +
> > +/**
> > + * ep93xx_spi_interrupt() - SPI interrupt handler
> > + * @irq: IRQ number (not used)
> > + * @dev_id: pointer to EP93xx controller struct
> > + *
> > + * This function handles TX/RX/ROR interrupts that come from the SPI c=
ontroller.
> > + * Returns %IRQ_HANDLED when interrupt was handled and %IRQ_NONE in ca=
se the
> > + * @irq was not handled.
> > + */
> > +static irqreturn_t ep93xx_spi_interrupt(int irq, void *dev_id)
> > +{
> > + =A0 =A0 =A0 struct ep93xx_spi *espi =3D dev_id;
> > + =A0 =A0 =A0 u8 irq_status;
> > +
> > + =A0 =A0 =A0 irq_status =3D ep93xx_spi_read_u8(espi, SSPIIR);
> > +
> > + =A0 =A0 =A0 if (!(irq_status & (SSPIIR_RORIS | SSPIIR_TIS | SSPIIR_RI=
S)))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_NONE; /* not for us */
> > +
> > + =A0 =A0 =A0 /* clear the interrupt */
> > + =A0 =A0 =A0 ep93xx_spi_write_u8(espi, SSPICR, 0);
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* If we got ROR (receive overrun) interrupt we know th=
at something is
> > + =A0 =A0 =A0 =A0* wrong. Just abort the message.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 if (unlikely(irq_status & SSPIIR_RORIS)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&espi->pdev->dev,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"receive overrun, abor=
ting the message\n");
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock(&espi->lock);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 espi->current_msg->status =3D -EIO;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&espi->lock);
> > + =A0 =A0 =A0 } else {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Interrupt is either RX (RIS) or TX (=
TIS). For both cases we
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* simply execute next data transfer.
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ep93xx_spi_read_write(espi)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* In normal case, ther=
e still is some processing left
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* for current transfer=
. Let's wait for the next
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* interrupt then.
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Current transfer is finished, either with error or w=
ith success. In
> > + =A0 =A0 =A0 =A0* any case we disable interrupts and notify the worker=
 to handle
> > + =A0 =A0 =A0 =A0* any post-processing of the message.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 ep93xx_spi_disable_interrupts(espi);
> > + =A0 =A0 =A0 complete(&espi->wait);
> > + =A0 =A0 =A0 return IRQ_HANDLED;
> > +}
> > +
> > +static int __init ep93xx_spi_probe(struct platform_device *pdev)
> > +{
> > + =A0 =A0 =A0 struct spi_master *master;
> > + =A0 =A0 =A0 struct ep93xx_spi_info *info;
> > + =A0 =A0 =A0 struct ep93xx_spi *espi;
> > + =A0 =A0 =A0 struct resource *res;
> > + =A0 =A0 =A0 int error;
> > +
> > + =A0 =A0 =A0 info =3D pdev->dev.platform_data;
> > +
> > + =A0 =A0 =A0 master =3D spi_alloc_master(&pdev->dev, sizeof(*espi));
> > + =A0 =A0 =A0 if (!master) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to allocate s=
pi master\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 master->setup =3D ep93xx_spi_setup;
> > + =A0 =A0 =A0 master->transfer =3D ep93xx_spi_transfer;
> > + =A0 =A0 =A0 master->cleanup =3D ep93xx_spi_cleanup;
> > + =A0 =A0 =A0 master->bus_num =3D 0;
> > + =A0 =A0 =A0 master->num_chipselect =3D info->num_chipselect;
> > + =A0 =A0 =A0 master->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
> > +
> > + =A0 =A0 =A0 platform_set_drvdata(pdev, master);
> > +
> > + =A0 =A0 =A0 espi =3D spi_master_get_devdata(master);
> > +
> > + =A0 =A0 =A0 espi->clk =3D clk_get(&pdev->dev, NULL);
> > + =A0 =A0 =A0 if (IS_ERR(espi->clk)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "unable to get spi cl=
ock\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D PTR_ERR(espi->clk);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_release_master;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 spin_lock_init(&espi->lock);
> > + =A0 =A0 =A0 init_completion(&espi->wait);
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Calculate maximum and minimum supported clock rates
> > + =A0 =A0 =A0 =A0* for the controller.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 espi->max_rate =3D clk_get_rate(espi->clk) / 2;
> > + =A0 =A0 =A0 espi->min_rate =3D clk_get_rate(espi->clk) / (254 * 256);
> > + =A0 =A0 =A0 espi->info =3D info;
> > + =A0 =A0 =A0 espi->pdev =3D pdev;
> > +
> > + =A0 =A0 =A0 switch (transfer_method) {
> > + =A0 =A0 =A0 case EP93XX_SPI_METHOD_POLL:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 espi->transfer =3D ep93xx_spi_polling_tra=
nsfer;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > +
> > + =A0 =A0 =A0 case EP93XX_SPI_METHOD_INTERRUPT:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 espi->transfer =3D ep93xx_spi_interrupt_t=
ransfer;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 espi->irq =3D platform_get_irq(pdev, 0);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (espi->irq < 0) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -EBUSY;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "fail=
ed to get irq resources\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_put_clock;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> > +
> > + =A0 =A0 =A0 default:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "invalid transfer met=
hod %d given\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 transfer_method);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -EINVAL;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_put_clock;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > + =A0 =A0 =A0 if (!res) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "unable to get iomem =
resource\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -ENODEV;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_put_clock;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 res =3D request_mem_region(res->start, resource_size(res)=
, pdev->name);
> > + =A0 =A0 =A0 if (!res) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "unable to request io=
mem resources\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -EBUSY;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_put_clock;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 espi->regs_base =3D ioremap(res->start, resource_size(res=
));
> > + =A0 =A0 =A0 if (!espi->regs_base) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to map resour=
ces\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D -ENODEV;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_free_mem;
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 if (espi->irq) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D request_irq(espi->irq, ep93xx_s=
pi_interrupt, 0,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "=
ep93xx-spi", espi);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (error) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "fail=
ed to request irq\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_unmap_regs;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 }
> > +
> > + =A0 =A0 =A0 espi->wq =3D create_singlethread_workqueue("ep93xx_spid");
> > + =A0 =A0 =A0 if (!espi->wq) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "unable to create wor=
kqueue\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_free_irq;
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 INIT_WORK(&espi->msg_work, ep93xx_spi_work);
> > + =A0 =A0 =A0 INIT_LIST_HEAD(&espi->msg_queue);
> > + =A0 =A0 =A0 espi->running =3D true;
> > +
> > + =A0 =A0 =A0 /* make sure that the hardware is disabled */
> > + =A0 =A0 =A0 ep93xx_spi_write_u8(espi, SSPCR1, 0);
> > +
> > + =A0 =A0 =A0 error =3D spi_register_master(master);
> > + =A0 =A0 =A0 if (error)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto fail_free_queue;
> > +
> > + =A0 =A0 =A0 dev_info(&pdev->dev, "EP93xx SPI Controller at 0x%08lx\n",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned long)res->start);
> > + =A0 =A0 =A0 if (espi->irq)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&pdev->dev, "using irq %d\n", =
=A0espi->irq);
> > +
> > + =A0 =A0 =A0 return 0;
> > +
> > +fail_free_queue:
> > + =A0 =A0 =A0 destroy_workqueue(espi->wq);
> > +fail_free_irq:
> > + =A0 =A0 =A0 if (espi->irq)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(espi->irq, espi);
> > +fail_unmap_regs:
> > + =A0 =A0 =A0 iounmap(espi->regs_base);
> > +fail_free_mem:
> > + =A0 =A0 =A0 release_mem_region(res->start, resource_size(res));
> > +fail_put_clock:
> > + =A0 =A0 =A0 clk_put(espi->clk);
> > +fail_release_master:
> > + =A0 =A0 =A0 spi_master_put(master);
> > + =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
> > +
> > + =A0 =A0 =A0 return error;
> > +}
> > +
> > +static int __exit ep93xx_spi_remove(struct platform_device *pdev)
> > +{
> > + =A0 =A0 =A0 struct spi_master *master =3D platform_get_drvdata(pdev);
> > + =A0 =A0 =A0 struct ep93xx_spi *espi =3D spi_master_get_devdata(master=
);
> > + =A0 =A0 =A0 struct resource *res;
> > +
> > + =A0 =A0 =A0 spin_lock_irq(&espi->lock);
> > + =A0 =A0 =A0 espi->running =3D false;
> > + =A0 =A0 =A0 spin_unlock_irq(&espi->lock);
> > +
> > + =A0 =A0 =A0 destroy_workqueue(espi->wq);
> > +
> > + =A0 =A0 =A0 /*
> > + =A0 =A0 =A0 =A0* Complete remaining messages with %-ESHUTDOWN status.
> > + =A0 =A0 =A0 =A0*/
> > + =A0 =A0 =A0 spin_lock_irq(&espi->lock);
> > + =A0 =A0 =A0 while (!list_empty(&espi->msg_queue)) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct spi_message *msg;
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg =3D list_first_entry(&espi->msg_queue,
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0struct spi_message, queue);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del_init(&msg->queue);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg->status =3D -ESHUTDOWN;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&espi->lock);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg->complete(msg->context);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&espi->lock);
> > + =A0 =A0 =A0 }
> > + =A0 =A0 =A0 spin_unlock_irq(&espi->lock);
> > +
> > + =A0 =A0 =A0 if (espi->irq)
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 free_irq(espi->irq, espi);
> > +
> > + =A0 =A0 =A0 iounmap(espi->regs_base);
> > + =A0 =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > + =A0 =A0 =A0 release_mem_region(res->start, resource_size(res));
> > + =A0 =A0 =A0 clk_put(espi->clk);
> > + =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
> > +
> > + =A0 =A0 =A0 spi_unregister_master(master);
> > + =A0 =A0 =A0 return 0;
> > +}
> > +
> > +static struct platform_driver ep93xx_spi_driver =3D {
> > + =A0 =A0 =A0 .driver =A0 =A0 =A0 =A0 =3D {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "ep93xx-spi",
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> > + =A0 =A0 =A0 },
> > + =A0 =A0 =A0 .remove =A0 =A0 =A0 =A0 =3D __exit_p(ep93xx_spi_remove),
> > +};
> > +
> > +static int __init ep93xx_spi_init(void)
> > +{
> > + =A0 =A0 =A0 return platform_driver_probe(&ep93xx_spi_driver, ep93xx_s=
pi_probe);
> > +}
> > +module_init(ep93xx_spi_init);
> > +
> > +static void __exit ep93xx_spi_exit(void)
> > +{
> > + =A0 =A0 =A0 platform_driver_unregister(&ep93xx_spi_driver);
> > +}
> > +module_exit(ep93xx_spi_exit);
> > +
> > +MODULE_DESCRIPTION("EP93xx SPI Controller driver");
> > +MODULE_AUTHOR("Mika Westerberg <mika.westerberg@iki.fi>");
> > +MODULE_LICENSE("GPL");
> > +MODULE_ALIAS("platform:ep93xx-spi");
> > --
> > 1.5.6.5
> >
> >
> =

> =

> =

> -- =

> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
