From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/3] spi: fsl-dspi: Fix clock rate scale values
Date: Mon, 6 Apr 2015 18:11:28 +0100
Message-ID: <20150406171128.GR6023@sirena.org.uk>
References: <1428093571-20407-1-git-send-email-aaron.brice@datasoft.com>
 <1428093571-20407-2-git-send-email-aaron.brice@datasoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5mQWZobUy98rde9G"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	stefan-XLVq0VzYD2Y@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaron Brice <aaron.brice-vSOi0k5x9wFWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428093571-20407-2-git-send-email-aaron.brice-vSOi0k5x9wFWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--5mQWZobUy98rde9G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 03, 2015 at 01:39:29PM -0700, Aaron Brice wrote:
> Previous algorithm had an outer loop with the values {2,3,5,7} and an
> inner loop with {2,4,6,8,16,32,...,32768}, and would pick the first
> value over the required scaling value (where the total scale was the two
> numbers multiplied).

Applied, thanks.

--5mQWZobUy98rde9G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVIr5AAAoJECTWi3JdVIfQ5mUH/j08PS6yKEzpB4gsTPgcnyfZ
9AnYaY+r19ZEoxK9aul8lRjsMhzLPrNdtyd5NwFD1P9nbgFf5pbAYEeqwRilOUdS
VsGbVtWrconvk6qJn6W6pQeL3mQa1uLPuXqJ2VetBj3R+3lRuNfQTXR8MYIGdwOU
WBIDWbR/w9DLp3ZgGT7KySkq/yKUAcave5Vkbn3lAWTSuE3NI9fBaFR+HQpjLqBI
smHvZb38oRN483cQFOGEtTza8OrY2KoYMB1ACs8d9+l/gJDF9aNoJmyvLy2Pkfku
XAnMPjXtQnQZ3BxBMBT7AmNFG/hQrAv59TS2pLxRj0jNK9mtYHT6FOL0i8gtnz8=
=R/zY
-----END PGP SIGNATURE-----

--5mQWZobUy98rde9G--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
