From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: altera: Use bits_per_word_mask
Date: Thu, 13 Mar 2014 09:55:45 +0000
Message-ID: <20140313095545.GL366@sirena.org.uk>
References: <1393997820.19790.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="00hq2S6J2Jlg6EbK"
Cc: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393997820.19790.2.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--00hq2S6J2Jlg6EbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 05, 2014 at 01:37:00PM +0800, Axel Lin wrote:
> This driver does not work for bits_per_word greater than 16.
> Set bits_per_word_mask so spi core will reject transfers that attempt to use
> an unsupported bits_per_word value.

Applied, thanks.

--00hq2S6J2Jlg6EbK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIYCdAAoJELSic+t+oim95nAP/3EA+kdEBvUD1k1F/fgDfNqj
eh1b3CXuk413L4keHSg5JlZaAvJG6Y6yPHItbtLZFKn/kVlPA4paokqAkGRNYmBD
Y1GPLbyYMvA7B4Q9tbbOfeMV9O5a2dECZrVB7vnYsYwzYIJD/auZRZKAnl4/qMLC
virh99gGk5GebbHQCRuidTntQ6+zRaT2UOeXsTnwGOpIjg9/Hl4iMXp+oG+ME0oq
r+IRdADaTemRN3v+ywZV+BrE0hFDV7zl585hGEvzWZTR3bmFUQ2XREHER8qSFsJH
zU2pYBRIWJkQGmRPT8FStYc3sGkL8fAWJG0W9d92gkNuMCYh4ignOCv2WLzotdCY
VUv/cJA7II9DcpgjVjke2bGIaoFuWbw8e0DeCVsnfGfWqWsY33+SSCtEjQDBFBL+
YZ2E1tcocVEGKx9WL46HdE1y5Ngl89Xg1tKU30M3lcx5POw7yNU0y50iahAzRP6g
lqu7/nmod1CEnbplohm6NaHTHSgOMKEs8JzN7/ozT/QfGEpQSEtxNDCKo14IGvMg
WYXb5FI1HFxpd5aEyqaYsXoeUcYbKdP+sGIOM78YowW9V5UCqKF6riYQhRypaAh1
/1SxIsxsTW/xFd9jHxXzw2x4Kt+8PEHw7P9El+waUdSPijuQgbBNEtf/NxYd8aqG
br5hKXhJ3vgU7BtXWrXA
=VXLd
-----END PGP SIGNATURE-----

--00hq2S6J2Jlg6EbK--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
