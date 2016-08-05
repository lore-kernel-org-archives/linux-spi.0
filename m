From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFCv1 1/1] spi: Expand tx_nbits/rx_nbits to add 8-bit
 transfer
Date: Fri, 5 Aug 2016 18:57:42 +0100
Message-ID: <20160805175742.GB10383@sirena.org.uk>
References: <1468438477-18883-1-git-send-email-girishm@codeaurora.org>
 <1468438477-18883-2-git-send-email-girishm@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vkJ987n7uXEPtlXE"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
	linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Girish Mahadevan <girishm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1468438477-18883-2-git-send-email-girishm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--vkJ987n7uXEPtlXE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 13, 2016 at 01:34:37PM -0600, Girish Mahadevan wrote:
> Expand the tx_nbits/rx_nbits member of the spi_transfer struct to a 4 bit
> value to allow specifying 8 bit transfers (SPI_NBITS_OCTO).

Do you have any examples of hardware that might use this on both the
controller and device side?  Hardware like this tends to be memory
mapped rather than driven by a SPI controller in my experience.

> Change-Id: I0b7ab41b2caa8495da431944ccbc0b90942d5dd9

Don't include noise like this in upstream submissions, it means nothing
outside your gerritt install.

--vkJ987n7uXEPtlXE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXpNOVAAoJECTWi3JdVIfQXIsH/3qbAw9qIIXcf+FjhAFFKjqP
lBXM0KZ/FXAiAzUDiEQpf8kFmCjqxeiwdcziESkGqxrbIplSdMAG+stp3LzNSalu
6dUzLPMDckbToz60NH+rlyjsYqI414QuV8lUQoeHFDNcPfohwKvJhThzEVzY1fYj
vQ7gbHxnud6ZTgqzXJM2JCwS4BYl2jKNFHsyWvS53TJUtHapIBI6Qqw3LG5YSg9z
jq47mjFfgD9fYIrxEWwV32JCEyeMpmm+lOpG4Woj0bBuj/KMmGJUCnexBrrMcQcb
xcbhPFq4zCTmJscMtTZj06d7hh73o2j+QXf9GRtJFCwMhnhDj5u2DGErslVa2ic=
=qn7H
-----END PGP SIGNATURE-----

--vkJ987n7uXEPtlXE--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
