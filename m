From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/4] fix module autoloading for ACPI enumerated devices
Date: Thu, 16 Jan 2014 12:28:19 +0000
Message-ID: <20140116122819.GO15567@sirena.org.uk>
References: <1389689198-2641-1-git-send-email-rui.zhang@intel.com>
 <1389689198-2641-4-git-send-email-rui.zhang@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VjpKO6h983+pAmpQ"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org,
	rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389689198-2641-4-git-send-email-rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--VjpKO6h983+pAmpQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2014 at 04:46:37PM +0800, Zhang Rui wrote:
> ACPI enumerated devices has ACPI style _HID and _CID strings,
> all of these strings can be used for both driver loading and matching.
>=20
> Currently, in Platform, I2C and SPI bus, the ACPI style driver matching
> is supported by invoking acpi_driver_match_device() in bus .match() callb=
ack.
> But, the module autoloading is still broken.

Acked-by: Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

modulo the PAGE_SIZE stuff Mika noted - unless this changes radically
please just assume I'm OK with it.

--VjpKO6h983+pAmpQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS19BfAAoJELSic+t+oim93BQQAJAh6UiO01wNFvkTnZ7CqkPS
TMFxxVCz+0y+SuzfVu4EAx84RQIO4dMx7i/CWEyKojl1jDvajY//99UiePPwE+iY
Sap0woW8xwzhAnQJ/UARy3tUEwkw/oO6QdgwsuLVRvDODDxvvzoecPNgs0U6aSrV
CBH9YE3XQdObnTu2WbcSKvhmzJEvxEUDMDHQO17sl42E2ZDtp0Q8qmPScJcZAk7u
uZRMC38ApXfN4UOglj3X9GdRg8rFdyvKpsxW02u+OY2iJbc6Vycj28kfjTD9OlyK
jnDP3rMcP1Ui5kk4fQHrC6fE5ijhSrRZvDg8czk/wO2DnUPPuEhhhURXHKjx8fmE
z+qtGmSb0ZDap7VZqFktBsUdr8yJW+Zh/K96OMKaym6AjgVbYMPFAzt+F/pzNNY5
E68/yG4mxT6DAWkxlHjsL8JoPO1RArPomWTuzBjdXa+Gv18lF1L9SDuYHitmxNdL
e0N6m2qD1+obaEgXkt6EdpNBESCTkqblCponhiEUI6Idsk3xyhYUvXb9OxjCSup+
d8pLKIw+cDeN1oW3v3/VeK5qtJWvEcMHPh/kQtr1cEQyB9UGOwvWinEoq+Ti3Zsq
+oUepOlxVE53zUB+OasFJl2RXrH1bmdIEdtYic5juq8EmwRV96PLFRRfV7DsB8au
mci+Ps8ReUHWdPgVfxOk
=CtLh
-----END PGP SIGNATURE-----

--VjpKO6h983+pAmpQ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
