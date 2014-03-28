From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: dw: Don't call kfree for memory allocated by
 devm_kzalloc
Date: Fri, 28 Mar 2014 11:48:38 +0000
Message-ID: <20140328114838.GD30768@sirena.org.uk>
References: <1395722653.16744.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ax5Xc7LkAiI0IBI6"
Cc: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395722653.16744.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Ax5Xc7LkAiI0IBI6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 25, 2014 at 12:44:13PM +0800, Axel Lin wrote:
> With devm_kzalloc, the memory is automatically freed when spi_device detach from
> the bus.

Applied, thanks.

--Ax5Xc7LkAiI0IBI6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNWGTAAoJELSic+t+oim99fcQAJHUxEq1DdJn/WS0+BCVofpE
w6UtMX6jUIHoUDL8MahwCQhBxEYbvGGEQ1MLwN5XZFUy7tUPe56vfLcYSdAS6ece
s0dYyRIMgOYbqJCVk7JlECjVipY9GR0CqSuMU2vNKIyXWR17gL/M/f3QiG0FtSvl
BtSq9l10GREEa/5RAICEc7fcQQNtHTdkEY6inbE3S1H1vibpHbgMmCFbM8cutWtR
VXCFDAWqIbB7xZnCTKjKOQ4WxJjuD5p3T2lm06V/zpDWC/dPuqua69xgrfhXhFin
giK4JDbamOkUc7alCqC8RaARlxxOKdSuriy9nL2Mg92evCSUtqTL6ePmeUEkzvdT
SEMTN07A7CrYoUppIUR9IewLVjM3g5LrugO+/mE80qj4c/xr3rO/T/Lg3P5ZgfF5
1SZkFNfpnsLiB7KeiCojmhZAAXmkElo1MRVDZECaShwUb5/vecsyYD44ip5FvyvE
fbSZFHpnzaIjbqxDGb6194f77E7UZcjrpI8KsfBYiQRRfYwbLZ5wUoUolsETG5Z2
CDO2BU7k0mG7QZSK2M8j3Fv0N7Lto/4Ia2AMEL2wlUG+Z1smdKEwgbfifwko5ibk
BkceG8y1WUef9+x0NhWrU7W3gyKHSMdS7d0q3Mt7kcP8V9pdWOWLmL0z6XBpRsMO
R0V1xu7WyMONm0QiBuZB
=klmK
-----END PGP SIGNATURE-----

--Ax5Xc7LkAiI0IBI6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
