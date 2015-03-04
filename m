From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: spidev_test: Added functionalities
Date: Wed, 4 Mar 2015 23:54:39 +0000
Message-ID: <20150304235439.GX21293@sirena.org.uk>
References: <1424891324-24784-1-git-send-email-adrianremonda@gmail.com>
 <20150227151117.15a79baa@lwn.net>
 <20150301182841.GA19947@debian.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="GNXaOx9AMrrC7lQw"
Cc: Jonathan Corbet <corbet@lwn.net>,
	"open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
To: AdrianRemonda <adrianremonda@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150301182841.GA19947@debian.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--GNXaOx9AMrrC7lQw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 01, 2015 at 07:28:41PM +0100, AdrianRemonda wrote:

> I apologize for the wrong patch format.
> Should I contact the mantainer of the tool path and ask him where to add
> it? Or how should I proceed?

I am the relevant maintainer here.  The main thing from my point of view
is to split the three changes you were making out into separate commits
so they can be easily reviewed.  Jon is right that this should be moved
into a better directory but that's a separate issue that can be tackled
separately (though feel free to do it immediately if you like!).

--GNXaOx9AMrrC7lQw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU95s+AAoJECTWi3JdVIfQqsMH/2N8+mOgAtTnKhRrQeWSyvfg
eqxPzyShSoOR7JSGGuUVPdIkjpSjzHwxWSImCBLFwrgZTDB6ccVeaAlDzjI+n6wF
GgtmFOJvCMR0Rg1qWxQrZi/jZk4NAB0i9ZtFSYm19xab6J4QjmuGzrKItdHmisLp
uwttF/dUFyIgBcjb91MM39t71qchgpk3iBPegewkd/7FH0ZShFfW/fCNaommtUL7
pvGCl8d8M6s4AcLe5ntL6Asyll/YEq6ogTmFJd2xCqBb4eccLvRf59ZeWkR7Yokx
nhD0rxQ36TErBrqgHB9w0Qx15kjYZ+fSzd6Odlkr/+qjC0RDhKaB4+OqKGW7Sk0=
=fJdw
-----END PGP SIGNATURE-----

--GNXaOx9AMrrC7lQw--
