From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: mxs: Use list_for_each_entry to iterate over
 transfer list
Date: Fri, 7 Feb 2014 12:20:49 +0000
Message-ID: <20140207122049.GF32298@sirena.org.uk>
References: <1391593679.1420.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KC8G+boRvJEnfJv0"
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391593679.1420.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--KC8G+boRvJEnfJv0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 05, 2014 at 05:47:59PM +0800, Axel Lin wrote:
> We don't modify the list entry while iterating the transfer list.
> So use list_for_each_entry instead of list_for_each_entry_safe.

Applied, thanks.

--KC8G+boRvJEnfJv0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS9M+eAAoJELSic+t+oim9rUEP/RKhLkSsGzsxmJTCKHkJStYV
0A1fwcRJ7JwttxDtmm6CMeR24+I8g8aP376onDFg/Ya6SZi0Q5uBvw2mU4suc7Iw
c/EL8IUfLADoIZbcQLXSAfVHGUfx+35fQ6A/ud0i/raFKeHXW7hrZ/4hxL4s535W
/DKHzDxTrbwLcGFDy/fCfoAZdWlFF5YI/DwETGCLjoyRL3QDP72fQTj910n9lB06
JLPjJsWlLPt0QZBoDmc1mOeLjpnd1tg5AVeejpt87tqBmffpy2O2Pmc6Fr2/jZZK
W/Yv4a6X6Fxggc5vAdF4CHGWoQmMGmNm8wrjDo5tHuVsgKDYRvj//+QHfdSNkMNT
7GdUCuujennkwFBqEUMFMxYmM9XCuoQyX1UW4tNCLkXCuxj1SmsX0Nfs5jovB+TR
owetc5jzvZjKdyXE0L5YqQdueCB0JyuTzRsvOrNycjgt00phhPiAQkzeWKSIkL/s
zDu/smkbM5B6+uyo1mc++KQ7JF/Hkw5xbPPg6p3xY3qlwysgCxy3MrZg4RfcVd9x
7CBwXsVbgzNnRMH70hf3YXhd0EcVlbV1BmnzE32hUxkBQwC2jeTnKF9zof2Ztr0R
IB3RI3bC/n0Twz7GSWULJT+GboBc5iRvig5KinUJCXE/hdQJ2qOdgzftygKhuJs8
itpKNIPDBgShfhBMD9J2
=hTzv
-----END PGP SIGNATURE-----

--KC8G+boRvJEnfJv0--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
