From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] spi: Prevent unexpected SPI time out due to arithmetic
 overflow
Date: Thu, 1 Sep 2016 20:57:47 +0100
Message-ID: <20160901195747.GN5967@sirena.org.uk>
References: <1472479367-50682-1-git-send-email-sien.wu@ni.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uMPAU7A2Er6+wvsD"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Sien Wu <sien.wu@ni.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1472479367-50682-1-git-send-email-sien.wu@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--uMPAU7A2Er6+wvsD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 29, 2016 at 09:02:47AM -0500, Sien Wu wrote:
> When reading SPI flash as MTD device, the transfer length is
> directly passed to the spi driver. If the requested data size
> exceeds 512KB, it will cause the time out calculation to

This doesn't apply against current code, please check and resend.

--uMPAU7A2Er6+wvsD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXyIg5AAoJECTWi3JdVIfQhXYH/2QlkEMJdwyyDBHTK6lhfJnj
m6d5Fq+G3PlD41mZVHkCTkSbsvaIcJznbDHm2wCCRNK7WE1pnOl3wFLKwvW/5XBi
F2y03gswiV8T7Ey/gXAk0+55nmOpgn58IIRSdslggw+shrrUpkgxReZRfrwHXo9I
loI8SHE1MWMtJyWe5lAmXwLtOBUkP7KsiQ5v+W/Yl+Z27jjXTWEDHntDt8hI/Dbh
9O2jBFI1UsEtTqt33YWb1TsZhcxbfWTzlHy23gaDFJvu1JN1LOPiU4xX/0DvBkKR
RuE2g0hAOk9KvQ71BlfazQQc1D1pUFTWJ9YFeu1/n4Vlk8i4vV/QLdj0wQGZEH4=
=HD3+
-----END PGP SIGNATURE-----

--uMPAU7A2Er6+wvsD--
