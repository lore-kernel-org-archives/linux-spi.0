From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1 3/3] spi: spi-fsl-dspi: Bug fix incorrect CS de-assert
Date: Thu, 21 May 2015 21:54:33 +0100
Message-ID: <20150521205433.GI21577@sirena.org.uk>
References: <1431511935-19820-1-git-send-email-haikun.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HwdYac1wHLTJyVrJ"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Haikun Wang <haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1431511935-19820-1-git-send-email-haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--HwdYac1wHLTJyVrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 13, 2015 at 06:12:15PM +0800, Haikun Wang wrote:
> SPI chip select signal need to keep asserted between several
> spi_transfer in the same spi_message usually.
> But the driver will de-assert CS signal and the assert it between
> serval spi_transfer in the same spi_message under some condiations.
> This patch fix the bug.

Applied, thanks.

--HwdYac1wHLTJyVrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXkYIAAoJECTWi3JdVIfQH2UH/0tohAbipUgJvchOQFXXlSsm
MZ7ZLg3jm/znA+Ex26iPtRhfVoUNt/+MfDu3zD5TF28aNeNRGRtsuSF8cguuWtVY
ga5hXbX7KEG4pSEw53KqSFy3oZc0dwCSgttLnaw4cbyWsOC1oOf6jxV0UWJb9A8y
VpIKIiDQQ3pFk/htG8CHXu0MDNdXzu8b/w5xXLbMr+ArkZLEWlBMIib3r9UUzGCz
8+WBT8Aow+xpdQaOqf+PvOqtEGmPbfGEOfJ9NbDKquQStwY8Z0FKunsZ+sQ6w/d8
pjiBnW5b11WzqMJp88ZDv59a4kZLW7yo+gVvT2e2Sh3Osrq3W1hjyRRtaIAsSJI=
=uv4d
-----END PGP SIGNATURE-----

--HwdYac1wHLTJyVrJ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
