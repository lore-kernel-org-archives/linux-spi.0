From: Mark Brown <broonie@kernel.org>
Subject: Re: [DISCUSSION] spi multi chipselect support
Date: Thu, 19 Jul 2018 14:25:12 +0100
Message-ID: <20180719132512.GA27938@sirena.org.uk>
References: <20180718163530.zsa5md3huz3dnotb@earth.universe>
 <c497b0e2-c663-fa29-dabc-6dd5ca26e0a4@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Cc: Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com
To: Lars-Peter Clausen <lars@metafoo.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c497b0e2-c663-fa29-dabc-6dd5ca26e0a4@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 18, 2018 at 07:19:19PM +0200, Lars-Peter Clausen wrote:

> My preferred solution would to have something like
> i2c_new_secondary_device(), but for SPI. This way the driver that binds to
> the compatible string can allocate devices for additional chip selects as
> necessary. Also make use of the reg-names property the same way as in I2C.

Yes, that's at least the most consistent way forwards if nothing else.
I don't really have any more appealing ideas anyway.

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltQkTUACgkQJNaLcl1U
h9BUkAf/YnEw9f7VUM63wKafD/gmY55xm7M0gWEZi4Mm18LD1AfLpyNVO3YWB1Vq
G+GPeacLi0g6Mb1Vu7kkAV67Ox3IjATYxADuxhGksQvSTszyCV8v0DY2nTlozSb+
Z20YGSnh8zjFCPENA3tBAsj56HghEumfXlWmFL06/XNpmxcG7UrVMtkLmeglavNf
GZh+sNKlC363Obm8eOWVkXLuSB+JeHHexyN6q40tvT1BrFbDkYktGNJJ93F7cM07
nq5uluV/EhPnJCcSo0zoqj3gtwpDGfJpYEe9b4t63qoMaB6wAhG+dR3mYmm2fZd8
IONpmBEc0tP8PQHrh9jTQwy59lRDAQ==
=YmQv
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
