From: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Subject: Re: Autoloading of SPI/nor driver on kirkwood (qnap devices)
Date: Thu, 04 Sep 2014 03:11:29 +0100
Message-ID: <1409796689.27524.34.camel@decadent.org.uk>
References: <1409673299.14324.43.camel@dagon.hellion.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-GE2BA4lK9Aiz0+lL9T0z"
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	debian-kernel <debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ian Campbell <ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409673299.14324.43.camel-ztPmHsLffjjnO4AKDKe2m+kiAK3p4hvP@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--=-GE2BA4lK9Aiz0+lL9T0z
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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

--=-GE2BA4lK9Aiz0+lL9T0z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUAVAfKVue/yOyVhhEJAQqz0Q/+KUKj3uLlkTqhHKrYLHveL+w19w4RBB3w
43ECTRpCxJAbC7OkjLcd8UW5GYSIXgekPFVujhHek3D/RUUcJTlSy3DLg9g77+B2
iAmfl/VLpao8LxsBYEDs1p1ywZ2TJLFl2KqxixyG86x9ufLpC2Qun4Sp229hf8qu
+LzvDvGdlFSZ5uEtHvbQ0LVOuan5ZoJcK4o0Uhbh0b4YIgjQ34uAjrtzOaXmeBjT
BCL0uDvZRnRm1NWKOwzsAJDSPGj4fMR4AJsvrbGzme6Ez9Rj9FFYcKPQC1RGxvgD
bCa8ESWZpJtKc46efVxSVS06A33rA8LH7gtcFIgHYoM0Fz4nA5QjmUxNL69da/8h
V06copYYvQUhfCnjS4OJ01txgHTwCFbw6Bh0EPNl3H6NLPMIQTZVzXBw5PPOhzAQ
sXkI3Ke9nOY/ImUIm0e7maNC2cfvKl7QTr37y0VITH2hxIbftC7QrPNBuz79YmLc
Zh63LIA9nwE3t6hstHXLCB24rr3Pq/BGxLsD82HQj/bWlPsGGhWj2NW6YvRoxla5
kprAQBmyrvb8qiP4+4H9h4kqzd8+324bw4YgAHbc2GP1e/NSVxzwUU2vdBYqICgK
/mUPmn3tJGBa4RTvCCxY5mU7AOVaRu7rWHk1uBhJ2fuuiQct6NlEpOXg7WlTjcZx
jUWl8+q9CBk=
=CQFt
-----END PGP SIGNATURE-----

--=-GE2BA4lK9Aiz0+lL9T0z--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
