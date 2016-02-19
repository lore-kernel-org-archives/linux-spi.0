From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 04/12] spi: imx: drop fallback to PIO
Date: Sat, 20 Feb 2016 00:51:03 +0900
Message-ID: <20160219155103.GS18327@sirena.org.uk>
References: <1455867792-26389-1-git-send-email-s.hauer@pengutronix.de>
 <1455867792-26389-5-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ShzQXCswyqjgWi6k"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1455867792-26389-5-git-send-email-s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ShzQXCswyqjgWi6k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 19, 2016 at 08:43:04AM +0100, Sascha Hauer wrote:
> At the moment the driver decides to fallback to PIO mode the buffers
> are already mapped for DMA. It's a bug to access them with the CPU
> afterwards, so we cannot just fallback to PIO mode.

This doesn't apply against current code, please check and resend.

--ShzQXCswyqjgWi6k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWxznnAAoJECTWi3JdVIfQaxAIAIIsELtT92+qKvTtaRXxMWyC
2RU7UJ9lZBFiEY2zlTLrY1s/L16QZoWKOOazOZb2kbEx5bmti+7UHro7Xuh24MTU
Ws9pIMzR24bRLEUqgMULBEou3LKW4doHiQLx4R8kiAfo9WbJ1ubyKreCyeD9ZeY3
WBcdevs6G9r68qf65LmgTLCssCfxz09q2jHqs1cvn783S8QnRAur68L1DFtl6+LQ
gcnCT1QetMpvy+Q6sSH2tVBF5kCbGeL/S6klXCC5jmLdZVADUnx27werc2SWFgAz
90pBzMNjifQwepZDzVIhoUtKA4jl275v19bfayn4Y/N4aqWKdA1ROrx4DJn5/JA=
=Q6g3
-----END PGP SIGNATURE-----

--ShzQXCswyqjgWi6k--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
