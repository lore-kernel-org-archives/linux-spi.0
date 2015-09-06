From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH RESEND 0/1] Revert "spi/doc: spi_master_put must be
 followed up by kfree"
Date: Sun, 6 Sep 2015 01:06:40 +0100
Message-ID: <20150906000640.GR5313@sirena.org.uk>
References: <CAP_9M6973VAtM6WkP7gkzDMnJbRxmmmiCCuSxMU-_aQm4YQZbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vdyjigDobekge4RG"
Cc: Guenter Roeck <linux@roeck-us.net>, linux-spi@vger.kernel.org,
	Alexey Klimov <klimov.linux@gmail.com>, djkurtz@chromium.org,
	linux-kernel@vger.kernel.org,
	Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
To: Alexey Klimov <alexey.klimov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAP_9M6973VAtM6WkP7gkzDMnJbRxmmmiCCuSxMU-_aQm4YQZbg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--vdyjigDobekge4RG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 06, 2015 at 01:47:21AM +0300, Alexey Klimov wrote:

> During review of new SPI drivers I tried to understand connection
> between comment "calling spi_master_put() and kfree() to prevent a
> memory leak" for spi_alloc_master() in spi.c and why no driver calls
> kfree() on error path. Looks like Uwe added this comment and later I
> found patch from Guenter that reverted this comment but spi-imx.c was
> not fixed for that time. Later in 2013 spi-imx was fixed. Is it
> correct time right now to fix comment?

I'm sorry but I'm not clear what you're talking about here as there's
missing context...  where is this comment you're talking about?

In general please don't send cover letters for single patches, either
add the content to the commit message or put it after the --- if it's
administrative stuff (like SubmittingPatches says).

--vdyjigDobekge4RG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV64OQAAoJECTWi3JdVIfQmKkH/3H59ZjJp9XUwxvauFDP4Ggu
uSwScizn7fz1VpT6f/ubq8sCKeic+W2+QKqAbA6ww9XdebxJX6Ffa29f4WJwqeSS
CxaAUlzHTGsMJzSfCRrWKW8MxDWDDGhq5J8RYHwCrXSgdFW+OmzBgnv3/T33yewr
V/M23N043pjbFlHZessoWiad5+SDKmjobrUJZdZ9xf5GTOBb03KmKkhhXff87bP7
OaJcgthzKfxkQJy1uZMtPgyTVdcVKT6nsTvBXOPptvu+FfZO9thqnT3Ap79zfpTu
FH/hTii8c2GbM4jZKCbJMd8/84SyKsfeqOnw6jVeTBffXKT2VIrYlnboQt6IQl0=
=FCWK
-----END PGP SIGNATURE-----

--vdyjigDobekge4RG--
