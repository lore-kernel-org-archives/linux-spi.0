From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/5] spi: img-spfi: Implement an unprepare_message()
 callback
Date: Tue, 7 Apr 2015 12:17:38 +0100
Message-ID: <20150407111738.GI6023@sirena.org.uk>
References: <1428355747-16822-1-git-send-email-abrestic@chromium.org>
 <1428355747-16822-3-git-send-email-abrestic@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="AqQmwD3r69meD/Zp"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
To: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428355747-16822-3-git-send-email-abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--AqQmwD3r69meD/Zp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 06, 2015 at 02:29:05PM -0700, Andrew Bresticker wrote:

> The driver can be greatly simplified by moving the transfer
> finishing and timeout handling to an unprepare_message() callback.

The timeout handling would actually be better moved to the handle_err()
callback which is provided for that purpose.

--AqQmwD3r69meD/Zp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVI7zRAAoJECTWi3JdVIfQFkYH/R/uZtY6y2kqsiPccdEadhoK
+9OLr5vJWMj9q0Ecfdwggofkz7OmMhs9KRVbZ2cB41NVs2R6Uy90/yW7MsU+QTuJ
IzTaD3Yu3C8lV/B0jX+MpsGCFH0TCpK+5p7HYgBD1uM5kIugmtvswhj5OAN37by9
94HyVnB9qnrNZKS5RPw/qFSnRjWqPWSEfsZdBAiEP9Od5/EuLjI2pe1/ZsAOEfrv
JI39DRNDzAwkyjAdi4uoMuWa6aOXKUD7haQAL/+XSMIcNEE+t797wAAaqAKrzju+
TpYLiAyxBPjOwU1pzWVAP3Xw6UY38MjU8yasv3SXYPrhu8GtSFlyE1c/Npwtpws=
=aDYK
-----END PGP SIGNATURE-----

--AqQmwD3r69meD/Zp--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
