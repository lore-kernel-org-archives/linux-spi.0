From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: orion: Fix extended baud rates for each Armada
 SoCs
Date: Wed, 27 May 2015 18:45:47 +0100
Message-ID: <20150527174547.GI21577@sirena.org.uk>
References: <1432633484-18758-1-git-send-email-gregory.clement@free-electrons.com>
 <1432633484-18758-3-git-send-email-gregory.clement@free-electrons.com>
 <20150526120853.GB28523@lunn.ch>
 <556464F8.1020707@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3tHEeV7QUZcH1cKB"
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <556464F8.1020707-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--3tHEeV7QUZcH1cKB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 26, 2015 at 02:20:08PM +0200, Gregory CLEMENT wrote:

> Mark do you want a new patch or do you prefer fixing the typo
> yourself ? it should be

I fixed it up locally (in general it's easier to just send the patch
though).

--3tHEeV7QUZcH1cKB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVZgLKAAoJECTWi3JdVIfQkTUH/ikSDcT1xhGnHlh0t1BJdp5p
5Xgt0vxHI9vcx2NcMYfxU80bmWEsMlL/b+1UAg6LyB+X8WXJltBQGMIabCpkVHnQ
hz8v9yEvIcZJ9gybLElwkUAyMNrW+wpAKjGTUH2zlO4YQuvXTGznq1FaYkeipdNN
Idsl5e8cdyQUqhj7GeIs9j5EqEjHqHZk2DryIybgnv4onGUn4VqyZBia4BkQlLgD
NQLjcafSXTNSDfoMWn/gib87wySqNowgjLgKlZo4aNe/21tizRgTMMPeRIoEN78o
cfcGXCjjlfhLXlwYHBjFXb28ZlB2yWQboi0IQYwJN8iqlT+YYxyRVX3xz2Vy6eQ=
=bql6
-----END PGP SIGNATURE-----

--3tHEeV7QUZcH1cKB--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
