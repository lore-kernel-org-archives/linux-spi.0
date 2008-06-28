From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] spi: driver for Marvell Orion SPI
	controllers
Date: Fri, 27 Jun 2008 18:14:29 -0700
Message-ID: <200806271814.29246.david-b@pacbell.net>
References: <20080626183911.GC16994@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, nico-mo2vmkxb4K0@public.gmane.org
To: Lennert Buytenhek <buytenh-OLH4Qvv75CYX/NnBR394Jw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080626183911.GC16994-mfnYTeDhw6uOVk/H6u/4e9i2O/JbrIOy@public.gmane.org>
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

This has some deep assumptions that this controller only
ever has one chipselect.  Is that really not going to be
worked around by using GPIOs?  If so, color me surprised...

I'd encourage you to change the structure earlier, rather
than later, to make such (almost inevitable) tweaks easier.
Or at least, flag places you're assuming there can never
be more than one slave -- even possibly a copout comment up
at the top with a big "**WARNING** flag documenting that
little surprise.


On Thursday 26 June 2008, Lennert Buytenhek wrote:

> +#define SPI_REG(orion_spi, reg)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0(((u32)orion_spi->base) + (reg))

Inline functions please, not macros-with-unparenthesized-params.


> +static int orion_spi_set_transfer_size(struct orion_spi *orion_spi, int =
size)
> +{
> +	if (size =3D=3D 16) {
> +		orion_spi_setbits(orion_spi, ORION_SPI_IF_CONFIG_REG,
> +				  ORION_SPI_IF_8_16_BIT_MODE);
> +	} else if (size =3D=3D 8) {
> +		orion_spi_clrbits(orion_spi, ORION_SPI_IF_CONFIG_REG,
> +				  ORION_SPI_IF_8_16_BIT_MODE);
> +	} else {

... always writes register bank, except on error cases; OK, but
I would have filtered out the error cases from orion_spi_setup()
or orion_spi_transfer().  In fact I notice transfer() has such
a test but it just doesn't match this one!


> +		pr_debug("Bad bits per word value %d (only 8 or 16 are "
> +			 "allowed).\n", size);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +
> +static u8 prescale[] =3D { 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, =
28, 30 };

Should be const ... I suppose this generates better code than
the obvious "for" loop?


> +
> +static int orion_spi_baudrate_set(struct spi_device *spi, unsigned int r=
ate)
> +{
> +	u32 min_offset =3D 0xFFFFFFFF;
> +	u8 best_idx =3D 100;
> +	int i;
> +	u32 cpu_clk;
> +	u32 reg;
> +	struct orion_spi *orion_spi;
> +	struct orion_spi_info *spi_info;
> +
> +	...
> +
> +	if (best_idx > ARRAY_SIZE(prescale))
> +		return -EINVAL;
> +
> +	/* Convert the array index to SPI clock divisor value.	*/
> +	reg =3D readl(SPI_REG(orion_spi, ORION_SPI_IF_CONFIG_REG));
> +	reg =3D ((reg & ~ORION_SPI_CLK_PRESCALE_MASK) | (best_idx + 0x12));
> +	writel(reg, SPI_REG(orion_spi, ORION_SPI_IF_CONFIG_REG));

... always writes register bank, except on error cases ...

> +
> +	return 0;
> +}
> +
> +/*
> + * called only when no transfer is active to this device

I think you mean "any" device, in fact.  This one looks OK
at a first glance.


> + */
> +static int orion_spi_setup_transfer(struct spi_device *spi,
> +				    struct spi_transfer *t)
> +{
> +	...
> +}
> +


But *HERE* I see a bunch of issues, or at least things that
will break the first time someone tries to support a second
slave on this controller.

Remember that spi_setup(spi) may be called at any time "spi"
has no pending messages ... very much in particular, when
some other  device is active.

> +static int orion_spi_setup(struct spi_device *spi)
> +{
> +	struct orion_spi_state *spi_state;
> +	struct orion_spi *orion_spi;
> +	struct orion_spi_info *spi_info;
> +
> +	spi_state =3D spi->controller_state;
> +	orion_spi =3D spi_master_get_devdata(spi->master);
> +	spi_info =3D orion_spi->spi_info;
> +
> +	if (spi->bits_per_word =3D=3D 0) {
> +		spi->bits_per_word =3D ORION_SPI_DEF_BPW;
> +	} else if (spi->bits_per_word < 8 || spi->bits_per_word > 16) {
> +		dev_dbg(&spi->dev, "setup: unsupported %d bit words\n",
> +			spi->bits_per_word);
> +		return -EINVAL;
> +	}
> +
> +	if (orion_spi_set_transfer_size(orion_spi, spi->bits_per_word) !=3D 0)

OK, you may just have trashed transfers that are now taking
place at another wordsize to a different device...

> +		return -EINVAL;
> +
> +	if (!spi_state) {
> +		spi_state =3D kzalloc(sizeof(*spi_state), GFP_KERNEL);
> +		if (!spi_state)
> +			return -ENOMEM;
> +		spi->controller_state =3D spi_state;
> +	}
> +	spi_state->data_width =3D spi->bits_per_word;

You don't need to record bits-per-word; it's already held for
you in the spi_device.


> +
> +	dev_dbg(&spi->dev, "setup: Set MAX Speed to %d ", spi->max_speed_hz);
> +	if (orion_spi_baudrate_set(spi, spi->max_speed_hz) =3D=3D 0)

Here you may have just trashed transfers that are now taking
place at a different bitrate (say, slower) to a different device...

Looks to me like you should probably update spi_state so that
it holds the default register settings for that device ... or
maybe just have this code validate the settings.

Speaking of which ... what about the spi->mode bits?  This
driver totally ignores CPOL/CPHA (the four SPI modes), the
chipselect polarity, and so on.

At an *absolute minimum* it should verify that spi->mode is
the single valeu this evidently handles.  Notice how other
drivers handle this:  spi_setup() rejects calls when any of
the bits in spi->mode aren't understood by the driver.


> +		dev_dbg(&spi->dev, "OK");
> +	else
> +		dev_dbg(&spi->dev, "Failed");
> +
> +	return 0;
> +}
> +
> +static int orion_spi_transfer(struct spi_device *spi, struct spi_message=
 *m)
> +{
> +	struct orion_spi *orion_spi;
> +	unsigned long flags;
> +	struct spi_transfer *t;
> +
> +	m->actual_length =3D 0;
> +	m->status =3D 0;
> +
> +	/* reject invalid messages and transfers */
> +	if (list_empty(&m->transfers) || !m->complete)
> +		return -EINVAL;
> +
> +	list_for_each_entry(t, &m->transfers, transfer_list) {
> +		const void *tx_buf =3D t->tx_buf;
> +		void *rx_buf =3D t->rx_buf;
> +		unsigned len =3D t->len;
> +
> +		if (t->speed_hz > ORION_SPI_MAX_FREQ
> +				|| (len && !(rx_buf || tx_buf))
> +				|| (t->bits_per_word &&
> +					(t->bits_per_word < 8
> +					|| t->bits_per_word > 16))) {

See?  this requires bits-per-word between 8 and 16 bits, but the
other place insists 8 *or* 16 bits.


> +			dev_dbg(&spi->dev, "transfer: %d Hz, %d %s%s, %d bpw\n",
> +					t->speed_hz,
> +					len,
> +					tx_buf ? "tx" : "",
> +					rx_buf ? "rx" : "",
> +					t->bits_per_word);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	orion_spi =3D spi_master_get_devdata(spi->master);
> +
> +	spin_lock_irqsave(&orion_spi->lock, flags);
> +	list_add_tail(&m->queue, &orion_spi->msg_queue);
> +	queue_work(orion_spi_wq, &orion_spi->work);
> +	spin_unlock_irqrestore(&orion_spi->lock, flags);
> +
> +	return 0;
> +}
> +

> +static struct platform_driver orion_spi_driver =3D {
> +	.driver =3D {
> +		.name	=3D DRIVER_NAME,
> +		.owner	=3D THIS_MODULE,
> +	},
> +	.remove		=3D __exit_p(orion_spi_remove),

Good, I always like to see drivers do the right thing with respect
to runtime footprint shrinkage.  For platform drivers that's usually
what you did here:  __exit_p() for the remove function, and use
platform_driver_probe().

> +};
> +
> +static int __init orion_spi_init(void)
> +{
> +	orion_spi_wq =3D create_singlethread_workqueue(
> +				orion_spi_driver.driver.name);
> +	if (orion_spi_wq =3D=3D NULL)
> +		return -1;

This should probably be "return -ENOMEM;" ... never return "-1"
when the interface requires a negative errno.


> @@ -0,0 +1,17 @@
> +/*
> + * include/linux/spi/orion_spi.h
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#ifndef __LINUX_SPI_ORION_SPI_H
> +#define __LINUX_SPI_ORION_SPI_H
> +
> +struct orion_spi_info {

What's a "tclk"?  And why can't you just

	tclk =3D clk_get_rate(clk_get(NULL, "cpu"));

or whatever?  This looks likely to break whenever
anyone re-clocks a board.


> +	u32	tclk;
> +};
> +
> +
> +#endif
> =




-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
