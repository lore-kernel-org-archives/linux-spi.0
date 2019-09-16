From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 03/15] spi: make `cs_change_delay` the first user of
 the `spi_delay` logic
Date: Mon, 16 Sep 2019 13:47:08 +0100
Message-ID: <20190916124707.GD4352@sirena.co.uk>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
 <20190913114550.956-4-alexandru.ardelean@analog.com>
 <20190916122505.GC4352@sirena.co.uk>
 <ae469c65828443524f9ff0409f1c7a81bf64cf6b.camel@analog.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cd1j4nHwcOEAktEG"
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "baolin.wang@linaro.org" <baolin.wang@linaro.org>,
        "bcm-kernel-feedback-list@broadcom.com"
        <bcm-kernel-feedback-list@broadcom.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "orsonzhai@gmail.com" <orsonzhai@gmail.com>,
        "zhang.lyra@gmail.com" <zhang.lyra@gmail.com>
To: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ae469c65828443524f9ff0409f1c7a81bf64cf6b.camel@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--cd1j4nHwcOEAktEG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 16, 2019 at 12:37:12PM +0000, Ardelean, Alexandru wrote:

> > This breaks the build as there is a user of this interface.

> Ack.
> Jonathan pointed this out.
> There's a V3 that changes both this and it's user (in IIO).

That v3 seems to be a small subset of this series?

--cd1j4nHwcOEAktEG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1/hEsACgkQJNaLcl1U
h9BGGQf+KEkdqu8sl97blIC9u02sAznBDKI8WBw8hq8w1EI3irkrZZsjLo+22UTB
cUIp8bzIXq5GQ/ZbRPTG/jQOKc44E8gajZBxhWc9bFF2oNQQUy/9H5JoIgeUQspk
Nd6lo3EyKLFHLHHc2zLeYt0HK70RKJHO09MRciWmJBDWoanZC0x7wohRuvJvoNy5
nbtGX9+mdgIqsp17Z4RrDvr4hr1d8vPOHSl54jA0L8y+M+qo4Zcn9WvJ9WXybVZL
yik9wnQApavBdBrubRMqnUri/p6fvp6yGGYKJlNssskGyKB8RoNFqNWSA2YAshPi
WxdlbuP6o9Qq/Twrv5sM9fj02xApyw==
=zm0D
-----END PGP SIGNATURE-----

--cd1j4nHwcOEAktEG--
