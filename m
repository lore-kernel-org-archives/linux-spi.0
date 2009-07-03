From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] Freescale STMP spi driver, revised
Date: Fri, 3 Jul 2009 00:02:06 -0700
Message-ID: <200907030002.06725.david-b@pacbell.net>
References: <1243971638.4011.16.camel@hp.diimka.lan>
	<20090603042746.GB8721@tarshish>
	<1244045746.4074.5.camel@hp.diimka.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: dpervushin-L1vi/lXTdtvkgf6YlCu6wwC/G2K4zDHf@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1244045746.4074.5.camel-GL0tbJR47UuzLY3athcO2A@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wednesday 03 June 2009, dmitry pervushin wrote:

> +#define busy_wait(cond)						\
> +	({							\
> +	  int count;						\
> +	  for (count = 1000; (cond) && count > 0; count--)	\

Where does the "1000" come from?

> +		  cpu_relax();					\
> +	  (count);						\
> +	})


> +static int stmp_spi_setup_transfer(struct spi_device *spi,
> +		struct spi_transfer *t)
> +{
> +	u8 bits_per_word;
> +	u32 hz;
> +	struct stmp_spi *ss = spi_master_get_devdata(spi->master);
> +	u16 rate;
> +
> +	bits_per_word = spi->bits_per_word;
> +	if (t && t->bits_per_word)
> +		bits_per_word = t->bits_per_word;
> +
> +	/*
> +	  Calculate speed:
> +		- by default, use maximum speed from ssp clk
> +		- if device overrides it, use it
> +		- if transfer specifies other speed, use transfer's one
> +	 */
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
> +	dev_dbg(&spi->dev, "Requested clk rate = %uHz, max = %uHz/%d = %uHz\n",
> +		hz, ss->speed_khz, ss->divider,
> +		ss->speed_khz * 1000 / ss->divider);
> +
> +	if (ss->speed_khz * 1000 / ss->divider < hz) {
> +		dev_err(&spi->dev, "%s, unsupported clock rate %uHz\n",
> +			__func__, hz);
> +		return -EINVAL;
> +	}
> +
> +	rate = 1000 * ss->speed_khz/ss->divider/hz;
> +
> +	writel(BF(ss->divider, SSP_TIMING_CLOCK_DIVIDE)		|
> +	       BF(rate - 1, SSP_TIMING_CLOCK_RATE),
> +	       HW_SSP_TIMING + ss->regs);
> +
> +	writel(BF(1 /* mode SPI */, SSP_CTRL1_SSP_MODE)		|
> +	       BF(4 /* 8 bits   */, SSP_CTRL1_WORD_LENGTH)	|
> +	       ((spi->mode & SPI_CPOL) ? BM_SSP_CTRL1_POLARITY : 0) |
> +	       ((spi->mode & SPI_CPHA) ? BM_SSP_CTRL1_PHASE : 0) |
> +	       (pio ? 0 : BM_SSP_CTRL1_DMA_ENABLE),
> +	       ss->regs + HW_SSP_CTRL1);

That's kind of long to be doing before each spi_transfer.

You might make your main loop only call that when it knows
the current settings are wrong ... e.g. on the first pass
through the handle_message() loop, and when there are some
per-transfer-overrides to apply/remove.

(That's *only* a performance issue, not a correctness one.)
It will be pretty visible with small transfers.)

> +
> +	return 0;
> +}



> +static int stmp_spi_handle_message(struct stmp_spi *ss, struct spi_message *m)
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
> +		stmp_spi_setup_transfer(m->spi, t);
> +
> +		if (&t->transfer_list == m->transfers.next)
> +			first = !0;
> +		if (&t->transfer_list == m->transfers.prev)
> +			last = !0;
> +		if (t->rx_buf && t->tx_buf) {
> +			pr_debug("%s: cannot send and receive simultaneously\n",
> +				__func__);

In that case add SPI_MASTER_HALF_DUPLEX to spi_master.flags in
your probe() routine.  Given a patch I sent out earlier today,
you will be able to remove this test from this critical path.


> +			return -EINVAL;
> +		}
> +
> +		/*
> +		  REVISIT:
> +		  here driver completely ignores setting of t->cs_change

Yeah, please fix that.  Minimally, by rejecting submission of
messages where it's set anywhere except in the final transfer.


> +		 */
> +		if (t->tx_buf) {
> +			status = pio ?
> +			   stmp_spi_txrx_pio(ss, cs, (void *)t->tx_buf,
> +				   t->len, &first, &last, 1) :
> +			   stmp_spi_txrx_dma(ss, cs, (void *)t->tx_buf,
> +				   t->tx_dma, t->len, &first, &last, 1);

Rather than "1", or "0" below, please change to "bool" param
and use "true" and "false".  It's still a bit ugly though.


> +			if (debug) {

This debug stuff really ought to be compiled out of the
driver if DEBUG is not set.


> +				if (t->len < 0x10)
> +					print_hex_dump_bytes("Tx ",
> +						DUMP_PREFIX_OFFSET,
> +						t->tx_buf, t->len);
> +				else
> +					pr_debug("Tx: %d bytes\n", t->len);
> +			}
> +		}


> +/**
> + * stmp_spi_handle - handle messages from the queue
> + */
> +static void stmp_spi_handle(struct work_struct *w)
> +{
> +	struct stmp_spi *ss = container_of(w, struct stmp_spi, work);
> +	unsigned long flags;
> +	struct spi_message *m;
> +
> +	BUG_ON(w == NULL);

Strike this BUG_ON(can't happen) ...


> +
> +	spin_lock_irqsave(&ss->lock, flags);
> +	while (!list_empty(&ss->queue)) {
> +		m = list_entry(ss->queue.next, struct spi_message, queue);
> +		list_del_init(&m->queue);
> +		spin_unlock_irqrestore(&ss->lock, flags);
> +
> +		m->status = stmp_spi_handle_message(ss, m);
> +		if (m->complete)

And don't bother checking m->complete either; it's required.


> +			m->complete(m->context);
> +
> +		spin_lock_irqsave(&ss->lock, flags);
> +	}
> +	spin_unlock_irqrestore(&ss->lock, flags);
> +
> +	return;
> +}

> +static irqreturn_t stmp_spi_irq_err(int irq, void *dev_id)
> +{
> +	struct stmp_spi *ss = dev_id;
> +	u32 c1, st;
> +
> +	c1 = readl(ss->regs + HW_SSP_CTRL1);
> +	st = readl(ss->regs + HW_SSP_STATUS);
> +	printk(KERN_ERR"IRQ - ERROR!, status = 0x%08X, c1 = 0x%08X\n", st, c1);

Make it a dev_err().


> +	stmp3xxx_clearl(c1 & 0xCCCC0000, ss->regs + HW_SSP_CTRL1);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int __devinit stmp_spi_probe(struct platform_device *dev)
> +{
> +	int err = 0;
> +	struct spi_master *master;
> +	struct stmp_spi *ss;
> +	struct resource *r;
> +
> +	/* Get resources(memory, IRQ) associated with the device */

That's not what spi_alloc_master() does ... this comment needs
to be re-located.  :)

> +	master = spi_alloc_master(&dev->dev, sizeof(struct stmp_spi));
> +
> +	if (master == NULL) {
> +		err = -ENOMEM;
> +		goto out0;
> +	}
> +
> +	ss = spi_master_get_devdata(master);
> +	platform_set_drvdata(dev, master);
> +
> +	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
> +	if (r == NULL) {
> +		err = -ENODEV;
> +		goto out_put_master;
> +	}
> +	ss->regs = ioremap(r->start, resource_size(r));
> +	if (!ss->regs) {
> +		err = -EINVAL;
> +		goto out_put_master;
> +	}
> +
> +	ss->master_dev = &dev->dev;
> +	ss->id = dev->id;
> +
> +	INIT_WORK(&ss->work, stmp_spi_handle);
> +	INIT_LIST_HEAD(&ss->queue);
> +	spin_lock_init(&ss->lock);
> +
> +	ss->workqueue = create_singlethread_workqueue(dev_name(&dev->dev));
> +	if (!ss->workqueue) {
> +		err = -ENXIO;
> +		goto out_put_master;
> +	}
> +	master->transfer = stmp_spi_transfer;
> +	master->setup = stmp_spi_setup;
> +
> +
> +	ss->irq = platform_get_irq(dev, 0);
> +	if (ss->irq < 0) {
> +		err = -ENXIO;
> +		goto out_put_master;
> +	}
> +
> +	r = platform_get_resource(dev, IORESOURCE_DMA, 0);
> +	if (r == NULL) {
> +		err = -ENODEV;
> +		goto out_put_master;
> +	}
> +
> +	ss->dma = r->start;
> +	err = stmp3xxx_dma_request(ss->dma, &dev->dev, dev_name(&dev->dev));
> +	if (err)
> +		goto out_put_master;
> +
> +	err = stmp3xxx_dma_allocate_command(ss->dma, &ss->d);
> +	if (err)
> +		goto out_free_dma;
> +
> +	master->bus_num = dev->id;
> +	master->num_chipselect = 1;
> +
> +	/* SPI controller initializations */
> +	err = stmp_spi_init_hw(ss);
> +	if (err) {
> +		dev_dbg(&dev->dev, "cannot initialize hardware\n");
> +		goto out_free_dma_desc;
> +	}
> +
> +	if (clock) {
> +		dev_info(&dev->dev, "clock rate forced to %d\n", clock);
> +		clk_set_rate(ss->clk, clock);
> +	}
> +	ss->speed_khz = clk_get_rate(ss->clk);
> +	ss->divider = 2;
> +	dev_info(&dev->dev, "max possible speed %d = %ld/%d kHz\n",
> +		ss->speed_khz, clk_get_rate(ss->clk), ss->divider);
> +
> +	/* Register for SPI interrupt */
> +	err = request_irq(ss->irq, stmp_spi_irq, 0,
> +			  dev_name(&dev->dev), ss);
> +	if (err) {
> +		dev_dbg(&dev->dev, "request_irq failed, %d\n", err);
> +		goto out_release_hw;
> +	}
> +
> +	/* ..and shared interrupt for all SSP controllers */
> +	err = request_irq(IRQ_SSP_ERROR, stmp_spi_irq_err, IRQF_SHARED,

This should use a value from the platform resources, not a
constant IRQ_SSP_ERROR (which might change on other silicon).


> +			  dev_name(&dev->dev), ss);
> +	if (err) {
> +		dev_dbg(&dev->dev, "request_irq(error) failed, %d\n", err);
> +		goto out_free_irq;
> +	}


------------------------------------------------------------------------------
