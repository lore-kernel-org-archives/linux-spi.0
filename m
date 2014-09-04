From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: Re: Autoloading of SPI/nor driver on kirkwood (qnap devices)
Date: Thu, 04 Sep 2014 03:21:58 +0100
Message-ID: <1409797318.27524.37.camel@decadent.org.uk>
References: <1409673299.14324.43.camel@dagon.hellion.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-cis7sBr9TmdqXO/HY6GK"
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	debian-kernel <debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ian Campbell <ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409673299.14324.43.camel-ztPmHsLffjjnO4AKDKe2m+kiAK3p4hvP@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--=-cis7sBr9TmdqXO/HY6GK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Re-sending with more recent address for Huang Shijie.]

On Tue, 2014-09-02 at 16:54 +0100, Ian Campbell wrote:
> Hello,
>=20
> I recently tried to switch to using the DT based kirkwood stuff with
> v3.16.1 on a QNAP TS-419 for the Debian kernel. Most things seemed ok
> except that the flash driver was not autoloaded -- as well as spi-nor.ko
> I had to manually modprobe m25p80.ko. Once I loaded both the flash was
> detected.
>=20
> I noticed that many platforms declare the flash chip as compatible =3D
> "st,m25pXXX" whereas the ts219.dtsi just said m25p128 but I tried
> changing that and it didn't help. In any case without spi-nor.ko being
> autoloaded I don't support m25p80.ko ever would be.

m25p80.c has:

static struct spi_driver m25p80_driver =3D {
	...
	.id_table	=3D spi_nor_ids,
	...
};

while spi_nor_ids is defined in spi-nor.c.  Since they end up as two
separate modules, modpost can't read the ID table and add the device ID
aliases to m25p80.ko.

It looks like m25p80 has been split up in order that the new fsl-qspi
driver can share its code (bypassing the SPI core and its device
model!).  Why doesn't fsl-qspi implement an SPI controller device?  I
think it is totally unacceptable to regress m25p80 in this way for the
sake of a new driver.

> I could set these things to =3Dm for the Debian kirkwood flavour, but
> since this is supposed to be a distro-style kernel.
>=20
> I'm not entirely sure how module loading of this SPI stuff is supposed
> to fit together -- anyone got any hints?

Same as for any bus driver.

Ben.

--=20
Ben Hutchings
Experience is directly proportional to the value of equipment destroyed.
                                                         - Carolyn Scheppne=
r

--=-cis7sBr9TmdqXO/HY6GK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVAfMzOe/yOyVhhEJAQpUgBAAjB1BBKrOq6Enw/tGTc9hzG9mbk5YUNHH
vPWXNjw1oXeQJyU2KiiVTnHLc1NwgQFpj0lEvMxxRiMqPwBfywSlD8Q+lpP5Q9fZ
w5WjqyiVqusn9wmwEKPu26YizQj6LxDMc+fR8Q//t2lldlH7Eohg7tfACNJdKVE5
einL2dSeQOLNXTqAzu+m0kct0FCYPVNQ0PqSNqEGIT3gQ9KELX57mC9lL/+lQUI5
51aHxjq6G1Vxqsjg+6i78c4fiZYfERlLGAld5CJiXUUwBuElWT5rKfGL6FWOjm/W
GTRcrPeWC0OdTX/NTlb859BdVbffqzbLLFkbbT7dILc4L7tjBXI+71soyKmXXdCE
NRI2bW9O5qWkF3OufryisFUx/VkXW+IjmQFr4pGGl/7qERZ/lTi4Drow7aHQjwGt
KM7d4ItDb9zXP0UzJ7j6NpPlyAU/uzlBjZ6dEXB7qWMYEC4hv8nHm73TLtiAYGQU
7dEVsX/BWmIKs5AEJE8dWUls54NV3d4lJWdq7kb1h99+syJZoYX7spgy3Ktwl7/X
wa2imsiB6tSGucww2hyFKQSuRpBslxQ9RlAtU/I/sgdRmmhPdHF4NUM09QshGi0c
JQShqv1CRMc3leIDHdJ8t3JewNzHEZSnxeYNd6OdIUw36lRYRh22s4JlpQr5Y5nS
bmz3gwqDeto=
=Lc42
-----END PGP SIGNATURE-----

--=-cis7sBr9TmdqXO/HY6GK--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
