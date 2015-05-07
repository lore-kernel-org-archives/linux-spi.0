From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] spi: omap2-mcspi: Add support for GPIO chipselects
Date: Thu, 7 May 2015 19:58:31 +0100
Message-ID: <20150507185831.GQ22845@sirena.org.uk>
References: <1430955472-11409-1-git-send-email-mwelling@ieee.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1mi/MjpzKkI3NMOc"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430955472-11409-1-git-send-email-mwelling-EkmVulN54Sk@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--1mi/MjpzKkI3NMOc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 06, 2015 at 06:37:52PM -0500, Michael Welling wrote:
> This patch allows for GPIOs specified in the devicetree to be used as SPI
> chipselects on TI OMAP2 SoCs.
>=20
> Tested on the AM3354.
>=20
> Signed-off-by: Michael Welling <mwelling-EkmVulN54Sk@public.gmane.org>
> ---
> v3: Switches driver to use transfer_one instead of transfer_one_message
> allowing the spi core to handle toggling GPIO chip selects if specified.

This is now two changes so it should be two patches, one converting to
transfer_one() and another adding the GPIO chip select support.  This
makes things easier to review and helps people trying to understand the
git history in the future (right now there's not even a mention of the
conversion to transfer_one() in the changelog).

--1mi/MjpzKkI3NMOc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVS7XWAAoJECTWi3JdVIfQnCkH+wabH6tOM1Od31OQ0nu1o28J
wnpO14YP9f+SPu2TbGXeLrLyw37UWEFZbEapsjQ3XfytPcjwMklV2bwrWD1thQSQ
87K1dfcoVNUoEbnqaYhbFA47dIXLuib5zLZESYBRd5AzkADrBsgBVDFNYgtK3n+9
RyZUgRiNnPZEu7VMmEp5UpOHwcCW5T6ZCey9f+Xh1KeJIRDXLuWG3hIKtjDuPbfg
LJTe8TbiZfV7FuFNwy9UWAjLsU7zOeT33V7m9z2qvyMBpoQlTaAj08XyxPROTYew
zOloYcuywoytfvAOiLSADKpCOVsMgwA3EsW33o4USfRMy+nH2q3oxD0Pn8bT85E=
=IFMn
-----END PGP SIGNATURE-----

--1mi/MjpzKkI3NMOc--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
