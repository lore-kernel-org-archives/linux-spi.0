From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: spi-pic32: Add PIC32 SPI master driver
Date: Tue, 2 Feb 2016 12:13:42 +0000
Message-ID: <20160202121342.GN4455@sirena.org.uk>
References: <1454366701-10847-1-git-send-email-joshua.henderson@microchip.com>
 <1454366701-10847-2-git-send-email-joshua.henderson@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bPrm2PuLP7ysUh6c"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
	Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joshua Henderson <joshua.henderson-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1454366701-10847-2-git-send-email-joshua.henderson-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--bPrm2PuLP7ysUh6c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 01, 2016 at 03:44:57PM -0700, Joshua Henderson wrote:

> The PIC32 SPI driver is capable of performing SPI transfers either using
> polling or based on interrupt-trigger. GPIO based CS support (necessary
> for correct SPI operation) is available. It is dependent on availability
> of "cs-gpios" property of spi node in board dts file.

There's quite a lot of issues here.  At a high level the big issues are
with duplicating core functionality, a large number of helper functions
that don't seem to add much and some interesting locking.  There's also
no DT binding documentation which is mandatory for new bindings.

> +config SPI_PIC32
> +	tristate "Microchip PIC32 series SPI"
> +	depends on MACH_PIC32
> +	help
> +	  SPI driver for PIC32 SPI master controller.
> +
> +
>  #
>  # Add new SPI master controllers in alphabetical order above this line
>  #

Note the comment here (yes, there are some things out of order but
that's no reason to add more).  Please also add an || COMPILE_TEST
unless there's an actual build time dependency.

> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 8991ffc..bb37fed 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -94,3 +94,4 @@ obj-$(CONFIG_SPI_XILINX)		+= spi-xilinx.o
>  obj-$(CONFIG_SPI_XLP)			+= spi-xlp.o
>  obj-$(CONFIG_SPI_XTENSA_XTFPGA)		+= spi-xtensa-xtfpga.o
>  obj-$(CONFIG_SPI_ZYNQMP_GQSPI)		+= spi-zynqmp-gqspi.o
> +obj-$(CONFIG_SPI_PIC32)			+= spi-pic32.o

Similarly here where things are better sorted already.

> +/*
> + * PIC32 SPI core controller driver (refer dw_spi.c)

What should we refer to dw_spi.c for?  If this is a Designware IP you
should share the same driver.

> +static inline void spi_disable_chip(struct pic32_spi *pic32s)
> +{
> +	writel(SPICON_ON, pic32s->regs + SPICON_CLR);
> +	cpu_relax();
> +}

What is the cpu_relax() intended to do here?

> +static inline void spi_set_clk_mode(struct pic32_spi *pic32s, int mode)
> +{
> +	u32 conset = 0, conclr = 0;
> +
> +	/* active low */
> +	if (mode & SPI_CPOL)
> +		conset |= SPICON_CKP;
> +	else
> +		conclr |= SPICON_CKP;
> +
> +	/* tx on rising edge of clk */
> +	if (mode & SPI_CPHA)
> +		conclr |= SPICON_CKE;
> +	else
> +		conset |= SPICON_CKE;
> +
> +	/* rx at end of tx */
> +	conset |= SPICON_SMP;
> +
> +	writel(conclr, pic32s->regs + SPICON_CLR);
> +	writel(conset, pic32s->regs + SPICON_SET);
> +}

This is large for an inline function and only has one caller anyway.
Why not just include it in that user?

> +static inline void spi_drain_rx_buf(struct pic32_spi *pic32s)
> +{
> +	u32 sr;
> +
> +	/* drain rx bytes until empty */
> +	for (;;) {
> +		sr = readl(pic32s->regs + SPISTAT);
> +		if (sr & STAT_RF_EMPTY)
> +			break;
> +
> +		(void)readl(pic32s->regs + SPIBUF);

Why do you need this cast to void?

> +	}

A busy waiting loop like this is more where I'd expect to see a
cpu_relax().  I'd also expect to see some kind of timeout here,
otherwise if something goes wrong we could lock up.

> +static inline void spi_set_clk_rate(struct pic32_spi *pic32s, u32 sck)

Essentially all the functions in this file appear to be marked as
inline.  Don't do this unless the function really *needs* to be inline,
just let the compiler inline it if it figures out that it's a good idea.

> +static inline void spi_set_ss_auto(struct pic32_spi *pic32s, u8 mst, u32 mode)
> +{
> +	u32 v;
> +
> +	/* spi controller can drive CS/SS during transfer depending on fifo
> +	 * fill-level. SS will stay asserted as long as TX fifo has something
> +	 * to transfer, else will be deasserted confirming completion of
> +	 * the ongoing transfer.
> +	 */
> +
> +	v = readl(pic32s->regs + SPICON);
> +	v &= ~SPICON_MSSEN;
> +	if (mst) {
> +		v |= SPICON_MSSEN;
> +		if (mode & SPI_CS_HIGH)
> +			v |= SPICON_FRMPOL;
> +		else
> +			v &= ~SPICON_FRMPOL;
> +	}
> +
> +	writel(v, pic32s->regs + SPICON);
> +}

I don't really know what the above is suposed to do just from looking at
it.  If it's enabling automatic /CS managment that doesn't sound like
something we can actually use in Linux based on the comment.

> +static inline void spi_set_err_int(struct pic32_spi *pic32s)
> +{
> +	u32 mask;
> +
> +	mask = SPI_INT_TX_UR_EN | SPI_INT_RX_OV_EN | SPI_INT_FRM_ERR_EN;
> +	writel(mask, pic32s->regs + SPICON2_SET);
> +}

There is no need for this to be a function - there is one caller and
it contains only a single function.  Just inline it and add a comment if
there is a need for documentation.  This applies to quite a lot of the
functions in this file, they are very small and have only one user so
mostly just make the code less direct.  Using spi_ as the prefix also
has a namespacing issue, that's the namespace for the core.

> +	pic32s->mesg->state = (void *)-1;

This is trying to munge a numeric return code into a pointer without
using PTR_ERR() and friends which is ugly and fragile.  If you really
need to do this use the standard macros, but since we already have an
error code in the message you can use that (though it seems nothing
actually ever reads these...).  You should also use real error codes not
magic numbers.

> +	complete(&pic32s->xfer_done);
> +
> +	disable_irq_nosync(pic32s->fault_irq);
> +	disable_irq_nosync(pic32s->rx_irq);
> +	disable_irq_nosync(pic32s->tx_irq);

This is racy, you are completing the transfer then disabling the
interrupts.  Something could come along and try and do another transfer
before the interrupts are disabled.

> +	if (!pic32s->mesg) {
> +		pic32_err_stop(pic32s, "err_irq: mesg error");
> +		goto irq_handled;
> +	}

There's nothing in this case that checks that the interrupt actually
fired.

> +	/* tx complete? mask and disable tx interrupt */
> +	if (pic32s->tx_end == pic32s->tx)
> +		disable_irq_nosync(pic32s->tx_irq);

It seems there's no interrupt masking in the actual IP and the
interrupts will scream when the IP is idle?

> +static inline void pic32_spi_cs_assert(struct pic32_spi *pic32s)
> +{
> +	int cs_high;
> +	struct spi_device *spi_dev = pic32s->spi_dev;
> +
> +	if (pic32s->flags & SPI_SS_MASTER)
> +		return;
> +
> +	cs_high = pic32s->mode & SPI_CS_HIGH;
> +	gpio_set_value(spi_dev->cs_gpio, cs_high);
> +}

Don't open code GPIO chip selects, use the core support.

> +static void pic32_spi_dma_rx_notify(void *data)
> +{
> +	struct pic32_spi *pic32s = data;
> +
> +	spin_lock(&pic32s->lock);
> +	complete(&pic32s->xfer_done);
> +	spin_unlock(&pic32s->lock);
> +}

Taking the spinlock here looks completely pointless - what is it
intended to protect?

> +err_dma:
> +	pic32_spi_dma_abort(pic32s);
> +	return -ENOMEM;

-ENOMEM looks completely random here, please use a sensible error code
(if you got one back from another funtion pass it through).

> +static int pic32_spi_one_transfer(struct pic32_spi *pic32s,
> +				  struct spi_message *message,
> +				  struct spi_transfer *transfer)

> +	if (transfer->speed_hz && (transfer->speed_hz != pic32s->speed_hz)) {

Just use the transfer, the core will ensure that it is set.

> +	spin_lock_irqsave(&pic32s->lock, flags);
> +
> +	spi_enable_chip(pic32s);
> +
> +	/* polling mode? */
> +	if (pic32s->flags & SPI_XFER_POLL) {
> +		ret = pic32_spi_poll_transfer(pic32s, 2 * HZ);
> +		spin_unlock_irqrestore(&pic32s->lock, flags);
> +
> +		if (ret) {
> +			dev_err(&master->dev, "poll-xfer timedout\n");
> +			message->status = ret;
> +			goto err_xfer_done;
> +		}
> +		goto out_xfer_done;
> +	}
> +
> +	reinit_completion(&pic32s->xfer_done);
> +
> +	/* DMA mode ? */
> +	if (pic32_spi_dma_is_ready(pic32s)) {
> +		spin_unlock_irqrestore(&pic32s->lock, flags);
> +
> +		ret = pic32_spi_dma_transfer(pic32s, transfer);
> +		if (ret) {
> +			dev_err(&master->dev, "dma xfer error\n");
> +			message->status = ret;
> +			spin_lock_irqsave(&pic32s->lock, flags);
> +		} else {
> +			goto out_wait_for_xfer;
> +		}
> +	}
> +
> +	/* enable interrupt */
> +	enable_irq(pic32s->fault_irq);
> +	enable_irq(pic32s->tx_irq);
> +	enable_irq(pic32s->rx_irq);
> +
> +	spin_unlock_irqrestore(&pic32s->lock, flags);

This seems like a very large section of code to hold a spinlock for and
I'm not immediately seeing a reason why the locking has to be so
aggressive.  Among other things it's holding a spinlock with interrupts
disabled for up to two seconds over a polling transfer which is at best
needless.

> +static int pic32_spi_one_message(struct spi_master *master,
> +				 struct spi_message *msg)
> +{
> +	int ret = 0;
> +	int cs_active = 0;

Don't open code message parsing, use the core support and implement
transfer_one().

> +	clk_prepare_enable(pic32s->clk);

No error checking.  It'd also be better to have runtime power management
of this.

> +	if (dev->of_node) {

This has DT support but the DT binding is not documented.  Documentation
is mandatory for all new DT bindings.

> +		of_property_read_u32(dev->of_node,
> +				     "max-clock-frequency", &max_spi_rate);

This looks like it's duplicating something that should be in the clock
bindings.  As far as I can tell we never change the parent clock rate so
we can just look at that to identify the maximum clock rate.

> +		if (of_find_property(dev->of_node, "use-no-dma", NULL)) {
> +			dev_warn(dev, "DMA support not requested\n");
> +			pic32s->flags &= ~SPI_DMA_CAP;
> +		}

Why not just handle the DT binding information being missing?

--bPrm2PuLP7ysUh6c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWsJ12AAoJECTWi3JdVIfQslQH/iHeR5LrfgnNh0Ei/WbzSllU
TTmpMT/hUbfMvaqGnNelDxn/INWdUs8Hx7TRZs+Oa8IhS+Qo8srrIeFjt07hZy7D
butExMdlP51av3NblaMBr6ZqYd0lF6Gur8FFB1VptUI+hyZkzxex8gW3emthqT6d
YBKhVb5WxJWmKWZs5RSJ10LkG76i8x0WWGrfdRQJLEVCfgyyGLOGYGO7J9dsYrBd
g/lkxS3YZ8qLamrhaMIwhPQfzF2Bnq+2NwR5TSJDbhiL3MDBO62vhASnt7lIg7to
6bPB9NSDVkjvnFQJRnPTdbIgdFtpfw0SdB2ti8LHEc32Kzhn2PGlExnmxylconU=
=XUdy
-----END PGP SIGNATURE-----

--bPrm2PuLP7ysUh6c--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
