From: Mark Brown <broonie@kernel.org>
Subject: Re: [LINUX PATCH v2] spi: spi-mem: Fix build error without
 CONFIG_SPI_MEM
Date: Wed, 10 Apr 2019 11:31:06 +0100
Message-ID: <20190410103106.GE6106@sirena.org.uk>
References: <1554875085-25350-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CGDBiGfvSTbxKZlW"
Cc: yuehaibing@huawei.com, vigneshr@ti.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        michal.simek@xilinx.com, nagasuresh12@gmail.com
To: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1554875085-25350-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--CGDBiGfvSTbxKZlW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2019 at 11:14:45AM +0530, Naga Sureshkumar Relli wrote:
> When building with CONFIG_SPI_MEM is not set
> gc warns this:
>=20
> drivers/spi/spi-zynq-qspi.o: In function `zynq_qspi_supports_op':
> spi-zynq-qspi.c:(.text+0x1da): undefined reference to `spi_mem_default_su=
pports_op'
>=20
> Fixes: 67dca5e580f1 ("spi: spi-mem: Add support for Zynq QSPI controller")
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>

Why is there a signed off by for YueHaibing here?  Did they write the
patch (in which case the authorship is incorrect)?

You've also got an extra blank line between the Fixes and the rest of
the tags which is unusual and might confuse some tools.

--CGDBiGfvSTbxKZlW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlytxeoACgkQJNaLcl1U
h9DUkgf5AWdnX2ZIBdbQt2YsEIvuq/qHrPSwZocJ8bSg/uUdDc+JTMSfV/kTo6oz
tfu0H86NODC8oFErYo4tvPxv4oVyKJxwm+mpa2yGdzzN7cLe+FZYzyxhZ6DhsihF
h0afCMoCV8uesIbntwp//g60MaYPVVgQzRNzc69mQxeB5U0VBSvPo3r93Cv2yMvx
DwjQBgIaYPDbYKiSRJsgnlYEx1AOnMsi3aJdI9DJHlzjnQRRA0C6Iip9psSTyf95
HArQmhLb57lOi6/AVpR/Z7sf3NJ3ApIO7J43i96QM0//K+hZsFXMu3+mvklk5Q4f
CNzeO+U+1p9QciX9GCxjgZAizmUDpg==
=kxip
-----END PGP SIGNATURE-----

--CGDBiGfvSTbxKZlW--
