From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: fix IDR collision on systems with both fixed and
 dynamic SPI bus numbers
Date: Fri, 13 Oct 2017 17:55:12 +0100
Message-ID: <20171013165512.3btsd4yxilgohfwi@sirena.co.uk>
References: <20171013155946.1486-1-l.stach@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dxrdo23tx4xaxrvo"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
        patchwork-lst-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Lucas Stach <l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171013155946.1486-1-l.stach-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--dxrdo23tx4xaxrvo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 13, 2017 at 05:59:46PM +0200, Lucas Stach wrote:

> Fix this by skipping all known alias numbers when assigning the dynamic IDs.

> -		id = idr_alloc(&spi_master_idr, ctlr, SPI_DYN_FIRST_BUS_NUM, 0,
> -			       GFP_KERNEL);
> +		id = idr_alloc(&spi_master_idr, ctlr,
> +			       of_alias_get_highest_id("spi") + 1,
> +			       0, GFP_KERNEL);

I'll apply this but I'm wondering if we want to have the static bus
number allocation also allocate that number out of the IDR so the IDR
code handles things more transparently.  Feels like it's more trouble
than it's worth though, this should work fine.  I'm also worrying about
the case where IDR allocated a number before a static assignment got to
it...  not much we can do to guarantee that we avoid that case though.

--dxrdo23tx4xaxrvo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlng7+8ACgkQJNaLcl1U
h9BSRQf9EKqauOMuF6IfLY2LG94UuirJdrZnMN6HVvFvY6Z+w9dpR2JdOBanP6n9
MR/GYxGMy9sd5i2mnKdBKtn2M+8uU1jn6aC+/NiSQ4cNLLqnG31iYDbQBYXP74Kt
u0/+jG00jzJ8qaOc9WGhQsisHShKp8L2Unp+ahASXkqB9XsZ0/xLwaHu69lkuMAA
rIERhRZZcqBeJSnpOr6s8ra1TXlWnzNpxClwIZH42F81BSDuA0TC3Sr+BEGr3izV
1Wa2b9EBIvfIjPK5I8B8WZ81Z4nei6k4/2q4s/vML+b1ABQ7hf18xxUlWEtWuC/q
KVh3FXmBYqVm3lDKX0J7EF4qfYs5hg==
=WbTQ
-----END PGP SIGNATURE-----

--dxrdo23tx4xaxrvo--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
