From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: spi-ti-qspi: Handle truncated frames properly
Date: Wed, 13 Apr 2016 14:12:39 +0100
Message-ID: <20160413131239.GR14664@sirena.org.uk>
References: <1460462185.32355.7.camel@codethink.co.uk>
 <1460462294.32355.9.camel@codethink.co.uk>
 <20160413071324.GP14664@sirena.org.uk>
 <1460539893.32355.19.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TDVcAd+kFgbLxwBe"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	CT kernel <linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org>
To: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1460539893.32355.19.camel-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--TDVcAd+kFgbLxwBe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 13, 2016 at 10:31:33AM +0100, Ben Hutchings wrote:
> On Wed, 2016-04-13 at 08:13 +0100, Mark Brown wrote:
> > On Tue, Apr 12, 2016 at 12:58:14PM +0100, Ben Hutchings wrote:

> > > -		ret = qspi_transfer_msg(qspi, t);
> > > +		wlen = t->bits_per_word >> 3;

> > I did ask you to fix this to just / 8 so it's more readable :/

> Not explicitly.  And that would be inconsistent with every other place
> this driver bits_per_word to a byte count.

If someone is reviewing code and showing a different way of doing things
it is reasonable to interpret that as a request to change things.  It's
best to engage with rather than completely ignore the feedback, what I'd
have said would have been that it is better to have clear code than be
consistent with unclear code.

--TDVcAd+kFgbLxwBe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXDkXGAAoJECTWi3JdVIfQWfUH/jzvreIuAq6Uwyp54zLnjwIG
5F2R/iUiPI45Hh7t4WUhr1K8p5OxH4VNTyPq9wZ43Lc53B9A99mrPKeM0QuCs8DK
K45unKlse2qlDn+ixBRJFz5Psjll3GB+CQrTKBOe0Ca7HhGXgA9Dzm6kbhvPGFML
tg7gnjIlnufmvLiOely4Z36CEZfhWxH0J96t9JWM0HQ38N0Gmfz9PpI9KKmN9s2/
4V+cql9tuGPML3NOI8jivMkKagvWZUBi4baDhS/C/rmmE4HigdDSK1pPgbJ4ovci
Vn8t8wCIrrOGtaaEiwUZdpXM97+Y6mbDPsruO6RCkx+Au0yAIJqunoGLcgw+RGg=
=uih4
-----END PGP SIGNATURE-----

--TDVcAd+kFgbLxwBe--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
