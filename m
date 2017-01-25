From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: mediatek: Manually set dma_ops for spi_master device
Date: Wed, 25 Jan 2017 12:34:29 +0000
Message-ID: <20170125123429.dj4zln2kukuw3omx@sirena.org.uk>
References: <20170124132519.13271-1-djkurtz@chromium.org>
 <b1180920-8ead-40e8-6155-8510226e719b@arm.com>
 <CAGS+omBV3o1hergAjU3_9ok5NTmk8Z315zo3yW9jU_jA+reZCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ifkw4txuyvsbvaok"
Cc: Robin Murphy <robin.murphy@arm.com>,
        Leilk Liu <leilk.liu@mediatek.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support"
        <linux-mediatek@lists.infradead.org>, groeck@chromium.org,
        Dmitry Torokhov <dtor@chromium.org>,
        "moderated list:ARM/Mediatek SoC support"
        <linux-arm-kernel@lists.infradead.org>
To: Daniel Kurtz <djkurtz@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGS+omBV3o1hergAjU3_9ok5NTmk8Z315zo3yW9jU_jA+reZCQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--ifkw4txuyvsbvaok
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 25, 2017 at 06:24:12PM +0800, Daniel Kurtz wrote:

> I'm in a bit over my head here, any suggestions on how to fix this?

As both Robin and I said the driver should be using the platform device
which physically exists rather than the virtual master device.

--ifkw4txuyvsbvaok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAliIm1QACgkQJNaLcl1U
h9BAqQf/ZQzDC6EehMwdLhUewjMWTxLSj5pYb4bHPz1GYfvP42MPZKCcAKcLJ6+2
ahGaFpeeaiYUqcb6ch3bHZ2CdJdEC6BJbFyF6Je862zXr3dKwLUV2ZTLXv9Hw9Fr
GvS3G5DW6TsM/swiOR6KzIz3DgtNtCrPHkcOG3doOmZLjyL/by8Cadmu3/h1VzjP
Cv5rGKnB8e/a6DFBU7HXzjRz7r6JNoTdSMslKrNiX2ybWRnnc+LRIjLgW2VjpGWW
pm5awGUS/Id17fQzbXhrZIKmOC/cG0nHBVDun6FBv0DCibAjZ2kIfaQU2mT0H84Z
pwtRFG5mmvdIezvnfL48FbNF5nUSHQ==
=APxn
-----END PGP SIGNATURE-----

--ifkw4txuyvsbvaok--
