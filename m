From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: spreadtrum adi: add hwspinlock dependency
Date: Thu, 5 Oct 2017 13:22:44 +0100
Message-ID: <20171005122244.6avlzy6vl44326c4@sirena.co.uk>
References: <20171005121129.531046-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fr33zswgrm2mxzyg"
Cc: Baolin Wang <baolin.wang@spreadtrum.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171005121129.531046-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--fr33zswgrm2mxzyg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 05, 2017 at 02:11:17PM +0200, Arnd Bergmann wrote:

> This adds a hard Kconfig dependency on HWSPINLOCK, which is the
> simplest solution since we don't care about building for the case
> without HWSPINLOCK.

Given that there are stubs for HWSPINLOCK it'd be good to also have an
|| COMPILE_TEST in there, otherwise what's the point in the stubs?

--fr33zswgrm2mxzyg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnWJBQACgkQJNaLcl1U
h9CmZwf/R9CH5V/JrDuuO3eW1XcWSOfZ9UpUbVDWzwW+bpfgxpsCU0WexSvFBMfu
mkQw1JR2Z6wDf+RfunQ9yK+URHq2GVcF2C6ZhTa4pdVXMWytWTiQX380ZzHynMVV
+UHlmge6TJAUbEo87klFLS8zcgn6NbcBtFB9eTVQ2MbvsNlS7CoUM+mwwwDM/WRc
K2T39PtEGx2vryRdN3Luuff/3Yr4x5xxsT7kDEBvJ3azvLE4ea/yTJOACXz3z3X2
hzAUqo6ZHsZh6HxmawB11iCrEVDUqVLJ4tvmDaHlUAk/kIuiOffA+GS1T58FS9d/
2EPm4Yr7R7ntc13h57V4k3Qr3GpYHw==
=zmsN
-----END PGP SIGNATURE-----

--fr33zswgrm2mxzyg--
