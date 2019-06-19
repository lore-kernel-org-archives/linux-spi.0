From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] include: linux: spi: more helpers for declaring spi
 drivers
Date: Wed, 19 Jun 2019 13:14:41 +0100
Message-ID: <20190619121441.GS5316@sirena.org.uk>
References: <1560796840-18207-1-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6s/G0Ait2f6IH9MX"
Cc: linux-kernel@vger.kernel.org, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, linux-gpio@vger.kernel.org,
        linux-spi@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1560796840-18207-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--6s/G0Ait2f6IH9MX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 17, 2019 at 08:40:38PM +0200, Enrico Weigelt, metux IT consult wrote:

> +/* subsys_spi_driver() - Helper macro for drivers that don't do
> + * anything special in module init/exit.  This eliminates a lot of
> + * boilerplate.  Each module may only use this macro once, and
> + * calling it replaces subsys_initcall() and module_exit()
> + */
> +#define subsys_spi_driver(__spi_driver) \

I'm not convinced we want to be encouraging anyone to be using
subsys_initcall() for SPI drivers in the first place - my guess would be
that with deferred probing none of that is needed anyway and the driver
could just use module_spi_driver().  Certainly if the drivers do
actually need subsys_initcall() I'd like to understand why before going
forward with something like this, and ideally we'd be able to remove the
need.

--6s/G0Ait2f6IH9MX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl0KJzAACgkQJNaLcl1U
h9DeUQf+PgOAkyo4pT4LasAHcsQL8bXxE3hqloJcMpaFpRgnSp4/I5Pc/Jg04XCu
CI2k7QnDLDIcUq1FlrI+eVvb0SKhzeEkIfJyaL8dX1kRPea2n9WbP0ZF5GcnQQ2d
ZidAKFQNB7eSWEhgPUIvkNHIvGm7TUNST35PbhZCd+j4ACcErdrKhGpZPm2hmHRN
7T7nUtkLFL5YvCH8QqdPLUzg2Co6BFik3jiseCAIi1PH4+zIA9QPi3g47VDPQ6aF
nTUg51S5Y4aduklIOTW8G+D47tUTsjFiKb3g2ZqUz1wbgmJlyd6q48h4lR55gSj8
xJYmx5diMemXIks5Ksr1Ny2mhGsXqg==
=szr+
-----END PGP SIGNATURE-----

--6s/G0Ait2f6IH9MX--
