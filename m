From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI)
 documentation
Date: Fri, 21 Sep 2018 10:39:03 -0700
Message-ID: <20180921173903.GH20825@sirena.org.uk>
References: <20180920224055.164856-1-ryandcase@chromium.org>
 <153755105782.119890.8484594239463905156@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wayzTnRSUXKNfBqd"
Cc: Ryan Case <ryandcase@chromium.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
To: Stephen Boyd <swboyd@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <153755105782.119890.8484594239463905156@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--wayzTnRSUXKNfBqd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 21, 2018 at 10:30:57AM -0700, Stephen Boyd wrote:
> Quoting Ryan Case (2018-09-20 15:40:54)

> > +Required properties:
> > +- compatible:  Should contain:
> > +               "qcom,sdm845-qspi"

> Does someone have a more generic compatible string that can be added
> here to indicate the type of quad SPI controller this is? I really doubt
> this is a one-off hardware block for the specific SDM845 SoC.=20

The idiom for DT is supposed to be to use only device specific names
unfortunately.

--wayzTnRSUXKNfBqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlulLLYACgkQJNaLcl1U
h9AU1wgAgr4OI2IG5x9+yA8va8lXHDVS1UyHUqTHnwCA/kxaU4R7rgH206FRlpJ8
pFUfghnofGabgVNonvWdrWrKMc91J3CDus2GxlK4ABtCd3Lw5DtRhSJGoyNV7Fod
UM/VSpTgicbumfAzBezNumE404xAKGrhD6Q0qsSq9X6wyAaX+GsQXeEquCetMEvq
1DHzxH06iPB4GElxOV3Wvn2qxNeoGyB3biQPharwFIPZ9gAuTz6S4HlPiZ8ZoK0c
g6ltMOlI7lHyWRcEouAS83uxZPpTOy0C9U0zgxd403hVDKB4Fmj7NLKgi2MwAMf4
DnbWiuFULuhhd6jw/6rZbkB3XDKHXQ==
=FO1W
-----END PGP SIGNATURE-----

--wayzTnRSUXKNfBqd--
