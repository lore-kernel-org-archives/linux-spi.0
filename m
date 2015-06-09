From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] spi: spi-fsl-dspi: Change the way of increasing
 spi_message->actual_length
Date: Tue, 9 Jun 2015 18:36:15 +0100
Message-ID: <20150609173615.GQ14071@sirena.org.uk>
References: <1433850337-30713-1-git-send-email-haikun.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wqJKAkAJyMuynVpZ"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Haikun Wang <haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1433850337-30713-1-git-send-email-haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--wqJKAkAJyMuynVpZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2015 at 07:45:37PM +0800, Haikun Wang wrote:
> In current driver, we increase actual_length in the following way:
> message->actual_length += dspi_xxx_transfer()

Applied, thanks.

--wqJKAkAJyMuynVpZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVdyQOAAoJECTWi3JdVIfQesgH/1nnEzk21pCVd6cmEHIf0Osx
Kc67f36bfGqHZm/HRFS7WKlW3ZiGPfxVYfmvQ8dLMtY8Lm+bK9ZD/QGDU3MwndA0
zl0Fv7MKX7BTQGCOdjFJ95NswlFd1p83Nq/23VtkgOJYoacqF/DZCRR1pw84vpR0
N8xaaCAOtBaS00FBNEUQYhXCkmPhRiKBiEdzUG1rYS/a7aAK9BLyZwzsDctkRby+
D83DKPSKYxwNmIhKQ79l1gcOQb85JI7PQ/Uzq2ekZstVENUxDsn3V3nAPGfv2S0b
cfZK82OA5KNoVU7upodSg6SFLVZAhCX7PrYep1uouXbUT5ZEaLUKFwUV/EkoqOc=
=bg9v
-----END PGP SIGNATURE-----

--wqJKAkAJyMuynVpZ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
