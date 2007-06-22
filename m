From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] TXx9 SPI controller driver
Date: Fri, 22 Jun 2007 11:51:24 -0700
Message-ID: <200706221151.24959.david-b@pacbell.net>
References: <20070622.232111.36926005.anemo@mba.ocn.ne.jp>
	<200706221103.19761.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
	Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
	mlachwani-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200706221103.19761.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Friday 22 June 2007, David Brownell wrote:
> On Friday 22 June 2007, Atsushi Nemoto wrote:
> > This is a driver for SPI controller built into TXx9 MIPS SoCs.
> 
> Looks mostly pretty good.  I made a few minor changes/cleanups
> in the appended version, notably:
>  - checking for spi->mode bits this code doesn't understand;
>  - updating to match latest patches;
> 
> Note that if gpio_set_value() needs an mmiowb(), that seems like
> a bug in this platform's  GPIO code; other platforms don't require
> I/O barriers after GPIO calls.  Comments?
> 
> Also:
> 

... yeah, -ENOPATCH, sorry.  And the minor whitespace fixes.

One more comment:  surely platform_driver_probe() would be
appropriate here?

=======	CUT HERE
From: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>

This is a driver for SPI controller built into TXx9 MIPS SoCs.
This driver is derived from arch/mips/tx4938/toshiba_rbtx4938/spi_txx9.c.

Signed-off-by: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
---
 drivers/spi/Kconfig    |    6 
 drivers/spi/Makefile   |    1 
 drivers/spi/spi_txx9.c |  434 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 441 insertions(+)

--- g26.orig/drivers/spi/Kconfig	2007-06-20 20:15:51.000000000 -0700
+++ g26/drivers/spi/Kconfig	2007-06-22 09:01:03.000000000 -0700
@@ -175,6 +175,12 @@ config SPI_S3C24XX_GPIO
 	  the inbuilt hardware cannot provide the transfer mode, or
 	  where the board is using non hardware connected pins.
 
+config SPI_TXX9
+	tristate "Toshiba TXx9 SPI controller"
+	depends on SPI_MASTER && GENERIC_GPIO && CPU_TX49XX
+	help
+	  SPI driver for Toshiba TXx9 MIPS SoCs
+
 config SPI_XILINX
 	tristate "Xilinx SPI controller"
 	depends on SPI_MASTER && XILINX_VIRTEX && EXPERIMENTAL
--- g26.orig/drivers/spi/Makefile	2007-06-20 20:15:50.000000000 -0700
+++ g26/drivers/spi/Makefile	2007-06-22 09:00:34.000000000 -0700
@@ -24,6 +24,7 @@ obj-$(CONFIG_SPI_MPC52xx_PSC)		+= mpc52x
 obj-$(CONFIG_SPI_MPC83xx)		+= spi_mpc83xx.o
 obj-$(CONFIG_SPI_S3C24XX_GPIO)		+= spi_s3c24xx_gpio.o
 obj-$(CONFIG_SPI_S3C24XX)		+= spi_s3c24xx.o
+obj-$(CONFIG_SPI_TXX9)			+= spi_txx9.o
 obj-$(CONFIG_SPI_XILINX)		+= xilinx_spi.o
 # 	... add above this line ...
 
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ g26/drivers/spi/spi_txx9.c	2007-06-22 11:48:28.000000000 -0700
@@ -0,0 +1,434 @@
+/*
+ * spi_tx99.c - TXx9 SPI controller driver.
+ *
+ * Based on linux/arch/mips/tx4938/toshiba_rbtx4938/spi_txx9.c
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ *
+ * 2003-2005 (c) MontaVista Software, Inc. This file is licensed under the
+ * terms of the GNU General Public License version 2. This program is
+ * licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Support for TX4938 in 2.6 - Manish Lachwani (mlachwani-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org)
+ *
+ * Convert to generic SPI framework - Atsushi Nemoto (anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org)
+ */
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/workqueue.h>
+#include <linux/spi/spi.h>
+#include <asm/gpio.h>
+
+
+#define SPI_FIFO_SIZE 4
+
+#define TXx9_SPMCR		0x00
+#define TXx9_SPCR0		0x04
+#define TXx9_SPCR1		0x08
+#define TXx9_SPFS		0x0c
+#define TXx9_SPSR		0x14
+#define TXx9_SPDR		0x18
+
+/* SPMCR : SPI Master Control */
+#define TXx9_SPMCR_OPMODE	0xc0
+#define TXx9_SPMCR_CONFIG	0x40
+#define TXx9_SPMCR_ACTIVE	0x80
+#define TXx9_SPMCR_SPSTP	0x02
+#define TXx9_SPMCR_BCLR		0x01
+
+/* SPCR0 : SPI Control 0 */
+#define TXx9_SPCR0_TXIFL_MASK	0xc000
+#define TXx9_SPCR0_RXIFL_MASK	0x3000
+#define TXx9_SPCR0_SIDIE	0x0800
+#define TXx9_SPCR0_SOEIE	0x0400
+#define TXx9_SPCR0_RBSIE	0x0200
+#define TXx9_SPCR0_TBSIE	0x0100
+#define TXx9_SPCR0_IFSPSE	0x0010
+#define TXx9_SPCR0_SBOS		0x0004
+#define TXx9_SPCR0_SPHA		0x0002
+#define TXx9_SPCR0_SPOL		0x0001
+
+/* SPSR : SPI Status */
+#define TXx9_SPSR_TBSI		0x8000
+#define TXx9_SPSR_RBSI		0x4000
+#define TXx9_SPSR_TBS_MASK	0x3800
+#define TXx9_SPSR_RBS_MASK	0x0700
+#define TXx9_SPSR_SPOE		0x0080
+#define TXx9_SPSR_IFSD		0x0008
+#define TXx9_SPSR_SIDLE		0x0004
+#define TXx9_SPSR_STRDY		0x0002
+#define TXx9_SPSR_SRRDY		0x0001
+
+
+struct txx9spi {
+	struct workqueue_struct	*workqueue;
+	struct work_struct work;
+	spinlock_t lock;	/* protect 'queue' */
+	struct list_head queue;
+	wait_queue_head_t waitq;
+	void __iomem *membase;
+	int mapped;
+	int irq;
+	int baseclk;
+};
+
+struct txx9spi_cs {
+	u32 cr1;
+};
+
+static u32 txx9spi_rd(struct txx9spi *c, int reg)
+{
+	return __raw_readl(c->membase + reg);
+}
+static void txx9spi_wr(struct txx9spi *c, u32 val, int reg)
+{
+	__raw_writel(val, c->membase + reg);
+}
+
+static void txx9spi_cs_func(struct spi_device *spi, int on)
+{
+	if (spi->mode & SPI_CS_HIGH)
+		on = !on;
+	gpio_set_value(spi->chip_select, !on);
+	mmiowb();
+}
+
+/* the spi->mode bits understood by this driver: */
+#define MODEBITS	(SPI_CS_HIGH|SPI_CPOL|SPI_CPHA)
+
+static int txx9spi_setup(struct spi_device *spi)
+{
+	struct txx9spi *c = spi_master_get_devdata(spi->master);
+	struct txx9spi_cs *cs = spi->controller_state;
+	unsigned int n;
+
+	if (spi->mode & ~MODEBITS)
+		return -EINVAL;
+
+	if (!spi->max_speed_hz)
+		return -EINVAL;
+
+	if (gpio_direction_output(spi->chip_select,
+				  !(spi->mode & SPI_CS_HIGH))) {
+		dev_err(&spi->dev, "Cannot setup GPIO for chipselect.\n");
+		return -EINVAL;
+	}
+
+	if (!cs) {
+		cs = kmalloc(sizeof(*cs), GFP_KERNEL);
+		if (!cs)
+			return -ENOMEM;
+		spi->controller_state = cs;
+	}
+
+	if (spi->bits_per_word == 0)
+		spi->bits_per_word = 8;
+	else if (spi->bits_per_word != 8 && spi->bits_per_word != 16)
+		return -EINVAL;
+
+	/* calc real speed */
+	n = (c->baseclk + spi->max_speed_hz - 1) / spi->max_speed_hz;
+	if (n < 1)
+		n = 1;
+	else if (n > 0xff)
+		return -EINVAL;
+	spi->max_speed_hz = c->baseclk / n;
+
+	cs->cr1 = (n << 8) | spi->bits_per_word;
+	return 0;
+}
+
+static irqreturn_t txx9spi_interrupt(int irq, void *dev_id)
+{
+	struct txx9spi *c = dev_id;
+
+	/* disable rx intr */
+	txx9spi_wr(c, txx9spi_rd(c, TXx9_SPCR0) & ~TXx9_SPCR0_RBSIE,
+		   TXx9_SPCR0);
+	wake_up(&c->waitq);
+	return IRQ_HANDLED;
+}
+
+static int txx9spi_work_one(struct txx9spi *c, struct spi_message *m)
+{
+	struct spi_device *spi = m->spi;
+	struct txx9spi_cs *cs = spi->controller_state;
+	struct spi_transfer *t;
+	unsigned int nsecs;
+	unsigned int cs_change;
+	int status;
+	u32 mcr;
+
+	mcr = txx9spi_rd(c, TXx9_SPMCR);
+	if (unlikely((mcr & TXx9_SPMCR_OPMODE) == TXx9_SPMCR_ACTIVE)) {
+		dev_err(&spi->dev, "Bad mode.\n");
+		return -EIO;
+	}
+
+	/* enter config mode */
+	mcr &= ~(TXx9_SPMCR_OPMODE | TXx9_SPMCR_SPSTP | TXx9_SPMCR_BCLR);
+	txx9spi_wr(c, mcr | TXx9_SPMCR_CONFIG | TXx9_SPMCR_BCLR, TXx9_SPMCR);
+	txx9spi_wr(c, TXx9_SPCR0_SBOS |
+		   ((spi->mode & SPI_CPOL) ? TXx9_SPCR0_SPOL : 0) |
+		   ((spi->mode & SPI_CPHA) ? TXx9_SPCR0_SPHA : 0) |
+		   0x08,
+		   TXx9_SPCR0);
+	txx9spi_wr(c, cs->cr1, TXx9_SPCR1);
+	/* enter active mode */
+	txx9spi_wr(c, mcr | TXx9_SPMCR_ACTIVE, TXx9_SPMCR);
+
+	cs_change = 1;
+	status = 0;
+	nsecs = 100 + 1000000000 / spi->max_speed_hz / 2;
+	list_for_each_entry (t, &m->transfers, transfer_list) {
+		const void *txbuf = t->tx_buf;
+		void *rxbuf = t->rx_buf;
+		u32 data;
+		unsigned int len = t->len;
+		unsigned int wsize = spi->bits_per_word >> 3; /* in bytes */
+		if ((!txbuf && !rxbuf && len) || (len & (wsize - 1))) {
+			status = -EINVAL;
+			break;
+		}
+		if (cs_change) {
+			txx9spi_cs_func(spi, 1);
+			ndelay(nsecs);
+		}
+		cs_change = t->cs_change;
+		while (len) {
+			unsigned int count = SPI_FIFO_SIZE;
+			int i;
+			u32 cr0;
+			if (len < count * wsize)
+				count = len / wsize;
+			/* now tx must be idle... */
+			while (!(txx9spi_rd(c, TXx9_SPSR) & TXx9_SPSR_SIDLE))
+				;
+			cr0 = txx9spi_rd(c, TXx9_SPCR0);
+			cr0 &= ~TXx9_SPCR0_RXIFL_MASK;
+			cr0 |= (count - 1) << 12;
+			/* enable rx intr */
+			cr0 |= TXx9_SPCR0_RBSIE;
+			txx9spi_wr(c, cr0, TXx9_SPCR0);
+			/* send */
+			for (i = 0; i < count; i++) {
+				data = txbuf ? (wsize == 1 ?
+						*(const u8 *)txbuf :
+						*(const u16 *)txbuf) : 0;
+				txx9spi_wr(c, data, TXx9_SPDR);
+				if (txbuf)
+					txbuf += wsize;
+			}
+			/* wait all rx data */
+			wait_event(c->waitq,
+				   txx9spi_rd(c, TXx9_SPSR) & TXx9_SPSR_RBSI);
+			/* receive */
+			for (i = 0; i < count; i++) {
+				data = txx9spi_rd(c, TXx9_SPDR);
+				if (rxbuf) {
+					if (wsize == 1)
+						*(u8 *)rxbuf = data;
+					else
+						*(u16 *)rxbuf = data;
+					rxbuf += wsize;
+				}
+			}
+			len -= count * wsize;
+		}
+		m->actual_length += t->len;
+		if (t->delay_usecs)
+			udelay(t->delay_usecs);
+
+		if (!cs_change)
+			continue;
+		if (t->transfer_list.next == &m->transfers)
+			break;
+		/* sometimes a short mid-message deselect of the chip
+		 * may be needed to terminate a mode or command
+		 */
+		ndelay(nsecs);
+		txx9spi_cs_func(spi, 0);
+		ndelay(nsecs);
+	}
+
+	m->status = status;
+	m->complete(m->context);
+
+	/* normally deactivate chipselect ... unless no error and
+	 * cs_change has hinted that the next message will probably
+	 * be for this chip too.
+	 */
+	if (!(status == 0 && cs_change)) {
+		ndelay(nsecs);
+		txx9spi_cs_func(spi, 0);
+		ndelay(nsecs);
+	}
+
+	/* enter config mode */
+	txx9spi_wr(c, mcr | TXx9_SPMCR_CONFIG | TXx9_SPMCR_BCLR, TXx9_SPMCR);
+	return status;
+}
+
+static void txx9spi_work(struct work_struct *work)
+{
+	struct txx9spi *c = container_of(work, struct txx9spi, work);
+	unsigned long flags;
+
+	spin_lock_irqsave(&c->lock, flags);
+	while (!list_empty(&c->queue)) {
+		struct spi_message *m;
+
+		m = container_of(c->queue.next, struct spi_message, queue);
+		list_del_init(&m->queue);
+		spin_unlock_irqrestore(&c->lock, flags);
+
+		txx9spi_work_one(c, m);
+
+		spin_lock_irqsave(&c->lock, flags);
+	}
+	spin_unlock_irqrestore(&c->lock, flags);
+}
+
+static int txx9spi_transfer(struct spi_device *spi, struct spi_message *m)
+{
+	struct spi_master *master = spi->master;
+	struct txx9spi *c = spi_master_get_devdata(master);
+	unsigned long flags;
+
+	m->actual_length = 0;
+	spin_lock_irqsave(&c->lock, flags);
+	list_add_tail(&m->queue, &c->queue);
+	queue_work(c->workqueue, &c->work);
+	spin_unlock_irqrestore(&c->lock, flags);
+
+	return 0;
+}
+
+static void txx9spi_cleanup(struct spi_device *spi)
+{
+	kfree(spi->controller_state);
+}
+
+#ifdef CONFIG_64BIT
+#define TXX9_DIRECTMAP_BASE	0xfff000000ul
+#else
+#define TXX9_DIRECTMAP_BASE	0xff000000ul
+#endif
+
+static int __init txx9spi_probe(struct platform_device *dev)
+{
+	struct spi_master *master;
+	struct txx9spi *c;
+	struct resource *res;
+	int ret = -ENODEV;
+	u32 mcr;
+
+	master = spi_alloc_master(&dev->dev, sizeof(*c));
+	if (!master)
+		return ret;
+	c = spi_master_get_devdata(master);
+	platform_set_drvdata(dev, master);
+
+	INIT_WORK(&c->work, txx9spi_work);
+	spin_lock_init(&c->lock);
+	INIT_LIST_HEAD(&c->queue);
+	init_waitqueue_head(&c->waitq);
+
+	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+	if (!res)
+		goto put_and_exit;
+	if (res->start >= TXX9_DIRECTMAP_BASE)
+		c->membase = (void __iomem *)(unsigned long)(int)res->start;
+	else {
+		c->membase = ioremap(res->start, res->end - res->start + 1);
+		c->mapped = 1;
+	}
+
+	/* enter config mode */
+	mcr = txx9spi_rd(c, TXx9_SPMCR);
+	mcr &= ~(TXx9_SPMCR_OPMODE | TXx9_SPMCR_SPSTP | TXx9_SPMCR_BCLR);
+	txx9spi_wr(c, mcr | TXx9_SPMCR_CONFIG | TXx9_SPMCR_BCLR, TXx9_SPMCR);
+
+	c->irq = platform_get_irq(dev, 0);
+	if (c->irq < 0)
+		goto res_and_exit;
+	c->baseclk = platform_get_irq_byname(dev, "baseclk");
+	if (c->baseclk < 0)
+		goto res_and_exit;
+	ret = request_irq(c->irq, txx9spi_interrupt, 0, dev->name, c);
+	if (ret)
+		goto res_and_exit;
+
+	c->workqueue = create_singlethread_workqueue(master->cdev.dev->bus_id);
+	if (!c->workqueue)
+		goto irq_and_exit;
+
+	dev_info(&dev->dev, "at 0x%llx, irq %d, %dMHz\n",
+		 (unsigned long long)res->start, c->irq,
+		 (c->baseclk + 500000) / 1000000);
+
+	master->bus_num = dev->id;
+	master->setup = txx9spi_setup;
+	master->transfer = txx9spi_transfer;
+	master->cleanup = txx9spi_cleanup;
+
+	ret = spi_register_master(master);
+	if (ret)
+		goto wq_and_exit;
+	return 0;
+ wq_and_exit:
+	destroy_workqueue(c->workqueue);
+ irq_and_exit:
+	free_irq(c->irq, c);
+ res_and_exit:
+	if (c->mapped)
+		iounmap(c->membase);
+ put_and_exit:
+	platform_set_drvdata(dev, NULL);
+	spi_master_put(master);
+	return ret;
+}
+
+static int __exit txx9spi_remove(struct platform_device *dev)
+{
+	struct spi_master *master = spi_master_get(platform_get_drvdata(dev));
+	struct txx9spi *c = spi_master_get_devdata(master);
+
+	spi_unregister_master(master);
+	platform_set_drvdata(dev, NULL);
+	destroy_workqueue(c->workqueue);
+	free_irq(c->irq, c);
+	if (c->mapped)
+		iounmap(c->membase);
+	spi_master_put(master);
+	return 0;
+}
+
+static struct platform_driver txx9spi_driver = {
+	.probe = txx9spi_probe,
+	.remove = __exit_p(txx9spi_remove),
+	.driver = {
+		.name = "txx9spi",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init txx9spi_init(void)
+{
+	return platform_driver_register(&txx9spi_driver);
+}
+subsys_initcall(txx9spi_init);
+
+static void __exit txx9spi_exit(void)
+{
+	platform_driver_unregister(&txx9spi_driver);
+}
+module_exit(txx9spi_exit);
+
+MODULE_DESCRIPTION("TXx9 SPI Driver");
+MODULE_LICENSE("GPL");



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
