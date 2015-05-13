From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Wed, 13 May 2015 18:13:00 +0100
Message-ID: <20150513171300.GD2761@sirena.org.uk>
References: <1431462804-30467-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150513112604.GI3066@sirena.org.uk>
 <20150513153740.GC11677@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zfZAIAilk/YNj2Pr"
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20150513153740.GC11677-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--zfZAIAilk/YNj2Pr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2015 at 08:37:40AM -0700, Greg Kroah-Hartman wrote:

> You can easily bind drivers to devices today from userspace, why not
> just use the built-in functionality you have today if you "know" that
> there is no driver for this hardware.

So, that was my original suggestion too but people were complaining that
this wasn't a generally supported feature and requires specific support
of some kind in the bus (which nobody posted a patch for).  I have to
confess I didn't investigate too deeply myself.

--zfZAIAilk/YNj2Pr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVU4YbAAoJECTWi3JdVIfQkBIH/icM+QlwQBIqsC5uZTv3aBQN
mn13EyneBNclFf8Hq1r4YBTmJGaHk0PrfrQjBCGodutHLpJB7OuMHOUpx/hDITZS
cVTKU0csuDKDToXrMBBThRTxV7x5n17q/EhRiM2IBvMz0EuPWUoZ0A9yXSWTrBjV
wrpgoHskKgENl1Js6cTV7yn2UL4Af5uReeScwoyEFnnqLAX7LcmVL2ULmsqXJDKl
Pv80HKtBFS0TYS9DZ0Gee3XSwAqLISZktscrNlaSXpYxRGCAHjIKkSrbpzdH3tXn
cQyPwJWWPE8P+6APrj+NaoPYBcGalS1JGgijrE8IJwAbeSnAKK3XQ34xrARmdVA=
=FM7A
-----END PGP SIGNATURE-----

--zfZAIAilk/YNj2Pr--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
