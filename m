From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: bcm-mspi: Add support for Broadcom MSPI driver.
Date: Tue, 12 May 2015 20:17:18 +0100
Message-ID: <20150512191718.GW3066@sirena.org.uk>
References: <1431452293-16697-1-git-send-email-jonathar@broadcom.com>
 <1431452293-16697-3-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aXNiKu4lnbRqA5kZ"
Cc: Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431452293-16697-3-git-send-email-jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--aXNiKu4lnbRqA5kZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 12, 2015 at 10:38:13AM -0700, Jonathan Richardson wrote:

> +	/* Wait for interrupt indicating transfer is complete. */
> +	if (!wait_for_completion_timeout(&mspi->xfer_done,
> +		msecs_to_jiffies(10))) {

What if we have a large transfer on a slow bus?

> +	while (bytes_processed < transfer->len) {

> +		/* Start transfer and wait until complete. */
> +		err = bcm_mspi_start_transfer(mspi, !last_slot, slot);
> +		if (err)
> +			return err;

This isn't really start_transfer() is it?  It's doing the entire
operation.

> +		/* Delay requested amount before next transfer. */
> +		udelay(transfer->delay_usecs);
> +	}

This is buggy, it's applying the per-transfer delay every timme we fill
the FIFO.

> +	/* The rx data will go into RXRAM0/1 + last tx length. */
> +	if (slot + 1 >= NUM_SLOTS)
> +		mspi->rx_slot = 0;
> +	else
> +		mspi->rx_slot = slot + 1;

How is this going to work for full duplex transfers if we had to fill
the FIFO more than once?

> +static int bcm_mspi_transfer_one(struct spi_master *master,
> +	struct spi_device *spidev, struct spi_transfer *transfer)
> +{
> +	int err;
> +
> +	/* 8 bit transfers only are currently supported. */
> +	if (transfer->bits_per_word > 8)
> +		return -ENOTSUPP;

Tell the core what the device supports and it will check for you.

> +
> +	err = bcm_mspi_tx_data(master, spidev, transfer);
> +	if (err)
> +		return err;
> +
> +	err = bcm_mspi_rx_data(master, spidev, transfer);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}

I would expect the recieve and transmit operations to be running in
parallel, not executed one after another, given the need to keep
manually filling and draining the FIFOs.

> +	struct spi_master *master;
> +	struct device *dev = &pdev->dev;
> +	int err;
> +	struct resource *res;
> +	unsigned int irq;
> +
> +	dev_info(dev, "Initializing BCM MSPI\n");

Don't spam the logs like this, there's no content in this message.

> +	master = spi_alloc_master(dev, sizeof(*data));
> +	if (!master) {

devm_spi_alloc_master().

> +	/* Map base memory address. */
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	data->base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(data->base)) {
> +		dev_err(&pdev->dev, "unable to map base address\n");

devm_ioremap_resource() will complain for you.

--aXNiKu4lnbRqA5kZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUlG+AAoJECTWi3JdVIfQcfAH/31CJDZtGYr/iXyEKOTtt7oV
UCr8DyxtC71Mo3dJ+8qwQkiAs+3XxJ95WfbS2K46tGTn1LKBpWSWKJaRirJcrMK1
WTR7uevPAlJm6qM8/rcrTFrE+mt2kOnbJ4oGKX9kj2z9CcwEfyY+oFY2I75rn2q2
2ovTRhZyhmd2Hs9Jk0L4W61gYJZlM3T8OEUXnwuBd6u0LxYeVgxSjN7evbQi4O0d
EeFXfibv2KU8ktfMiuV53u10/LVjXipkGFhrlKzC/hnTpvSOREnPpA5zhgTSGUIt
cps1htq19/T49fJlEVGwFBr7nER0LcKchgfrlJZmdd0bS2hcLkA1wOSu8aJxMcY=
=Huax
-----END PGP SIGNATURE-----

--aXNiKu4lnbRqA5kZ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
