From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: Add initial support for spi-mxs
Date: Fri, 20 Apr 2012 12:12:08 +0800
Message-ID: <20120420041153.GJ22219@S2101-09.ap.freescale.net>
References: <1334795434-8780-1-git-send-email-festevam@gmail.com>
	<1334795434-8780-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, snijsure-4jo+YWezP1RWk0Htik3J/w@public.gmane.org,
	marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1334795434-8780-2-git-send-email-festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Apr 18, 2012 at 09:30:34PM -0300, Fabio Estevam wrote:
...
>  #define HW_SSP_VERSION				(cpu_is_mx23() ? 0x110 : 0x130)

This is something needs a bit work (as well as mxs-mmc).  The VERSION
register sits on different address between imx23 and imx28, so it loses
its point.

The cpu_is_xxx stuff does not scale for long term and will not cope
with device tree support.  We really need to get rid of it.

> +/*
> + * Freescale MXS SPI master driver
> + *
> + * Heavily based on spi-stmp.c, which is:
> + * Author: dmitry pervushin <dimka-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org>
> + *
> + * Copyright 2012 Freescale Semiconductor, Inc.
> + * Copyright 2008 Embedded Alley Solutions, Inc All Rights Reserved.
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
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/spi/spi.h>
> +#include <linux/err.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
> +#include <linux/dma-mapping.h>

What's this for?

> +#include <linux/errno.h>
> +#include <linux/delay.h>
> +#include <mach/mxs.h>

When you get rid of the using of cpu_is_xxx, the inclusion can be
removed.

> +#include <mach/ssp-regs.h>
> +#include <mach/common.h>

With Wolfram's stmp-style devices support merged, you can save this
inclusion.

> +
> +#define SSP_TIMEOUT		200	/* 200 ms */
> +
> +#define rev_struct		(ss->version)
> +
What's this for?

> +struct mxs_spi {
> +	void __iomem *regs;	/* vaddr of the control registers */
> +
> +	u32 speed_khz;
> +	u32 divider;
> +
> +	struct clk *clk;
> +	struct device *master_dev;
> +
> +	struct work_struct work;
> +	struct workqueue_struct *workqueue;
> +	spinlock_t lock;
> +	struct list_head queue;
> +
> +	u32 version;
> +};
> +
> +static int mxs_spi_setup_transfer(struct spi_device *spi,
> +				  struct spi_transfer *t)
> +{
> +	u8 bits_per_word;
> +	u32 hz;
> +	struct mxs_spi *ss;
> +	u16 rate;
> +
> +	ss = spi_master_get_devdata(spi->master);
> +
> +	bits_per_word = spi->bits_per_word;
> +	if (t && t->bits_per_word)
> +		bits_per_word = t->bits_per_word;
> +/*
> + * Calculate speed:
> + * - by default, use maximum speed from ssp clk
> + * - if device overrides it, use it
> + * - if transfer specifies other speed, use transfer's one
> + */

Indent is missed.

> +	hz = 1000 * ss->speed_khz / ss->divider;
> +	if (spi->max_speed_hz)
> +		hz = min(hz, spi->max_speed_hz);
> +	if (t && t->speed_hz)
> +		hz = min(hz, t->speed_hz);
> +
> +	if (hz == 0) {
> +		dev_err(&spi->dev, "Cannot continue with zero clock\n");
> +		return -EINVAL;
> +	}
> +
> +	if (bits_per_word != 8) {
> +		dev_err(&spi->dev, "%s, unsupported bits_per_word=%d\n",
> +			__func__, bits_per_word);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(&spi->dev, "Requested clk rate = %uHz, max = %ukHz/%d = %uHz\n",
> +		hz, ss->speed_khz, ss->divider,
> +		ss->speed_khz * 1000 / ss->divider);
> +
> +	if (ss->speed_khz * 1000 / ss->divider < hz) {
> +		dev_err(&spi->dev, "%s, unsupported clock rate %uHz\n",
> +			__func__, hz);
> +		return -EINVAL;
> +	}
> +
> +	rate = 1000 * ss->speed_khz / ss->divider / hz;
> +
> +	__raw_writel(BF_SSP_TIMING_CLOCK_DIVIDE(ss->divider) |
> +		     BF_SSP_TIMING_CLOCK_RATE(rate - 1),
> +		     ss->regs + HW_SSP_TIMING);
> +

writel or writel_relaxed?

> +	__raw_writel(BF_SSP_CTRL1_SSP_MODE(BV_SSP_CTRL1_SSP_MODE__SPI) |
> +		     BF_SSP_CTRL1_WORD_LENGTH
> +		     (BV_SSP_CTRL1_WORD_LENGTH__EIGHT_BITS) |
> +		     ((spi->mode & SPI_CPOL) ? BM_SSP_CTRL1_POLARITY : 0) |
> +		     ((spi->mode & SPI_CPHA) ? BM_SSP_CTRL1_PHASE : 0),
> +		     ss->regs + HW_SSP_CTRL1);
> +
> +	__raw_writel(0x0, ss->regs + HW_SSP_CMD0_SET);
> +
> +	return 0;
> +}
> +
> +static void mxs_spi_cleanup(struct spi_device *spi)
> +{
> +	return;
> +}
> +
> +/* the spi->mode bits understood by this driver: */
> +#define MODEBITS (SPI_CPOL | SPI_CPHA)
> +static int mxs_spi_setup(struct spi_device *spi)
> +{
> +	struct mxs_spi *ss;
> +	int err = 0;
> +
> +	ss = spi_master_get_devdata(spi->master);
> +
> +	if (!spi->bits_per_word)
> +		spi->bits_per_word = 8;
> +
> +	if (spi->mode & ~MODEBITS)
> +		return -EINVAL;
> +
> +	err = mxs_spi_setup_transfer(spi, NULL);
> +	if (err)
> +		dev_err(&spi->dev, "Failed to setup transfer: %d\n", err);
> +
> +	return err;
> +}
> +
> +static inline u32 mxs_spi_cs(unsigned cs)
> +{
> +	return ((cs & 1) ? BM_SSP_CTRL0_WAIT_FOR_CMD : 0) |
> +	    ((cs & 2) ? BM_SSP_CTRL0_WAIT_FOR_IRQ : 0);
> +}
> +
> +static inline void mxs_spi_enable(struct mxs_spi *ss)
> +{
> +	__raw_writel(BM_SSP_CTRL0_LOCK_CS, ss->regs + HW_SSP_CTRL0_SET);
> +	__raw_writel(BM_SSP_CTRL0_IGNORE_CRC, ss->regs + HW_SSP_CTRL0_CLR);
> +}
> +
> +static inline void mxs_spi_disable(struct mxs_spi *ss)
> +{
> +	__raw_writel(BM_SSP_CTRL0_LOCK_CS, ss->regs + HW_SSP_CTRL0_CLR);
> +	__raw_writel(BM_SSP_CTRL0_IGNORE_CRC, ss->regs + HW_SSP_CTRL0_SET);
> +}
> +
> +int mxs_ssp_wait_set(struct mxs_spi *ss, int offset, int mask)

static?

> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(SSP_TIMEOUT);
> +
> +	while (!(readl_relaxed(&ss->regs + offset) & mask)) {
> +		udelay(1);
> +		if (time_after(jiffies, timeout))
> +			return -ETIMEDOUT;
> +	}
> +	return 0;
> +}
> +
> +int mxs_ssp_wait_clr(struct mxs_spi *ss, int offset, int mask)

ditto

> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(SSP_TIMEOUT);
> +
> +	while ((readl_relaxed(&ss->regs + offset) & mask)) {
> +		udelay(1);
> +		if (time_after(jiffies, timeout))
> +			return -ETIMEDOUT;
> +	}
> +	return 0;
> +}
> +
> +static int mxs_spi_txrx_pio(struct mxs_spi *ss, int cs,
> +			    unsigned char *buf, int len,
> +			    int *first, int *last, int write)
> +{
> +	if (*first) {
> +		mxs_spi_enable(ss);
> +		*first = 0;
> +	}
> +
> +	__raw_writel(mxs_spi_cs(cs), ss->regs + HW_SSP_CTRL0_SET);
> +
> +	while (len--) {
> +		if (*last && len == 0) {
> +			mxs_spi_disable(ss);
> +			*last = 0;
> +		}
> +
> +		if (ss->version > 3) {
> +			__raw_writel(1, ss->regs + HW_SSP_XFER_SIZE);
> +		} else {
> +			__raw_writel(BM_SSP_CTRL0_XFER_COUNT,
> +				     ss->regs + HW_SSP_CTRL0_CLR);
> +			__raw_writel(1, ss->regs + HW_SSP_CTRL0_SET);
> +		}
> +
> +		if (write)
> +			__raw_writel(BM_SSP_CTRL0_READ,
> +				     ss->regs + HW_SSP_CTRL0_CLR);
> +		else
> +			__raw_writel(BM_SSP_CTRL0_READ,
> +				     ss->regs + HW_SSP_CTRL0_SET);
> +
> +		 /* Activate Run bit */
> +		__raw_writel(BM_SSP_CTRL0_RUN, ss->regs + HW_SSP_CTRL0_SET);
> +
> +
> +		if (mxs_ssp_wait_set(ss->regs, HW_SSP_CTRL0, BM_SSP_CTRL0_RUN))
> +			return -ETIMEDOUT;

It should return what mxs_ssp_wait_set() returns.

> +
> +		if (write)
> +			__raw_writel(*buf, ss->regs + HW_SSP_DATA);
> +
> +		/* Set TRANSFER */
> +		__raw_writel(BM_SSP_CTRL0_DATA_XFER,
> +			     ss->regs + HW_SSP_CTRL0_SET);
> +
> +		if (!write) {
> +			if (mxs_ssp_wait_clr(ss->regs, HW_SSP_STATUS,
> +						BM_SSP_STATUS_FIFO_EMPTY))
> +				return -ETIMEDOUT;
> +
> +			*buf = (__raw_readl(ss->regs + HW_SSP_DATA) & 0xFF);
> +		}
> +
> +		if (mxs_ssp_wait_clr(ss->regs, HW_SSP_CTRL0, BM_SSP_CTRL0_RUN))
> +			return -ETIMEDOUT;
> +		/* advance to the next byte */
> +		buf++;
> +	}
> +	return len < 0 ? 0 : -ETIMEDOUT;
> +}
> +
> +static int mxs_spi_handle_message(struct mxs_spi *ss, struct spi_message *m)
> +{
> +	int first, last;
> +	struct spi_transfer *t, *tmp_t;
> +	int status = 0;
> +	int cs;
> +
> +	first = last = 0;
> +
> +	cs = m->spi->chip_select;
> +
> +	list_for_each_entry_safe(t, tmp_t, &m->transfers, transfer_list) {
> +
> +		mxs_spi_setup_transfer(m->spi, t);
> +
> +		if (&t->transfer_list == m->transfers.next)
> +			first = !0;

Use bool for first and last?

> +		if (&t->transfer_list == m->transfers.prev)
> +			last = !0;
> +		if (t->rx_buf && t->tx_buf) {
> +			pr_debug("%s: cannot send and receive simultaneously\n",
> +				 __func__);

Manage to use dev_dbg?

> +			return -EINVAL;
> +		}
> +		/*
> +		 *  REVISIT:
> +		 *  here driver completely ignores setting of t->cs_change
> +		 */
> +		if (t->tx_buf)
> +			status = mxs_spi_txrx_pio(ss, cs, (void *)t->tx_buf,

Why the cast?

> +					     t->len, &first, &last, 1);
> +		if (t->rx_buf)
> +			status = mxs_spi_txrx_pio(ss, cs, t->rx_buf,
> +					     t->len, &first, &last, 0);
> +		m->actual_length += t->len;
> +		if (status)
> +			break;
> +
> +		first = last = 0;
> +	}
> +	return status;
> +}
> +
> +/*
> + * mxs_spi_handle
> + *
> + * The workhorse of the driver - it handles messages from the list
> + */
> +static void mxs_spi_handle(struct work_struct *w)
> +{
> +	struct mxs_spi *ss = container_of(w, struct mxs_spi, work);
> +	unsigned long flags;
> +	struct spi_message *m;
> +
> +	BUG_ON(w == NULL);
> +
> +	spin_lock_irqsave(&ss->lock, flags);
> +	while (!list_empty(&ss->queue)) {
> +		m = list_entry(ss->queue.next, struct spi_message, queue);
> +		list_del_init(&m->queue);
> +		spin_unlock_irqrestore(&ss->lock, flags);
> +
> +		m->status = mxs_spi_handle_message(ss, m);
> +		if (m->complete)
> +			m->complete(m->context);
> +
> +		spin_lock_irqsave(&ss->lock, flags);
> +	}
> +	spin_unlock_irqrestore(&ss->lock, flags);
> +
> +	return;
> +}
> +
> +/*
> + * mxs_spi_transfer
> + *
> + * Called indirectly from spi_async, queues all the messages to
> + * spi_handle_message
> + *
> + */
> +static int mxs_spi_transfer(struct spi_device *spi, struct spi_message *m)
> +{
> +	struct mxs_spi *ss = spi_master_get_devdata(spi->master);
> +	unsigned long flags;
> +
> +	m->actual_length = 0;
> +	m->status = -EINPROGRESS;
> +	spin_lock_irqsave(&ss->lock, flags);
> +	list_add_tail(&m->queue, &ss->queue);
> +	queue_work(ss->workqueue, &ss->work);
> +	spin_unlock_irqrestore(&ss->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int __devinit mxs_spi_probe(struct platform_device *dev)

We usually name it pdev.

> +{
> +	int ret;
> +	struct spi_master *master;
> +	struct mxs_spi *ss;
> +	struct resource *res;
> +
> +	master = spi_alloc_master(&dev->dev, sizeof(struct mxs_spi));

sizeof(*ss)

> +	ss = spi_master_get_devdata(master);
> +	ss->master_dev = &dev->dev;
> +
> +	if (!master)
> +		return -ENOMEM;
> +
Shouldn't the check be put right after spi_alloc_master call?

> +	platform_set_drvdata(dev, master);
> +
> +	INIT_WORK(&ss->work, mxs_spi_handle);
> +	INIT_LIST_HEAD(&ss->queue);
> +	spin_lock_init(&ss->lock);
> +	ss->workqueue = create_singlethread_workqueue(dev_name(&dev->dev));
...
> +	master->transfer = mxs_spi_transfer;
> +	master->setup = mxs_spi_setup;
> +	master->cleanup = mxs_spi_cleanup;
> +	master->mode_bits = MODEBITS;
> +
It makes more sense to move this new line to above.

> +	master->bus_num = dev->id;
> +	master->num_chipselect = 1;
> +
> +	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		return -ENOENT;
> +
We do not have to check that.  We can pass whatever we get from
platform_get_resource into devm_request_and_ioremap, and the latter
will do sanity check.

> +	ss->regs = devm_request_and_ioremap(&dev->dev, res);
> +	if (!ss->regs)
> +		return -EBUSY;
The kernel doc of devm_request_and_ioremap suggests -EADDRNOTAVAIL.
> +
> +	mxs_reset_block(ss->regs);
> +	ss->clk = clk_get(&dev->dev, NULL);
> +	if (IS_ERR(ss->clk)) {
> +		ret = PTR_ERR(ss->clk);
> +		dev_err(&dev->dev, "cannot get spi clk\n");

Put ret into the message?

> +		goto out_put_master;
> +	}
> +
> +	clk_prepare_enable(ss->clk);
> +
> +	ss->speed_khz = clk_get_rate(ss->clk) / 1000;
> +	ss->divider = 2;
> +	dev_dbg(&dev->dev, "Max possible speed %d = %ld/%d kHz\n",
> +		 ss->speed_khz, clk_get_rate(ss->clk), ss->divider);
> +
> +	ss->version = __raw_readl(ss->regs + HW_SSP_VERSION) >> 24;
> +
> +	ret = spi_register_master(master);
> +	if (ret) {
> +		dev_err(&dev->dev, "cannot register spi master, %d\n", ret);
> +		goto out_clk_put;
> +	}
> +
> +	dev_info(&dev->dev, "driver probed\n");
> +
> +	return 0;
> +
> +out_clk_put:
> +	clk_disable_unprepare(ss->clk);
> +	clk_put(ss->clk);
> +out_put_master:
> +	spi_master_put(master);
> +	if (ss->workqueue)
> +		destroy_workqueue(ss->workqueue);
> +	platform_set_drvdata(dev, NULL);

I'm wondering if this is really needed.

> +
> +	return ret;
> +}
> +
> +static int __devexit mxs_spi_remove(struct platform_device *dev)
> +{
> +	struct mxs_spi *ss;
> +	struct spi_master *master;
> +
> +	master = platform_get_drvdata(dev);
> +	if (!master)
> +		goto out0;

Will we ever run into this error?

> +	ss = spi_master_get_devdata(master);
> +
> +	clk_disable_unprepare(ss->clk);
> +	clk_put(ss->clk);
> +	spi_unregister_master(master);
> +
> +	destroy_workqueue(ss->workqueue);
> +	spi_master_put(master);
> +	platform_set_drvdata(dev, NULL);
> +out0:
> +	return 0;
> +}
> +
> +static struct platform_driver mxs_spi_driver = {
> +	.probe = mxs_spi_probe,
> +	.remove = __devexit_p(mxs_spi_remove),
> +	.driver = {
> +		   .name = "mxs-spi",
> +		   .owner = THIS_MODULE,
> +		   },

Strange indent.

Regards,
Shawn

> +};
> +module_platform_driver(mxs_spi_driver);
> +
> +MODULE_AUTHOR("dmitry pervushin <dimka-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org>");
> +MODULE_AUTHOR("Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org");
> +MODULE_DESCRIPTION("MXS SPI master driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:mxs-spi");
> -- 
> 1.7.1
> 

------------------------------------------------------------------------------
For Developers, A Lot Can Happen In A Second.
Boundary is the first to Know...and Tell You.
Monitor Your Applications in Ultra-Fine Resolution. Try it FREE!
http://p.sf.net/sfu/Boundary-d2dvs2
