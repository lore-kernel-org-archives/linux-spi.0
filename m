From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: s3c64xx: Get fifosize via device tree
Date: Mon, 15 Feb 2016 18:04:36 +0000
Message-ID: <20160215180436.GT18988@sirena.org.uk>
References: <1455031585-11113-1-git-send-email-ym0914@gmail.com>
 <20160209161036.GI13270@sirena.org.uk>
 <56C01E8E.6090107@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="K0M4iRgkWWXhiQ9N"
Cc: kgene@kernel.org, k.kozlowski@samsung.com,
	linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org
To: Youngmin Nam <ym0914@gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56C01E8E.6090107@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--K0M4iRgkWWXhiQ9N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 14, 2016 at 03:28:30PM +0900, Youngmin Nam wrote:
> On 2016=EB=85=84 02=EC=9B=94 10=EC=9D=BC 01:10, Mark Brown wrote:
> > On Wed, Feb 10, 2016 at 12:26:25AM +0900, Youngmin Nam wrote:

> > I disagree that it is useless to do this, it means that if we realize
> > later that there is some other difference between the implementations
> > then we have the information in the DT to handle this without needing=
=20
> > to update the ABI.

> To clarify, let me check that I understood.
> Do you mean we can fix fifosize of each SPI channel with DT handling
> if there is difference on this fifosize with driver code?
>=20
> If I understand your words correctly, let me modify commit messages.=20

I'm having a hard time understanding what you're saying here but it
sounds like you've understood the oppositve of my intention here.  I'm
saying that it's not clear to me that this is better than adding more
compatibles.  At the very least we need a new compatible which requires
this property as Krzysztof was suggesting.

--K0M4iRgkWWXhiQ9N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWwhMyAAoJECTWi3JdVIfQNxcH/iSSWqgUuqfxRas3hQp6EVzO
ISCdZhyWB5B4fskE8xuwihBNGIeSPEVBVll9pivbxJSlYGtmIHQf4TolLV4XAkdP
2mUBu3xnIHymVMYpeeKJko6KyAEud3M5Gh07kTKFENZ4hMWCM2OMWXOHg8WZo39z
rRgNdBYbNxURsaWmea4O4rbdKCO8BGsY16UcOwTCbTkRoh0imfRua7E5iyICcA2l
UMWorSxZeOZ1XEziVG43FSSsssz6SU7FGN21umlyk5l9uwELedjmuycufbV+4L2y
gxyBvwM21ZbF+c+B4r6oZqcuMB/iUPy9ZmE2VSWg240eBTqOFNpucqRpBEd4yx4=
=xEuJ
-----END PGP SIGNATURE-----

--K0M4iRgkWWXhiQ9N--
