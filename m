From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] spi:fsl-dspi:add support of DSPI IP in big endian
Date: Thu, 9 Jan 2014 17:52:08 +0000
Message-ID: <20140109175208.GK12858@sirena.org.uk>
References: <1389161655-21856-1-git-send-email-b44548@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IA03tywDYuoVKXrw"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Jingchang Lu <b35083-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Chao Fu <b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389161655-21856-1-git-send-email-b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--IA03tywDYuoVKXrw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 08, 2014 at 02:14:14PM +0800, Chao Fu wrote:

This looks a lot nicer - a few things below though.

> +#define DSPI_BITWISE16(d, v)	(d->big_endian ? cpu_to_be16(v) : cpu_to_le16(v))
> +#define DSPI_BITWISE32(d, v)	(d->big_endian ? cpu_to_be32(v) : cpu_to_le32(v))

These should probably be inline for the same reason as the I/O
functions, perhaps even being done as part of the I/O functions.

> +static inline u16 dspi_readw(void __iomem *addr)
> +{
> +	u16 __v = (__force u16) __raw_readw(addr);
> +	__iormb();
> +
> +	return __v;
> +}

Why does this need a barrier and why does it not take care of the
endianness translation?  A quick glance through shows most if not all of
the callers doing the translation.

> +static inline void dspi_writew(u16 val, void __iomem *addr)
> +{
> +	__iowmb();
> +	__raw_writew((__force u16) val, addr);
> +}

Again the memory barrier seems odd, especially the barrier *before*
doing the write.

--IA03tywDYuoVKXrw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzuHEAAoJELSic+t+oim9B4kP/j1y6Hd0YuJqPK0qoBf2gy9Y
ps2+cdd09ovlOMEne4WEy+X2mbDaRaWBc4IVihN2vBwki3aRIyzpi7AkOmzEMw/A
8qmnb+BiFYV3o4fzskZJpo7vloOXSKYJa37rbDHBkVYo0Kq6Sd0RJJb3RekR/CVe
68CL7RV4cfikxBwrZrxKApH1iOU/fH1FHn7hXjcYbk3g2BAoYf4TuClrT9LNesA+
CcavFGLSHxEHVH2j8nS9+utv3UQG1q9fOb4rQun87bda91xEt3WRi68Due9I+Ilk
RJjx0D/6j24l7ZDQcLoQGHAwQJCk0bxn8IBPF4VoCXbpnoJxk4H1CRjvspKibV94
iVvisPqj+7bJLM2lD9dNd6bUm059WifbHDD311zLUi+foKXwWRXYSL/VwavUw3qv
jtXmxUdMDaE+1k6+yTzfqT0V8sKzHiMh8iT1A9WFK7mLgi0vfYdvGKYWlNuOxP30
vyuN4YEIEyWpdRKwGEmKCDfIxnLbcKKgSl0m5cEYbIbrNRt7Brcy9wDjv7QmXsHX
9aYnOCEk1BYAyKWeYrWmsTHY7+czykQOrTeYnbgmrkaSg8/Hm/TpdPXowfgv2fBp
QdBYfKXEskE9noc/g1RTqE4mmIbTLYzLoBb8WKiM2c00d9K+vioxM2GwSpKkLgyn
kmfgAjn2dh6III4Fnc78
=H3Mc
-----END PGP SIGNATURE-----

--IA03tywDYuoVKXrw--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
