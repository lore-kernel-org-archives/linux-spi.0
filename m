From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/4] spi: mediatek: Add spi bus for Mediatek MT8173
Date: Fri, 24 Jul 2015 18:49:22 +0100
Message-ID: <20150724174922.GT11162@sirena.org.uk>
References: <1437642643-11966-1-git-send-email-leilk.liu@mediatek.com>
 <1437642643-11966-4-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fNOZNvBbfUx8KYZM"
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1437642643-11966-4-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--fNOZNvBbfUx8KYZM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2015 at 05:10:42PM +0800, Leilk Liu wrote:

This basically seems fine but there's a couple of issues that should be
relatively easy to fix:

> +	mdata->cur_transfer =3D xfer;
> +	mtk_spi_prepare_transfer(master, xfer);
> +	mtk_spi_setup_packet(master, xfer);
> +
> +	cnt =3D (xfer->len % 4) ? (xfer->len / 4 + 1) : (xfer->len / 4);

Please write this as an if statement for legibility.

> +static bool mtk_spi_can_dma(struct spi_master *master,
> +			    struct spi_device *spi,
> +			    struct spi_transfer *xfer)
> +{
> +	struct mtk_spi *mdata =3D spi_master_get_devdata(master);
> +
> +	if (xfer->len > MTK_SPI_MAX_FIFO_SIZE)
> +		mdata->use_dma =3D true;
> +	else
> +		mdata->use_dma =3D false;
> +
> +	return mdata->use_dma;
> +}

This is broken since can_dma() can be called multiple transfers before
actually doing a transfer (the current implementation loops over all
transfers in a message before starting the message) - you can't store
any local data.  The transfer_one() function should do another can_dma()
check to decide if it can DMA, it shouldn't rely on driver global data. =20

> +	if (!mdata->use_dma) {
> +		if (trans->rx_buf) {

This should be a variable set when doing the transfer (or perhaps based
on checking spi->cur_xfer with can_dma()).=20

> +			for (i =3D 0; i < trans->len; i++) {
> +				if (i % 4 =3D=3D 0)
> +					reg_val =3D
> +					readl(mdata->base + SPI_RX_DATA_REG);
> +				*((u8 *)(trans->rx_buf + i)) =3D
> +					(reg_val >> ((i % 4) * 8)) & 0xff;

This isn't the clearest code ever...  a comment would help.

> +	if (mdata->tx_sgl && (mdata->tx_sgl_len =3D=3D 0)) {
> +		mdata->tx_sgl =3D sg_next(mdata->tx_sgl);
> +		if (mdata->tx_sgl) {
> +			trans->tx_dma =3D sg_dma_address(mdata->tx_sgl);
> +			mdata->tx_sgl_len =3D sg_dma_len(mdata->tx_sgl);
> +		}
> +	}

There's a *lot* of code in this interrupt handler, and a lot of it looks
an awful lot like the contents of mtk_spi_dma_transfer() has been
cut'n'pasted in.  The shared code should all be factored out into a
function called from both places.

--fNOZNvBbfUx8KYZM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVsnqhAAoJECTWi3JdVIfQCl8H/01bnBwUdNC9G0XaTE5e8keW
tsObBdeG5x98z0txYDA8RKCn5h7kNUYJOnRtI+zd9nK+xLk5Ibyh4PIK17m3/RaI
mZJtpkZPyY32l1KRgR1akNTBC1+y7moll1co4gdyHvkVAv2c13nugzj3TDK6ZYmt
Km2NM9QJUWXljxVRvFCUaA5/nSJWJ4EPCgIlTG6pczq0VtzdcqBFiUhMOtFNB8C5
1VTaNLnF2JwgIZH4Z+gZX/4PNnZSj3VeWAvFK/7aidGBaACzAOKwHOpwvtsuTOPt
s5Z00bJlY0CzIrh00G9v4FdJqmcJMSs34z21iUIL/NoxltnE351dFqlX/cb2ah0=
=c+JI
-----END PGP SIGNATURE-----

--fNOZNvBbfUx8KYZM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
