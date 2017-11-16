From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/2] Revert "spi: atmel: fix corrupted data issue on
 SAM9 family SoCs"
Date: Thu, 16 Nov 2017 10:36:49 +0000
Message-ID: <20171116103649.jmjmm35copbzqstf@sirena.org.uk>
References: <1510763732-10151-1-git-send-email-radu.pirea@microchip.com>
 <1510763732-10151-2-git-send-email-radu.pirea@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6i5lkcv7lofhjbz4"
Cc: linux-spi@vger.kernel.org, nicolas.ferre@microchip.com,
        linux-kernel@vger.kernel.org
To: Radu Pirea <radu.pirea@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1510763732-10151-2-git-send-email-radu.pirea@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--6i5lkcv7lofhjbz4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2017 at 06:35:31PM +0200, Radu Pirea wrote:
> This reverts commit 7094576ccdc3acfe1e06a1e2ab547add375baf7f.
>=20
> A better fix was found and DMA for SAM9 SoCs must be enabled.

Why can't this better fix be done incrementally, why do we have to
revert this?

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.  Look at what existing commits in the area you're changing are
doing and make sure your subject lines visually resemble what they're
doing.

--6i5lkcv7lofhjbz4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloNaj4ACgkQJNaLcl1U
h9Bd5wf9EmXabv83IPUFN9YujFRHFQnWmjMD9GY+k3wdlswnDRIS4csAm8biRWwy
GK7BWc5YjxpBKwvJ4A8i3Bl8tHQdxe5hJSS1azFHVbLZIFO9yeap1sXDlha6gdFT
5iCQJ0d+Z0z6GH5oTRhUzeHlKPzSUhEsTcWQoOBDgJwXhjz6/C+7EAMOkmNi8OWx
ePlizMZ5j6jVC/Q2x827BPM+ryXGxgDbq8p78wG7QEBG8w8ikfhWF5D+SziFcSre
QqE8Y1X5xr90/YgqIpw/EuKDdEzP1iA0th3zJGmtiCP5H3EtiCXD1wdfvGI8nWh6
ENSVHrqyhvXNC+Ty04DoMfFR3XtFsA==
=O1M7
-----END PGP SIGNATURE-----

--6i5lkcv7lofhjbz4--
