From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 2/2] spi: cadence-qspi: Add QSPI support for Intel LGM
 SoC
Date: Mon, 16 Sep 2019 12:32:55 +0100
Message-ID: <20190916113255.GA4352@sirena.co.uk>
References: <20190916073843.39618-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20190916073843.39618-3-vadivel.muruganx.ramuthevar@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GlsaLUDw2IYctviq"
Cc: robh+dt@kernel.org, mark.rutland@arm.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com
To: "Ramuthevar,Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190916073843.39618-3-vadivel.muruganx.ramuthevar@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--GlsaLUDw2IYctviq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 16, 2019 at 03:38:43PM +0800, Ramuthevar,Vadivel MuruganX wrote:

> Existing cadence drivers do not support SPI-NAND, it only supports to
> SPI-NOR and SPI devices. To state that is the driver for the same IP
> but due to different SPI flash memory(NAND) need to write from scratch.

What makes you say you need to write a separate driver?  It's perfectly
possible to support the normal and flash I/O mechanisms in a single
driver and as well as the maintainence issues obviously someone could
build a system with both flash and non-flash devices on the same SPI
controller.

--GlsaLUDw2IYctviq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1/cuYACgkQJNaLcl1U
h9BZEgf6A7cU/9Mcguk8zxT6d8uwEkFrWUSeIxR2aztdTbp5LhL6rUcO3xLsgkCU
dZ4JAbLPoGgs259OdM22+ZBgdzs5V8Bkz26IQCdOgkGfM3I4EzUjVbDuxyLS4DBx
MjkIMJESszbMzK5OpYQZHnPFixsF3h0KPqysktr58CeUPzfGAXVaIuVsmT0lSfHq
DaDjUL2Zn7j8rgpA2/EM1sMyPiF1qTav07LBJ8ih7Z92W14/mO9TlWypJdfsB2dX
aIpIemsrom83swwKBsCXHRU8sB6cbz35Sx3Mx0Z3lM6dhALcHdRE4xCiWwGIbpNT
EEb1sXnWRIKgHh0uV8e/AoiT5S4bjg==
=kev6
-----END PGP SIGNATURE-----

--GlsaLUDw2IYctviq--
