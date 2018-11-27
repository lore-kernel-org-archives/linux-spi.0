From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 0/1] add SPI driver support for mt7629
Date: Tue, 27 Nov 2018 11:43:24 +0000
Message-ID: <20181127114324.GA3206@sirena.org.uk>
References: <1543285790-11379-1-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Cc: Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org, ryder.lee@mediatek.com
To: Leilk Liu <leilk.liu@mediatek.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1543285790-11379-1-git-send-email-leilk.liu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2018 at 10:29:49AM +0800, Leilk Liu wrote:
> From cf719ac350c36cb58e2013b58f73ad04f6981384 Mon Sep 17 00:00:00 2001
> From: Leilk Liu <leilk.liu@mediatek.com>
> Date: Tue, 27 Nov 2018 10:18:30 +0800
> Subject: [PATCH v2 0/1] add SPI driver support for mt7629
>=20
> v2:
> remove "mediatek,mt7629-spi" compatible according Matthias's advice.

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv9LdsACgkQJNaLcl1U
h9DaMQf+M5cu0Zb2/dENEP6o5v7mVH7OBjhuL8YgALsv8xX+mjDdgGbEsY6Y3EzR
EWNY63wGZNCCm5Z043Tus5ydXXjYMWTpy5EXSNRk5tH1B97jTxUNMEBHX9qjWvQq
QqVkactN22X6g2zYOfl/cJ1FlCnENgriobKXbWlhmkuA02qJtVjL/o7WrwFETNZp
F37eUSc1/5txuMl4o7jJpg/8eB0VtaHtDqDrN7lFc0aHIDlPlIUFtDPWkA0eDYx9
zcRgnRdoqhG2VMZefG+KTXJJaRlOE5RANRQEbCffpLZDIFYLPThAhM4GdhiRmup1
RMDHEjOcgQX4wEsCnMvm0db4JIMDNg==
=eCFa
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
