From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH/RFC 6/6] spi: bcm2835: set gpio-cs to high state prior to
 any
Date: Sun, 29 Mar 2015 21:28:21 -0700
Message-ID: <20150330042821.GD1568@sirena.org.uk>
References: <DA037FBB-56A7-4379-88F0-650367BBB822@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VV4b6MQE+OnNyhkM"
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <DA037FBB-56A7-4379-88F0-650367BBB822-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--VV4b6MQE+OnNyhkM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Mar 29, 2015 at 04:03:28PM +0200, Martin Sperl wrote:

> A variation of this probably should get moved into spi_register_master
> to fix this for other spi-controller as well.

Yes, this is the wrong place to solve this.

--VV4b6MQE+OnNyhkM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVGNDkAAoJECTWi3JdVIfQ3D8H+wXb7/yblMCWG9XS/acp2k3I
Jlj1/MdrZe6QlpcKfMzk3YAWDsJ2fW9vzMqzRu2sBuai36upmdW5SqEh7/WWhiw/
HkKDhZZkFPClIylU1s86lltIwyl0RywYe44WbwMUtgcdi2Tq/YAWbqvn8YxijHOv
yjG2fjkSuDXcmY0QrfzXIqR0HKr/8c2db2yFZ6rGxyM1/QxVf97upqFsGTWEMToL
msZ6FoOAntmecbomaRQ9CTJAr8eYWfRaMNglSZW+PCuxzM7QtBAh+fJwEGSnDb2w
xqUS+3Z3JI7Nhc22i606wfxT91Vld0uHGi2VkpP06RarN7eSs/0pHEc/M+w6Rjo=
=9thw
-----END PGP SIGNATURE-----

--VV4b6MQE+OnNyhkM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
