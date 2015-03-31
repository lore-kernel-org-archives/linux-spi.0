From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: bitbang: only toggle bitchanges
Date: Tue, 31 Mar 2015 15:13:21 +0100
Message-ID: <20150331141321.GR2869@sirena.org.uk>
References: <1427810089-14866-1-git-send-email-m.grzeschik@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Rg893I9M3tK9A1lH"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427810089-14866-1-git-send-email-m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Rg893I9M3tK9A1lH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 31, 2015 at 03:54:49PM +0200, Michael Grzeschik wrote:

>  		if ((flags & SPI_MASTER_NO_TX) == 0)
> -			setmosi(spi, word & (1 << 31));
> +			if ((word & (1 << 31)) != oldbit) {
> +				setmosi(spi, word & (1 << 31));
> +				oldbit = word & (1 << 31);
> +			}
>  		spidelay(nsecs);	/* T(setup) */

This change is fine but for legibility can you please add braces around
the outer if as well?

--Rg893I9M3tK9A1lH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVGquAAAoJECTWi3JdVIfQ7xUH/0P8fK2G0oTeRKad4cHYwLuD
hwh4wRslafbqaIY3/8XUU+mvcPss50P63efED/p8dmRdTBNwTRXcBiKVto+miaud
kjoFGd50tZPsE3r14c06U4fhRrqXffSdGXdz4XcFiPqDTmHNiqXVSNuIojkQA4PQ
dpRl+b7UqBiDC6tJcowYJEzuKA+vEHyJ7KipjMIsSanqDW44Yq8qExKwl7eqW1/Q
WmulZn2Ypf2O8KKg2JLOt6dHsrAYLxaZZUybhartIliE9cbIu2cwfs1MQVOcXSS4
pBv6icHome5HLY/9Uq3wZApvxlbwZuU0wj0skSO0utfeJYoeREc2oOeqeHGgP4Y=
=WNXm
-----END PGP SIGNATURE-----

--Rg893I9M3tK9A1lH--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
