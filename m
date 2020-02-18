From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/2] rewrite mtk-quadspi spi-nor driver with spi-mem
Date: Tue, 18 Feb 2020 12:55:57 +0000
Message-ID: <20200218125557.GD4232@sirena.org.uk>
References: <20200215065826.739102-1-gch981213@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/3yNEOqWowh/8j+e"
Cc: linux-mediatek@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Chuanhong Guo <gch981213@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200215065826.739102-1-gch981213@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 15, 2020 at 02:58:24PM +0800, Chuanhong Guo wrote:

> To keep patchset small for easier reviewing, there will be 3 patchsets
> including this one.
> 1. add the new driver, which is this patchset.
> 2. update existing dts for the new driver:
>    spi-max-frequency is missing in current mtk-quadspi binding. Old
>    driver parses child node manually so it doesn't need this, but
>    new spi-mem driver is probed via spi subsystem which requires the
>    presence of spi-max-frequency. Since this doesn't break old driver
>    support, I'll send this separately as a standalone patch.

This is an ABI break so you shouldn't be doing this, if the existing
binding works it should continue to work.

> 3. removing the old driver. I'll create this commit after 1 and 2 are
>    applied to avoid possible rebasing due to any changes in the old
>    driver.

This isn't great as it means we have a period with two drivers for the
same thing in tree which is at best going to be confusing.  There's no
advantage to splitting this out.

--/3yNEOqWowh/8j+e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5L3twACgkQJNaLcl1U
h9CQ0Af/bCSGtGQh9O/SezBLGjZ59DSJjcG/kJ2CB/e5Ub3WkveUKq3prcIpbWRZ
j7LZ1+3P0+IQJC2b4wWFTf6xOOoucP4Qb1qVBc1HyBt9SrqrrZ3SdEXzhbsYJ1Zq
tLGrQ37qdRhfSpspLm1N3FN+EBZuVW3tYPclxUjkHTE50mu0wmMAk4OXtrbyBKp7
H046klgqVPBXzTlP8mFTtp0/E/hYhrBUTqcEcUBTAw3nCMBMiVxUjdxRx+tB41CR
TBBlM9+VwbxRbrzZC9IL5S+l+Bi9EW2axbZ2zFG7vOTc+AoCIT/PxwyZBshr8Xoh
A7hM2b6D+BSbpRcPwjpZLi3E11d0ug==
=CyQ7
-----END PGP SIGNATURE-----

--/3yNEOqWowh/8j+e--
