From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH, V4, 2/5] spi: bcm-qspi: Add SPI flash and MSPI driver
Date: Wed, 22 Jun 2016 17:07:26 +0100
Message-ID: <20160622160726.GQ28202@sirena.org.uk>
References: <1466197433-11290-1-git-send-email-kdasu.kdev@gmail.com>
 <1466197433-11290-2-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jsrFa/5v3cIbBmG8"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	Yendapally Reddy Dhananjaya Reddy
	<yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1466197433-11290-2-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--jsrFa/5v3cIbBmG8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 17, 2016 at 05:03:50PM -0400, Kamal Dasu wrote:
> Adding unified SPI flash and MSPI driver for Broadcom
> BRCMSTB, NS2, NSP SoCs. Driver shall work with
> brcm,7120-l2-intc or brcm-l2-intc or with a single
> muxed L1 interrupt source. Driver implements the
> transfer_one() method for standard spi transfers and
> supports spi_flash_read so that the SoC controller can
> provide faster accelerated reads.

> +#define STATE_IDLE				0
> +#define STATE_RUNNING				1
> +#define STATE_SHUTDOWN				2

There's a lot of defines with very generic names that look like they
should be namespaced.

> +#define DWORD_ALIGNED(a)			IS_ALIGNED((uintptr_t)(a), 4)
> +#define ADDR_TO_4MBYTE_SEGMENT(addr)		(((u32)(addr)) >> 22)

This just doesn't belong in a driver, there's nothing driver specific
about it.  It should go in a generic header if it's useful.

> +	/*
> +	 * MIPS endianness is configured by boot strap, which also reverses all
> +	 * bus endianness (i.e., big-endian CPU + big endian bus ==> native
> +	 * endian I/O).
> +	 *
> +	 * Other architectures (e.g., ARM) either do not support big endian, or
> +	 * else leave I/O in little endian mode.
> +	 */
> +	if (IS_ENABLED(CONFIG_MIPS) && IS_ENABLED(CONFIG_CPU_BIG_ENDIAN))
> +		return ioread32be(qspi->base[type] + offset);
> +	else
> +		return readl_relaxed(qspi->base[type] + offset);

Just put this in the DT like we do for other MIPS IPs.

> +/* Interrupt helpers when not using brcm intc driver */
> +static void bcm_qspi_enable_interrupt(struct bcm_qspi *qspi, u32 mask)
> +{
> +	unsigned int val;
> +
> +	if (qspi->hif_spi_mode) {
> +		bcm_qspi_write(qspi, INTR, HIF_SPI_INTR2_CPU_MASK_CLEAR, mask);
> +	} else {
> +		val = bcm_qspi_read(qspi, INTR, 0);
> +		val = val | (mask << INTR_BASE_BIT_SHIFT);
> +		bcm_qspi_write(qspi, INTR, 0, val);
> +	}
> +}

All this interrupt code and especially the fact that it's a completely
separate register range in the binding looks very much like it's just
an interrupt controller IP that's not particularly anything to do with
the SPI controller and should therefore be in a separate driver.  Why is
this part of the SPI controller driver?

> +static int bcm_qspi_bspi_set_override(struct bcm_qspi *qspi, int width,
> +				      int addrlen, int hp)
> +{
> +	u32 data = bcm_qspi_read(qspi, BSPI, BSPI_STRAP_OVERRIDE_CTRL);
> +
> +	pr_debug("set override mode w %x addrlen %x hp %d\n",
> +		 width, addrlen, hp);

dev_dbg().  If you've got a device prints should use it, it makes
reading logs vastly easier.

> +	switch (width) {
> +	case SPI_NBITS_QUAD:
> +		/* clear dual mode and set quad mode */
> +		data &= ~BSPI_STRAP_OVERRIDE_CTRL_DATA_DUAL;
> +		data |= BSPI_STRAP_OVERRIDE_CTRL_DATA_QUAD;
> +		break;
> +	case SPI_NBITS_DUAL:
> +		/* clear quad mode set dual mode */
> +		data &= ~BSPI_STRAP_OVERRIDE_CTRL_DATA_QUAD;
> +		data |= BSPI_STRAP_OVERRIDE_CTRL_DATA_DUAL;
> +		break;
> +	case SPI_NBITS_SINGLE:
> +		/* clear quad/dual mode */
> +		data &= ~(BSPI_STRAP_OVERRIDE_CTRL_DATA_QUAD |
> +			  BSPI_STRAP_OVERRIDE_CTRL_DATA_DUAL);
> +		break;
> +	default:
> +		break;
> +	}

We just ignore other widths?

> +static void bcm_qspi_enable_bspi(struct bcm_qspi *qspi)
> +{
> +
> +	if ((!qspi->base[BSPI]) || (qspi->bspi_enabled))
> +		return;

Why would it be OK to call this if we don't have BSPI?

> +	xp->mode = spi->mode;
> +	xp->bits_per_word = spi->bits_per_word ? spi->bits_per_word : 8;

Write normal if statements for legibility please.

> +/* MSPI helpers */
> +
> +/* stop at end of transfer, no other reason */
> +#define FNB_BREAK_NONE			0
> +/* stop at end of spi_message */
> +#define FNB_BREAK_EOM			1
> +/* stop at end of spi_transfer if delay */
> +#define FNB_BREAK_DELAY			2
> +/* stop at end of spi_transfer if cs_change */
> +#define FNB_BREAK_CS_CHANGE		4
> +/* stop if we run out of bytes */
> +#define FNB_BREAK_NO_BYTES		8
> +
> +/* events that make us stop filling TX slots */
> +#define FNB_BREAK_TX			(FNB_BREAK_EOM | FNB_BREAK_DELAY | \
> +					 FNB_BREAK_CS_CHANGE)
> +
> +/* events that make us deassert CS */
> +#define FNB_BREAK_DESELECT		(FNB_BREAK_EOM | FNB_BREAK_CS_CHANGE)

This block of defies is just randomly in the middle of the driver?

> +static int find_next_byte(struct bcm_qspi *qspi, struct position *p,
> +			  int flags)
> +{
> +	int ret = FNB_BREAK_NONE;

I'm unclear what this is intended to do, I suspect other readers might
be too.

> +static int bcm_qspi_flash_read(struct spi_device *spi,
> +			       struct spi_flash_read_message *msg)

There's a lot of flash code in the driver, it would make review a lot
easier to split this out into a followup patch so we have one patch with
the standard SPI controller and some more adding the flash acceleration.

> +static void bcm_qspi_trans_mode(struct bcm_qspi *qspi,
> +				struct spi_device *spi,
> +				struct spi_transfer *trans)

This still appears to be trying to parse the data in SPI transfers.
Please don't do this, remove this code in favour of using the
accelerated flash operations.

> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hif_mspi");
> +	if (!res)
> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						   "mspi");

Why support both names?

> +	if (res) {
> +		qspi->base[MSPI]  = devm_ioremap_resource(dev, res);
> +		if (IS_ERR(qspi->base[MSPI])) {
> +			ret = PTR_ERR(qspi->base[MSPI]);
> +			goto err2;
> +		}
> +	} else
> +		goto err2;

Coding style, { } on both sides of the if.

> +	if (!qspi->bspi_mode)
> +		master->bus_num += 1;

Why is the driver attempting to set a bus number manually?  The core
will assign bus numbers automatically and anything that relies on them
is going to be fragile.

> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cs_reg");
> +	if (res) {
> +		qspi->base[CHIP_SELECT]  = devm_ioremap_resource(dev, res);
> +		if (IS_ERR(qspi->base[CHIP_SELECT])) {
> +			ret = PTR_ERR(qspi->base[CHIP_SELECT]);
> +			goto err2;
> +		}
> +	}

As with the interrupt controller is this really part of the IP rather
than just a GPIO block?

> +	qspi->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(qspi->clk)) {
> +		dev_warn(dev, "unable to get clock, using defaults\n");
> +		qspi->clk = NULL;
> +	}

This is broken - it's just ignoring errors.  That's going to be broken
for probe deferral or any other case where a clock is specified but
fails to be found for some reason.  Given that this is a completely new
binding and it's trivial to specify fixed clocks I can see no reason why
we'd even want to support missing clocks, it's going to be much more
robust to just require that the DT specifies the clock.

> +	bcm_qspi_hw_init(qspi);
> +	init_completion(&qspi->mspi_done);
> +	init_completion(&qspi->bspi_done);

Can we have mspi and bspi simultaneously?

--jsrFa/5v3cIbBmG8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXare8AAoJECTWi3JdVIfQjQkH/icifZjLcLLTdRSPqzxeEEpu
hm1UNqVY9x8unRwDQPoatXCpqzD+lYwVFj/3nZQW/y1aIJ8lvNlgeJ4AH+1/+z0V
nvaM51ZDjSHrR4ivre4svZHaEOTDjcLAIznehNVB8qWbHDgK/GMDOS0e3GcCJCfw
h3Bn0sYCOBsbXhGREzgc4VBYHt3XZiogECZHa7PhTLFMcnZ10/Z5z2PzVl9aUa+h
7JB769pkE3EXJcwOiDkMb6NjzwqKAry5Kaw6BWVpW/hj/qgZf4tGMQ6znp88SqZd
oJ7Cwizc9IUFS5NFbKjI/B3k5ZOu6aiub8Qt52ZFhJMaZikaNQ7f8R8li5wboos=
=wWaW
-----END PGP SIGNATURE-----

--jsrFa/5v3cIbBmG8--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
