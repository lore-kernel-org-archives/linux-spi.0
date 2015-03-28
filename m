From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi: fsl-dspi: Fix clock rate scale values
Date: Fri, 27 Mar 2015 19:33:36 -0700
Message-ID: <20150328023336.GL1743@sirena.org.uk>
References: <1427493103-7354-1-git-send-email-aaron.brice@datasoft.com>
 <1427493103-7354-2-git-send-email-aaron.brice@datasoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DfnuYBTqzt7sVGu3"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	stefan@agner.ch
To: Aaron Brice <aaron.brice@datasoft.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427493103-7354-2-git-send-email-aaron.brice@datasoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--DfnuYBTqzt7sVGu3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 27, 2015 at 02:51:42PM -0700, Aaron Brice wrote:
> Update baud rate scaling algorithm to get better scaling values.

Can we have a better changelog please?  What is better about the new
algorithm?

--DfnuYBTqzt7sVGu3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVFhL/AAoJECTWi3JdVIfQMOAH/2ZL/CD6yBZFMV5e1WmIt+5z
n9r9rGF/oIjlSQfDYS9Mt18/Vo1RO91OPBqjlk3DmfKdZjCjRGufB127XMK/xgOD
FKKFTsI2oX1eln3mbIDh3cymUgI+1wKMTgVNT8JNG2jm64m9xeCDqeCS+5Cmj3SS
W7710F/FfszaAF3KQlSubWkIQGoVE35kaFADsuvofS2sRHvL1RAm2JdGG60GEQmc
hnesKjADcvpq5OcfRtromBTFLMB9hgLdgNgtUyW9Ih3V/I/oBaBwJbF94Fc4BXFd
3St0VJte0K0V9Ac4lk2U+F0YNn0PzVnIfK8SaWreiUvOSAdoW6oTfZpP7H1CkGY=
=1OCS
-----END PGP SIGNATURE-----

--DfnuYBTqzt7sVGu3--
