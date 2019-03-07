From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: work around clang bug in SPI_BPW_RANGE_MASK()
Date: Thu, 7 Mar 2019 11:23:16 +0000
Message-ID: <20190307112316.GD6529@sirena.org.uk>
References: <20190307105619.2780591-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uxuisgdDHaNETlh8"
Cc: Nick Desaulniers <ndesaulniers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190307105619.2780591-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--uxuisgdDHaNETlh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 07, 2019 at 11:56:07AM +0100, Arnd Bergmann wrote:

> Link: https://bugs.llvm.org/show_bug.cgi?id=38789

>  #define SPI_BPW_MASK(bits) BIT((bits) - 1)
> -#define SPI_BIT_MASK(bits) (((bits) == 32) ? ~0U : (BIT(bits) - 1))
> -#define SPI_BPW_RANGE_MASK(min, max) (SPI_BIT_MASK(max) - SPI_BIT_MASK(min - 1))
> +#define SPI_BIT_MASK(bits) ((BIT((bits) - 1) << 1) - 1)
> +#define SPI_BPW_RANGE_MASK(min, max) (SPI_BIT_MASK(max) - (BIT((min) - 1) - 1))

Can we have a comment that this is for the clang warning please so
nobody goes in and simplifies the code?

--uxuisgdDHaNETlh8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyA/yMACgkQJNaLcl1U
h9DKhwf/SozTac0wQSMSrUHIwpvylWyr+FBIm0JsAJoURYCL+uTKN/vJJqlIOarw
v7Xl06lpLSYGjxgVs7grdlA+FmiJbcNpJDJV3V1fThKuqHyt5rZ75R4uMvVu7Tea
C+642mKN9GMqEsnB9nz4Po+n6krbez65AW6fKE30Oaa5yMebQ7vz6gf6Z1a22zM2
sJiNXkCu51A6jrb+H/l3gtd/iSTDCfvQvOvX2bE1ihQhJl5C9Y+Sev+wgxGvfTPq
wG+qNBTX43NSpV8LNg6p1pNBDUDxDR5HWYDlAuy8svmiDBo3pcHxXco1iq8rASRk
yxY1mB8uzXI6tehvTKLYM1ZbOTAFeQ==
=n2rH
-----END PGP SIGNATURE-----

--uxuisgdDHaNETlh8--
