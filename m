From: Mark Brown <broonie@kernel.org>
Subject: Re: [patch] spi: signedness bug in qspi_trigger_transfer_out_int()
Date: Mon, 6 Apr 2015 17:20:23 +0100
Message-ID: <20150406162023.GK6023@sirena.org.uk>
References: <20150403084527.GA27292@mwanda>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qE0/TkNoJLLGUzs4"
Cc: Hiep Cao Minh <cm-hiep@jinso.co.jp>, linux-spi@vger.kernel.org,
	kernel-janitors@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150403084527.GA27292@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--qE0/TkNoJLLGUzs4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 03, 2015 at 11:45:27AM +0300, Dan Carpenter wrote:
> We need "ret" to be unsigned for the error handling to work.  The
> signedness of "i" and "n" don't matter but qspi_set_send_trigger()
> returns an int so I've changed them to int as well.

Applied, thanks.

--qE0/TkNoJLLGUzs4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVIrJGAAoJECTWi3JdVIfQ2r4H/R27iq0VQzvUAkmAA5XpXwL5
YCJWG0fp+mKwJtkMK/LMvI/CN6T17yzeAmR3SddVmVsTBObwC1f78fv5cfVIqMhg
f6ZwD4GSH0NmSHiAPeCYFbd8EFXxzSkPtj36ZAZmN7Ujh5ez8ZXekxp2IA0dORpM
3/DY0jvgBFYvXt8M0MSrIlHT+YPbevMvNg1FHqxpNz9iAuXaVa7n2qdD25JAMpE/
0jdp1agr0p5W2rS0ZFAQmpr9TEmYEFHUgDcKofJaJGkV2/JcLaxQbmAh6vAl45fj
4F4J5toBj82JxmgAsxx3CUOXTCcybQ+B3jI4UNBRXT2JLItf/ZK3Ura8bgTXXtI=
=KAi4
-----END PGP SIGNATURE-----

--qE0/TkNoJLLGUzs4--
