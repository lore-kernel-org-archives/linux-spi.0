From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH for-next] spi: bcm53xx: add spi_flash_read callback for
 MMIO-based reads
Date: Mon, 18 Apr 2016 12:57:31 +0100
Message-ID: <20160418115731.GX3217@sirena.org.uk>
References: <1460977843-9426-1-git-send-email-zajec5@gmail.com>
 <20160418112457.GU3217@sirena.org.uk>
 <CACna6rzQfX7SxDoL-CTQp3_Ms5_K54pEa8uaUAiTPjR-un=VOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H7DA0n3a+SnB4bJ2"
Cc: "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"open list:SPI SUBSYSTEM" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACna6rzQfX7SxDoL-CTQp3_Ms5_K54pEa8uaUAiTPjR-un=VOg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--H7DA0n3a+SnB4bJ2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 18, 2016 at 01:38:28PM +0200, Rafa=C5=82 Mi=C5=82ecki wrote:

> What shall we do if spi_flash_read fails? Should we always fallback to
> the standard SPI flash read? Or should we standarize error codes
> returned by spi_flash_read and fallback on some particular error code
> only?

I'm not sure, probably just fall back all the time.

--H7DA0n3a+SnB4bJ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXFMuqAAoJECTWi3JdVIfQk6AH/17dNIsYHIOjiN+q3S4LZDeu
8ephxu97hyErGvZUyICt4lIKzVBb95nBrTav4Rg/0uS3SaPdRykYX31uPIfJw87Z
eDVF1CmTghfdGGN3Hh+/ngyO2PteIrE+zntghiJWEAza8cbN6ayIbE2a3NG/YbDE
6XkOnvsZ0gZOEm2uEvBij7BLFvWR917YS8o6Z6C6aZbLJpUMpS9TeJauOb1+TMhT
gd11aEgsm6jvjTHNeFSLJSQMXE7sGAwWm7rFeu0c17ZJSlIcUAHjvrC77ZsAs54+
/OWnAQfHVYISSWvfmLxYkKGL/N0lKZrmERzpqJKheDAI+eVb53qYs2ok67RNAXU=
=EFhm
-----END PGP SIGNATURE-----

--H7DA0n3a+SnB4bJ2--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
