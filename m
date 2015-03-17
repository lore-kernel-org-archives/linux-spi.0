From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv5] spi: dw-spi: Convert 16bit accesses to 32bit accesses
Date: Tue, 17 Mar 2015 12:27:28 +0000
Message-ID: <20150317122728.GM28806@sirena.org.uk>
References: <1426187971-8794-1-git-send-email-tthayer@opensource.altera.com>
 <1426187971-8794-2-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Eo/CjPu4VxesyHHD"
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org,
	jkosina-AlSwsSmVLrQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org, baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org,
	andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org,
	galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org,
	wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, s.trumtrar-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Julia.Lawall-L2FTfq7BK8M@public.gmane.org
To: tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1426187971-8794-2-git-send-email-tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Eo/CjPu4VxesyHHD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2015 at 02:19:31PM -0500, tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org wrote:

> Altera's Arria10 SoC interconnect requires a 32-bit write for APB
> peripherals. The current spi-dw driver uses 16-bit accesses in
> some locations. This patch converts all the 16-bit reads and
> writes to 32-bit reads and writes.

Applied, thanks.

--Eo/CjPu4VxesyHHD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVCB2vAAoJECTWi3JdVIfQCGQH/2ra2xsAPuYMeGoGd1fYTUH6
x0YUp5L9RhpCJUALwKheW70ZYvy5AUq0rSLByka8zZQ8TFlAa9G+D4ZRladHJ9XL
PdhR8tYOla0UvVB5sEqRtuDMlzDYL9ifriYQK5VoaEC3vEoqUxueLN9dYChQ3ur7
GfIniidKIOZx3Y6c3ct/DwLRTe+KsByiNDvI3jciShmf1srBp8yUoLlgUPWCGCe+
ozm5WIdvhCGqekh/gd0t9XyFXHU2YZDOae2CsIhgESO1xhJ0TZn8M9zB+JfIrQBV
Nkmn0ekcqyFdFwO/zF1/VYkDcSnMrTH6fIyWkzKSkQgx8l08B562pMSvR261iQY=
=WLiO
-----END PGP SIGNATURE-----

--Eo/CjPu4VxesyHHD--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
