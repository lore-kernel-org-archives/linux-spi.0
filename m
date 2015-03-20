From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] SPI: BCM2835: fix all checkpath --strict messages
Date: Fri, 20 Mar 2015 13:36:23 +0000
Message-ID: <20150320133623.GM2869@sirena.org.uk>
References: <1426755714-28130-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rdbbj4JunmnVtKq/"
Cc: warren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426755714-28130-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--rdbbj4JunmnVtKq/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 19, 2015 at 09:01:50AM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:

Looks like I did get these but they took a while to come through...
odd.

> -static int bcm2835_spi_start_transfer(struct spi_device *spi,
> -		struct spi_transfer *tfr)
> +static int bcm2835_spi_start_transfer(
> +	struct spi_device *spi,
> +	struct spi_transfer *tfr)

Like Stephen says I'm not 100% sure what issues this is fixing but I
have to say I find the overall result worse.  It's possible the
warning is something reasonable but without knowing what it is it's hard
to say, I do like to see at least the first argument on the same line as
the function name though.

--rdbbj4JunmnVtKq/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDCJWAAoJECTWi3JdVIfQKtUH+QHEg6kqoxAG08Hfo+64eBjV
x85tl9eOun+f78hha6u0lEW/T/bBVKZOBSYPSLFnMEmhUGW6nVZPuZTfvF0pWqs/
sQhRcZGfYk2md+nJiX4JA2QBCYDQu5Dz9/s2hjl3eMiqbJhyn4+FcTU1hmyzEk2c
d/KgSTANP0ium+h2Rbx5tmTmWySk1jf8aswXqLjfAjG7r6dsVPyV2z6EBXJXARPc
UPckmTShSatc5izPk4ho540rUKxUgqTPP+16eU0gimg4KwBKrgzGln07M/najlJw
IT99dVs44I727E7knZHIAO8c2j6Ly9l1M0fWQJVqTCBLnbgmUysty2VMZ9GDFPk=
=z4J1
-----END PGP SIGNATURE-----

--rdbbj4JunmnVtKq/--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
