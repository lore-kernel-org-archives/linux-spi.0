From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: spi-fsl-dspi: Fill actual_length when doing DMA
 transfer
Date: Mon, 16 Jul 2018 12:26:29 +0100
Message-ID: <20180716112629.GC20734@sirena.org.uk>
References: <20180716062508.7726-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="raC6veAxrt5nqIoY"
Cc: Sanchayan Maity <maitysanchayan@gmail.com>,
        Stefan Agner <stefan@agner.ch>, cphealy@gmail.com,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180716062508.7726-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--raC6veAxrt5nqIoY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 15, 2018 at 11:25:08PM -0700, Andrey Smirnov wrote:
> Users of SPI device drivers may rely on 'actual_length', so it is
> important that information is correctly reported. One example would be
> spi_mem_exec_op() which will fail if 'actual_length' doesn't match
> requested transfer length. To fix the problem, add necessary code to
> populate 'actual_length'.

This doesn't apply against current code, please check and resend.

--raC6veAxrt5nqIoY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltMgOQACgkQJNaLcl1U
h9B8uwf/U8yc5YQUdZomPA25pS8WoG3Zg6ed86KrBQdSDvgckrM73McNoEHTIJVi
b3pmXBS17zXlfVF7aWHbotAJi5Xd1syeoZjc60nUMqtbtRlTox65GtRclrErsaGU
9/wwCi+UZqzV3iP2tqOR2gJhkEImH8wPSJTYQTaswLrJsxMNTvwaxYUKAG8oSLey
UdyiY/LhS8EfknzMDHE1zWvno8MC2lg3ZlNO++rGFWlAHw/PuGgmcMk7xuGj44Pz
55MJKFrCcmqImwmfcTv9NsgOaNZRFLzdOzGc/QX47JhWQQVlAUt3Pu3aKhbZo5t4
0ywSGlEM+T/EhjVaoEo+K14NQZMYVQ==
=qoT6
-----END PGP SIGNATURE-----

--raC6veAxrt5nqIoY--
