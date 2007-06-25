From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] TXx9 SPI controller driver
Date: Tue, 26 Jun 2007 01:12:37 +0900 (JST)
Message-ID: <20070626.011237.44099374.anemo@mba.ocn.ne.jp>
References: <20070622.232111.36926005.anemo@mba.ocn.ne.jp>
	<200706221103.19761.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org,
	sshtylyov@ru.mvista.com, mlachwani@mvista.com,
	spi-devel-general@lists.sourceforge.net
To: david-b@pacbell.net
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <200706221103.19761.david-b@pacbell.net>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-Id: linux-spi.vger.kernel.org

On Fri, 22 Jun 2007 11:03:18 -0700, David Brownell <david-b@pacbell.net> wrote:
> > +	/* calc real speed */
> > +	n = (c->baseclk + spi->max_speed_hz - 1) / spi->max_speed_hz;
> > +	if (n < 1)
> > +		n = 1;
> > +	else if (n > 0xff)
> > +		return -EINVAL;
> > +	spi->max_speed_hz = c->baseclk / n;
> 
> That's not right -- given the current API definitions.  The max_speed_hz
> value should be read-only to controller drivers.
> 
> On the other hand, I've also wondered how the actual rate should be
> reported to drivers, and that approach might be a reasonable solution
> to that problem.  Can you discuss this proposed change on the spi
> development list?

As for this driver, anyway I should move this calculation to the
transfer function to handle per-transfer speed_hz, so there is no
serious requirement to modify max_speed_hz here.

I agree reporting the actual speed to the protocol driver might be
useful, but I should think a bit more.

> > +static int txx9spi_work_one(struct txx9spi *c, struct spi_message *m)
> > +{
> > +	...
> > +	nsecs = 100 + 1000000000 / spi->max_speed_hz / 2;
> 
> ... which is why we can't just strike that line changing max_speed_hz.
> But please use only a single division in that expression, and explain
> what the value is used for.  (A good variable name would do wonders.
> Is this "nsecs per fortnight", or what?)
> 
> I suspect "nsecs" and the actual bitrate should probably be stored
> with the other spi->controller_state data.

These nsecs delays are all comes from spi_bitbang driver I referred
when writing this driver.  As you already found, this controller does
not have dedicated chipselect signals and generic GPIO is used for
them.  As the controller do nothing about CS, the driver should take
care of CS setup/hold/recovery time.

I will move these delays to cs_func() and add some comments.

> > +	list_for_each_entry (t, &m->transfers, transfer_list) {
> > +		const void *txbuf = t->tx_buf;
> > +		void *rxbuf = t->rx_buf;
> > +		u32 data;
> > +		unsigned int len = t->len;
> > +		unsigned int wsize = spi->bits_per_word >> 3; /* in bytes */
> 
> But on the other hand, here you're ignoring t->max_speed_hz as
> well as t->bits_per_word.  If you do that, you must check those
> values in txx9spi_transfer() and reject message which include
> transfers using those per-transfer overrides.
> 
> Given that this controller only seems to allow 8 or 16 bit
> transfers, you're going to need checks in the transfer() path
> even if you do support the per-transfer overrides someday.

Oh I had missed these per-transfer parameters.  I will add some
checking for them.

> > +		if ((!txbuf && !rxbuf && len) || (len & (wsize - 1))) {
> 
> That's confusing.  But it's also something that belongs with
> per-transfer checks -- doing it here is needlessly late.

Sure.  I will move it before actual transfer.

> > +				data = txbuf ? (wsize == 1 ?
> > +						*(const u8 *)txbuf :
> > +						*(const u16 *)txbuf) : 0;
> 
> Double "?:" expressions == confusing.  Please use at most one.

Will fix.

> > +	if (!(status == 0 && cs_change)) {
> > +		ndelay(nsecs);
> 
> Again:  if drivers need an extra delay, that's what delay_usec is for.
> 
> > +		txx9spi_cs_func(spi, 0);
> > +		ndelay(nsecs);
> 
> ... and I don't see why this delay is needed at all.  If your
> hardware needs extra delays around chipselect toggles, surely
> that should be built into your cs_func()?
> 
> But it looks to me like you have a bug here too.  You're trying
> to implement this behavioral hint, which is fine, but you're
> not recording that you did it.  So if the next message goes
> to a different chip, both chips will be selected at the same
> time -- right?  Bug... quickest for you to ignore this hint.

Oh it should be a bug.  I will fix by recording last chipselect.

> > +	if (res->start >= TXX9_DIRECTMAP_BASE)
> > +		c->membase = (void __iomem *)(unsigned long)(int)res->start;
> > +	else {
> > +		c->membase = ioremap(res->start, res->end - res->start + 1);
> > +		c->mapped = 1;
> > +	}
> 
> That looks plain wrong.  Maybe it reflects a platform-level bug,
> but ioremap(res->start) should Just Work even when it performs
> an identity mapping on a given system.  Remove this ugly code.
> Always map.

Yes this was a hack...  I will try to make MIPS ioremap() can handle
this special case.

> > +	c->baseclk = platform_get_irq_byname(dev, "baseclk");
> > +	if (c->baseclk < 0)
> > +		goto res_and_exit;
> 
> Yeech!!   If you're getting a clock, then clk_get(dev, "baseclk").
> That's very clearly not an IRQ.  If you need values that don't fit
> into the current resource framework, either extend that framework
> or use platform_data to pass the values.
> 
> In this case, extending the ioresource framework would be the wrong
> answer, since the clock framework is there to handle clocks.  If
> this platform doesn't support the clock framework, then you must
> use platform_data to pass such nonstandard clock data.

Another hack.  Good to know about the clock framework.  That's what
I wanted.  I will try to implement them for MIPS.

> > +	master->bus_num = dev->id;
> > +	master->setup = txx9spi_setup;
> > +	master->transfer = txx9spi_transfer;
> > +	master->cleanup = txx9spi_cleanup;
> 
> Something else that seems incorrect here is the lack of setup
> for master->num_chipselect.  It seems that you're using the
> spi->chip_select value as a GPIO number.  That's unusual, but
> not wrong.  Just set num_chipselect to the number of GPIOs on
> the platform.  Otherwise, just map from chipselect to GPIO
> like the other drivers do.  Such mappings fit naturally into
> platform_data.
> 
> The fact that this works at all is a temporary bug in the
> SPI core.

Yes, I'm using GPIO number as chipselect value.  This controller
itself does not have any constraint about chipselect, I wanted to set
num_chipselect as "unlimited".  Though providing max GPIO number or
mapping table might be safe, I think just using chipselect number for
GPIO as is would be simple and enough.  I will do explicitly
initialize num_chipselect as 0 and add a comment for it.


I will send an updated patch in a few days.  Thank you.
---
Atsushi Nemoto
