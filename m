From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/5] spi: spi-gpio: Rewrite to use GPIO descriptors
Date: Wed, 3 Jan 2018 15:55:19 +0000
Message-ID: <20180103155519.GD28713@sirena.org.uk>
References: <20180101133749.29567-1-linus.walleij@linaro.org>
 <20180101133749.29567-3-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="d01dLTUuW90fS44H"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
        Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>,
        Harald Welte <laforge-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>,
        Manuel Lauss <manuel.lauss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>,
        Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180101133749.29567-3-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--d01dLTUuW90fS44H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 01, 2018 at 02:37:46PM +0100, Linus Walleij wrote:

> mach-s3c64xx/mach-smartq.c has the same problem and additionally
> defines the *same* GPIO line for MOSI and MISO which is not going
> to be accepted by gpiolib. As the lines were number 1,2,2 I assumed

You do get three wire SPI buses where one data line is used for both
MOSI and MISO so that might be intentional - IIRC it used to work fine
with a lot of SPI chips.

--d01dLTUuW90fS44H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlpM/OYACgkQJNaLcl1U
h9CYjQf/f7qJgwhRNGmCbbJiLUn9OdsuN4FYqf/g5alTFFgvk/c2W2YjZ+XSDpGY
4O3km1Uh+4HhJR/gKgwb5R11w4zQ3KJYlfnOx2E9byCCPkMSvaeA3dfgzeNy8I9d
7j+HZ1v5vXY1HsxTVFnWiMCBFs35nARPYj27zKckrLWuKH/slzCyx03Himqw6JxX
y6U+LFCVoGNKXJnvkMFJ+YveaykyqdonEv8U/9oEp08ohr7fF5Mje2xCSt+YO8h6
j4OtJSOXygu3Evpc0witEw1KR+4ZLTJzZOm+HhGoD+2Eqcv3fbainDek38hPLZjR
OAOea1aiYKM6Yvm5xnYwGxNszB8VKQ==
=Bw6Q
-----END PGP SIGNATURE-----

--d01dLTUuW90fS44H--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
