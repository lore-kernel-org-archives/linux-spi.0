From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: img-spfi: Remove udelay in soft reset
Date: Tue, 3 Mar 2015 14:27:09 +0000
Message-ID: <20150303142709.GX21293@sirena.org.uk>
References: <1425312118-13952-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vcFgiivuaw+Jg4lr"
Cc: abrestic@chromium.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Sifan Naeem <sifan.naeem@imgtec.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425312118-13952-1-git-send-email-sifan.naeem@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--vcFgiivuaw+Jg4lr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 02, 2015 at 04:01:58PM +0000, Sifan Naeem wrote:
> Removing the udelay between setting and clearing the soft reset bit in
> the spfi control register as it is not required.

Applied, thanks.

--vcFgiivuaw+Jg4lr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU9cS8AAoJECTWi3JdVIfQeGwH/imdaX3CmdniosPVd+ZHi+wV
awamBoTnSSno9nnW49UMV4t/IPOndEA+quR0ZF1LbtYq5xYSRaEoa6hrr7bdkGDW
IbOMrPCSM5rmy6nH0YwfVViF+vLo3m49uLLMKQ6saaTNgGMQudPbltI6s1cvXUbn
8onu0ffPSJ0viuIlQzORg5NP2Ttr1j2SJoxWVWJoA3uc/02kmzFBxZ5aRqxulU2p
mEGCkWuLQJy73Wb+x/oSI32VnM6CukEjYK9tqruvbjg+GZAblMLFGEu6mPH/HXn4
mZYSimjssqVEivkBGGmWxKSR/4IBLf39uLf6J3Uug6LLFpaIKMA24obfhKQYqFE=
=8lq9
-----END PGP SIGNATURE-----

--vcFgiivuaw+Jg4lr--
