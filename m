From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: bcm2835: Allow platform to set realtime priority
Date: Thu, 23 Mar 2017 15:46:07 +0000
Message-ID: <20170323154607.nho3wdtzxwax4dcn@sirena.org.uk>
References: <c1ca8a5522272d06f5c3fb67d8442f148b2d6cfb.1490264661.git.lukas@wunner.de>
 <1503363fcfb92adfa765d1c1c3e69fc673e72dde.1490264661.git.lukas@wunner.de>
 <20170323110718.sncw32gspvls75u7@sirena.org.uk>
 <20170323120257.GC20546@h08.hostsharing.net>
 <20170323122118.i2gc77debz4eu5hq@sirena.org.uk>
 <20170323134336.GA10576@h08.hostsharing.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hw4uyu4l47wix3ry"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Mathias Duckeck <m.duckeck-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>,
        linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
        Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170323134336.GA10576-KMaqurgeqYRAE5l8fViCMtHuzzzSOjJt@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--hw4uyu4l47wix3ry
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 23, 2017 at 02:43:36PM +0100, Lukas Wunner wrote:
> On Thu, Mar 23, 2017 at 12:21:18PM +0000, Mark Brown wrote:

> > This was being done via platform data not via device tree, unlike
> > platform data device tree should provide a long term stable OS neutral
> > ABI.

> No, specifying it via the device tree was subsequently added with
> commit 39a6ac11df65 ("spi/pl022: Devicetree support w/o platform data"),
> sorry for not mentioning this in the commit message.

> There's already a bool in struct spi_master for this functionality and
> device tree support for pl022, so I don't quite understand why converting
> the bool to an int and adding device tree support for bcm2835 would be
> the wrong approach?

The presence of the device tree support for pl022 is an oversight during
the initial DT transition.  It's perfectly fine for the functionality to
be there and used in running systems but it's not something that makes
sense in device tree as it's too much of an implementation detail.

--hw4uyu4l47wix3ry
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljT7b8ACgkQJNaLcl1U
h9AujQf/XG31w/688OL8KibnEnWS9GqzjbgFMVPbpXuG2YciLY4Eu3TvpGoV3WRT
aeBs+AYftnurLmL3LYYYcbF2xleVrpHjJtnEBFsY0kxesIeENWVqCAwd5ERnyh4s
zOwfADojB+zRgcDELUkvKHuMJOHKpAfxn+L+wTuHUiro05SgJ3DjdAFGAf3OvP25
683lbG1YdflKpAPtYcV6DCRZEhhfWoqMkxHCcIFgGWoY1bbIBXPd+LFz+P6Zfo3c
xN/OkwEyBPPqShuC8i4teC5wPzZEbM96oDcXuxs1AHLwj8GCqr4ankjejNz+OcGM
5HvDd1RiOvbBuDvs9jgcIqIbjeEy8g==
=rg3J
-----END PGP SIGNATURE-----

--hw4uyu4l47wix3ry--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
