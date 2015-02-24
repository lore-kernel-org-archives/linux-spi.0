From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: atmel: Fix interrupt setup for PDC transfers
Date: Tue, 24 Feb 2015 22:40:55 +0900
Message-ID: <20150224134055.GG6236@finisterre.sirena.org.uk>
References: <CANZ4BrSBnE78Z8WeNvRhEZRdxKMhToxpwcSvf0cLpZLJxGA78Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0EphSjNCSB1asamE"
Cc: "nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org" <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Torsten Fleischer <torfl6749-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CANZ4BrSBnE78Z8WeNvRhEZRdxKMhToxpwcSvf0cLpZLJxGA78Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--0EphSjNCSB1asamE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2015 at 01:26:20PM +0100, Torsten Fleischer wrote:

> spi_master *master,
>   (unsigned long long)xfer->rx_dma);
>   }
>=20
> - /* REVISIT: We're waiting for ENDRX before we start the next
> + /* REVISIT: We're waiting for RXBUFF before we start the next
>   * transfer because we need to handle some difficult timing
> - * issues otherwise. If we wait for ENDTX in one transfer and
> - * then starts waiting for ENDRX in the next, it's difficult
> - * to tell the difference between the ENDRX interrupt we're
> - * actually waiting for and the ENDRX interrupt of the
> + * issues otherwise. If we wait for TXBUFE in one transfer and
> + * then starts waiting for RXBUFF in the next, it's difficult
> + * to tell the difference between the RXBUFF interrupt we're
> + * actually waiting for and the RXBUFF interrupt of the
>   * previous transfer.
>   *
>   * It should be doable, though. Just not now...
>   */
> - spi_writel(as, IER, SPI_BIT(ENDRX) | SPI_BIT(OVRES));
> + spi_writel(as, IER, SPI_BIT(RXBUFF) | SPI_BIT(OVRES));
>   spi_writel(as, PTCR, SPI_BIT(TXTEN) | SPI_BIT(RXTEN));
>  }

It looks like your mail program has corrupted the patch and turned all
tabs into spaces...

--0EphSjNCSB1asamE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7H9mAAoJECTWi3JdVIfQl2QH/2847kRVOz61wrYiYN17WH1q
RT3aUUFaRWhUl8GvVhfAjI4AcgppLUmNpPDOB+JB6zJPaMAxzxpmgFLY/lesGLLn
6LsEUbvBU6G5L1CizLbcnZr1gEikUnkfjRcdllSnKBpPJFUUbEhYCRsxSzzgLxlc
aohQ+BQ4vWJ+45YX2t1lGdqw4e6p01qW72dOPA+6L5CvUa8x1sWy8dR/MwbN8Dj7
PCRodBPS85zwT84rWjv0PXsvAzE5A7nlSjGrTTVQGQXl5QlvOdkzLVvT29vOgaKi
oRBZEe3qqZ4/pTXKrkaojiAAGKXX55Jg1z/8rlS3s4RKwJAifZ8AdC1498W+xf4=
=akeH
-----END PGP SIGNATURE-----

--0EphSjNCSB1asamE--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
