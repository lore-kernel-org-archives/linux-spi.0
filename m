From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: spi: bcm2835: driver for "auxiliar" spi1/spi2
Date: Thu, 18 Jun 2015 11:38:08 +0100
Message-ID: <20150618103808.GD14071@sirena.org.uk>
References: <5582933E.1050500@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WFkhpfBSKA51eMK1"
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5582933E.1050500-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--WFkhpfBSKA51eMK1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 18, 2015 at 11:45:34AM +0200, Martin Sperl wrote:
> Quick question: for the auxiliar spi1 and spi2 of the BCM2835 chipset
> should I create a separate driver - say spi-bcm2835aux.c - or incorporate
> it into the exising spi-bcm2835.c driver.

> Note that the register set for the auxiliar spi devices is totally different
> so any code-overlap with the existing spi-bcm2835.c would be minimal.

> Any preferences?

If there's no code overlap it should be a separate driver, your proposed
name sounds good.

--WFkhpfBSKA51eMK1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVgp+PAAoJECTWi3JdVIfQ38YH/jRRca/OlVX7bvo6aqMrvAn6
0BseKKVfnc7Dt7lH+37e5jnZcmirRZXM6zNFKK/9Y0RrYx5pS0BXOKkzk6+Fdg47
s66hF/xr7PNuiBxfOHv+rRu4EOq/795bcLoGA2SnbtaeKfxRbPAMozs7emkOUGdd
IFSVg5fzn+iV7yuN4Xu038gs6d4M4swZbxHrcaSKUSwSvhFU8Y++FgwQwD4fhXVk
hTvSJhX31Z5/ShV4R+SXocnDHvLNMSx/RPc9E9K5H+V45upQiPNrVEvCLp4zd28O
VcJiTVHtKsGXkitvbf7uB0RRn1ah3lfxNeF2Emy5npfaViQBimOz31OxmqiSNcU=
=fttl
-----END PGP SIGNATURE-----

--WFkhpfBSKA51eMK1--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
