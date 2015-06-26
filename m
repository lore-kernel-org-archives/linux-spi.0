From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Fix per-page mapping of unaligned vmalloc-ed buffer
Date: Fri, 26 Jun 2015 12:46:22 +0100
Message-ID: <20150626114622.GW14071@sirena.org.uk>
References: <1435250415-9147-1-git-send-email-andrew_gabbasov@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QpO1T/ITbdn+x1ew"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Gabbasov <andrew_gabbasov-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1435250415-9147-1-git-send-email-andrew_gabbasov-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--QpO1T/ITbdn+x1ew
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 25, 2015 at 11:40:15AM -0500, Andrew Gabbasov wrote:
> spi_map_buf() processes mapping of vmalloc-ed buffers in a special way,
> making mapping of every page separately. However, if the buffer is not
> aligned to page boundary (e.g. sub-array in a vmalloc-ed array), it
> fills the scatter table with page-size unaligned pieces, that cross
> page boundaries. This is incorrect and can, for example, cause memory
> corruption and various crashes when working with ubifs on spi-nor chips.

The caller is supposed to be providing us with aligned memory here.
However it could be helpful to do this so...

> -	const int sgs = DIV_ROUND_UP(len, desc_len);
> +	const int sgs = DIV_ROUND_UP(vmalloced_buf ?
> +					len + offset_in_page(buf) : len,
> +				     desc_len);

No, please write this legibly without the ternery operator.

--QpO1T/ITbdn+x1ew
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVjTuNAAoJECTWi3JdVIfQpAsH/jM+s3Rdlzeol9GYI0uzRxPV
U8Cqth7vd4uGDk/u309+L1EW/Jt3be6KCSNPhmad6NryTasyJw1+Py2d13pcTZVg
DQClMfaHxh5FZmbAbTV+kawO0Lv7SjFdP9ND2/kqFg5nKlZKghuna4nNdj7FJyLd
TtplDoUpUDr4+H6eb9yVU2DNE3P9WCozkSIOf9hC/K4kTmYea9r31nRg6e37rMUk
jWssh6DCbWqBRL/WF+rxEJspi5gXmkbU3Q7DgLveyDopp8eJC1KWYVxt8Ul36+QO
yvllzb/eRGBH/LAw9Jn27M3xsMTN/DNEZKsE4OLT5E4aHKu8QsVfHrl3mlJwRDQ=
=c9Zz
-----END PGP SIGNATURE-----

--QpO1T/ITbdn+x1ew--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
