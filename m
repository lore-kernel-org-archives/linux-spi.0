From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 2/2] spi: spi-pic32: Add PIC32 SPI master driver
Date: Mon, 28 Mar 2016 12:26:29 -0700
Message-ID: <20160328192629.GG2350@sirena.org.uk>
References: <1458740576-9168-1-git-send-email-purna.mandal@microchip.com>
 <1458740576-9168-2-git-send-email-purna.mandal@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lHGcFxmlz1yfXmOs"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>,
	Joshua Henderson <digitalpeer-icZdIMMiY0PM6KjX8ROVJw@public.gmane.org>
To: Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1458740576-9168-2-git-send-email-purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--lHGcFxmlz1yfXmOs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 23, 2016 at 07:12:56PM +0530, Purna Chandra Mandal wrote:

> +	switch (bits_per_word) {
> +	default:
> +	case 8:

Are you sure that all bits per word settings other than those explicitly
supported should be handled in exactly the same fashion as 8 bits per
word?  That doesn't seem entirely expected.  I'd expect the default to
be to return an error.

> +static int pic32_spi_prepare_message(struct spi_master *master,
> +				     struct spi_message *msg)
> +{
> +	struct spi_device *spi = msg->spi;
> +	struct spi_transfer *xfer;
> +	struct pic32_spi *pic32s;
> +
> +	pic32s = spi_master_get_devdata(master);
> +
> +	pic32s->mesg = msg;
> +	pic32_spi_disable_chip(pic32s);
> +
> +	if (!pic32_spi_debug)
> +		return 0;

This appears to be some half implemented debugging code which is never
enabled, please remove it.

> +	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> +		dev_dbg(&spi->dev, "  xfer %p: len %u tx %p rx %p\n",
> +			xfer, xfer->len, xfer->tx_buf, xfer->rx_buf);
> +		print_hex_dump(KERN_DEBUG, "tx_buf ",
> +			       DUMP_PREFIX_ADDRESS,
> +			       16, 1, xfer->tx_buf,
> +			       min_t(u32, xfer->len, 16), 1);
> +	}

Similarly here, the core already has extensive trace stuff in it which
you can use.

> +	/* transact by DMA mode */
> +	if (transfer->rx_sg.nents && transfer->tx_sg.nents) {
> +		ret = pic32_spi_dma_transfer(pic32s, transfer);
> +		if (ret) {
> +			dev_err(&spi->dev, "dma submit error\n");
> +			return ret;
> +		}
> +
> +		/* DMA issued, wait for completion */
> +		set_bit(PIC32F_DMA_ISSUED, &pic32s->flags);
> +		goto out_wait_for_xfer;
> +	}

...

> +
> +out_wait_for_xfer:

Please write normal code with an if/else rather than using gotos, it's a
lot easier to follow.

> +	pic32s = spi_master_get_devdata(master);
> +
> +	pic32_spi_disable_chip(pic32s);

Do we really need tod isable the hardware after every single message?
It's normally more efficient to just leave the hardware powered until it
goes idle and unprepare_transfer_hardware() is called.

> +	/* SPI master supports only one spi-device at a time.
> +	 * So multiple spi_setup() to different devices is not allowed.
> +	 */
> +	if (unlikely(pic32s->spi_dev && (pic32s->spi_dev != spi))) {

unlikely() is for fast paths, outside of them it's just noise.

> +	/* But spi_setup() can be called multiple times by same device.
> +	 * In that case stop current on-going transaction and release
> +	 * resource(s).
> +	 */
> +	if (pic32s->spi_dev == spi)
> +		pic32_spi_cleanup(spi);

This is broken, it will break in progress transfers.  setup() shouldn't
be doing anything that disrupts them, anything that can't be run when
other transfers are in progress needs to be deferred till we actually do
the transfers (or done earlier in probe).

--lHGcFxmlz1yfXmOs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW+YVjAAoJECTWi3JdVIfQYJ4H/1uJ0+/wU6wEUlByE/uWaPud
MUo40m63f1Qs8Idu0WtQn6U30AECZpk8qRGJ7Hy9ZKgwtsXB1LPTSwUsBh3kKuVV
Fs3TIdwtPiTvCP3+mH5F/mO5H4y0aoKSRl3wQZRWt2fw3O4Z71HP9GknyPUnzEmg
rSqURBXbOFSEj4Kbvyb2CNv37kRYepU2LMrFv49V3oDq2MkDGKDi4SnNl0Dck49S
Z4TBQ388plWqpBly/x2tL0Q6EeuCc/2Ztn9PjHmB13WEp/q2HpESEnNy8++MKhmI
Hba7N7lC8jCnYXhLV7w3/WiaOOYfZV+1+T/nQfhWd4qYz0nmY8/RBAhv6tLo4wM=
=/AvX
-----END PGP SIGNATURE-----

--lHGcFxmlz1yfXmOs--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
