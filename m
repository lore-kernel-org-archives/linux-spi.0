From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/4] spi: spidev: Restore all SPI mode flags on ioctl
 failure
Date: Thu, 27 Feb 2014 13:50:32 +0900
Message-ID: <20140227045032.GN9383@sirena.org.uk>
References: <1393324819-3810-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DH4/xewco2zMcht6"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393324819-3810-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--DH4/xewco2zMcht6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2014 at 11:40:16AM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
>=20
> In commit f477b7fb13df2b843997559ff34e87d054ba6538 ("spi: DUAL and QUAD
> support"), spi_device.mode was enlarged from 8 to 16 bits.

Applied, thanks.

> For SPI_IOC_WR_MODE this is probably not so important, as it doesn't allow
> setting Quad or Dual mode anyway, but SPI_IOC_WR_LSB_FIRST is used to just
> set or clear a single bit.

Since there's no API for it at present I'd not expect somethng that is
using spidev to be able to have enabled any of the high mode bits.
Unless I'm missing some path for this?

--DH4/xewco2zMcht6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDsQVAAoJELSic+t+oim9iN4P/j8Hw067KEtQTynyv4XZGwZ8
PdkL4EYwoYbxH+PjzhPfY+AEUL+oebyT2UMWAMHCG2GgxchcCdVjl1TfooJ9yQyR
xbrx8/gVoTbQ0Uod/zv/uZUijOopDFkvfu9logB9ExGk9MDRgr4XccAwCZRauwqF
bmkEBeNwWaBvOVfBCbXARuy3zPHN3cmt1i7bHIrqoyEQqe+FBG4O8JGbokSgZeWZ
EA+w8TTULEd+GcV3SUJ5jrZJI6bIIClulImGvrS2KIPvFCaU0LsYUEIQ59YIKR9/
aZxm14+LRf1NL2xtTR0uD8/px5a+HY1wLo5aFHzlN3p+/u9UpLvTtLATVaHj6Cz+
NqIsV4TAkYnLKERpQjH5rmqUGmbxr54a8c7B2wM+Zfg3fxhqz8hol+iW8dr8MRVW
1WUXWdwCvcZrjYpNJnRIq/d28V3c63YQcmIVh9xrftU83/x2ehtIZ6SoOp8qJJmY
N7rzFSt0ZPXNLkdUNJ3Og7u4Gqz5UnzNDV6ezczaA1B6T4rUQlfS9cpod/6lxkXN
s/F1gR9YrO710Ujc74vztmMZD09/Okf37d5vhVnW3UETXtAehlEolYpMj7cSTRd8
rkwRDhZa5cGkQHaoCp6FEv9oYTyXCucC2YBDeDoEBrpL0GOxDcti/kGcW+IVxcFW
OnIgdfYfz7SFREMLaXot
=ZQQD
-----END PGP SIGNATURE-----

--DH4/xewco2zMcht6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
