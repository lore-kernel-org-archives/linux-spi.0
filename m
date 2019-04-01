From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] spi: tegra20-slink: change chip select action order
Date: Mon, 1 Apr 2019 16:17:53 +0700
Message-ID: <20190401091753.GP2059@sirena.org.uk>
References: <20190329174411.13832-1-gaireg@gaireg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QKpLca3blcvhMJ0W"
Cc: Sowjanya Komatineni <skomatineni@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Randolph =?iso-8859-1?Q?Maa=DFen?= <gaireg@gaireg.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190329174411.13832-1-gaireg@gaireg.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--QKpLca3blcvhMJ0W
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2019 at 06:44:11PM +0100, Randolph Maa=DFen wrote:
> To transfer via SPI the tegra20-slink driver first sets the command
> register, which contains the chip select value, and after that the
> command2 register, which contains the chip select line. This leads to a
> small spike in the chip selct 0 line between the set of the value and
> the selection of the chip select line.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--QKpLca3blcvhMJ0W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyh1z4ACgkQJNaLcl1U
h9BDYgf/YxJE2IHgyTgkto9LXOZqZugnVydpvQUWbP2oMfH2WkmNmnGlkfheNMCX
CG7QiiEJ1ynANmzUkhSa7TZ6dVYDKc2Jrd58Bth540GSOhL9ceRsueaHtcH/glYs
qDuha+hrPYhrQT3x9YcgS1lr6fzTO62aypzjX0cc/CcNcPzURQL9FOuMHtFyElG3
SVHWVIBJnrMGac4te496gGdZe2oXBOv5QN9jcViRvRGQSYCJX2NJpyfpQmWj9sbZ
H3d1N1gfc53ailiOM9JVKmjTQgOR8r9XADjukWUw/NUwDyJw7RgAcWEj3VGo7Sen
6pEk4fP6z+P8lYmEX1OD3zTnNz9Bcw==
=406+
-----END PGP SIGNATURE-----

--QKpLca3blcvhMJ0W--
