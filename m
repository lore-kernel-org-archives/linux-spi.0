From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5 0/6] spi: s3c64xx: add support for device tree
Date: Thu, 12 Jul 2012 17:16:57 +0100
Message-ID: <20120712161657.GC7256@opensource.wolfsonmicro.com>
References: <1342021265-11212-1-git-send-email-thomas.abraham@linaro.org>
 <20120711174908.GP3938@opensource.wolfsonmicro.com>
 <CAJuYYwQA_x112xqOnQmwZjzoXoR-DAvT8YdB90Wm=78CH72uOg@mail.gmail.com>
 <0fae01cd600e$442ed160$cc8c7420$%kim@samsung.com>
 <20120712130234.GE3957@opensource.wolfsonmicro.com>
 <CAJuYYwS59yoRnyFOR4_M5ymAS5uh0fN5zS=x2CS5Ax-795awBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z4+8/lEcDcG5Ke9S"
Cc: Kukjin Kim <kgene.kim@samsung.com>,
	spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, rob.herring@calxeda.com,
	grant.likely@secretlab.ca, jaswinder.singh@linaro.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJuYYwS59yoRnyFOR4_M5ymAS5uh0fN5zS=x2CS5Ax-795awBA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--z4+8/lEcDcG5Ke9S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 12, 2012 at 07:13:37PM +0530, Thomas Abraham wrote:
> On 12 July 2012 18:32, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > Well, simple conflicts aren't that big a deal...  However, Thomas
> > mentioned that in order to test this he merged the SPI tree into your
> > tree so perhaps there is also a dependency on the SPI tree?  If that was
> > just for good practice testing then I agree that the best thing is to
> > merge via your tree, otherwise we might need to think harder.

> There were no dependency on Grant's spi/next branch. It was merged
> just to ensure that nothing is broken.

OK, great - then the Samsung tree it is.

--z4+8/lEcDcG5Ke9S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP/vhyAAoJEBus8iNuMP3dQ38P/0m4ND3jUnJYH4/DfwgQz0Eh
Fy9fIK6BwxjVeykl9rDvP5GgLq+ckFRcL4aTTGE+GuLWP8QQgnsapzEg+DtdRSj1
hzsJNmOF2eDgX/SgFju3P9pgnd4/N13xOTE7/rujZ4TkcSYohmaGFz18SO5jOdIY
Kvy8zvUch1M4bl7LUFAmdE7qYEI2mQR+JGey+lxCqbAZW45rEXpZrwD6XLcAPXVy
i/zCTsJMA+xqiF5HZrJcOQDHA/Gj+OOwdCq3v2RzwyoVWGC1WkeqcjjdpmxVTDlf
Q4pTzyvhk14u9GHk2IdGCF55XbbLol7tGaMPkrVVLT+8FvwSwrw4JcJykhJ6VZU4
56nYwsiFLWWmMnePE7hTG8RV5n84b8wnaCyLCau97pN5kzCUiEukRWadGhvmjSxc
tJJVjiJCUkVQcgvI8204hAegAwLYAtcBUdXNAdEE+1Oz/2s/QLn+t8Oqpf3d7a5U
7piPIWBuTCbRrLW1omJbb9412rrBiOn4cPAe91vfLLd8zTV9MUhy/qr/DkoY+Jga
AaLLG6v/xLJdD8XSK2+6lrkAxGxbaO7ieLB+LfpkVqp6TjbxlfKGtpIeGla44RbW
8xxmJxHNDXMV4gACU80VZI6pBFZrofA12GlKRoTz+K70jQjr1fCJi+E1eSaF0CLu
bpT31LCsWpoZhY3VKg0H
=zVJo
-----END PGP SIGNATURE-----

--z4+8/lEcDcG5Ke9S--
