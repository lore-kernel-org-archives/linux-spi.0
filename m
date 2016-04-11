From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] spi: orion.c: Add direct access mode
Date: Mon, 11 Apr 2016 11:57:40 +0100
Message-ID: <20160411105740.GB3351@sirena.org.uk>
References: <1460030811-13787-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QTprm0S8XgL7H0Dt"
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1460030811-13787-1-git-send-email-sr-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--QTprm0S8XgL7H0Dt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 07, 2016 at 02:06:51PM +0200, Stefan Roese wrote:

> @@ -372,10 +383,44 @@ orion_spi_write_read(struct spi_device *spi, struct=
 spi_transfer *xfer)
>  {
>  	unsigned int count;
>  	int word_len;
> +	struct orion_spi *orion_spi;
> +	int cs =3D spi->chip_select;
> =20
>  	word_len =3D spi->bits_per_word;
>  	count =3D xfer->len;
> =20
> +	orion_spi =3D spi_master_get_devdata(spi->master);
> +
> +	/* Use SPI direct access mode if base address is available */
> +	if (orion_spi->direct_access[cs].vaddr) {
> +		struct orion_direct_acc *da =3D &orion_spi->direct_access[cs];
> +
> +		if (count > da->size) {
> +			dev_err(&spi->dev,
> +				"max transfer size exceeded (%d > %d)\n",
> +				count, da->size);
> +			return 0;
> +		}

This seems obviously broken, we're neither returning an error nor
falling back to PIO here but instead silently ignoring the transfer.  If
we can't fall back then I'd expect the driver to be setting
max_transfer_size but it isn't, it's probably a good idea from a
performance point of view to set it even if we can fall back.

> +		if (xfer->tx_buf) {
> +			/*
> +			 * Send the tx-data to the SPI device via the direct
> +			 * mapped address window
> +			 */
> +			memcpy(da->vaddr, xfer->tx_buf, count);
> +		}
> +
> +		if (xfer->rx_buf) {
> +			/*
> +			 * Read the rx-data from the SPI device via the direct
> +			 * mapped address window
> +			 */
> +			memcpy(xfer->rx_buf, da->vaddr, count);
> +		}

Do bidirectional transfers work properly with this method (how much
incoming data can we queue up, is there memory backing the whole
region?), and are we guaranteed that the transfer finished by the time
we return?  I'm also not seeing anything here that handles word size so
I suspect this will cause data corruption with anything other than 8 bit
words and the driver does support 16 bit with PIO.  If only 8 bit words
can be supported with direct access I'd expect to see the
bits_per_word_mask updated.

> +               spi->direct_access[cs].vaddr =3D devm_ioremap_resource(&p=
dev->dev,
> +                                                                    r);
> +               if (IS_ERR(spi->direct_access[cs].vaddr)) {
> +                       status =3D PTR_ERR(spi->direct_access[cs].vaddr);
> +                       goto out_rel_clk;
> +               }
> +
> +               spi->direct_access[cs].size =3D resource_size(r);
> +               dev_info(&pdev->dev, "CS%d configured for direct access\n=
", cs);
> +       }

I seem to be missing where we configure the hardware to connect the
windows to the chip selects.  We just seem to map the windows but never
otherwise interact with the hardware.

--QTprm0S8XgL7H0Dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXC4MjAAoJECTWi3JdVIfQZTUH/0dMKdJb7F60Gq4hLzztfre2
moiO6wD1WPP/WEfhpAsWJWhebTGNcI+X6ACeekoDKXZilARJUS3YRQrrelThgZcP
w+qj1E8KMZ64jTpcYr78TU5SQQN1Eq8VfYEv7SqEnwU8dfy2/yFShjIRUJwvocAA
BcOGUUFze6tbbzHTP1jTCxj1FxnLP0KzrTpyeN/IKsq6PKpU+7UP4nQmpuPVf3/M
yuDqftr11Q/iM/8dblsz2AOTV3EmKe7WB1fA7dZQdla4IMB4PfE3XtKeL1b470mW
BSKspRyyc31DIbq6Ha3JBOSbIY91gWU1RZJTdF1cLWn33zauCo2cy8o97fWqDds=
=PQ98
-----END PGP SIGNATURE-----

--QTprm0S8XgL7H0Dt--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
