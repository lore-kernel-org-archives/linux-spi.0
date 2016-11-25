From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/5] spi: atmel: trivial: move info banner to latest
 probe action
Date: Fri, 25 Nov 2016 13:05:40 +0000
Message-ID: <20161125130540.twmacpqtuzz6imdn@sirena.org.uk>
References: <cover.1479985886.git.nicolas.ferre@atmel.com>
 <e259bb1c87e32c67295747f868f8684c1e929d68.1479985886.git.nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vvglwj5kyfm76hbf"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org,
        cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org
To: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e259bb1c87e32c67295747f868f8684c1e929d68.1479985886.git.nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--vvglwj5kyfm76hbf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 24, 2016 at 12:24:57PM +0100, Nicolas Ferre wrote:
> The info banner is here to tell that everything went well, so place
> it at the very end of the probe function.

Really we should just drop this, the banner is only telling us things
enumerated from DT so it's adding noise to the boot.

--vvglwj5kyfm76hbf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYODckAAoJECTWi3JdVIfQ+F8H/jCEcZda1Hz/6nAk88ZE+h6t
AABSPE9N4/uuQcSkICbpbMUG2ZlOgXrklsk6IvRTWcpSwqEyJK6p1nc1h8deDePf
DTtHehb6mjqweww54fcQvzII++dYOUace3JuDRsskpAETmzqKQ+60BhrxXHhRlYL
U43zLsYqmpO3/iGg9NLDCGtXRSHVvEljV5Ri4CIz9hKBwpga1ya9OcOMzhmBAm5N
qzBXHw7sT/33wRcB7E/8FYpenKkB+S68uYbPjXknKSLkrlRkTk+dCtzTNOhqFT+P
osJHZRgstt4MNpiqrZfnHpW+fFe1CZjQwO7ZJ5tUIem9e6MaHkmtF2o/6hC0U5Y=
=i7mQ
-----END PGP SIGNATURE-----

--vvglwj5kyfm76hbf--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
