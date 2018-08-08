From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] spi: sprd: Add SPI driver for Spreadtrum SC9860
Date: Wed, 8 Aug 2018 10:31:48 +0100
Message-ID: <20180808093148.GA9346@sirena.org.uk>
References: <64681bf903104c8a02f118294e616e2a12a5ebe4.1533638405.git.baolin.wang@linaro.org>
 <99befd2badc4dffb59662fca1e11d79f18b64755.1533638405.git.baolin.wang@linaro.org>
 <20180807142408.GB7958@sirena.org.uk>
 <CAMz4kuL2=7mNHLoTg7hjA4NjfGgNQ-mBJBSE8uMb0oqwnU1=Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        lanqing.liu@spreadtrum.com, linux-spi@vger.kernel.org,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMz4kuL2=7mNHLoTg7hjA4NjfGgNQ-mBJBSE8uMb0oqwnU1=Yg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 08, 2018 at 10:45:33AM +0800, Baolin Wang wrote:
> On 7 August 2018 at 22:24, Mark Brown <broonie@kernel.org> wrote:
> > On Tue, Aug 07, 2018 at 06:43:38PM +0800, Baolin Wang wrote:

> >> +     bits_per_word = bits_per_word > 16 ? round_up(bits_per_word, 16) :
> >> +             round_up(bits_per_word, 8);

> > Please

> Sorry I did not get your points here, could you elaborate on?

Sorry, missed the actual comment there - use normal if statements rather
than the ternery operator, it's easier to read.

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltquIEACgkQJNaLcl1U
h9D8Lwf+J5prKQ102tAnrwIbX+bnTbGLWbzHy/xe9I5LurjAiiD71625mnUJpUa6
wySqLkDVivSopvk0Kep3i6i1M7CGRHHJucqFNe631u8ZahigQ9yE9CM8IVQxkqEY
vfg6FCLyGxqGk5BCbjOHnqHDznkCsKVLYRPyp5QrPo8OxX1IvjZASba2Unksiyov
ivsRL8LCBFHtzynR07kIvjMDYkulC6E0H2VsQE8fNAbrOfTd+WD4Ht8L2gj0PY+t
GWBUX5H+wQmYNo+aSrwartUsw9SpHF8/O6yk1X9nIOlOEWC64FF3YGw87EcP4HOM
XA7NKASPkS8NEYZR3pDoOR3OeyViqw==
=rz+7
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
