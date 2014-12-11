From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 0/3] ARM: sun4i: SPI improvements
Date: Thu, 11 Dec 2014 17:56:02 +0100
Message-ID: <20141211165602.GD8739@lukather>
References: <1418033642-29731-1-git-send-email-mr.nuke.me@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3Shs6nLsUBL77Lfu"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
	ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
	linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandru Gagniuc <mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1418033642-29731-1-git-send-email-mr.nuke.me-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--3Shs6nLsUBL77Lfu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 08, 2014 at 04:13:59AM -0600, Alexandru Gagniuc wrote:
> This is a series of patches that gets SPI working in a better state on the
> Cubieboard. The main motivation was to use flashrom to to program SPI ROM=
s.
> There is one patch missing, which adds an spidev node on the Cubieboard. =
Since
> Maxime did not like the approach in that patch, I've left it out for now.

Just to make things straight, it's not me alone that didn't like the
approach.

It's both wrong on a theorical point of view to put that in the DT,
since it has no hardware meaning at all (ie it doesn't describe the
hardware, or the state the bootloader left the hardware in), and this
has been NAKed a number of times already by Mark Brown.

See http://permalink.gmane.org/gmane.linux.kernel.spi.devel/11747 for
example.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--3Shs6nLsUBL77Lfu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUicyiAAoJEBx+YmzsjxAg9twP/3bQgAN+X5ClIXQJ+Qlx9oRJ
d0fkgMv5w9XgpSzMcSYFBUzKlarTm4FPvyCa/0075ylAuP3fPTgwn37JYU+s6gvf
PnYHhk+JGsimwzD55+HldZm+d+7rbOGvvCRq8nTOtWDCyhJ6NOH775Gkg3BIVB3V
uzeEvDxdAFhT6M9lJOVRrmCQ5+lTVjEnkeirmkdTMISzYn4elajWW2ncIYow2hQV
pWL9iM7MBjLHP/yFzLeqD5fcc6hALDBsKiagj+EI3gXKYI5Qxyjh6mJUcjuFa/Da
yur5bevfa87LhFkf1EsY8z/Q2bGGzhei/3tbW7dsZoGieEgJQ+m3rfRpMyitbfv9
siTEt0y8UhYS+1Du8yqhCL7IYS1hn1VAizTdFK/VyNcQ2vGyU5eZEtAoWiO11LhD
AkK/9SUTJvspBENbTZkbDAL2SMB7AbluGiofQvwYXtYXwoGc81ivZtNx96WmCyUG
8tHKhSRxG7SECx9T/jcW7xulc92BUHfOHOjfIKqSYblbrWYmFoL/y1LbTXwqxnY1
Wc30O4UWYXeRyj/PPxAqS70ItXY+av4o6CARqAcGSJ7pYr0JxbyYtFeCqu2T+58v
D6zvRAUW97B8ATUf+5v2X+BnetL/M6mSgv0eLxzE7qLk7v/nHuOMFHtPtjR+ocSd
YSHxlUQYTZmgdUnEfk9w
=agy8
-----END PGP SIGNATURE-----

--3Shs6nLsUBL77Lfu--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
