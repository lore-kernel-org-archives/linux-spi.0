From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 05/11] spi: spi-ep93xx: use devm_clk_get()
Date: Wed, 3 Jul 2013 23:51:17 +0100
Message-ID: <20130703225117.GH27646@sirena.org.uk>
References: <201307021008.22347.hartleys@visionengravers.com>
 <20130703182125.GZ27646@sirena.org.uk>
 <ADE657CA350FB648AAC2C43247A983F0021DAC39039F@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q3ujDxr0EyD34e0X"
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	Ryan Mallon <rmallon@gmail.com>,
	"mika.westerberg@iki.fi" <mika.westerberg@iki.fi>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>
To: H Hartley Sweeten <hartleys@visionengravers.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ADE657CA350FB648AAC2C43247A983F0021DAC39039F@AUSP01VMBX24.collaborationhost.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Q3ujDxr0EyD34e0X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 03, 2013 at 04:12:39PM -0500, H Hartley Sweeten wrote:

> This commit is in linux-next which is what the patch series was based on.
> I'm not sure what branch you applied that patch to.

I'll apply anything to topic/ep83xx branch.  Which I'll probably rebase
against spi-v3.11 now since Linus pulled the tree for the merge window.
The bits per word change was a cross subsystem thing so ended up on its
own topic branch.

> If you need to drop my previous patches that you applied to topic/ep93xx
> in order to sync things up please let me know how to proceed. There are
> four more patches pending for spi-ep93xx to finish the cleanup and convert
> it to the SPI queued driver infrastructure.

I'm waiting for others to review and/or test them since there seem to be
several interested people.

--Q3ujDxr0EyD34e0X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1KriAAoJELSic+t+oim9D/gP/0wARntDbJGr5n6wj4DltuZW
YZkONLHs1+mxZ/ZpkRQJDIHS7hmFPBGkO6omh0SsX8XkFRGkY92xkMhCKjjH+x6F
5Nc9676uOWtX3tAN1bqEfhB8T0sDVikk8srJIsej404t7d6jngzxW5Kf/0PAlWBQ
5XrtaKoM6mcETREDq9mSTQSKZtoV373UOp9Mc5uZ18QjOyUzMQiwFE5TsjDGZXDK
KljxOEv5QzDZ5ppKAIY5V2JOTAATaO0DCpqbFa7NhhXIEa/wXDYZiF+jFYnWoXQ/
n35V7WfCfv7RiknpNVQf5zYYNP0aM6RTJ5i11vA/fDKHjr/39ZxnygMLXgxsVCQr
kmpabVCjAkPur1BiT4gl3nw6uWTCLATmD61s/oJDETiJ/u0ILdX2pGr2e0sjKV8v
qu4EvIooTSntB0LE1LdoPp1p/XSZihhH9P0f8XxfBSYaRQ7ULtG7bM2RtGXmx42b
yzC9W0ZC35PEKMHwuugmxfgd7Z/zQGfI2I5v/lme8+GeWMMNAVtfucZEoZx4BGOd
9Ic+ouAuBvKyS+3pQLvPt1gGQ2plC5m2w7S9yrHkzBRdSZDb7lYd3GicEB78ATQW
q3KMfIZPG/MF5EMxbFjrR0LuyMObIZL24kMgCS63eM2SUuv+LA+jozBnZoNfIYn8
PUycjfBTIBwIFdSCZGxY
=Yqmc
-----END PGP SIGNATURE-----

--Q3ujDxr0EyD34e0X--
