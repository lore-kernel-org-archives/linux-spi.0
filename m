From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver" to the spi tree
Date: Wed, 13 Feb 2019 12:16:35 +0000
Message-ID: <20190213121635.GD7540@sirena.org.uk>
References: <20190212142236.2807D1128113@debutante.sirena.org.uk>
 <4f91497a-96ee-4c10-436f-4d011edb3834@gmail.com>
 <20190212144359.GD20635@sirena.org.uk>
 <20190212164940.GI20635@sirena.org.uk>
 <OF9C8DA179.15D69C0A-ON482583A0.00283EB5-482583A0.002E45C8@mxic.com.tw>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xB0nW4MQa6jZONgY"
Cc: bbrezillon@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <OF9C8DA179.15D69C0A-ON482583A0.00283EB5-482583A0.002E45C8@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 13, 2019 at 04:25:32PM +0800, masonccyang@mxic.com.tw wrote:

> From current mainline branch, MFD seems support the device which is on=20
> the same hardware bus(i.e, I2C, SPI, MMIO and SPMI)for multi-function=20
> by Read/Write the common same registers.

That's most MFDs but there are some that do some level of enumeration
(even if it's just looking at the device ID that got registered) to
decide what subdevices get registered, that's what people are suggesting
here I think.

> I am checking and not sure if MMIO of MFD could support RPC-IF for=20
> different hardware bus on SPI and CFI.
> I also doubt if this method is a correct solution for RPC-IF works
> either in SPI mode or CFI mode.

For MMIO devices MFD just passes through the parent resources.

--xB0nW4MQa6jZONgY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxkCqIACgkQJNaLcl1U
h9DInQf/VCq6GImO2gWzb8POBs/8E+Zowh70BkglP3V8cajNwCqJm9L18qzSqyRe
C8GPNxySkek+ROrDjdDsGrRjtTkQYjG5+6/XLG63HQZRvbmutc/x2fIgzZlYXNWK
v9cRpwT3hBpDwI4jXqAX3Vz7aPUklAf5r2t1ui0tfN8ijrPefqrOkzgBJn6V0QUp
MJg0+9oGeGysfA3ssX2FKWBxU9d0B0C/acn4c46ZfKcANpwxufN9jZb33AON2uAQ
4LYtxSg2JZww1ZYlBd0BBKWb+bZg1TAvFjNvTrwUJWpeqJ7yS7IGR0BlvKO2VJAc
b3+u/ZFH9iS+ACmhOLukNPcuPpH0sg==
=Unbo
-----END PGP SIGNATURE-----

--xB0nW4MQa6jZONgY--
