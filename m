From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 1/3] spi: img-spfi: Implement a handle_err() callback
Date: Wed, 8 Apr 2015 21:05:05 +0100
Message-ID: <20150408200505.GN6023@sirena.org.uk>
References: <1428512596-23766-1-git-send-email-abrestic@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Zt1jgzG8cgV/dHjv"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
To: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428512596-23766-1-git-send-email-abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Zt1jgzG8cgV/dHjv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2015 at 10:03:14AM -0700, Andrew Bresticker wrote:
> From: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
>=20
> The driver can be greatly simplified by moving the transfer timeout
> handling to a handle_err() callback.

Applied all, thanks.

--Zt1jgzG8cgV/dHjv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJYnwAAoJECTWi3JdVIfQu2UH/iius01fXtF1X9H3oAyn5MdL
h9JtTZ2cwdaDa9Bbc85NxXDAM/j5PKdWVgfeChiYyMSe4wDHdH2Gc9x89PdaZM7H
gGpXkM+3sb3htvaOtBfUvwQvV7+xiCwb2KjMXcLreu5xuBSN5roVn1mnql4z9byA
ZwQldBqIsngIpStcenAkqaoM5N2tGWd8TDut2GQQIwH3RTeiI0qnKiBSgJBXpybn
/ND1uQ6MH40aIIqf6toL2gq3sTkmBE43+U53AFUmFHzOT8H7EEaKN2V2HGL3Wt9r
b6ZNjAfQyX/GQTcin1W8QtDtm09ZiiE/pgtzby2Iq3ZfEtT15noRuVPTtdE6mvI=
=/vjd
-----END PGP SIGNATURE-----

--Zt1jgzG8cgV/dHjv--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
