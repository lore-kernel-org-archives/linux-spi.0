From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "spi: davinci: enable DMA when channels are defined in
 DT" to the spi tree
Date: Wed, 8 Mar 2017 13:43:16 +0100
Message-ID: <20170308124316.56vn2qijllu6mi3v@sirena.org.uk>
References: <E1clG07-0006mU-6x@finisterre>
 <11df78f1-7b4e-5093-f166-b3af21c03abc@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ad7vpasrwnav4phg"
Cc: Fabien Parent <fparent@baylibre.com>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, nsekhar@ti.com,
        ptitiano@baylibre.com, khilman@baylibre.com
To: Frode Isaksen <fisaksen@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <11df78f1-7b4e-5093-f166-b3af21c03abc@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--ad7vpasrwnav4phg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 08, 2017 at 11:35:02AM +0100, Frode Isaksen wrote:

> To avoid data corruption issues with UBIFS volume over SPI NOR, DMA should not be used for vmalloc'ed buffers. The 5'th patch in my series fixes that:

It's best to always try to ensure that your patch serieses are
bisectable...

--ad7vpasrwnav4phg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAli//GMACgkQJNaLcl1U
h9D9BQf9E5QKvVHtDgUizVN7yVtSoPidiTwOBtNYsh5Y2WiQjkzsjMgc8rRtSrYR
LORw2SGI8dGMRFiCQ7FPd38gzmYf/Tu2H21rpLSjtySdJgBVXBGmcf3cCeC47LEp
DsjwpRDOQo32Tjc0pobRdKcy4Me0UzcXkK2tVOnpCiWjACacO4e/GAU3U/TBMvXB
bHn6igM0nj3GiL3mIce6pBdAplHDorhS/JFuBtEmrKL4/YS2mOILQCfXWJIhUsrW
0AocT29suWJpcHB7hxyE1FtwUiUPjV8ACZi9lrbT5shRXYRABM5SNuvpP4FIt945
o0I2i33XYyTpwgNOsaQlB3+m+P0woA==
=1uS4
-----END PGP SIGNATURE-----

--ad7vpasrwnav4phg--
