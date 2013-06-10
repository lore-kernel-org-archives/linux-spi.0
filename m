From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND] spi: s3c64xx: Fix pm_runtime_get_sync() return
 value check
Date: Mon, 10 Jun 2013 18:04:18 +0100
Message-ID: <20130610170418.GN1403@sirena.org.uk>
References: <1370881346-28000-1-git-send-email-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UExESr5xZTMxdOWv"
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	kyungmin.park@samsung.com, spi-devel-general@lists.sourceforge.net
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1370881346-28000-1-git-send-email-s.nawrocki@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--UExESr5xZTMxdOWv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 10, 2013 at 06:22:26PM +0200, Sylwester Nawrocki wrote:
> If the device is already in a runtime PM enabled state
> pm_runtime_get_sync() will return 1, so a test for negative
> value should be used to check for errors.

Applied, thanks.

--UExESr5xZTMxdOWv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRtgcPAAoJELSic+t+oim9paoP/jkM2dFIJg/QPdlwbgxU4Rsi
5kgbSYlQUCPi1F7CNHc/ZZfeGY8WDslFzMRyTId0EbvdcvUKk0bYPx+qC107vawS
SQAZBB2e4YxGdCFlYkrE5dShXwq5kxoHIhdM4CqznU5Ktlf6gm1YRZ3D/UZUU5XN
FdIoG2AM+ZkBcH+5NKGhnLGuMe243LRd2rQ/KnpD1aDnzSYcKnnxkmzxODmpzgCR
7erigKIz49MeLUWO/STUbUoZfko5cBIiqrf/e3YET2/ThufJkOuI6is3d5uP8QtA
Ne3R9EOLNiIubtY1EdvCLbA6UflWEqoGIwgQsHktsh3J4rPq2EA8m16TmnlsrVbo
9GzLBPV4iNF4UCb7+NRKfmJdN+89r838OSpUjosdS4ab39ltQhZIRa7QdOwUJh4d
oOz4YcORuasqdnlA+e/dBVpuchTJCsT1GJJXGNGAOYtXJbgzI3+SDPcnP3ZjVluk
j+9HbJh1wUCKYS17E2+ffXrcOB3+fEP3RPNi0f9H+FccT/e/tZprFU5/iOHv3JoS
CCBMumhyAszMn+kkmujKlLn+oxEXy1H9Bx85+1bUsqRq5AFdWDxhyCMnoNQ476zr
9/pKiME/lmUKKT1mWTYhhkLF1/GgPqWNTSN+4Mlh2CekafqkFdiNHnyiQY438kLp
9R0im3GVhwLP/EyO63tf
=y3wE
-----END PGP SIGNATURE-----

--UExESr5xZTMxdOWv--
