From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spi-pxa2xx: Fix potential NULL handler data in
 pump_transfers
Date: Tue, 3 Mar 2015 10:02:40 +0000
Message-ID: <20150303100240.GK21293@sirena.org.uk>
References: <1425351570-29571-1-git-send-email-huiquan.zhong@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g8GocXA1jxbUqAjB"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: Huiquan Zhong <huiquan.zhong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1425351570-29571-1-git-send-email-huiquan.zhong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--g8GocXA1jxbUqAjB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 03, 2015 at 10:59:30AM +0800, Huiquan Zhong wrote:
> Set drv_data->cur_chip to NULL before finalize current message, otherwise
> kernel may crash.

This doesn't apply against curent code (even Linus' tree) because an
equivalent change has already been made.

--g8GocXA1jxbUqAjB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU9Ya/AAoJECTWi3JdVIfQzjQH/1crjAWS7RJjkNTvU0Ie33Jh
huQYr8GvRK49ySRMNva3ujj1REi3TXmZWl1pXwif/L8JMILJRJSr7jpxtRd7xTeZ
IJEdwo9x3u1HjzIg1fhBUbVgzHCS1bn+HX4DjgPW9a/MjjBi7m4NQdPvpfBMu1lP
OJXPqKjoBMN9QksnNsDMIIwFF4XoUvSfgFPCRMp1pAOc6TfC8PRh7/swLrFn6F6V
+Pbh78f9REh92Tqm4GoV89cWIFDkSeWRW8COqqoGY9y0d0g5Gs7r/EBy11aimm6Z
lNKJXUfiUGGTj4aNS+OiO9fX5+o3DzX9tb8Ar5cXiRyGOTedOMKJfoWcFv90S44=
=idRY
-----END PGP SIGNATURE-----

--g8GocXA1jxbUqAjB--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
