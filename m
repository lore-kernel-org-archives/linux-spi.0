From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 4/6] ARM: Samsung: Modify
 s3c64xx_spi{0|1|2}_set_platdata function
Date: Sun, 20 May 2012 10:21:13 +0100
Message-ID: <20120520092113.GA20652@opensource.wolfsonmicro.com>
References: <1337333613-6216-1-git-send-email-thomas.abraham@linaro.org>
 <1337333613-6216-5-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Cc: spi-devel-general@lists.sourceforge.net,
	devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, rob.herring@calxeda.com,
	grant.likely@secretlab.ca, kgene.kim@samsung.com,
	jaswinder.singh@linaro.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1337333613-6216-5-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 18, 2012 at 03:03:31PM +0530, Thomas Abraham wrote:

> -	s3c64xx_spi0_set_platdata(&s3c64xx_spi0_pdata, 0, 1);
> +	s3c64xx_spi0_set_platdata("s3c6410-spi", NULL, 0, 1);

...

> +	pd.src_clk_nr = src_clk_nr;
> +	pd.cfg_gpio = (cfg_gpio) ? cfg_gpio : s3c64xx_spi0_cfg_gpio;
> +	s3c64xx_device_spi0.name = dev_name;

This looks *really* strange.  Why do we need to pass in a name to set in
s3c64xx_device_spi0's name, why would we want to use a different name?
This dev_name also isn't equivalent to dev_name() which makes matters
more confusing than they need to be.

There was similar code for the I2C controllers which caused some really
hard to debug brittleness.

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPuLd9AAoJEBus8iNuMP3dLqoQAIR6rqQ9pjM8FvqwohQzlWo+
1jzGq53e1GzU9X3dEGxd9JKO+G7dH1zsltCbYlMpOAZC/RJVjsC+f6Ni8+ZOI7Em
9ixnGTf+iQT475vW4XBi0FZoWzsdYtvU9f8RD0xVLkVjNPfF1ALubhfdBu/hJo8i
eyYk+426Lc9QCI2YrMceCJcgLv7CwwZ6sFckDU5pSXvDReSQ9AJ+LtCR/e9MOds3
otGDcT4x5+5BoFm+m01628qqJoN2VrNlrxprtMMg1rYW2s/jKOKN9KNujC6DmY7S
i5pIF9EqNsa4+xrGRbDnqCo5mr/9yEAXFCSA1P0PnbAKUO0QL9U0iJu/20hZoAX3
bOsvy+YinWi/I6t3bMcOND6uivjcDJDzaXcXCTCtfXeQAlzecQ/OfU7t7KwJuGb8
yKD2Li02enYN9z/NFA0tOB6g75Nkuy+HFL0IpWi3zqz8Ap8qxjssukBMMuvtuu1N
7mBr3WKhxTh/XnGLGT2zoCvTvc/p/wznajsM3fDB5Afygf3WP5cHU6t5BdO1jpaT
e6uskxXD9fS3+PsXheAqggAMEBNnU2U+ca8MVzAq7t2Ncr5xgKJINaJhd7uQaTXp
LzyITh8TCogXQKSQAxbv+edWKL1XEMKTGaHtITg6NYgMh9o0Phf7DREEXvSBZa2b
dB7NFN04HgHCpyh1YajU
=fwSS
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
