From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/6] spi: add flow controll support
Date: Wed, 2 Mar 2016 10:32:33 +0900
Message-ID: <20160302013233.GK18327@sirena.org.uk>
References: <56D448E1.6090006@de.bosch.com>
 <1456843400-20696-1-git-send-email-linux@rempel-privat.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TbqbGUYwJfHHaS/d"
Cc: fixed-term.Oleksij.Rempel-V5te9oGctAVWk0Htik3J/w@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org,
	dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
To: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1456843400-20696-1-git-send-email-linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--TbqbGUYwJfHHaS/d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 01, 2016 at 03:43:15PM +0100, Oleksij Rempel wrote:
> Different HW implement different variants of SPI based flow control (FC).
> To flexible FC implementation a spited it to fallowing common parts:

Please don't bury new patches in reply to the middle of some other
thread, it makes it really hard to follow what's going on.

--TbqbGUYwJfHHaS/d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW1kKwAAoJECTWi3JdVIfQUl8H/jlGEhFFbt3osepFKo6tgpAY
rNWTYftIjHuS5zp8ACPyVPNlCwCgeyx6aI6rOZ1CpxPFNxxQdCyyDsZtOSwtxeMN
cE4PG6mIjLX74pPsrpvnv4VVVdmNBhEWtX1cev7cBYxbenv33tBYf6RlcP6FeBLa
O6D0SLkefp3TVp9VwZLK8KTs+eDAhpwG0H3/dWOSd5WvSlIDc4J80njI1o4XsS0l
AJZ1irHZngVPOcXfQthw5jhWooFevjdhGeeq7r25t5ZmJXfLBdj4yGyZetAiHkj8
/4l/m9lCX+oGFAsSJveIRKGuNzKm0jIYIQlhBkqPEZoRNuUVfE3j6bdOwZwCVXo=
=Yn32
-----END PGP SIGNATURE-----

--TbqbGUYwJfHHaS/d--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
