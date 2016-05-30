From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/3] spi: xilinx: Remove bitbang and register with spi
 core
Date: Mon, 30 May 2016 18:35:57 +0100
Message-ID: <20160530173557.GZ29837@sirena.org.uk>
References: <1464601609-5095-1-git-send-email-nagasure@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="McORcswOES2gGXLb"
Cc: michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, harinik-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Naga Sureshkumar Relli <nagasure-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: Naga Sureshkumar Relli <naga.sureshkumar.relli-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1464601609-5095-1-git-send-email-nagasure-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--McORcswOES2gGXLb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 30, 2016 at 03:16:49PM +0530, Naga Sureshkumar Relli wrote:
> This patch removes the bitbang layer registration.
> it directly register with spi core using spi_register_master and uses
> the call backs provided by spi_master struct.

This is doing a whole bunch of other stuff as well. =20

> +/* Register Offsets */
> +#define XSPI_CR_OFFSET		0x60
> +#define XSPI_SR_OFFSET		0x64
> +#define XSPI_TXD_OFFSET		0x68
> +#define XSPI_RXD_OFFSET		0x6c
> +#define XSPI_SSR_OFFSET		0x70
> +#define XIPIF_V123B_DGIER_OFFSET	0x1c
> +#define XIPIF_V123B_IISR_OFFSET		0x20
> +#define XIPIF_V123B_IIER_OFFSET		0x28
> +#define XIPIF_V123B_RESETR_OFFSET	0x40

> -#define XSPI_SR_RX_EMPTY_MASK	0x01	/* Receive FIFO is empty */
> -#define XSPI_SR_RX_FULL_MASK	0x02	/* Receive FIFO is full */
> -#define XSPI_SR_TX_EMPTY_MASK	0x04	/* Transmit FIFO is empty */
> -#define XSPI_SR_TX_FULL_MASK	0x08	/* Transmit FIFO is full */
> -#define XSPI_SR_MODE_FAULT_MASK	0x10	/* Mode fault error */
> -
> -#define XSPI_TXD_OFFSET		0x68	/* Data Transmit Register */
> -#define XSPI_RXD_OFFSET		0x6c	/* Data Receive Register */
> -
> -#define XSPI_SSR_OFFSET		0x70	/* 32-bit Slave Select Register */

There's unrelated code motion stuff here.

> +/**
> + * xspi_write32 - Write a value to the device register little endian
> + * @val:	Value to write at the Register offset
> + * @addr:	Register offset
> + *
> + * Write data to the paricular SPI register
> + */
>  static void xspi_write32(u32 val, void __iomem *addr)

There's adding some new documentation.

> -static void xilinx_spi_tx(struct xilinx_spi *xspi)
> -{
> -	u32 data =3D 0;

And what looks like a total rewrite of even the FIFO stuffing code
rather than the refactoring to go into the new framework that I'd
expect.  As a result of all this it's very hard to review this change,
welcome though it is.  Can you please split this out into a patch series
with smaller changes in each patch rather than one big rewrite
everything patch?

> -	if (!xspi->tx_ptr) {
> -		xspi->write_fn(0, xspi->regs + XSPI_TXD_OFFSET);
> -		return;
> -	}
> -
> -	switch (xspi->bytes_per_word) {
> -	case 1:
> -		data =3D *(u8 *)(xspi->tx_ptr);
> -		break;
> -	case 2:
> -		data =3D *(u16 *)(xspi->tx_ptr);
> -		break;
> -	case 4:
> -		data =3D *(u32 *)(xspi->tx_ptr);
> -		break;
> -	}
> -
> -	xspi->write_fn(data, xspi->regs + XSPI_TXD_OFFSET);
> -	xspi->tx_ptr +=3D xspi->bytes_per_word;
> -}

For example this refactoring of the FIFO stuffing looks good but ought
to be a separate patch.

--McORcswOES2gGXLb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXTHn8AAoJECTWi3JdVIfQK14H/Rs8nX73kjNIKUewNDfitge8
mFQBSMRWGmgtYv/bNrIRSYPZDOHoGruwUg6J3lqHvq0o8oLteklEUY16WH2EibNi
DxBL+HkZjl4MXUxxdYTQ6jyNBuIR5/BrbndBBz8hOoIhdMfAOYdswCf1/hUH1QL0
fzNblQExJ55OOg2MSAnPdBLof/5HSLoPYCUAeCCTMPgiOIJtwycRRK5gjo4h4+XN
5c5bajV242sy3JEAqvIz3xx31sTolvC4q6sy6ublDB/cQ+mW5mmXAttFsLwBz5NL
0EG0+Php8TKSRQ0mamYvVlePSzeKKBkyqSLBBUJkzsc0dmqLSx2M2PXW90i8+ZM=
=Z3vl
-----END PGP SIGNATURE-----

--McORcswOES2gGXLb--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
