From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 19/20] DT bindings: spi: document tx/rx clock delay
 properties
Date: Mon, 8 Apr 2019 14:22:11 +0700
Message-ID: <20190408072211.GL2803@sirena.org.uk>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
 <1554423259-26056-19-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bzq2cJcN05fcPrs+"
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1554423259-26056-19-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Bzq2cJcN05fcPrs+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 04, 2019 at 05:14:18PM -0700, Sowjanya Komatineni wrote:
> Tegra SPI controller has TX and RX trimmers to tuning the delay of
> SPI master clock with respect to the data.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--Bzq2cJcN05fcPrs+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyq9qIACgkQJNaLcl1U
h9CL1Qf+Jzho0wXetIigWcaXeklQTCcQGD/HvADTvRefQVzgKGRbdbYM7XofM95W
d6UkqYM3UZokgjeqckpNZ0YsvlMkUJDXcTAldSA91XHo/rPfnM6VEAtIHLYNZ60K
DyHx7b+AETu8NGFx916xDLSnkzibjXM66JSR/P9IQANLHBiU8xIYWIJ5pHTO2j1h
5Hq9gjGcLRvldhmwpk8OlNSak7MlOb+EYwmKMMvFvLWaivr9w+gyNbtwELL6GaUx
XP9wCV1ZFJs3cKxSg7IL1etBKbvVny/1suM08+0IlniqYDQdlA3LRqQuk4+unkRd
OePcmB7Ut740XUhSQH6ZmV6CykWsQw==
=trro
-----END PGP SIGNATURE-----

--Bzq2cJcN05fcPrs+--
