From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Revert "spi: bitbang: only toggle bitchanges"
Date: Fri, 24 Jul 2015 11:44:19 +0100
Message-ID: <20150724104419.GH11162@sirena.org.uk>
References: <1437716236-12715-1-git-send-email-larper@axis.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="SRANlrd+GMVhaYmh"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	Lars Persson <larper-VrBV9hrLPhE@public.gmane.org>
To: Lars Persson <lars.persson-VrBV9hrLPhE@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1437716236-12715-1-git-send-email-larper-VrBV9hrLPhE@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--SRANlrd+GMVhaYmh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 24, 2015 at 07:37:16AM +0200, Lars Persson wrote:
> This reverts commit 232a5adc5199 ("spi: bitbang: only toggle
> bitchanges") because it breaks bitbanged SPI on our MIPS system. I
> found two problems with the patch:
> - oldbit must initially be computed from bit position 7, 15 or 31 of
>   word depending on the value of bits.

This might be a real issue but fixing it does not require a revert.

> - The optimization also does not eliminate consecutive ones because
>   the compare of 1<<31 and 1 will be false (a bool only takes values 0
>   or 1).

No, any non-zero value is true in C.  I assume you're talking about
this section of the diff:

> -		if ((flags & SPI_MASTER_NO_TX) == 0) {
> -			if ((word & (1 << 31)) != oldbit) {
> -				setmosi(spi, word & (1 << 31));
> -				oldbit = word & (1 << 31);

which looks fine - we see if the top bit is the same as the last top bit
we wrote, if it isn't we update the value output and record what we just
wrote.

--SRANlrd+GMVhaYmh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVshcDAAoJECTWi3JdVIfQM0UH/RXD9RGsqEPsHl/AVoxV9FWv
AzRUv5TKwQMI80lHe8TYTNVDMfOFgiYqkgKD32i7LhIvpoXiaf9fOM2RICMWAPiV
h7x9SyVNQdjTofVPYOndfVakix+6uyj/ylsCoTrProXjPXIFwc1fFT2HbnJU7WzF
1PViCgfRm9o7Z27MbaRa8OKGSIp+0qLKnPLIAYWTBnIzzieBwo/95FjLlGpnmRLa
dKe4gHn0Pe25y6Gzo/beKuRZdNRI22D9lX1gyinFpVnzdgJN50jOV3Kz7zFmGsuo
ye4ZGVBYSJAKNrWqm/8V/KNirGvU5Nsy5IAuYlBoC2XNAyojeLjAy12/WiHpCCE=
=duci
-----END PGP SIGNATURE-----

--SRANlrd+GMVhaYmh--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
