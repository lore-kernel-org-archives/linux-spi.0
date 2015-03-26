From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] SPI: bcm2835: move to the transfer_one driver model
Date: Thu, 26 Mar 2015 10:35:11 -0700
Message-ID: <20150326173511.GW3572@sirena.org.uk>
References: <550BAA89.5090707@wwwdotorg.org>
 <20150320095247.GE2869@sirena.org.uk>
 <1756D77D-173D-4D6D-B629-59CC8A49714F@martin.sperl.org>
 <20150325151611.GA3572@sirena.org.uk>
 <681599F9-2D88-49FF-BD16-4F388D0B2874@martin.sperl.org>
 <20150325165441.GI3572@sirena.org.uk>
 <767DFCCF-C8A4-44B3-9E85-96011B0FF0FA@martin.sperl.org>
 <20150325185007.GL3572@sirena.org.uk>
 <561486F6-3580-4884-8A6A-8477D8C3BDC9@martin.sperl.org>
 <30057D30-6A2D-4517-B374-76FF2448E455@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lQcP9vuZCkvmDKre"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	notro-L59+Z2yzLopAfugRpC6u6w@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <30057D30-6A2D-4517-B374-76FF2448E455-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--lQcP9vuZCkvmDKre
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 26, 2015 at 11:08:36AM +0100, Martin Sperl wrote:
> This also allows for GPIO-CS to get used removing the limitation of
> 2/3 SPI devises on the SPI bus.

This doesn't apply against current code, please check and resend.  As
previously mentioned please use subject lines matching the style for the
subsystem.  A few other things below but it's basically all good.

> So the question is if we should depreciate native chip-selects for this
> driver with one of those future improvements listed below.

Given that this driver is only going to be used with a single SoC (or
perhaps a very limited set of SoCs, I don't know if it's the same driver
in the Pi 2) even if the DT specifies a hardware chip select we should
be able to look up which pin that's brought out to and put it into GPIO
mode if that's the most sensible thing for the driver.

> * multiple spi_transfers handled in interrupt alone without waking up the
>   worker-thread (for some transfers) to reduce context switching
>   overheads and the corresponding latencies.

This in particular is something the framework should have: it's
generally useful and we should be able to do it with either a new
transfer_irq_safe() (or something) operation or a refactoring of the
existing one.

> +	/* error in the case of native CS requested with CS-id > 2 */
> +	dev_err(&spi->dev,
> +		"setup: only three native chip-selects are supported\n"
> +		);

The indentation here is weird - at least the last ); should be with the
string.

--lQcP9vuZCkvmDKre
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVFENPAAoJECTWi3JdVIfQcn0IAIIj6uTj9R3O+pL//XHCUYRf
tMfGi8z5LL2yF3SCchaogpyZAt5fDwKvhesSmFFTwRW2zN65vn3KrgfT2AZGeEwl
Z0EifSaLzKOh88hHT+Ch6IJhd7xY840X0Y7ccFZsxmJVS2xoHiu2S2ZjQ+FKUCUI
2NJnOLdC0mvKbRhuJmL7UYEdyEt5OZ9WRcmyYY6ADNzcmPxxuQibrR84O4uiCjSn
PpLM5p0MlCvCJTYC8b4RSQIPr3om0JEchK+YYZ1R4NQwPOoCu/cazejAUt3+rr+R
zjkwS7BXX8YLi/t9bsf4qJ5tS1qO6eHIQgxmA+uoBn1HSAWwIoc3RlPpambm55E=
=NYsb
-----END PGP SIGNATURE-----

--lQcP9vuZCkvmDKre--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
