From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 03/15] spi: make `cs_change_delay` the first user of
 the `spi_delay` logic
Date: Mon, 16 Sep 2019 14:43:09 +0100
Message-ID: <20190916134309.GH4352@sirena.co.uk>
References: <20190913114550.956-1-alexandru.ardelean@analog.com>
 <20190913114550.956-4-alexandru.ardelean@analog.com>
 <20190916122505.GC4352@sirena.co.uk>
 <ae469c65828443524f9ff0409f1c7a81bf64cf6b.camel@analog.com>
 <20190916124707.GD4352@sirena.co.uk>
 <458cbb212fbd04c157c9861501f51c03ea958302.camel@analog.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="u0lqphHC8S+ob1K0"
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
In-Reply-To: <458cbb212fbd04c157c9861501f51c03ea958302.camel@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--u0lqphHC8S+ob1K0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 16, 2019 at 01:04:42PM +0000, Ardelean, Alexandru wrote:
> On Mon, 2019-09-16 at 13:47 +0100, Mark Brown wrote:

> > That v3 seems to be a small subset of this series?

> Ack.
> V3 is the first 4 patches from this series.
> Well, patches 3 & 4 are squashed.

> I am 100% convinced that the entire series is a good idea.
> In the sense that a `struct spi_delay` may be a good idea, but at the same time, it may be un-needed.

> All I wanted to do, was to add another delay somewhere, and got lost in the rework of current delays.
> I thought about proposing just the first 4 patches [on their own], but I thought that showing the current series as-is
> now, may be a good idea as well [to gather some feedback].

I think it makes more sense to review as a whole series rather than only
a part of the conversion, it doesn't really help to only do part of it.

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

--u0lqphHC8S+ob1K0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1/kW0ACgkQJNaLcl1U
h9AhYQf/a5Mv8ax53FhE2w2Iee+bq5bvfdkZRudCki/iqJxBUwCNKGfc62eBUwGY
qva3K4T6zi4pbX0dWNMojeJ5lQ7Viu2bnR20voTcVJhOmplIgWhH57tVxRU5bnRt
9205UV5Uc2FNDE1P60lC6Msts6I+8Rzx/a20fZ8pyXlVwOW4n0xxEkiMxYgg5mpo
BbGVM5rYkasqqmq8KjbIKWYl/XwcWDIKw8mlyAuLAq4Vh8KRGfu+kRUY3IqNzDIj
puzpCj6MJZW/8pzNfi/z6Lelkhtvmn04gEu0pMN2C1u9ILeUxixwtqQPv64qTR7I
ySxA++9//Vej3QKiuzfu/u+eDK6+WA==
=nPuT
-----END PGP SIGNATURE-----

--u0lqphHC8S+ob1K0--
