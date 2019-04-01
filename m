From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V1 24/26] spi: tegra114: de-assert CS before SPI mode is
 reset to its default
Date: Mon, 1 Apr 2019 14:49:40 +0700
Message-ID: <20190401074940.GL2059@sirena.org.uk>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
 <1553666207-11414-24-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iAzLNm1y1mIRgolD"
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1553666207-11414-24-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--iAzLNm1y1mIRgolD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2019 at 10:56:45PM -0700, Sowjanya Komatineni wrote:
> With SW CS, during transfer completion CS is de-asserted by writing the
> default command1 register value to SPI_COMMAND1 register. With this both
> mode and CS state are set at the same time and if current transfer mode
> is different to default SPI mode and if mode change happens prior to CS
> de-assert, clock polarity can change while CS is active before transfer
> finishes.

This is a bug fix so I'd expect it to be much earlier in the series
before any of the new features.

--iAzLNm1y1mIRgolD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhwpMACgkQJNaLcl1U
h9Bpygf/TbdkEy6Q+FfZhGR0lmQSqgaXu3RXuS1Vlv74EsyVNGbcjCDMLRaWVi0z
AEEsy31rNjVe/kqIctYJDlpKWiAo3s/e2PmVOK5AwWBGT6T63WyP4D8Q3zwC4JRI
UuTXIr9aTHD3CLMkfXfRMAmXXHawTabaOReaKwTMqqhNgYdpg1zpmiBM7YvDX3IX
PlE0tAGaRklxIDFdge9wXtHYbCpUC4VbZx4NICsTpF+g2n8iw9CoaimIACa7qRud
hVIzF2eRa80ID4zeltfxlcu4o6YaaE9go/uqQcxknFGDwLKZihiVn8698gANNOFm
hldnv/vWlSWtWsxDuhrwyKvf4usQfw==
=2SUy
-----END PGP SIGNATURE-----

--iAzLNm1y1mIRgolD--
