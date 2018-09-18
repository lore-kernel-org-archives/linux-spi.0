From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/5] dt-bindings: spi/spi-pxa2xx: add PXA2xx SSP SPI
 Controller
Date: Tue, 18 Sep 2018 10:43:03 -0700
Message-ID: <20180918174303.GU2471@sirena.org.uk>
References: <20180917113559.11101-1-lkundrak@v3.sk>
 <20180917113559.11101-2-lkundrak@v3.sk>
 <20180917175753.GE2471@sirena.org.uk>
 <54f5d070c8b0615baa26983e97e2a22401973096.camel@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4WCFFtl4AQpQKunj"
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
To: Lubomir Rintel <lkundrak@v3.sk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <54f5d070c8b0615baa26983e97e2a22401973096.camel@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--4WCFFtl4AQpQKunj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 18, 2018 at 02:15:12PM +0200, Lubomir Rintel wrote:
> On Mon, 2018-09-17 at 10:57 -0700, Mark Brown wrote:

> > > Changes since v1:
> > > - s/ssp@d4035000/spi@d4035000/

> > As covered in SubmittingPatches please put inter-version changelogs
> > after the --- so they don't end up in the commits.

> Will do. I was actually not sure about that, so I took a short look at
> the git log, and it seemed to me that commit messages with the
> changelogs are quite common.

For various reasons the drm subsystem explicitly does the opposite
thing and it does leak out in other places (eg, when someone does it and
then it doesn't get fixed up), it's a bit unfortunate that there's some
divergence here.

--4WCFFtl4AQpQKunj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluhOSYACgkQJNaLcl1U
h9AHkgf/cCVVEd+WCSVik9ryhlUhC1/wAgNrQri8wZDg/H5Ljb+1eVnzdtry1IHU
7sarVWP9dxDqyBro75/ECWPrB6+JEtOJ890j6eyf/4gpBjqSip0/4AKEBAT8ormp
wL4CSLpyCQhzOkeOKXVHS5la+tUFvbzcstJnzDl4hT6FoOFEJ3zPnOZOvBw3+HNT
zbcI3SiHIR+Mpp92Mn+ZhEA8tCDrSUyGMUXYxPlGMIT+0+wYdlubXDWFCQOrPQIm
VSe+0t7pM5yHPMWDkpUm00mFR3Q0LEGtsMpIAnkxu2yzYQyBC/TtV5ajoCkmqdJN
XXtDt31ZU8YSXyMeSw7Oh9XLEOdJZA==
=/CR4
-----END PGP SIGNATURE-----

--4WCFFtl4AQpQKunj--
