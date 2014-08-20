From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] SPI: spi-au1550: Fix build problem in au1550_spi_remove
Date: Wed, 20 Aug 2014 10:33:54 -0500
Message-ID: <20140820153354.GZ24407@sirena.org.uk>
References: <1408545613-28348-1-git-send-email-markos.chandras@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="csehs8AeUiGwWnbr"
Cc: linux-kernel@vger.kernel.org,
	Himangi Saraogi <himangi774@gmail.com>,
	linux-spi@vger.kernel.org, linux-mips@linux-mips.org
To: Markos Chandras <markos.chandras@imgtec.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1408545613-28348-1-git-send-email-markos.chandras@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--csehs8AeUiGwWnbr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 20, 2014 at 03:40:13PM +0100, Markos Chandras wrote:
> Commit 30670539b867 ("spi: au1550: Fix bug in deallocation of memory")
> switched from release_resource to release_mem_region to release
> memory regions allocated using the request_mem_region. However,
> a build problem was introduced due to 'r' being undefined in that
> function. We fix this by having 'r' being defined as the platform's
> IORESROUCE_MEM region.

A different fix has already been sent for htis issue - please check if
there's anything you want to change with that and resubmit if there's
anything.

--csehs8AeUiGwWnbr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT9L/eAAoJELSic+t+oim9FeYQAIW3Mhf8CpsJ/pa9TioJNU/E
pQEKiO/tYMSevoPRPiYj62YY9lCZNuafWl+rQ3v7xtw3+U0HxoujJiqFb8QqEJvy
2BZkexsiCxMbynEXiekwulBKHYc5v1Tuc+ft09igaHMnBhUTLrSPB2YBf6dcLX51
/tEkyoFxh/0My79a6yq19T4eKDvmluSNc83YqbQpbVkeIWaHpzaGcSG1nYL7bEH6
MYyNn1qP5WImJCFnYeTLvzDiwrtI3JMUhd1Klv9Iit9IOi+9CCBr8+yM6pnEtPcy
1cgOhl0VOzMVl9RrxS0ZFm4v5BmRI9dEefwmAQ7Q3jtEp1KcsTrrekcnR/gUQ6Qn
Kd9Kk1Nb+r46CmezJhKpMxVjHL5cJAx54YTu8pN7Mnp/JWEqt5M+wBb3s5DLsCL4
ZOb8YmHojmZluFPTxXQdmDXCcVgpX2+iNgTc51vgL1vQkrysvDHb+70ds9vTgYSx
ekqdMCYdhJPTupVT2/eWOhcG3tWO+kLsnOHvwgE1Q0lLMMuevtifKDN//PAIRBcN
btyr0z/By3Z2rVZwJQ3K6/VOueVdVyy0zbNgCBYYAycZOp969M59c8lDIGXS7TjF
xVSx6hr6EyjEkJa2wRm+xoiEX+4+MSldYgotYtA57TkBYT/yTn6e4S5VlH/L5cdc
E7xle/z50X6OpP/fAUmB
=hODX
-----END PGP SIGNATURE-----

--csehs8AeUiGwWnbr--
