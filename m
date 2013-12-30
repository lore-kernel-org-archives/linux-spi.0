From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi:fsl-dspi:add support of DSPI IP in big endian
Date: Mon, 30 Dec 2013 13:42:17 +0000
Message-ID: <20131230134217.GC31886@sirena.org.uk>
References: <1388388474-8662-1-git-send-email-b44548@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iaYIJ+kOC8t17Zqq"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Jingchang Lu <b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Chao Fu <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1388388474-8662-1-git-send-email-b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--iaYIJ+kOC8t17Zqq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2013 at 03:27:54PM +0800, Chao Fu wrote:

> +#define DSPI_BITWISE16(d, v)	(d->big_endian ? cpu_to_be16(v) : cpu_to_le=
16(v))
> +#define DSPI_BITWISE32(d, v)	(d->big_endian ? cpu_to_be32(v) : cpu_to_le=
32(v))
> +
> +#define dspi_readb(c)		readb(c)
> +#define dspi_readw(c)		({ u16 __v =3D (__force u16) __raw_readw(c); __io=
rmb(); __v; })
> +#define dspi_readl(c)		({ u32 __v =3D (__force u32) __raw_readl(c); __io=
rmb(); __v; })
> +#define dspi_writeb(v, c)	writeb(v, c)
> +#define dspi_writew(v, c)	({ __iowmb(); __raw_writew((__force u16) v, c)=
; })
> +#define dspi_writel(v, c)	({ __iowmb(); __raw_writel((__force u32) v, c)=
; })
> +

For type safety and general legibility make these inline functions
instead of macros, the generated code should be the same.  It's also not
clear why you're adding iowmb()s that weren't in the code before, and
see below...

> @@ -110,9 +120,10 @@ struct fsl_dspi {
> =20
>  	void __iomem		*base;
>  	int			irq;
> -	struct clk 		*clk;
> +	struct clk		*clk;
> =20
> -	struct spi_transfer 	*cur_transfer;
> +	bool			big_endian;
> +	struct spi_transfer	*cur_transfer;

Seems like there's some whitespace changes crept in here and elsewhere
which makes things harder to review.

>  static inline int is_double_byte_mode(struct fsl_dspi *dspi)
>  {
> -	return ((readl(dspi->base + SPI_CTAR(dspi->cs)) & SPI_FRAME_BITS_MASK)
> -			=3D=3D SPI_FRAME_BITS(8)) ? 0 : 1;
> +	return
> +	((DSPI_BITWISE32(dspi, dspi_readl(dspi->base + SPI_CTAR(dspi->cs)))
> +	& SPI_FRAME_BITS_MASK)
> +		=3D=3D SPI_FRAME_BITS(8)) ? 0 : 1;

The indentation here is a bit messed up, the return shouldn't be
indented to the same level as the argument.  More importantly the whole
thing is just becoming even harder to read with the addition of
DSPI_BITWISE32.  Would it not be clearer if the driver always worked
CPU native and the endianness of the hardware were hidden by the I/O
accessor functions?

> -	pr_warn("Can not find valid baud rate,speed_hz is %d,clkrate is %ld\
> +	pr_warn("Can not find valid baud rate,speed_hz is %d,clkrate is %ld
>  		,we use the max prescaler value.\n", speed_hz, clkrate);

This seems unrelated and will mess up the formatting of the resulting
print (which ought to be a dev_warn()).

> +	dspi->big_endian =3D of_property_read_bool(np, "big-endian");
> +

This needs an update to the DT binding document.

--iaYIJ+kOC8t17Zqq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwXg2AAoJELSic+t+oim9E54P/1GogUBzpdUVs51OxFg97Vv8
eBHhHEMbbE8usXIxXSXnzurVngYiawq3Q9SG8JA8wFjNz9GPAKmO0JFoCFlWfr8b
2eIYKUD7M3M2fS76akqojhRlMD8pofhaGwY5VuMyL0w1OvtD4YOhYqw/YJNYOscr
JglHdMGFJOHU+uALqbUsyZw37Jm9pPH5Cr/yDlRhrs4Zz1MFTXADqZRu4rIBUk8X
OIb1jPwX/Hc++ezU+xyFZnU4PjwABOTyDoBUG6pgcqbmvPKJSn+/Ml+UuM4Bfta/
4ocWFmhNhZ3Lzh1oVrsjzJAlB8+unQBdkHmamiGZ9sK6d5L/GLKZm786YK+nbGYi
SLGb952Fz95YLRd24s563Zza5k7gjzsb9i9nscWJRoUlzqLWUXG5Oa8gOB/5sqzg
w9HB1bpRinMKfPvFRIUAS1mgzX+wf9gy0Am1+Us+i53Y+H88BeNsw8xk6VSQ1kJF
xCV16nKYPzfmLqCjxZ2pnKDKd/bK/4H9mreEdTyAV3hK+v6X+N+8b3BZlEYeu2O/
MWCC5ShSfM16YMzxMw4wEL9At26Gvjlwq1O0cDjsHuiTS8EXQ3HTaDronr/SrNyF
f63Ohc8HqDorUJwKcGdW5Txs8rBxEEk4QFrkfu5wHdDNbzdRk/7oktuPwnCDI5zv
7/6RZT3CuLmCnFkOrgd+
=ayby
-----END PGP SIGNATURE-----

--iaYIJ+kOC8t17Zqq--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
