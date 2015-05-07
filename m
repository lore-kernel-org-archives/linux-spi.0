From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: sirf: add support for USP-based SPI
Date: Thu, 7 May 2015 11:30:10 +0100
Message-ID: <20150507103010.GK22845@sirena.org.uk>
References: <1430982791-8681-1-git-send-email-21cnbao@gmail.com>
 <1430982791-8681-2-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="z7+xBrcfEZZARtkx"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	workgroup.linux-kQvG35nSl+M@public.gmane.org, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430982791-8681-2-git-send-email-21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--z7+xBrcfEZZARtkx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2015 at 07:13:11AM +0000, Barry Song wrote:

This all looks mostly fine, there are a few comments below but they're
all coding style things rather than anything else so should be easy
enough to address.

> +#define SIRFSOC_SPI_FIFO_LEVEL_MASK(s)	((s->spi_type =3D=3D SIRF_REAL_SP=
I) ? \
> +					0xFF : ((s->is_atlas7_usp =3D=3D 1) ? \
> +					0x1FF : 0x7F))

This pattern isn't very legible and isn't going to scale if there's more
types added (eg, some new variant with a bigger FIFO).  Can you make
these static inline functions with switch and if statements instead?  It
looks like they should all fit into that pattern. =20

It'd probably help make the patch easier to read if the changes to use
these functions were added as separate patches - add the functions and
convert everything to use them, then in a separate patch add the options
for the new variants.

> +	.spi_dummy_delay_ctrl	=3D 0x144,
> +};
> +struct sirf_spi_register sirf_usp_spi =3D {

Can we have blank lines between the structs please?  Also the structs
should be declared as static const so they're not in the global
namespace.

> +		if (sspi->spi_type =3D=3D SIRF_REAL_SPI) {
> +			u32 regval =3D readl(sspi->base + spi_reg->spi_ctrl);
> +
> +			writel(regval, sspi->base + spi_reg->spi_ctrl);

=2E..

> +		} else {
> +			u32 regval =3D readl(sspi->base +
> +					spi_reg->usp_pin_io_data);

Please write this as a switch statement so it's easier to handle an new
variants.  Similarly for any other things that handle variants with if
statements.

--z7+xBrcfEZZARtkx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVSz6xAAoJECTWi3JdVIfQPzAH/RKJxTApFmRMGR9xurmRXobX
SQ1XfcXtJYyDGqAc56vqNh/9TAqHYiTcs0787SgDE645Dytmk+507q3m2aZl79Dl
gcBRa2D5HXnyer1l0DQkVuc1k21QBlCElgU8kBCv8uzHy3T4LAH1J7TvVYvOw+Wg
/Wu45YkLctzQ3iaiR+mQ6987JsEyEJa601usKqm3CrrJ9cJhTz43naHBdFOP3Nyy
Evt8AbH//Kqyn6tLnmgeGnAqPcyVfQZrPlbqtnwwyZ23+xpRf3Npb5hFP0brIJTv
jLbyiWCCRKPjC7I8EIq0oKVXX7VxugJhi1/YEP0voHqMVxjhc847lQS7SMiRHlI=
=Q5GN
-----END PGP SIGNATURE-----

--z7+xBrcfEZZARtkx--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
