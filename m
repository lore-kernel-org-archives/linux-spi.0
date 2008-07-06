From: saeed <saeed-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org: Re: [PATCH] spi:
 driver for Marvell Orion SPI controllers]
Date: Sun, 6 Jul 2008 00:01:18 -1100 (SST)
Message-ID: <alpine.DEB.0.99.0807030154050.9671@ubuntu-saeed.il.marvell.com>
References: <20080701090454.GF2983@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1744145698-1215342078=:9671"
Cc: nico-mo2vmkxb4K0@public.gmane.org, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
To: Lennert Buytenhek <buytenh-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>, david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080701090454.GF2983-mfnYTeDhw6uOVk/H6u/4e9i2O/JbrIOy@public.gmane.org>
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1744145698-1215342078=:9671
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: QUOTED-PRINTABLE

> From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
> To: Lennert Buytenhek <buytenh-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>
> Subject: Re: [PATCH] spi: driver for Marvell Orion SPI controllers
> Date: Fri, 27 Jun 2008 18:14:29 -0700
> User-Agent: KMail/1.9.9
> Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, nico-mo2vmkxb4K0@public.gmane.org
> In-Reply-To: <20080626183911.GC16994-mfnYTeDhw6uOVk/H6u/4e9i2O/JbrIOy@public.gmane.org>
>=20
> This has some deep assumptions that this controller only
> ever has one chipselect.  Is that really not going to be
> worked around by using GPIOs?  If so, color me surprised...
That's true, the driver supports only 1 slave, and the num_chipselect
is set accordingly.
>=20
> I'd encourage you to change the structure earlier, rather
> than later, to make such (almost inevitable) tweaks easier.
> Or at least, flag places you're assuming there can never
> be more than one slave -- even possibly a copout comment up
> at the top with a big "**WARNING** flag documenting that
> little surprise.
I made the code ready to support multi slaves by making the=20
orion_spi_setup_transfer() the only place where hw settings can be=20
changed, and that functoin guaranteed to be invoked only when no other
transaction is taking place.
>=20
>=20
> On Thursday 26 June 2008, Lennert Buytenhek wrote:
>=20
> > +#define SPI_REG(orion_spi, reg)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(((u32)orion_spi->=
base) + (reg))
>=20
> Inline functions please, not macros-with-unparenthesized-params.
done
>=20
>=20
> > +static int orion_spi_set_transfer_size(struct orion_spi *orion_spi, in=
t size)
> > +{
> > +=09if (size =3D=3D 16) {
> > +=09=09orion_spi_setbits(orion_spi, ORION_SPI_IF_CONFIG_REG,
> > +=09=09=09=09  ORION_SPI_IF_8_16_BIT_MODE);
> > +=09} else if (size =3D=3D 8) {
> > +=09=09orion_spi_clrbits(orion_spi, ORION_SPI_IF_CONFIG_REG,
> > +=09=09=09=09  ORION_SPI_IF_8_16_BIT_MODE);
> > +=09} else {
>=20
> ... always writes register bank, except on error cases; OK, but
> I would have filtered out the error cases from orion_spi_setup()
> or orion_spi_transfer().  In fact I notice transfer() has such
> a test but it just doesn't match this one!
done
>=20
>=20
> > +=09=09pr_debug("Bad bits per word value %d (only 8 or 16 are "
> > +=09=09=09 "allowed).\n", size);
> > +=09=09return -EINVAL;
> > +=09}
> > +
> > +=09return 0;
> > +}
> > +
> > +
> > +static u8 prescale[] =3D { 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26=
, 28, 30 };
>=20
> Should be const ... I suppose this generates better code than
> the obvious "for" loop?
the new code will calculate the needed ratio using divisions, this=20
"lookup" code that uses that array is deleted
>=20
>=20
> > +
> > +static int orion_spi_baudrate_set(struct spi_device *spi, unsigned int=
 rate)
> > +{
> > +=09u32 min_offset =3D 0xFFFFFFFF;
> > +=09u8 best_idx =3D 100;
> > +=09int i;
> > +=09u32 cpu_clk;
> > +=09u32 reg;
> > +=09struct orion_spi *orion_spi;
> > +=09struct orion_spi_info *spi_info;
> > +
> > +=09...
> > +
> > +=09if (best_idx > ARRAY_SIZE(prescale))
> > +=09=09return -EINVAL;
> > +
> > +=09/* Convert the array index to SPI clock divisor value.=09*/
> > +=09reg =3D readl(SPI_REG(orion_spi, ORION_SPI_IF_CONFIG_REG));
> > +=09reg =3D ((reg & ~ORION_SPI_CLK_PRESCALE_MASK) | (best_idx + 0x12));
> > +=09writel(reg, SPI_REG(orion_spi, ORION_SPI_IF_CONFIG_REG));
>=20
> ... always writes register bank, except on error cases ...
>=20
> > +
> > +=09return 0;
> > +}
> > +
> > +/*
> > + * called only when no transfer is active to this device
>=20
> I think you mean "any" device, in fact.  This one looks OK
> at a first glance.
>=20
>=20
> > + */
> > +static int orion_spi_setup_transfer(struct spi_device *spi,
> > +=09=09=09=09    struct spi_transfer *t)
> > +{
> > +=09...
> > +}
> > +
>=20
>=20
> But *HERE* I see a bunch of issues, or at least things that
> will break the first time someone tries to support a second
> slave on this controller.
>=20
> Remember that spi_setup(spi) may be called at any time "spi"
> has no pending messages ... very much in particular, when
> some other  device is active.
this function modified so it will not change the settings, that will=20
be done by orion_spi_setup_transfer() before each transfer message
>=20
> > +static int orion_spi_setup(struct spi_device *spi)
> > +{
> > +=09struct orion_spi_state *spi_state;
> > +=09struct orion_spi *orion_spi;
> > +=09struct orion_spi_info *spi_info;
> > +
> > +=09spi_state =3D spi->controller_state;
> > +=09orion_spi =3D spi_master_get_devdata(spi->master);
> > +=09spi_info =3D orion_spi->spi_info;
> > +
> > +=09if (spi->bits_per_word =3D=3D 0) {
> > +=09=09spi->bits_per_word =3D ORION_SPI_DEF_BPW;
> > +=09} else if (spi->bits_per_word < 8 || spi->bits_per_word > 16) {
> > +=09=09dev_dbg(&spi->dev, "setup: unsupported %d bit words\n",
> > +=09=09=09spi->bits_per_word);
> > +=09=09return -EINVAL;
> > +=09}
> > +
> > +=09if (orion_spi_set_transfer_size(orion_spi, spi->bits_per_word) !=3D=
 0)
>=20
> OK, you may just have trashed transfers that are now taking
> place at another wordsize to a different device...
>=20
> > +=09=09return -EINVAL;
> > +
> > +=09if (!spi_state) {
> > +=09=09spi_state =3D kzalloc(sizeof(*spi_state), GFP_KERNEL);
> > +=09=09if (!spi_state)
> > +=09=09=09return -ENOMEM;
> > +=09=09spi->controller_state =3D spi_state;
> > +=09}
> > +=09spi_state->data_width =3D spi->bits_per_word;
>=20
> You don't need to record bits-per-word; it's already held for
> you in the spi_device.
done, this makes no need for the spi state struction
>=20
>=20
> > +
> > +=09dev_dbg(&spi->dev, "setup: Set MAX Speed to %d ", spi->max_speed_hz=
);
> > +=09if (orion_spi_baudrate_set(spi, spi->max_speed_hz) =3D=3D 0)
>=20
> Here you may have just trashed transfers that are now taking
> place at a different bitrate (say, slower) to a different device...
>=20
> Looks to me like you should probably update spi_state so that
> it holds the default register settings for that device ... or
> maybe just have this code validate the settings.
>=20
> Speaking of which ... what about the spi->mode bits?  This
> driver totally ignores CPOL/CPHA (the four SPI modes), the
> chipselect polarity, and so on.
>=20
> At an *absolute minimum* it should verify that spi->mode is
> the single valeu this evidently handles.  Notice how other
> drivers handle this:  spi_setup() rejects calls when any of
> the bits in spi->mode aren't understood by the driver.
done, I also added the max and min speeds of the controller,=20
the max speed will be the default speed. and error code will be
return if the requested speed is lower that the min speed.
>=20
>=20
> > +=09=09dev_dbg(&spi->dev, "OK");
> > +=09else
> > +=09=09dev_dbg(&spi->dev, "Failed");
> > +
> > +=09return 0;
> > +}
> > +
> > +static int orion_spi_transfer(struct spi_device *spi, struct spi_messa=
ge *m)
> > +{
> > +=09struct orion_spi *orion_spi;
> > +=09unsigned long flags;
> > +=09struct spi_transfer *t;
> > +
> > +=09m->actual_length =3D 0;
> > +=09m->status =3D 0;
> > +
> > +=09/* reject invalid messages and transfers */
> > +=09if (list_empty(&m->transfers) || !m->complete)
> > +=09=09return -EINVAL;
> > +
> > +=09list_for_each_entry(t, &m->transfers, transfer_list) {
> > +=09=09const void *tx_buf =3D t->tx_buf;
> > +=09=09void *rx_buf =3D t->rx_buf;
> > +=09=09unsigned len =3D t->len;
> > +
> > +=09=09if (t->speed_hz > ORION_SPI_MAX_FREQ
> > +=09=09=09=09|| (len && !(rx_buf || tx_buf))
> > +=09=09=09=09|| (t->bits_per_word &&
> > +=09=09=09=09=09(t->bits_per_word < 8
> > +=09=09=09=09=09|| t->bits_per_word > 16))) {
>=20
> See?  this requires bits-per-word between 8 and 16 bits, but the
> other place insists 8 *or* 16 bits.
this code is deleted as the sanity check is done from the=20
orion_spi_set_transfer_size()
>=20
>=20
> > +=09=09=09dev_dbg(&spi->dev, "transfer: %d Hz, %d %s%s, %d bpw\n",
> > +=09=09=09=09=09t->speed_hz,
> > +=09=09=09=09=09len,
> > +=09=09=09=09=09tx_buf ? "tx" : "",
> > +=09=09=09=09=09rx_buf ? "rx" : "",
> > +=09=09=09=09=09t->bits_per_word);
> > +=09=09=09return -EINVAL;
> > +=09=09}
> > +=09}
> > +
> > +=09orion_spi =3D spi_master_get_devdata(spi->master);
> > +
> > +=09spin_lock_irqsave(&orion_spi->lock, flags);
> > +=09list_add_tail(&m->queue, &orion_spi->msg_queue);
> > +=09queue_work(orion_spi_wq, &orion_spi->work);
> > +=09spin_unlock_irqrestore(&orion_spi->lock, flags);
> > +
> > +=09return 0;
> > +}
> > +
>=20
> > +static struct platform_driver orion_spi_driver =3D {
> > +=09.driver =3D {
> > +=09=09.name=09=3D DRIVER_NAME,
> > +=09=09.owner=09=3D THIS_MODULE,
> > +=09},
> > +=09.remove=09=09=3D __exit_p(orion_spi_remove),
>=20
> Good, I always like to see drivers do the right thing with respect
> to runtime footprint shrinkage.  For platform drivers that's usually
> what you did here:  __exit_p() for the remove function, and use
> platform_driver_probe().
>=20
> > +};
> > +
> > +static int __init orion_spi_init(void)
> > +{
> > +=09orion_spi_wq =3D create_singlethread_workqueue(
> > +=09=09=09=09orion_spi_driver.driver.name);
> > +=09if (orion_spi_wq =3D=3D NULL)
> > +=09=09return -1;
>=20
> This should probably be "return -ENOMEM;" ... never return "-1"
> when the interface requires a negative errno.
>=20
>=20
> @@ -0,0 +1,17 @@
> > +/*
> > + * include/linux/spi/orion_spi.h
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2. This program is licensed "as is" without any
> > + * warranty of any kind, whether express or implied.
> > + */
> > +
> > +#ifndef __LINUX_SPI_ORION_SPI_H
> > +#define __LINUX_SPI_ORION_SPI_H
> > +
> > +struct orion_spi_info {
>=20
> What's a "tclk"?  And why can't you just
>=20
> =09tclk =3D clk_get_rate(clk_get(NULL, "cpu"));
>=20
> or whatever?  This looks likely to break whenever
> anyone re-clocks a board.
The tclk is the clock rate in Hz of the controller. we can't use the
clk framework since it's not implemented yet.
>=20
>=20
> > +=09u32=09tclk;
> > +};
> > +
> > +
> > +#endif
> >=20
Here is the updated patch:
From=2080e39e25f9dd35100f80b799f032711c3673da79 Mon Sep 17 00:00:00 2001
From: Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Date: Fri, 27 Jun 2008 19:10:06 +0200
Subject: [PATCH] spi: driver for Marvell Orion SPI controllers

This adds a SPI driver for the SPI controller found in various
Marvell Orion ARM SoCs.

Signed-off-by: Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Saeed Bishara <saeed-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Lennert Buytenhek <buytenh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/Kconfig           |    6 +
 drivers/spi/Makefile          |    1 +
 drivers/spi/orion_spi.c       |  545 +++++++++++++++++++++++++++++++++++++=
++++
 include/linux/spi/orion_spi.h |   17 ++
 4 files changed, 569 insertions(+), 0 deletions(-)
 create mode 100644 drivers/spi/orion_spi.c
 create mode 100644 include/linux/spi/orion_spi.h

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 66ec5d8..be4ba17 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -149,6 +149,12 @@ config SPI_OMAP24XX
 =09  SPI master controller for OMAP24xx/OMAP34xx Multichannel SPI
 =09  (McSPI) modules.
=20
+config SPI_ORION
+=09tristate "Orion SPI master (EXPERIMENTAL)"
+=09depends on SPI_MASTER && PLAT_ORION && EXPERIMENTAL
+=09help
+=09  This enables using the SPI master controller on the Orion chips.
+
 config SPI_PXA2XX
 =09tristate "PXA2xx SSP SPI master"
 =09depends on SPI_MASTER && ARCH_PXA && EXPERIMENTAL
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 7fca043..2d90a56 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_SPI_AU1550)=09=09+=3D au1550_spi.o
 obj-$(CONFIG_SPI_BUTTERFLY)=09=09+=3D spi_butterfly.o
 obj-$(CONFIG_SPI_IMX)=09=09=09+=3D spi_imx.o
 obj-$(CONFIG_SPI_LM70_LLP)=09=09+=3D spi_lm70llp.o
+obj-$(CONFIG_SPI_ORION)=09=09=09+=3D orion_spi.o
 obj-$(CONFIG_SPI_PXA2XX)=09=09+=3D pxa2xx_spi.o
 obj-$(CONFIG_SPI_OMAP_UWIRE)=09=09+=3D omap_uwire.o
 obj-$(CONFIG_SPI_OMAP24XX)=09=09+=3D omap2_mcspi.o
diff --git a/drivers/spi/orion_spi.c b/drivers/spi/orion_spi.c
new file mode 100644
index 0000000..86da165
--- /dev/null
+++ b/drivers/spi/orion_spi.c
@@ -0,0 +1,545 @@
+/*
+ * Marvell Orion SPI controller driver
+ *
+ * Author: Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
+ * Copyright (C) 2007-2008 Marvell Ltd.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/orion_spi.h>
+#include <asm/unaligned.h>
+
+#define DRIVER_NAME=09=09=09"orion_spi"
+
+#define ORION_SPI_DEF_BPW=09=0916
+#define ORION_NUM_CHIPSELECTS=09=091 /* only one slave is supported*/
+#define ORION_SPI_WAIT_RDY_MAX_LOOP=092000 /* in usec */
+#define DUMMY_8_BIT_TX_VAL=09=090xFF
+#define DUMMY_16_BIT_TX_VAL=09=090xFFFF
+
+#define ORION_SPI_IF_CTRL_REG=09=090x00
+#define ORION_SPI_IF_CONFIG_REG=09=090x04
+#define ORION_SPI_DATA_OUT_REG=09=090x08
+#define ORION_SPI_DATA_IN_REG=09=090x0c
+#define ORION_SPI_INT_CAUSE_REG=09=090x10
+
+#define ORION_SPI_IF_8_16_BIT_MODE=09(1 << 5)
+#define ORION_SPI_CLK_PRESCALE_MASK=090x1F
+
+struct orion_spi {
+=09struct work_struct=09work;
+
+=09/* Lock access to transfer list.=09*/
+=09spinlock_t=09=09lock;
+
+=09struct list_head=09msg_queue;
+=09struct spi_master=09*master;
+=09void __iomem=09=09*base;
+=09unsigned int=09=09max_speed;
+=09unsigned int=09=09min_speed;
+=09struct orion_spi_info =09*spi_info;
+};
+
+static struct workqueue_struct *orion_spi_wq;
+
+static inline u32 spi_reg(struct orion_spi *orion_spi, u32 reg)
+{
+=09return (u32)orion_spi->base + reg;
+}
+
+static inline void
+orion_spi_setbits(struct orion_spi *orion_spi, u32 reg, u32 mask)
+{
+=09u32 reg_addr =3D spi_reg(orion_spi, reg);
+=09u32 val;
+
+=09val =3D readl(reg_addr);
+=09val |=3D mask;
+=09writel(val, reg_addr);
+}
+
+static inline void
+orion_spi_clrbits(struct orion_spi *orion_spi, u32 reg, u32 mask)
+{
+=09u32 reg_addr =3D spi_reg(orion_spi, reg);
+=09u32 val;
+
+=09val =3D readl(reg_addr);
+=09val &=3D ~mask;
+=09writel(val, reg_addr);
+}
+
+static int orion_spi_set_transfer_size(struct orion_spi *orion_spi, int si=
ze)
+{
+=09if (size =3D=3D 16) {
+=09=09orion_spi_setbits(orion_spi, ORION_SPI_IF_CONFIG_REG,
+=09=09=09=09  ORION_SPI_IF_8_16_BIT_MODE);
+=09} else if (size =3D=3D 8) {
+=09=09orion_spi_clrbits(orion_spi, ORION_SPI_IF_CONFIG_REG,
+=09=09=09=09  ORION_SPI_IF_8_16_BIT_MODE);
+=09} else {
+=09=09pr_debug("Bad bits per word value %d (only 8 or 16 are "
+=09=09=09 "allowed).\n", size);
+=09=09return -EINVAL;
+=09}
+
+=09return 0;
+}
+
+static int orion_spi_baudrate_set(struct spi_device *spi, unsigned int spe=
ed)
+{
+=09u32 tclk_hz;
+=09u32 rate;
+=09u32 prescale;
+=09u32 reg;
+=09struct orion_spi *orion_spi;
+
+=09orion_spi =3D spi_master_get_devdata(spi->master);
+
+=09tclk_hz =3D orion_spi->spi_info->tclk;
+
+=09/*=20
+=09 * the supported rates are: 4,6,8...30
+=09 * round up as we look for equal or less speed
+=09 */
+=09rate =3D DIV_ROUND_UP(tclk_hz, speed);
+=09rate =3D roundup(rate, 2);
+
+=09/* check if requested speed is too small */
+=09if(rate > 30)
+=09=09return -EINVAL;=09
+
+=09if(rate < 4)
+=09=09rate =3D 4;
+
+=09/* Convert the rate to SPI clock divisor value.=09*/=09
+=09prescale =3D 0x10 + rate/2;
+
+=09reg =3D readl(spi_reg(orion_spi, ORION_SPI_IF_CONFIG_REG));
+=09reg =3D ((reg & ~ORION_SPI_CLK_PRESCALE_MASK) | prescale);
+=09writel(reg, spi_reg(orion_spi, ORION_SPI_IF_CONFIG_REG));
+
+=09return 0;
+}
+
+/*
+ * called only when no transfer is active on the bus
+ */
+static int orion_spi_setup_transfer(struct spi_device *spi,
+=09=09=09=09    struct spi_transfer *t)
+{
+=09struct orion_spi *orion_spi;
+=09unsigned int speed =3D spi->max_speed_hz;
+=09unsigned int bits_per_word =3D spi->bits_per_word;
+
+=09orion_spi =3D spi_master_get_devdata(spi->master);
+
+=09if ((t !=3D NULL) && t->speed_hz)
+=09=09speed =3D t->speed_hz;
+
+=09if ((t !=3D NULL) && t->bits_per_word)
+=09=09bits_per_word =3D t->bits_per_word;
+
+=09if (orion_spi_baudrate_set(spi, speed) !=3D 0)
+=09=09return -EINVAL;
+
+=09if (orion_spi_set_transfer_size(orion_spi, bits_per_word) !=3D 0)
+=09=09return -EINVAL;
+
+=09return 0;
+}
+
+static void orion_spi_set_cs(struct orion_spi *orion_spi, int enable)
+{
+=09if (enable)
+=09=09orion_spi_setbits(orion_spi, ORION_SPI_IF_CTRL_REG, 0x1);
+=09else
+=09=09orion_spi_clrbits(orion_spi, ORION_SPI_IF_CTRL_REG, 0x1);
+}
+
+static inline int orion_spi_wait_till_ready(struct orion_spi *orion_spi)
+{
+=09int i;
+
+=09for (i =3D 0; i < ORION_SPI_WAIT_RDY_MAX_LOOP; i++) {
+=09=09if (readl(spi_reg(orion_spi, ORION_SPI_INT_CAUSE_REG)))
+=09=09=09return 1;
+=09=09else
+=09=09=09udelay(1);
+=09}
+
+=09return -1;
+}
+
+static int
+orion_spi_write_read_8bit(struct spi_device *spi,
+=09=09=09  const u8 **tx_buf, u8 **rx_buf)
+{
+=09u32 tx_reg, rx_reg, int_reg;
+=09struct orion_spi *orion_spi;
+
+=09orion_spi =3D spi_master_get_devdata(spi->master);
+=09tx_reg =3D spi_reg(orion_spi, ORION_SPI_DATA_OUT_REG);
+=09rx_reg =3D spi_reg(orion_spi, ORION_SPI_DATA_IN_REG);
+=09int_reg =3D spi_reg(orion_spi, ORION_SPI_INT_CAUSE_REG);
+
+=09/* clear the interrupt cause register */
+=09writel(0x0, int_reg);
+
+=09if (tx_buf && *tx_buf)
+=09=09writel(*(*tx_buf)++, tx_reg);
+=09else
+=09=09writel(DUMMY_8_BIT_TX_VAL, tx_reg);
+
+=09if (orion_spi_wait_till_ready(orion_spi) < 0)
+=09=09return -1;
+
+=09if (rx_buf && *rx_buf)
+=09=09*(*rx_buf)++ =3D readl(rx_reg);
+
+=09return 1;
+}
+
+static int
+orion_spi_write_read_16bit(struct spi_device *spi,
+=09=09=09   const u16 **tx_buf, u16 **rx_buf)
+{
+=09u32 tx_reg, rx_reg, int_reg;
+=09struct orion_spi *orion_spi;
+
+=09orion_spi =3D spi_master_get_devdata(spi->master);
+=09tx_reg =3D spi_reg(orion_spi, ORION_SPI_DATA_OUT_REG);
+=09rx_reg =3D spi_reg(orion_spi, ORION_SPI_DATA_IN_REG);
+=09int_reg =3D spi_reg(orion_spi, ORION_SPI_INT_CAUSE_REG);
+
+=09/* clear the interrupt cause register */
+=09writel(0x0, int_reg);
+
+=09if (tx_buf && *tx_buf)
+=09=09writel(__cpu_to_le16(get_unaligned((*tx_buf)++)), tx_reg);
+=09else
+=09=09writel(DUMMY_16_BIT_TX_VAL, tx_reg);
+
+=09if (orion_spi_wait_till_ready(orion_spi) < 0) {
+=09=09dev_err(&spi->dev, "TXS timed out\n");
+=09=09return -1;
+=09}
+
+=09if (rx_buf && *rx_buf)
+=09=09put_unaligned(__le16_to_cpu(readl(rx_reg)), (*rx_buf)++);
+
+=09return 1;
+}
+
+static unsigned int
+orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
+{
+=09struct orion_spi *orion_spi;
+=09unsigned int count;
+=09void __iomem *base;
+=09int word_len;
+
+=09orion_spi =3D spi_master_get_devdata(spi->master);
+=09base =3D orion_spi->base;
+=09word_len =3D spi->bits_per_word;
+=09count =3D xfer->len;
+
+=09if (word_len =3D=3D 8) {
+=09=09const u8 *tx =3D xfer->tx_buf;
+=09=09u8 *rx =3D xfer->rx_buf;
+
+=09=09do {
+=09=09=09if (orion_spi_write_read_8bit(spi, &tx, &rx) < 0)
+=09=09=09=09goto out;
+=09=09=09count--;
+=09=09} while (count);
+=09} else if (word_len =3D=3D 16) {
+=09=09const u16 *tx =3D xfer->tx_buf;
+=09=09u16 *rx =3D xfer->rx_buf;
+
+=09=09while (count > 1) {
+=09=09=09if (orion_spi_write_read_16bit(spi, &tx, &rx) < 0)
+=09=09=09=09goto out;
+=09=09=09count -=3D 2;
+=09=09}
+
+=09=09if (count =3D=3D 1) {
+=09=09=09/* Set mode to 8 bit. */
+=09=09=09orion_spi_set_transfer_size(orion_spi, 8);
+=09=09=09if (orion_spi_write_read_8bit(spi, (const u8 **)&tx,
+=09=09=09=09=09=09(u8 **)&rx) < 0)
+=09=09=09=09goto out;
+
+=09=09=09/* Set mode to 16 bit. */
+=09=09=09orion_spi_set_transfer_size(orion_spi, 16);
+=09=09=09count--;
+=09=09}
+=09}
+
+out:
+=09return xfer->len - count;
+}
+
+
+static void orion_spi_work(struct work_struct *work)
+{
+=09struct orion_spi *orion_spi =3D
+=09=09container_of(work, struct orion_spi, work);
+
+=09spin_lock_irq(&orion_spi->lock);
+=09while (!list_empty(&orion_spi->msg_queue)) {
+=09=09struct spi_message *m;
+=09=09struct spi_device *spi;
+=09=09struct spi_transfer *t =3D NULL;
+=09=09int par_override =3D 0;
+=09=09int status =3D 0;
+=09=09int cs_active =3D 0;
+
+=09=09m =3D container_of(orion_spi->msg_queue.next, struct spi_message,
+=09=09=09=09 queue);
+
+=09=09list_del_init(&m->queue);
+=09=09spin_unlock_irq(&orion_spi->lock);
+
+=09=09spi =3D m->spi;
+
+=09=09/* Load defaults */
+=09=09status =3D orion_spi_setup_transfer(spi, NULL);
+=09=09
+=09=09if (status < 0)
+=09=09=09goto msg_done;
+
+=09=09list_for_each_entry(t, &m->transfers, transfer_list) {
+=09=09=09if (t->tx_buf =3D=3D NULL && t->rx_buf =3D=3D NULL && t->len) {
+=09=09=09=09status =3D -EINVAL;
+=09=09=09=09break;
+=09=09=09}
+
+=09=09=09if (par_override || t->speed_hz || t->bits_per_word) {
+=09=09=09=09par_override =3D 1;
+=09=09=09=09status =3D orion_spi_setup_transfer(spi, t);
+=09=09=09=09if (status < 0)
+=09=09=09=09=09break;
+=09=09=09=09if (!t->speed_hz && !t->bits_per_word)
+=09=09=09=09=09par_override =3D 0;
+=09=09=09}
+
+=09=09=09if (!cs_active) {
+=09=09=09=09orion_spi_set_cs(orion_spi, 1);
+=09=09=09=09cs_active =3D 1;
+=09=09=09}
+
+=09=09=09if (t->len)
+=09=09=09=09m->actual_length +=3D
+=09=09=09=09=09orion_spi_write_read(spi, t);
+
+=09=09=09if (t->delay_usecs)
+=09=09=09=09udelay(t->delay_usecs);
+
+=09=09=09if (t->cs_change) {
+=09=09=09=09orion_spi_set_cs(orion_spi, 0);
+=09=09=09=09cs_active =3D 0;
+=09=09=09}
+=09=09}
+
+msg_done:
+=09=09if (cs_active)
+=09=09=09orion_spi_set_cs(orion_spi, 0);
+
+=09=09m->status =3D status;
+=09=09m->complete(m->context);
+
+=09=09spin_lock_irq(&orion_spi->lock);
+=09}
+
+=09spin_unlock_irq(&orion_spi->lock);
+}
+
+static int __init orion_spi_reset(struct orion_spi *orion_spi)
+{
+=09/* Verify that the CS is deasserted */
+=09orion_spi_set_cs(orion_spi, 0);
+
+=09return 0;
+}
+
+static int orion_spi_setup(struct spi_device *spi)
+{
+=09struct orion_spi *orion_spi;
+
+=09orion_spi =3D spi_master_get_devdata(spi->master);
+
+=09if (spi->mode) {
+=09=09dev_err(&spi->dev, "setup: unsupported mode bits %x\n",
+=09=09=09spi->mode);
+=09=09return -EINVAL;
+=09}
+
+=09if (spi->bits_per_word =3D=3D 0)
+=09=09spi->bits_per_word =3D ORION_SPI_DEF_BPW;
+
+=09if ((spi->max_speed_hz =3D=3D 0) ||=20
+=09    (spi->max_speed_hz > orion_spi->max_speed))
+=09=09spi->max_speed_hz =3D orion_spi->max_speed;
+
+=09if (spi->max_speed_hz < orion_spi->min_speed) {
+=09=09dev_err(&spi->dev, "setup: requested speed too low %d Hz\n",
+=09=09=09spi->max_speed_hz);
+=09=09
+=09=09return -EINVAL;
+=09}
+=09/*
+=09 * baudrate & width will be set orion_spi_setup_transfer
+=09 *
+=09 */
+=09return 0;
+}
+
+static int orion_spi_transfer(struct spi_device *spi, struct spi_message *=
m)
+{
+=09struct orion_spi *orion_spi;
+=09unsigned long flags;
+
+=09m->actual_length =3D 0;
+=09m->status =3D 0;
+
+=09/* reject invalid messages and transfers */
+=09if (list_empty(&m->transfers) || !m->complete)
+=09=09return -EINVAL;
+
+=09orion_spi =3D spi_master_get_devdata(spi->master);
+
+=09spin_lock_irqsave(&orion_spi->lock, flags);
+=09list_add_tail(&m->queue, &orion_spi->msg_queue);
+=09queue_work(orion_spi_wq, &orion_spi->work);
+=09spin_unlock_irqrestore(&orion_spi->lock, flags);
+
+=09return 0;
+}
+
+static int __init orion_spi_probe(struct platform_device *pdev)
+{
+=09struct spi_master *master;
+=09struct orion_spi *spi;
+=09struct resource *r;
+=09struct orion_spi_info *spi_info;
+=09int status =3D 0;
+
+=09spi_info =3D pdev->dev.platform_data;
+
+=09master =3D spi_alloc_master(&pdev->dev, sizeof *spi);
+=09if (master =3D=3D NULL) {
+=09=09dev_dbg(&pdev->dev, "master allocation failed\n");
+=09=09return -ENOMEM;
+=09}
+
+=09if (pdev->id !=3D -1)
+=09=09master->bus_num =3D pdev->id;
+
+=09master->setup =3D orion_spi_setup;
+=09master->transfer =3D orion_spi_transfer;
+=09master->num_chipselect =3D ORION_NUM_CHIPSELECTS;
+
+=09dev_set_drvdata(&pdev->dev, master);
+
+=09spi =3D spi_master_get_devdata(master);
+=09spi->master =3D master;
+=09spi->spi_info =3D spi_info;
+
+=09spi->max_speed =3D DIV_ROUND_UP(spi_info->tclk, 4);
+=09spi->min_speed =3D DIV_ROUND_UP(spi_info->tclk, 30);
+
+=09r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+=09if (r =3D=3D NULL) {
+=09=09status =3D -ENODEV;
+=09=09goto out;
+=09}
+
+=09if (!request_mem_region(r->start, (r->end - r->start) + 1,
+=09=09=09=09pdev->dev.bus_id)) {
+=09=09status =3D -EBUSY;
+=09=09goto out;
+=09}
+=09spi->base =3D ioremap(r->start, SZ_1K);
+
+=09INIT_WORK(&spi->work, orion_spi_work);
+
+=09spin_lock_init(&spi->lock);
+=09INIT_LIST_HEAD(&spi->msg_queue);
+
+=09if (orion_spi_reset(spi) < 0)
+=09=09goto out_rel_mem;
+
+=09status =3D spi_register_master(master);
+=09if (status < 0)
+=09=09goto out_rel_mem;
+
+=09return status;
+
+out_rel_mem:
+=09release_mem_region(r->start, (r->end - r->start) + 1);
+
+out:
+=09spi_master_put(master);
+=09return status;
+}
+
+
+static int __exit orion_spi_remove(struct platform_device *pdev)
+{
+=09struct spi_master *master;
+=09struct orion_spi *spi;
+=09struct resource *r;
+
+=09master =3D dev_get_drvdata(&pdev->dev);
+=09spi =3D spi_master_get_devdata(master);
+
+=09r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+=09release_mem_region(r->start, (r->end - r->start) + 1);
+
+=09spi_unregister_master(master);
+
+=09return 0;
+}
+
+static struct platform_driver orion_spi_driver =3D {
+=09.driver =3D {
+=09=09.name=09=3D DRIVER_NAME,
+=09=09.owner=09=3D THIS_MODULE,
+=09},
+=09.remove=09=09=3D __exit_p(orion_spi_remove),
+};
+
+static int __init orion_spi_init(void)
+{
+=09orion_spi_wq =3D create_singlethread_workqueue(
+=09=09=09=09orion_spi_driver.driver.name);
+=09if (orion_spi_wq =3D=3D NULL)
+=09=09return -ENOMEM;
+
+=09return platform_driver_probe(&orion_spi_driver, orion_spi_probe);
+}
+module_init(orion_spi_init);
+
+static void __exit orion_spi_exit(void)
+{
+=09platform_driver_unregister(&orion_spi_driver);
+
+=09destroy_workqueue(orion_spi_wq);
+}
+module_exit(orion_spi_exit);
+
+MODULE_DESCRIPTION("Orion SPI driver");
+MODULE_AUTHOR("Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:orion_spi");
diff --git a/include/linux/spi/orion_spi.h b/include/linux/spi/orion_spi.h
new file mode 100644
index 0000000..0781855
--- /dev/null
+++ b/include/linux/spi/orion_spi.h
@@ -0,0 +1,17 @@
+/*
+ * include/linux/spi/orion_spi.h
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __LINUX_SPI_ORION_SPI_H
+#define __LINUX_SPI_ORION_SPI_H
+
+struct orion_spi_info {
+=09u32=09tclk;
+};
+
+
+#endif
--=20
1.5.2.5

--8323329-1744145698-1215342078=:9671
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--8323329-1744145698-1215342078=:9671
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--8323329-1744145698-1215342078=:9671--
