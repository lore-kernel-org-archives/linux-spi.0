From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] spi: spi-gpio: Add checks for the dt properties
Date: Sat, 26 Jan 2013 15:36:14 +0800
Message-ID: <20130126073612.GP10580@opensource.wolfsonmicro.com>
References: <1359103175-26304-1-git-send-email-maxime.ripard@free-electrons.com>
 <1359103175-26304-2-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vEfizQhTV1P/vojJ"
Cc: Shawn Guo <shawn.guo@linaro.org>,
	Brian Lilly <brian@crystalfontz.com>,
	linux-arm-kernel@lists.infradead.org,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1359103175-26304-2-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--vEfizQhTV1P/vojJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 25, 2013 at 09:39:34AM +0100, Maxime Ripard wrote:
> The bindings assumed that the gpios properties were always there, which
> made the NO_TX and NO_RX mode not usable from device tree. Add extra
> checks to make sure that the driver can work if either MOSI or MISO is
> not used.

Applied, thanks.

--vEfizQhTV1P/vojJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRA4deAAoJELSic+t+oim9aLwQAJWewq7M1O/o/7otLNU/pkbu
P6sIMzGMG5FHYnV7tFHgs4rTRfy/cEJeqzaG2+IVivZm9RS6rI0r9i40Wto575yL
7adroT0qCQFNOhLXo2ajtA0mjoDTi3xOTPgBSStHY4rURvCReTh2bzuFloyhDRSJ
tSCrC/FvNUjD447cYrWBQBJ9W6nYZ6Cr76D2tEczOyxgiLbA6UOWsOMidMJ9tuub
BPZm5sOtsNifugduiOX7WuwvyF2dAN3hxNndrz+kSEzW6w39z+mBDpcB22jh4WrA
/PYymQWXKeHGWHDX6HD/6E9dzP5tw5/rmNJaQj261MRtdbYeGGsFRvpmzkofAkh8
N/LvqPNvbcWgZA3oHGsP3kGx8jhOrK4RTQlzrTmLgmOEZPa4gW5rn+OLS60e0DQr
+96QRJlnxVRCj3V7/kVsPr+s88/MFHX8Qx+ei4m+mvGAsqASi2OR93kS0soDStxo
G8rfebtX78Y5JHMTHpT7GJ+2K5fbGPGPb6/xTPWpazaP5YLS6IRV2gZ/b3ervoAP
Sxc6s1V9VEb3izdcoqBKl6eV3dMYT4RGKTml5lhxLyq93uQmj7EeOJT1yi6BJM1p
rJk2jCZDGrETpIMcWVn8UZF4ayhzFURl0umcoqLIxR/rPiASAfMmhQFREu5ncAmT
ZcgESGZwDkH6rEoPBziW
=xxKH
-----END PGP SIGNATURE-----

--vEfizQhTV1P/vojJ--
