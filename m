From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: Add driver for IMG SPFI controller
Date: Wed, 12 Nov 2014 22:07:40 +0000
Message-ID: <20141112220740.GR3815@sirena.org.uk>
References: <1415828274-24727-1-git-send-email-abrestic@chromium.org>
 <1415828274-24727-3-git-send-email-abrestic@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FDQDjY+0Qvff/AOF"
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	James Hartley <James.Hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>,
	Ezequiel Garcia <Ezequiel.Garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415828274-24727-3-git-send-email-abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--FDQDjY+0Qvff/AOF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Wed, Nov 12, 2014 at 01:37:54PM -0800, Andrew Bresticker wrote:
> Add support for the Synchronous Peripheral Flash Interface (SPFI) master
> controller found on IMG SoCs.  The SPFI controller supports 5 chip-select
> lines and single/dual/quad mode SPI transfers.

>  drivers/spi/spi-img.c | 703 ++++++++++++++++++++++++++++++++++++++++++++++++++

How about spi-img-spfi?  That way if someone makes another SPI
controller (say a more generic one, this one seems flash specialized)
there won't be a collision.

> +static void spfi_flush_tx_fifo(struct img_spfi *spfi)
> +{
> +	spfi_writel(spfi, SPFI_INTERRUPT_SDE, SPFI_INTERRUPT_CLEAR);
> +	while (!(spfi_readl(spfi, SPFI_INTERRUPT_STATUS) &
> +		 SPFI_INTERRUPT_SDE))
> +		cpu_relax();
> +}

This will busy loop for ever if we don't get the response we want from
the hardware...  some cap on the number of spins would be good.

> +	while ((tx_bytes > 0 || rx_bytes > 0) &&
> +	       time_before(jiffies, timeout)) {
> +		unsigned int tx_count, rx_count;
> +
> +		if (xfer->bits_per_word == 32) {
> +			tx_count = spfi_pio_write32(spfi, tx_buf, tx_bytes);
> +			rx_count = spfi_pio_read32(spfi, rx_buf, rx_bytes);
> +		} else {
> +			tx_count = spfi_pio_write8(spfi, tx_buf, tx_bytes);
> +			rx_count = spfi_pio_read8(spfi, rx_buf, rx_bytes);
> +		}

switch statement please (here and elsewhere).  Apart from the
defensivenes it means that we'll do the right thing if someone decides
to add 16 bit support to the hardware.

> +		tx_buf += tx_count;
> +		rx_buf += rx_count;
> +		tx_bytes -= tx_count;
> +		rx_bytes -= rx_count;

No errors possible?

> +
> +		cpu_relax();

Seems random - we already relax in the data transfer?

> +	if (tx_buf)
> +		spfi_flush_tx_fifo(spfi);
> +	spfi_disable(spfi);

What does the enable and disable actually do?  Should this be runtime
PM?

> +       if (xfer->tx_nbits == SPI_NBITS_DUAL ||
> +           xfer->rx_nbits == SPI_NBITS_DUAL)
> +               val |= SPFI_CONTROL_TMODE_DUAL << SPFI_CONTROL_TMODE_SHIFT;
> +       else if (xfer->tx_nbits == SPI_NBITS_QUAD ||
> +                xfer->rx_nbits == SPI_NBITS_QUAD)
> +               val |= SPFI_CONTROL_TMODE_QUAD << SPFI_CONTROL_TMODE_SHIFT;

This suggests that dual and quad mode must be symmetric but doesn't
enforce that; I rather suspect that in reality these modes are only
supported on the transmit side.

> +static irqreturn_t img_spfi_irq(int irq, void *dev_id)
> +{
> +	struct img_spfi *spfi = (struct img_spfi *)dev_id;
> +	u32 status;
> +
> +	status = spfi_readl(spfi, SPFI_INTERRUPT_STATUS);
> +	if (status & SPFI_INTERRUPT_IACCESS) {
> +		spfi_writel(spfi, SPFI_INTERRUPT_IACCESS, SPFI_INTERRUPT_CLEAR);
> +		dev_err(spfi->dev, "Illegal access interrupt");
> +	}
> +
> +	return IRQ_HANDLED;
> +}

This will unconditionally claim to have handled an interrupt even if it
didn't get any interrupt status it has ever heard of.  At the very least
it should log unknown interrupts, ideally return IRQ_NONE though since
it seems to be a clear on read interrupt that's a bit misleading.

> +	ret = clk_prepare_enable(spfi->sys_clk);
> +	if (ret)
> +		goto put_spi;
> +	ret = clk_prepare_enable(spfi->spfi_clk);
> +	if (ret)
> +		goto disable_pclk;

We should have runtime PM callbacks to enable these clocks only when the
controller is active, this will improve power consumption slightly - the
core can manage the runtime PM for you.

--FDQDjY+0Qvff/AOF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUY9orAAoJECTWi3JdVIfQYS8H/jdeXwjx+GfsYfxM/6C8gff3
aagwCKsZEa6E5pJOqB8HlCWDdnPdTPYfXRZvzGM/fDRB10q+FeOBqr1W7uYH02pb
XqArVXx9dVmpp7B74jeD1NUrGPvOnXtEGfXkJ4/xU4hFFRdNvIwk+eIJSpBUogDI
9cPf1yTnd7ztBqOqdtxOmf/v5KhWAS6bGCRaKjdV1Xp8ru5K4iSfLUCWFwWwz0zj
OnY3kNhtecV/tk7TSN3CwRlNRcNApwAZULi4SHr3Ku61zkGjHxKoVf3zg6Oi+WLM
sLH1u/cTrWpuic88V7KR5LAYgmgs5la5nrKrc4Hs3puE/GDxra6PgovUPK4Ewac=
=B3cU
-----END PGP SIGNATURE-----

--FDQDjY+0Qvff/AOF--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
