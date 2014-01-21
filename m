From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/5] spi: Check that Quad/Dual is half duplex
Date: Tue, 21 Jan 2014 18:21:30 +0000
Message-ID: <20140121182130.GM17314@sirena.org.uk>
References: <1390317009-8292-1-git-send-email-geert@linux-m68k.org>
 <1390317009-8292-4-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QvYscaK3qHF14stx"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1390317009-8292-4-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--QvYscaK3qHF14stx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2014 at 04:10:08PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
>=20
> Quad and Dual SPI Transfers use all available data lines (incl. MOSI/MISO=
),
> hence they must be half duplex. Add a check that verify that.

This is surprising to me - I had expected that there would be extra
signals that would be used for these modes, not that the opposite
direction data line would be one of the ones being reused.  On the other
hand if this is what all the flash chips do then it would seem
reasonable that controllers do the same.  Can you clarify please?

--QvYscaK3qHF14stx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS3rqnAAoJELSic+t+oim9+sQQAJYLmkPiu2NJ3T3BGIkzJs3j
yi5O8Vi0yNjx+PIh6H/LVcqhCrIUEgWQqg1wM0YidxUkc2Z/GP7VEM4tocitVkky
TloJvedbxDLd4J6iXitSvomSG+4xc5MjkTUCP1rSS58vj0hB1b1xEdOAwyw6knMK
OlOhPyfZsjW9CzfLiUhS7Bull7qmclefBLZqYDlpSuuVk6VMB6mWrn8svHrPBEn1
jQ+pAJRlECEXjktPmRB6q2jxF/C17VFrHy7D+E8R648lZvnbT67NbEDdsYCBzom+
krYqAjpjtV+fMUOOQhV3DDv0oWxDVfqOfzCINHwC3vxq/XMMpNTjC1BBuxSmWdhD
2VA2DARnXIos0VuxgK7naBHI+qzWsdwDPGeas0kNbKxR3+AmhAtRAnINtTDjMN3d
FkNezKkwP8IOI8qGtkabJUTs/THjE5p/uoUWezN/e//wVOhIOb9gRPxQYg4kz70F
BfZEd7E1r38oo6TPqd2X0X8nxeOUfe58S+ZVVX/5P7Gw3pXXFBk/ABqpoxOiFkGZ
Bta7rkyrAWnHX5HSm/FpiTSYSflP58P4jbnV11uIXriKwExdnHOJWI8liWjZW4DC
7fHvQG+ziEVs77ULSjjUfUU8J4ee9nSpbgAfxgmQjm8BFQJN7ELheJfXHILWHUsP
MalsosmQxaOWsC+523aP
=g917
-----END PGP SIGNATURE-----

--QvYscaK3qHF14stx--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
