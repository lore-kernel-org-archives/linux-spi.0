From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spidev and the use of spi_async instead of spi_sync
Date: Wed, 22 Apr 2015 20:41:33 +0100
Message-ID: <20150422194133.GI22845@sirena.org.uk>
References: <AED5BFFC-FF25-4699-9534-AAB3AE285021@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aJFFgG5QZHt5jcrP"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AED5BFFC-FF25-4699-9534-AAB3AE285021-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--aJFFgG5QZHt5jcrP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 22, 2015 at 05:55:44PM +0200, Martin Sperl wrote:

> As this code is from 2008 the situation may be different
> now and we can use spi_sync instead?

Yes, that seems sensible.  I can't think of any reason why it shouldn't
have done that in the first place.  For things like this please just
provide a patch directly, it's much quicker and easier.

--aJFFgG5QZHt5jcrP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVN/lsAAoJECTWi3JdVIfQ0nkH/18ffDLCKJURYyt1EvyKTIKM
LYWSS2aGASXtg2ZOIMW2as2xwT1d0rXxJFpDNK5LQ8VTfO8qDwkTYDHS4NDyAGUG
N0VMY9BObHf7nyhldT37roVTW6W94uuSJbf0FuWKv1dZu9OW7lG+4VDRl8FXHEom
klc/md3whiBIgLBwJGapo8JJnqbBiwsyp2c7mnGGfD5d2W3EE5relYSj+ogwlsYp
P9Lp4uuEutrfRz3AOvjFjJjrhb0ZVc4iHvGWWLgy+VuR7dzHMDroJdNWIvaBdUIt
tr5fSl7J19/XTJt3kPX9H2+Z+yPBODpcrzRpBHtFFtQzeqkhR2t/I0P59PLmqNM=
=Axid
-----END PGP SIGNATURE-----

--aJFFgG5QZHt5jcrP--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
