From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH -next] spi: fix spi-sprd-adi build errors when
 COMPILE_TEST=y
Date: Thu, 21 Sep 2017 17:49:33 +0100
Message-ID: <20170921164933.hvvwfm6kvha3d5my@sirena.co.uk>
References: <1e21f485-7f06-0566-afd4-74f2bfc9606e@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tvr7n346xtud4nqd"
Cc: LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Baolin Wang <Baolin.Wang-lxIno14LUO0EEoCn2XhGlw@public.gmane.org>
To: Randy Dunlap <rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1e21f485-7f06-0566-afd4-74f2bfc9606e-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--tvr7n346xtud4nqd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 21, 2017 at 09:10:04AM -0700, Randy Dunlap wrote:

> +++ linux-next-20170921/drivers/spi/Kconfig
> @@ -625,6 +625,7 @@ config SPI_SIRF
>  config SPI_SPRD_ADI
>  	tristate "Spreadtrum ADI controller"
>  	depends on ARCH_SPRD || COMPILE_TEST
> +	depends on HWSPINLOCK
>  	help
>  	  ADI driver based on SPI for Spreadtrum SoCs.

Why is this a more sensible fix than providing stubs for HWSPINLOCK?

--tvr7n346xtud4nqd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnD7Z0ACgkQJNaLcl1U
h9Dj1wf9GG7xpGDnDit8BpVJOvTOs9Dn9sjNooFAmymK6FZY2CR61vH3FAaALrFB
T5eAv1Ca37fA29VwGs1CdgIH5TPfBpkoYTJmJFEgWgR8CJFADRvUXCy9gfXpFrBZ
5nPWpbA59zNF5zGalhL+dOZHYa9OLUMlwCjfjojyWGZhTNlzzKi6SF9//3fAnufo
MsS84PR1pun/FuvQF1FNn5raU+AR37yv9ev4BoiWnjL7AukNZaT1P3mtnHK+kmiU
1JPqc19QoN7NiLUDyBKjPoEXAJ8m4XtoWMji7wtPNxGIaIBIMZhNKR2lOblSH2pP
xZgzpA8wgFElfDosUIeZ61JlU/J+cg==
=IAJM
-----END PGP SIGNATURE-----

--tvr7n346xtud4nqd--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
