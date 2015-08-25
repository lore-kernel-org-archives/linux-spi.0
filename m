From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: fsl-(e)spi: migrate to using devm_ functions to
 simplify cleanup
Date: Tue, 25 Aug 2015 18:43:49 +0100
Message-ID: <20150825174349.GE12878@sirena.org.uk>
References: <55D9BAAA.7060401@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9crTWz/Z+Zyzu20v"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55D9BAAA.7060401-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--9crTWz/Z+Zyzu20v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 23, 2015 at 02:20:58PM +0200, Heiner Kallweit wrote:

>  	/* Register for SPI Interrupt */
> -	ret = request_irq(mpc8xxx_spi->irq, fsl_espi_irq,
> +	ret = devm_request_irq(dev, mpc8xxx_spi->irq, fsl_espi_irq,
>  			  0, "fsl_espi", mpc8xxx_spi);

Also, are you *sure* this conversion is safe?  One trick with interrupts
is that the interrupt could still fire after the device removal function
runs since devm_ dealloacation runs after that.

--9crTWz/Z+Zyzu20v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV3KlVAAoJECTWi3JdVIfQZq8H/iRoIwcQJXoor7BtbWv6Wjdg
wxrOnlADiAbzbxkoyvpknAD4EVD1W8rSEVSxx/0KeG1cpjMSRsDRMJb2xSH5/jFE
py6yEOdb9O6jmLtzB+rULgIVCSY6v4yTcrykw2FZQll3cd3fyB89BFAaE1T+EL7G
k1Tpsj2epAJwYElQdrzShV/4mJ7JW5bhaMhgmmufvT6k8CFDiy1WQ+BIlHFOkTo2
ZPRkJuZaUszkmq7qk0QbJtM2MrbkbOB4hlkTz1rNZYtANUrMwBsB+ih5zfUptt+H
qrNBMJ18XTA9/M/E1BUfUNGAyxVVlnkodNonfyIEIC3AvYhHmeedBuCq5AvDy2I=
=eBXK
-----END PGP SIGNATURE-----

--9crTWz/Z+Zyzu20v--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
