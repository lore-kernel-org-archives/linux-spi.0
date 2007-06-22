From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] TXx9 SPI controller driver
Date: Fri, 22 Jun 2007 11:03:18 -0700
Message-ID: <200706221103.19761.david-b@pacbell.net>
References: <20070622.232111.36926005.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: sshtylyov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
	mlachwani-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org
To: Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070622.232111.36926005.anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>
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

On Friday 22 June 2007, Atsushi Nemoto wrote:
> This is a driver for SPI controller built into TXx9 MIPS SoCs.

Looks mostly pretty good.  I made a few minor changes/cleanups
in the appended version, notably:
 - checking for spi->mode bits this code doesn't understand;
 - updating to match latest patches;

Note that if gpio_set_value() needs an mmiowb(), that seems like
a bug in this platform's  GPIO code; other platforms don't require
I/O barriers after GPIO calls.  Comments?

Also:

> +	/* calc real speed */
> +	n = (c->baseclk + spi->max_speed_hz - 1) / spi->max_speed_hz;
> +	if (n < 1)
> +		n = 1;
> +	else if (n > 0xff)
> +		return -EINVAL;
> +	spi->max_speed_hz = c->baseclk / n;

That's not right -- given the current API definitions.  The max_speed_hz
value should be read-only to controller drivers.

On the other hand, I've also wondered how the actual rate should be
reported to drivers, and that approach might be a reasonable solution
to that problem.  Can you discuss this proposed change on the spi
development list?



> +static int txx9spi_work_one(struct txx9spi *c, struct spi_message *m)
> +{
> +	...
> +	nsecs = 100 + 1000000000 / spi->max_speed_hz / 2;

... which is why we can't just strike that line changing max_speed_hz.
But please use only a single division in that expression, and explain
what the value is used for.  (A good variable name would do wonders.
Is this "nsecs per fortnight", or what?)

I suspect "nsecs" and the actual bitrate should probably be stored
with the other spi->controller_state data.


> +	list_for_each_entry (t, &m->transfers, transfer_list) {
> +		const void *txbuf = t->tx_buf;
> +		void *rxbuf = t->rx_buf;
> +		u32 data;
> +		unsigned int len = t->len;
> +		unsigned int wsize = spi->bits_per_word >> 3; /* in bytes */

But on the other hand, here you're ignoring t->max_speed_hz as
well as t->bits_per_word.  If you do that, you must check those
values in txx9spi_transfer() and reject message which include
transfers using those per-transfer overrides.

Given that this controller only seems to allow 8 or 16 bit
transfers, you're going to need checks in the transfer() path
even if you do support the per-transfer overrides someday.


> +		if ((!txbuf && !rxbuf && len) || (len & (wsize - 1))) {

That's confusing.  But it's also something that belongs with
per-transfer checks -- doing it here is needlessly late.


> +			status = -EINVAL;
> +			break;
> +		}
> +		if (cs_change) {
> +			txx9spi_cs_func(spi, 1);
> +			ndelay(nsecs);

Since cs_change is initialized to one, you're always delaying
after chipselect.  Now, it happens to be true that with CPOL=0
there must be a half clock delay between setting the MOSI value
and starting the first clock.  And maybe adding an extra delay
isn't harmful if CPOL=1.  But again -- comment please.  Say why
this is done in software when one would think the hardware would
do such things automatically.  There's a chip erratum??


> +		}
> +		cs_change = t->cs_change;
> +		while (len) {
> +			unsigned int count = SPI_FIFO_SIZE;
> +			int i;
> +			u32 cr0;
> +			if (len < count * wsize)
> +				count = len / wsize;
> +			/* now tx must be idle... */
> +			while (!(txx9spi_rd(c, TXx9_SPSR) & TXx9_SPSR_SIDLE))
> +				;
> +			cr0 = txx9spi_rd(c, TXx9_SPCR0);
> +			cr0 &= ~TXx9_SPCR0_RXIFL_MASK;
> +			cr0 |= (count - 1) << 12;
> +			/* enable rx intr */
> +			cr0 |= TXx9_SPCR0_RBSIE;
> +			txx9spi_wr(c, cr0, TXx9_SPCR0);
> +			/* send */
> +			for (i = 0; i < count; i++) {
> +				data = txbuf ? (wsize == 1 ?
> +						*(const u8 *)txbuf :
> +						*(const u16 *)txbuf) : 0;

Double "?:" expressions == confusing.  Please use at most one.

> +				txx9spi_wr(c, data, TXx9_SPDR);
> +				if (txbuf)
> +					txbuf += wsize;
> +			}
> +			/* wait all rx data */
> +			wait_event(c->waitq,
> +				   txx9spi_rd(c, TXx9_SPSR) & TXx9_SPSR_RBSI);
> +			/* receive */
> +			for (i = 0; i < count; i++) {
> +				data = txx9spi_rd(c, TXx9_SPDR);
> +				if (rxbuf) {
> +					if (wsize == 1)
> +						*(u8 *)rxbuf = data;
> +					else
> +						*(u16 *)rxbuf = data;
> +					rxbuf += wsize;
> +				}
> +			}
> +			len -= count * wsize;
> +		}
> +		m->actual_length += t->len;
> +		if (t->delay_usecs)
> +			udelay(t->delay_usecs);
> +
> +		if (!cs_change)
> +			continue;
> +		if (t->transfer_list.next == &m->transfers)
> +			break;
> +		/* sometimes a short mid-message deselect of the chip
> +		 * may be needed to terminate a mode or command
> +		 */

Admittedly the length of the deselect isn't specified, but this
looks goofy.  Just deselect immediately, and let driver use the
delay_usecs value if they need more.  Then if you want to stay
deselected for at least one full clock then try

	ndelay(min(2*nsec, 1000))

to more closely match other drivers' usage of udelay(1) here.


> +		ndelay(nsecs);
> +		txx9spi_cs_func(spi, 0);
> +		ndelay(nsecs);
> +	}
> +
> +	m->status = status;
> +	m->complete(m->context);
> +
> +	/* normally deactivate chipselect ... unless no error and
> +	 * cs_change has hinted that the next message will probably
> +	 * be for this chip too.
> +	 */
> +	if (!(status == 0 && cs_change)) {
> +		ndelay(nsecs);

Again:  if drivers need an extra delay, that's what delay_usec is for.

> +		txx9spi_cs_func(spi, 0);
> +		ndelay(nsecs);

... and I don't see why this delay is needed at all.  If your
hardware needs extra delays around chipselect toggles, surely
that should be built into your cs_func()?

But it looks to me like you have a bug here too.  You're trying
to implement this behavioral hint, which is fine, but you're
not recording that you did it.  So if the next message goes
to a different chip, both chips will be selected at the same
time -- right?  Bug... quickest for you to ignore this hint.


> +	}
> +
> +	/* enter config mode */
> +	txx9spi_wr(c, mcr | TXx9_SPMCR_CONFIG | TXx9_SPMCR_BCLR, TXx9_SPMCR);
> +	return status;
> +}
> +


> +
> +static int __init txx9spi_probe(struct platform_device *dev)
> +{
> +	struct spi_master *master;
> +	struct txx9spi *c;
> +	struct resource *res;
> +	int ret = -ENODEV;
> +	u32 mcr;
> +
> +	master = spi_alloc_master(&dev->dev, sizeof(*c));
> +	if (!master)
> +		return ret;
> +	c = spi_master_get_devdata(master);
> +	platform_set_drvdata(dev, master);
> +
> +	INIT_WORK(&c->work, txx9spi_work);
> +	spin_lock_init(&c->lock);
> +	INIT_LIST_HEAD(&c->queue);
> +	init_waitqueue_head(&c->waitq);
> +
> +	res = platform_get_resource(dev, IORESOURCE_MEM, 0);
> +	if (!res)
> +		goto put_and_exit;
> +	if (res->start >= TXX9_DIRECTMAP_BASE)
> +		c->membase = (void __iomem *)(unsigned long)(int)res->start;
> +	else {
> +		c->membase = ioremap(res->start, res->end - res->start + 1);
> +		c->mapped = 1;
> +	}

That looks plain wrong.  Maybe it reflects a platform-level bug,
but ioremap(res->start) should Just Work even when it performs
an identity mapping on a given system.  Remove this ugly code.
Always map.


> +
> +	/* enter config mode */
> +	mcr = txx9spi_rd(c, TXx9_SPMCR);
> +	mcr &= ~(TXx9_SPMCR_OPMODE | TXx9_SPMCR_SPSTP | TXx9_SPMCR_BCLR);
> +	txx9spi_wr(c, mcr | TXx9_SPMCR_CONFIG | TXx9_SPMCR_BCLR, TXx9_SPMCR);
> +
> +	c->irq = platform_get_irq(dev, 0);
> +	if (c->irq < 0)
> +		goto res_and_exit;
> +	c->baseclk = platform_get_irq_byname(dev, "baseclk");
> +	if (c->baseclk < 0)
> +		goto res_and_exit;

Yeech!!   If you're getting a clock, then clk_get(dev, "baseclk").
That's very clearly not an IRQ.  If you need values that don't fit
into the current resource framework, either extend that framework
or use platform_data to pass the values.

In this case, extending the ioresource framework would be the wrong
answer, since the clock framework is there to handle clocks.  If
this platform doesn't support the clock framework, then you must
use platform_data to pass such nonstandard clock data.



> +	ret = request_irq(c->irq, txx9spi_interrupt, 0, dev->name, c);
> +	if (ret)
> +		goto res_and_exit;
> +
> +	c->workqueue = create_singlethread_workqueue(master->cdev.dev->bus_id);
> +	if (!c->workqueue)
> +		goto irq_and_exit;
> +
> +	dev_info(&dev->dev, "at 0x%llx, irq %d, %dMHz\n",
> +		 (unsigned long long)res->start, c->irq,
> +		 (c->baseclk + 500000) / 1000000);
> +
> +	master->bus_num = dev->id;
> +	master->setup = txx9spi_setup;
> +	master->transfer = txx9spi_transfer;
> +	master->cleanup = txx9spi_cleanup;

Something else that seems incorrect here is the lack of setup
for master->num_chipselect.  It seems that you're using the
spi->chip_select value as a GPIO number.  That's unusual, but
not wrong.  Just set num_chipselect to the number of GPIOs on
the platform.  Otherwise, just map from chipselect to GPIO
like the other drivers do.  Such mappings fit naturally into
platform_data.

The fact that this works at all is a temporary bug in the
SPI core.

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
