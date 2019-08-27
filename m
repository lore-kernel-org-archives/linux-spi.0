From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 5/5] ARM: dts: ls1021a-tsn: Use the DSPI controller in
 poll mode
Date: Tue, 27 Aug 2019 19:05:02 +0100
Message-ID: <20190827180502.GF23391@sirena.co.uk>
References: <20190822211514.19288-1-olteanv@gmail.com>
 <20190822211514.19288-6-olteanv@gmail.com>
 <CA+h21hqWGDCfTg813W1WaXFnRsMdE30WnaXw5TJvpkSp0-w5JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rwlp4HDnqjg7pxzw"
Cc: linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawnguo@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+h21hqWGDCfTg813W1WaXFnRsMdE30WnaXw5TJvpkSp0-w5JA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--rwlp4HDnqjg7pxzw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 26, 2019 at 04:10:51PM +0300, Vladimir Oltean wrote:

> I noticed you skipped applying this patch, and I'm not sure that Shawn
> will review it/take it.
> Do you have a better suggestion how I can achieve putting the DSPI
> driver in poll mode for this board? A Kconfig option maybe?

DT changes go through the relevant platform trees, not the
subsystem trees, so it's not something I'd expect to apply.

--rwlp4HDnqjg7pxzw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1lcM0ACgkQJNaLcl1U
h9CfVggAgkZmmBRw2FvR5lO8tg9fAeeferqRJaLr9OpPEupYK4uNoP3Z/zg0Ge9A
O2/56jU1C+jO19IuuQ8zXPAInWSRRLaL/2b0epnxsTRz+NjGzTw5W+4BptoYV0nY
ZVdNbujRph1lSOZwk5vg6ae7U5DKvn33ygXHuCCagrvSlr6dqhXlBBHynn/5U7wy
Nb3mKneIUHaVHbTpcYbFTQTvojd84LkakJsh9gq0lWBZaeyZ8wJYh5rp/iCpinh7
CuPTCnTmxsQq8kfvfCrWR2bcvV1HxhCJIlmxZ/DnNduwhYQ1de9CCcNKzYpEKtWj
iQI2M/wERU2Kt3hCXw1m63+fKmtSIQ==
=E72x
-----END PGP SIGNATURE-----

--rwlp4HDnqjg7pxzw--
