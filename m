From: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH v2 0/2] spi: bcm2835aux: auxiliary spi improvements
Date: Mon, 15 Feb 2016 11:25:18 -0800
Message-ID: <87povx6ajl.fsf@eliezer.anholt.net>
References: <1455444269-4797-1-git-send-email-stephanolbrich@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Cc: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
To: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455444269-4797-1-git-send-email-stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org> writes:

> From: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
>
> This patch series has some improvements and fixes for the auxiliary spi.
>
> since v1:
> - the first two patches "fix bitmask defines" and "disable tx fifo empty =
irq"
>   were picked up by Mark Brown and applied to his spi tree so I don't post
>   them again.
> - speed bits are now reset before setting the new speed in case the speed
>   changes between transfers
> - remove CPHA from master->mode_bits
> - rename CPHA bit mask to RISING to make it more clear why things are done
>   that way
>
> 1. set up spi-mode before asserting cs-gpio
>  As Martin Sperl suggested this is done in the same way as in spi-bcm2835=
.c
>  acace73df2c1913a526c1b41e4741a4a6704c863
>
> 2. fix CPOL/CPHA setting
>  From what I've seen in the documentation [1] and seen on the scope this =
chip
>  doesn't support modes with CPHA=3D1. With this patch spi mode 0 and 2 sh=
ould
>  work correctly whereas mode 1 and 3 are not supported.=20

These are both:

Reviewed-by: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>

Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWwiYeAAoJELXWKTbR/J7oP9gP/229qjqxQLlBIdgFKCU24N+H
dg692VIzN6RysfjQ1XCvJG8TRAGeqzds2P8vTv1d+NOfoUR0DUqnXcw8XUBe3REK
sQLGR/jpopHnVFmf8heDEeqZK4SQTINk0TNt/phWSg0EAOJGuB0HfBD34Il88mA+
qHTRTNY6ZzLs5yEc85hPasSuaMv0PQZz54xNnyggEbriD+MJcyA+8+mA7A6xRH83
2dRyyO665RZVyHbNOIgyG7rmJAFNrvtWHZTC+TMhhimspmYqJJc7NLOv+Jbp412Z
jBsO/cxnsJEQObjo7BZovVejfsOMJv8Ty1rTMGvDyH9yz5GPknevCyI9+x3dfF/C
ggBi9ibDnlUolsWCGf9K6HlDptuXb6LPkWrVYqW7TDmcEsOtS15CWJDIH97RjBo4
o6lpfXnr2bXaZBtm2cBlfpXK5MrCWLhn3MzHB7udIRzK5RRWxtfZ1euct8PZgrZo
ISFDuwRO4ccuSHgEckeMshqg6RG5pm0slR10aLwSaaVehvfwDXW6uSVjAOCNJylf
ekH79cI8ClkIiQ7eth4SZpR+BKZGNb47DhXCKe0VWquHyDPHE37zAzjK04cZRYx3
oApgz5UxGNHc6r6Kok93LPUhZVEfhOkG1p11d9WlU5xlxzch0JXOaNi1nsaIQRXi
gFZPunS2KHCy58AsbBxy
=Tqb+
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
