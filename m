From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI)
 documentation
Date: Fri, 21 Sep 2018 11:51:06 -0700
Message-ID: <20180921185106.GJ20825@sirena.org.uk>
References: <20180920224055.164856-1-ryandcase@chromium.org>
 <153755105782.119890.8484594239463905156@swboyd.mtv.corp.google.com>
 <CAD=FV=Wbj+bgdSBeHSFr+nz6fzCMcmQS-D9oyzkR0yVkxiRb8A@mail.gmail.com>
 <153755522409.119890.5471037050114193@swboyd.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1ou9v+QBCNysIXaH"
Cc: Doug Anderson <dianders@chromium.org>, ryandcase@chromium.org,
        boris.brezillon@bootlin.com,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
To: Stephen Boyd <swboyd@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <153755522409.119890.5471037050114193@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--1ou9v+QBCNysIXaH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 21, 2018 at 11:40:24AM -0700, Stephen Boyd wrote:

> It seems that everybody has misunderstood my email. Let me try to
> clarify.

> I'm not saying to replace the sdm845 qspi compatible with a generic one.
> I'm recommending that a generic one is added in addition to the SoC
> specific one. That way, we get to put the generic compatible string in
> the driver and not need to update the driver compatible string array
> each time a new SoC comes out with a new compatible string.

> If it turns out later that we need to handle some bug in that specific
> SoC compatible string then we're good to go and we can handle it by
> matching the more specific SoC version compatible.

Right, the policy is generally not to have these strings at all.  IIRC
the argument is that they tend to either become unclear as the marketing
and technology changes.

--1ou9v+QBCNysIXaH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlulPZcACgkQJNaLcl1U
h9C0BQf9Fshy+ezWZkTSrgEQ3NGWsVxbZeRzrShDSv7SKUi6RMolLG49Uir+yHKW
oKzui9ZctJgJ7gm0eWwC93pv8IRrad7D4OboXV9WhBgbm+2jAZXva3mlPQtC97/2
VVPeBEnRxD8h3azct5dAM4Tv7t7MA6xD6JDToC8kYuVUJrAqXxPhxH3fhORYZVwk
xqzqqC4GMzM8UpjzR8v8QloS9F2YVbLuKuKRbXdJpBxrDQIZM/ot4+9g18kfS5z8
SA9rWix9UzupOnheaCpJfqcn6dYNOv4TgOV+or5H4gxBn9fn3Zxi4wsJMMnkvgNx
9nKlWL22qdTAaCWSDFdFeyXKR8Cj8g==
=geHU
-----END PGP SIGNATURE-----

--1ou9v+QBCNysIXaH--
