From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 03/15] spi: make `cs_change_delay` the first user of
 the `spi_delay` logic
Date: Mon, 16 Sep 2019 13:25:06 +0100
Message-ID: <20190916122505.GC4352@sirena.co.uk>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
 <20190913114550.956-4-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7U7nS7UhGMyosb9W"
Cc: linux-spi@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, jic23@kernel.org,
        f.fainelli@gmail.com, linus.walleij@linaro.org,
        orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190913114550.956-4-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--7U7nS7UhGMyosb9W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 13, 2019 at 02:45:38PM +0300, Alexandru Ardelean wrote:

> -	u16		cs_change_delay;
> -	u8		cs_change_delay_unit;
> +	struct spi_delay	cs_change_delay;

This breaks the build as there is a user of this interface.

--7U7nS7UhGMyosb9W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1/fyEACgkQJNaLcl1U
h9AR2Af8D01ThOEZ5vESTf3rqD3pj7SjkSwmXmtdE8km6WNwCuP/WAlc6Lrgj02m
yPoEFSxsQq97A47hALIaE3WogYwp5YTeN4rI8yeELVQItYThT8CPHYaQa8RuWtJB
qIp3h1PlKVmOnSNPtNsW1/rfxxgeJNzX6GZf1UWDHjfkSIexZBrVWgb/YP3p3n2k
YTyaVloShnXeUA6BXfla9Z05BHc5aCu5KBCfLyJ8uTPIeD6mIP6b3ympe6sn6+Kw
i1zrIFYvEU/J2ZN0IaZXsKRMgMD2XRPjaDlMyygOm9hr6y2SGEyOt8ml37ISXJ4w
bFoisz9mWYHBsC9+53nBiKsGV+OrlQ==
=pg1e
-----END PGP SIGNATURE-----

--7U7nS7UhGMyosb9W--
