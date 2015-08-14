From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: imx: fix ecspi mode setup
Date: Fri, 14 Aug 2015 20:30:15 +0100
Message-ID: <20150814193015.GN10748@sirena.org.uk>
References: <1436880205-25023-1-git-send-email-qxovxp@gmail.com>
 <20150714134934.GV11162@sirena.org.uk>
 <CAN8RqkDrc9sqsbv360yuu7cN3dg527vEomu+FakqnkbTgGZtzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FAVlh7XA/4iOdtaa"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Andrew Kuksov <qxovxp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAN8RqkDrc9sqsbv360yuu7cN3dg527vEomu+FakqnkbTgGZtzQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--FAVlh7XA/4iOdtaa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 14, 2015 at 07:06:36PM +0300, Andrew Kuksov wrote:
> >> Fixed problem with setting spi mode 0 or 1 after setting mode 2 or 3

> > What is the problem and how does this change fix it (this information
> > should be in the changelog)?

> SPI_MODE_0 and SPI_MODE_1 requires clock low when inactive. SPI_MODE_2
> and SPI_MODE_3 requires clk high when inactive.
> Currently driver can just set bits in fields SCLK_PHA (SPI Clock/Data
> Phase Control), SCLK_POL (SPI Clock Polarity Control),
> SCLK_CTL (controls the inactive state of SCLK) ans SS_POL (SPI SS
> Polarity Select) of ECSPIx_CONFIGREG register.
> This patch allows driver to clear corresponding bits in these fields.

Please provide a patch with a changelog more like this...

--FAVlh7XA/4iOdtaa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVzkHGAAoJECTWi3JdVIfQdq4IAITE5F5Wsm++PcQiCRBNmg8j
V25fCw6ofSPZBYRwc4faJvd8RVz138lDjynzIxK5aQUTiabdNMC+nn3zsngfh0iG
5t7wh7gp5M06hre16m4amwSXtTl+uG3l9dwZt1yJ0qGutSvCZsk74GM+vI0ds+/1
Zxi79evkoAsYMMGEWaQYY7HWBWMjZ3rbaK6+qxn16l8D8Z35E816+UelGSzd/cQw
EbI/wDYX3DhQFW3RLpgo/KlflppBMTnRCcs5yVgMhRPZKrnRFJ1knLW7whyXIpIH
MrR8dj1AT3DYLo5+uvXEYd92mgeGyH06miSR12HxLR/2wr/CymlrXjMumzxhMU8=
=hitE
-----END PGP SIGNATURE-----

--FAVlh7XA/4iOdtaa--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
