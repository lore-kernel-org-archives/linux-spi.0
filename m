From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Setup the master controller driver before setting
 the chipselect
Date: Fri, 16 Oct 2015 15:43:05 +0100
Message-ID: <20151016144305.GO14956@sirena.org.uk>
References: <1444942305-24038-1-git-send-email-fcooper@ti.com>
 <20151016102846.GJ14956@sirena.org.uk>
 <56210966.3040501@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0FDNE3+7N8PCoNAN"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	nsekhar-l0cyMroinI0@public.gmane.org, ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org,
	m-karicheri2-l0cyMroinI0@public.gmane.org, iivanov.xz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: "Franklin S Cooper Jr." <fcooper-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56210966.3040501-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--0FDNE3+7N8PCoNAN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 16, 2015 at 09:27:50AM -0500, Franklin S Cooper Jr. wrote:

> Makes sense. How about something like this?

> SPI controllers may need to be properly setup before chip selects
> can be used. Therefore, wait until the spi controller has a chance
> to perform their setup procedure before trying to use the chip
> select.

Yes, that's a lot better - there's also the fact that if we assert chip
select before we've got the pins in a good state we may cause the device
to see signals that confuse it as we change.

--0FDNE3+7N8PCoNAN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWIQz4AAoJECTWi3JdVIfQj3gH/ReI3+qDUkiwk/HTyPRXu59i
UqNJaM9bkQj/tfd6tsRZjXjp971IdaJ/VbbhlNBnAgj2fjA7cgTpfazR8OAbng+C
MnMYgLDBqA2VFni2x9vS073OAgafhYW0FfVU4powF8k3AL3P5OVoe24ltd3sKxz6
5YT1fUkN9vRt+zmmOWAqHgVt5xaz/Y/K2dk7vu9bOlRcIT1bImg4e0lXo5oNTGGA
UqwABCnziVaL9jElhSj26XyMw6RpVrNBSwN6SEUgSo1dkajLncT2D6LD4/Czs/xA
Q6TAQYmTVRi66lyDxdCyTHVcnwtupwxbBjBQbdHoXLcvXmCFSlgnlUfp3Ajg/dQ=
=v+Vw
-----END PGP SIGNATURE-----

--0FDNE3+7N8PCoNAN--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
