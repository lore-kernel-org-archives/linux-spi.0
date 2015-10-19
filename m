From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 04/10] spi: dw: remove a NULL check when call
 ->remove()
Date: Mon, 19 Oct 2015 20:32:32 +0100
Message-ID: <20151019193232.GT32054@sirena.org.uk>
References: <1444853545-59868-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1444853545-59868-5-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YqKeQn+qkMVHQmbT"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1444853545-59868-5-git-send-email-andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--YqKeQn+qkMVHQmbT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 14, 2015 at 11:12:19PM +0300, Andy Shevchenko wrote:
> Currently all users aware about calling dw_spi_remove_host() with properly set
> parameter. Remove unneeded check.

This looks good but depends on patch 1.

--YqKeQn+qkMVHQmbT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWJUVPAAoJECTWi3JdVIfQstAH/1zgqDD5q2Iyv1aCvX2nubEz
Fmc2gnC3zUGQdYYGQOjqRzNSn/Qstvc/7+63WinBHWBL5HLXPXNgjKY1dpgR39iW
yLLlatkPpwm0LkS/e+W4nseQbkWKvFzOv7sDkbV79XkMyrg60QabGv/g391gSsxK
p42iDZbFBGG0Q6gk0588fMAkBQK/J3h8CMeydm7/dclzo2NixX/eSLSyU1TZEDc5
4P/gwnk6vxIlf/x/yW7YUZjpDTuLfOqK7fzXYtQhv9XWWPBwnJ0wDtHFOqEKiACP
zPP8OblDVDOsscsJrjJcCkU9vdG1Ia1YxLjKbqcZ5cMTELjm9l+dSI4KczObyoY=
=a1c9
-----END PGP SIGNATURE-----

--YqKeQn+qkMVHQmbT--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
