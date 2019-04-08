From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 14/20] spi: tegra114: add support for gpio based cs
Date: Mon, 8 Apr 2019 13:30:22 +0700
Message-ID: <20190408063022.GK2803@sirena.org.uk>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
 <1554423259-26056-14-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1y1tiN5hVw5cPBDe"
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1554423259-26056-14-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--1y1tiN5hVw5cPBDe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 04, 2019 at 05:14:13PM -0700, Sowjanya Komatineni wrote:

> +		if (cstate->cs_gpio_valid) {
> +			int val = (spi->mode & SPI_CS_HIGH) ? 1 : 0;
> +
> +			gpio_set_value(spi->cs_gpio, val);
> +		}

This is adding new usage of the numbered GPIO interface but we're in the
process of trying to transition to GPIO descriptors.  Please update this
patch to use descriptors instead.

Please also investigate if it's possible to use the core GPIO chip
select support more.

--1y1tiN5hVw5cPBDe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyq6n0ACgkQJNaLcl1U
h9BcSAf+P79lHEqMrW7XuwAWcgHftZesiNc2uJiGMhLmSXW5FIZB0YnxdsMJq9Fk
9oml5tF0sZSunCU5fbZvsVmtvsdfLhf03Qpbi+wvG9Z+OR1IUHwrIRx60nhHBirr
aHqKNt3cJPQX/cNEvJ+v3LAuwe0Y5GB6wrjGbmWsoUFqFd65wzITOm1s6yzJAbN8
w+FQ0n3BnWLi5nk5tjsYUtd55Ha1Q5PFjN1u1G7tw1TJBqAmoWT5XfgSmcaEOQG+
loIcH0KURFQ3rKw6BYGofntwLzaFGGOkAw1HunyW6zJyoRGu4CBFI7R5FyZwXg1W
RU5GmuMxu0im7Vx+Axhh5E0tOu8ucg==
=NNIA
-----END PGP SIGNATURE-----

--1y1tiN5hVw5cPBDe--
