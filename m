From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/4] spi: imx: GPIO based chip selects should not be
 required
Date: Tue, 31 Oct 2017 11:19:19 +0000
Message-ID: <20171031111919.gocl7wwrhkwnxrya@sirena.co.uk>
References: <20171027010841.28624-1-tpiepho@impinj.com>
 <20171027010841.28624-2-tpiepho@impinj.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gsxaxndjex3eafbw"
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171027010841.28624-2-tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--gsxaxndjex3eafbw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2017 at 06:08:38PM -0700, Trent Piepho wrote:
> The driver will fail to load if no gpio chip selects are specified,
> this patch changes this so that it no longer fails.
>=20
> It's possible to use all native chip selects, in which case there is
> no reason to have a gpio chip select array.  This is what happens if
> the *optional* device tree property "cs-gpios" is omitted.

Do the native chip selects actually work usefully on this hardware?
There used to be problems with it wanting to do things like bounce the
chip select on every word which made it extremely difficult to use with
Linux.

--gsxaxndjex3eafbw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAln4XDYACgkQJNaLcl1U
h9DE7Af6AxBm8olB2sbCdU/jV5FWNZ85Ud7hODPDOTZpMbGpxBxynOnqy82FiFso
eN9KgO3OspEeaPXWCPdVbEh68H2o1M/RwS3wC4ivcE/470jKHmvSKR25TrJkNCxL
VWwXm2oG6kNQTFivllZpSacb/f2a9oObMBKf/GalK1TpxMkqEjOL7zX0NaXvIonZ
/oL/GeImZvC/DGPj6GDirQhNTeQR10o7xeVGJ085PhJLheiZkW82HdjafgpSzZ2E
fde6H60XjQG09Oo7G33PeIL6NeDo/KxHF/Im9jjL84RZ1RY74vQOq50ZWTFmLmNk
m0bnZbGamQ3akcFkC1lICJToi56iqA==
=p0Bi
-----END PGP SIGNATURE-----

--gsxaxndjex3eafbw--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
