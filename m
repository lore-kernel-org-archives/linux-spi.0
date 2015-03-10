From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCHv2 4/4] Moved spidev_tool.c to tools/spi
Date: Tue, 10 Mar 2015 20:55:20 +0000
Message-ID: <20150310205520.GV28806@sirena.org.uk>
References: <1426018353-13442-1-git-send-email-adrianremonda@gmail.com>
 <1426018353-13442-2-git-send-email-adrianremonda@gmail.com>
 <1426018353-13442-3-git-send-email-adrianremonda@gmail.com>
 <1426018353-13442-4-git-send-email-adrianremonda@gmail.com>
 <1426018353-13442-5-git-send-email-adrianremonda@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hjiPcpt6rcFNGbLy"
Cc: corbet@lwn.net, linux-spi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
To: Adrian Remonda <adrianremonda@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426018353-13442-5-git-send-email-adrianremonda@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--hjiPcpt6rcFNGbLy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2015 at 04:12:33PM -0400, Adrian Remonda wrote:
> 	renamed:    Documentation/spi/spidev_test.c -> tools/spi/spidev_test.c
>=20
> Signed-off-by: Adrian Remonda <adrianremonda@gmail.com>
> ---
>  Documentation/spi/spidev_test.c |  318 ---------------------------------=
------
>  tools/spi/spidev_test.c         |  318 +++++++++++++++++++++++++++++++++=
++++++

I've not applied this: it will break the build of the documentation
directory as there's a Makefile there which will build spidev_test but
that's not been updated (and we should probably have one in the new
tools directory but that's a bit less urgent).

--hjiPcpt6rcFNGbLy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/1o3AAoJECTWi3JdVIfQA+0H/Rddfbv1i7TmuY1KU1Zb09be
C68KyDOyn4Lk5vASjSsR0FtGxYfwaDnWsf2w6A6549YQIUyCcwImEqV6xMmQvhpJ
Kgsiapw+zjk6fBrJKGeudAIDH5Hnw1jDrTUscdPI9i9D6YoNxZB14AyAAHBNBjwu
ZpWC2wbuEefP5arIlglCvdicvBBtXv5DDGXSEADCal3xCMeLnrM4NMTp9BHESkWr
CF+WN43L7uKp2BDwrTfpnz9LjyXejlancUsg3GEMkVkAZTGi2aJuh8ZmPWvYVFXO
oAf5Acp9LyfgsIY5MPVU9lv4kRwzFHcjCPgCwkoVDdVbc22m2PTX92sLvs96wZ4=
=xicF
-----END PGP SIGNATURE-----

--hjiPcpt6rcFNGbLy--
