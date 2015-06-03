From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: pxa2xx: Make LPSS SPI general register optional
Date: Wed, 3 Jun 2015 13:14:59 +0100
Message-ID: <20150603121459.GK14071@sirena.org.uk>
References: <1433328587-20797-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1433328587-20797-3-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pKNzOuX3zSqsavrh"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1433328587-20797-3-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--pKNzOuX3zSqsavrh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 03, 2015 at 01:49:47PM +0300, Jarkko Nikula wrote:
> General register located in LPSS SPI private register space is not found in
> upcoming Intel LPSS platforms. Access it conditionally depending is it
> defined in configuration.

This too.

--pKNzOuX3zSqsavrh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbu/CAAoJECTWi3JdVIfQ+VIH+wfO2/ns2deETko5vl8D8H2g
7x63z6w0qBZrgEzVI0lKJ8tir3npML6rfyNerDZCfgRxan3PnYvgn9mdnk1qn1kU
n+yCmXCUTwsT0QHhdUdei1aXWWoAB+eM1NE0ZMx/AeDGT2Y0sgUCWSLe6PFmr3Rq
z0rd48wPfZTKUU2kwGIeDqE4qoNZn4wrZzSwzSxKjsRLw0ijeKb5FuD/y9orAQl1
9rfHzWWlcOvmOmKt0vfhxsdOr6HoIw+iymrpyvuscL4VD+GcKkOkdUxYNcnPCKUo
ZK1HyV4ZIp4OjRteWiIXhvSL6nXUeN9+qNXzhETG/swG0/7XQ04X8MYX1wpQY9s=
=EjDS
-----END PGP SIGNATURE-----

--pKNzOuX3zSqsavrh--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
