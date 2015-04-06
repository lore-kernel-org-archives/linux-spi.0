From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835: transform native-cs to gpio-cs on first
 spi_setup
Date: Mon, 6 Apr 2015 18:29:13 +0100
Message-ID: <20150406172913.GW6023@sirena.org.uk>
References: <1428340592-3196-2-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oDAD4Gb5rN9RYJiP"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428340592-3196-2-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--oDAD4Gb5rN9RYJiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 06, 2015 at 05:16:31PM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:

> There was a question if we could move the native-cs to GPIO in the driver
> itself.

> This patch implements this, but it is quite complex for the minimal gains.

> Maybe the originally proposed simple warning recommending to use cs_gpio
> in DT would be a sufficient alternative that introduces less code.

I'm not seeing any particular complexity here.  Can you be more explicit
please?

--oDAD4Gb5rN9RYJiP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVIsJpAAoJECTWi3JdVIfQ7h4H/jj5EI8WPPKsmnfdTEYOxE0p
I50QalRSyBx8iItY+va1evyVldvqZpM86Ox7+hXFWfdxhSXBS50OpSXWhO6fsaQ6
Fx0EEbCRFyRNZWOs2uK6vEDuJbuelxG95K12CTuHrfXoONuOq0ewHyHQOOZZSGtN
SnoiWs83+jFIwPyHHKJSNGpJIOOyTl5G/kYLQY8dXgPzQPWqhW32469sFM/pc9ks
5cEfo0cPW+1UZM8sXlHomznkMT4aDRdSf6pzBtXCzMcvWjXDrCBpDMbQhVwmgTfF
FmWPyAFn6Tyf1F2CXxmO7r343Gaydzj+bTDK3s3dk8KOp7QWbeyaZo9Yu28AAbI=
=AQXD
-----END PGP SIGNATURE-----

--oDAD4Gb5rN9RYJiP--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
