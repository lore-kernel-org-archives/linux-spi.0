From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [Question] Can of_find_spi_xx_by_node be moved out of
 CONFIG_OF_DYNAMIC in SPI driver
Date: Fri, 15 Jul 2016 11:58:41 +0100
Message-ID: <20160715105841.GE30372@sirena.org.uk>
References: <5786E7C0.4050709@asrmicro.com>
 <20160714101128.GK9976@sirena.org.uk>
 <5788446E.9080601@asrmicro.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xJK8B5Wah2CMJs8h"
Cc: pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: qiaozhou <qiaozhou-XOWFcpiLszpWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5788446E.9080601-XOWFcpiLszpWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--xJK8B5Wah2CMJs8h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 15, 2016 at 10:03:26AM +0800, qiaozhou wrote:

> My case is like this: I got a ARM mali-video driver, which may have several
> ports/endpoints, which needs I2C/SPI interface to do some initiation. In the
> video driver, it uses device node conf to find matching ports, and calls

This sounds like a fairly standard setup, most external HDMI encoders
are I2C and SPI controlled, which already works fine as far as I'm aware.

> functions, such as of_find_video_tx_by_node -> of_find_i2c_device_by_node.
> Now the hardware changes from i2c to spi, so I wonder whether
> of_find_spi_device_by_node can be used freely. Otherwise I may need to
> modify the mali-video driver, and as it's provided to us and may get updated
> from time to time, my change may be conflicted with future versions.
> Also I didn't quite understand the way to "use a phandle to connect the two
> devices", is there any code/driver which I can take as a reference? I'll
> study it.

Off the top of my head something like the TDA998x or ADV7511 should be
worth looking at here - it just sounds like the the Mali driver may just
not be using the frameworks well, you should probably encourage people
to get it upstreamed.

--xJK8B5Wah2CMJs8h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXiMHgAAoJECTWi3JdVIfQ7AgH/jkTrSUFXyS7NUVSKTZjU+3c
G1Y5ERjDQ3c2+DZ7df/hDvHNFdRVXJCJcqRtvr8x6AMZWXGebPCbO3n/6Yc1RUUI
XQ2Jd6TLscS2olS7D4ZLVJ2bihD6jIbCyD2Jg6wES7Ig7xNLrhW1X2wMa/lPGqSd
Jenci9NLY3oCWGLOgTKO7ffpXalpq0EUtcCGVd6qDPOekAz5nEguS9xUMiH20Y9D
xxdpPBThdNZ62n1ykKs9OihDUV4OFyXScBmNlWkiFT5dlUmWemine8nbL6e63epY
ai7S+wrggHjoNVArCylVO3DpQM4szNqTBVlRUC2q3nHcFal6pihbsNJb0TkA4ck=
=qbxS
-----END PGP SIGNATURE-----

--xJK8B5Wah2CMJs8h--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
