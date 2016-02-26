From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: sun4i: add DMA support
Date: Fri, 26 Feb 2016 21:25:04 +0900
Message-ID: <20160226122504.GR18327@sirena.org.uk>
References: <1456466217-6793-1-git-send-email-plaes@plaes.org>
 <1456466217-6793-2-git-send-email-plaes@plaes.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i471YDSmETikJJs7"
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Emilio =?iso-8859-1?Q?L=F3pez?= <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>,
	Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456466217-6793-2-git-send-email-plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--i471YDSmETikJJs7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 26, 2016 at 07:56:56AM +0200, Priit Laes wrote:
> From: Emilio L=F3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
>=20
> This patch adds support for 64 byte or bigger transfers on the
> sun4i SPI controller. Said transfers will be performed via DMA.
>=20
> Signed-off-by: Emilio L=F3pez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>
> Tested-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Tested-by: Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
> ---

You *must* sign off any patches you are sending, please see
SubmittingPatches.

--i471YDSmETikJJs7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW0EQfAAoJECTWi3JdVIfQ354H/j/uvZfFevcKvXWqyE+yE3O0
IXcZZyiZ0uM5S1eF/mIKUcoA/wqtuaehZikv1j7aPvwStYuP2+FOcnI4y1aXy8Jo
bcXoNmIgEhe/rIYf15odCVOshd26BmeP2RnfL7aibT3wpd2UM7N1g1Q+FhSMpD1Y
UM512AJUkp6rerdrCLhiRlyK+BGwDd546/QmCw7AvYDG6/mUe7qyc1znic6odNvj
Jr2uoifyQ9KaTN7eGgeSKrJlpPofBmZQ8Di75hHKrfdVehPhTbkUrMkFLizLv1tZ
BXkY2xYE3poDWFNgArIP2HbXj9frPKzapRo9G+LkPosVStimD17L0ZyFU8DbO+k=
=X8Hw
-----END PGP SIGNATURE-----

--i471YDSmETikJJs7--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
