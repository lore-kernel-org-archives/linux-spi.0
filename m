From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/5] spi: img-spfi: Implement a prepare_message() callback
Date: Tue, 7 Apr 2015 12:18:01 +0100
Message-ID: <20150407111801.GJ6023@sirena.org.uk>
References: <1428355747-16822-1-git-send-email-abrestic@chromium.org>
 <1428355747-16822-2-git-send-email-abrestic@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yMeU8KwQKf0wI0P3"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
To: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428355747-16822-2-git-send-email-abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--yMeU8KwQKf0wI0P3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 06, 2015 at 02:29:04PM -0700, Andrew Bresticker wrote:
> From: Ezequiel Garcia <ezequiel.garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
>=20
> In preparation for switching to using the SPI core's CS GPIO handling,
> move setup of the PORT_STATE register, which must be configured before
> CS is asserted, to a prepare_message() callback.

Applied, thanks.

--yMeU8KwQKf0wI0P3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVI7zpAAoJECTWi3JdVIfQ3WcIAIV643iINYXBBLx/fr3o7jnS
+62oqVGXWYySM7QDFFVhmWOy0KBvNZ+0nYL5THvgSGoKSh9tUTJQH09uXGKDgmxi
fUnpx7maJyObInfxE/Nlo5ycUxz0fiAac7gUEjw+dwzy8qrkephGXDjV1gwKH1Pe
Zt4s45F95n0B6dLxQ6U1UYrd78fhCj2QCRDhgHYcqj2nWqQ0/iBpvt7QsoTYNK66
Mrik6fKVS4PLHCgIF2DkyMUQ4MyqRhpJsOTOGmmPIaGwniN2YVR/diVTClAfF4Cm
dLxQy9EZ7upwTVo5VLrJvHSHNdZ3hnKX1a3yUEIt16ZEXtSzI2hmAz9FcVC0U4s=
=5K1u
-----END PGP SIGNATURE-----

--yMeU8KwQKf0wI0P3--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
