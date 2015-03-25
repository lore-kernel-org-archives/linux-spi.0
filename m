From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/1] spi: pxa2xx: replace ugly table by approximation
Date: Wed, 25 Mar 2015 08:31:03 -0700
Message-ID: <20150325153103.GE3572@sirena.org.uk>
References: <1427288776-244041-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qFgkTsE6LiHkLPZw"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Chen, Alvin" <alvin.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427288776-244041-1-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--qFgkTsE6LiHkLPZw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 25, 2015 at 03:06:16PM +0200, Andy Shevchenko wrote:
> The Quark SoC data sheet describes the baud rate setting using fractional
> divider. The subset of possible values represented by a table suggests that the
> divisor has one block that could divide by 5. This explains the number of the
> beast in some cases in the table. Thus, in this particular case the divisor can
> be evaluated as

Applied, thanks - this is much easier to understand!

--qFgkTsE6LiHkLPZw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEtS2AAoJECTWi3JdVIfQMrEH/i5N5+NWw0olGeObBRdnP8dc
4VdOjgW4Cc9vWbDVH+MfqwbjKnwh7tPQ6SUOgozP5rv7081fX5ISy1XSKXo4zsZn
WyIeBswsxH/amBywSJaBCybLObWV7ScL/C0Zn9E6Gsg2KwUj+yAhJA4tZRlz9gNJ
SAHn0s21Rm2WMfoTgO1rrXGlHfKTWDWKxwJyylbugQN+vUTpvcDn+RTjFjVw/ulh
LCUfT2C3ncEfd/eHgtBg0Cz2P5lsuiB2+PiHwCgzyWIn3CCd/j0ik3AWtqEL/4Pu
w/HsJ92NtrbEii14QCrjgLcUiFQ04hJPq0l/AJGkAlX/kL5wpaq7h3nanEpxD/w=
=mDBS
-----END PGP SIGNATURE-----

--qFgkTsE6LiHkLPZw--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
