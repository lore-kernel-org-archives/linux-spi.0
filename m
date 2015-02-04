From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] spi: match var type to return type of
 wait_for_completion
Date: Wed, 4 Feb 2015 20:52:39 +0000
Message-ID: <20150204205239.GJ21293@sirena.org.uk>
References: <1422865837-10357-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fz1k6AzmkLjpZ+k2"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nicholas Mc Guire <der.herr@hofr.at>
To: Nicholas Mc Guire <hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1422865837-10357-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--fz1k6AzmkLjpZ+k2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 02, 2015 at 03:30:32AM -0500, Nicholas Mc Guire wrote:
> From: Nicholas Mc Guire <der.herr@hofr.at>
>=20
> return type of wait_for_completion_timeout is unsigned long not int, this
> patch changes the type of m from int to unsigned long.

applied, thanks.

--fz1k6AzmkLjpZ+k2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU0oaXAAoJECTWi3JdVIfQscEH/0uCzBRduPkfLOaaIkygxZ0S
h+5lErgmhFOyHjFVgLIiBSVtFkZVIk8iD6UYRNaCUPQh2qEddM9bYRl7scdF1TU5
X70gWdD5Dsfu2O265HnAr0BitPWiDVAHIQQNGPeHlVAOJjhpXGxlKZ2mSGTYreAS
ypCFL3XGJOfJIoBkE4PcyDiBwVf5k3NlEGfDCIiEvuu7WQ8NDXHgS/tuavQZiOKj
K2nFVKq/J7HD6EUGzNNXxCcHFvTzRA6Fzfik6BxQVOWbPCWDxtk66fM7tZbS81zi
UtFjed1SJXg957fpWWMrL8aGKztndamhYWrTx+Nl57RNTn5ZN5qkTxYdsL7CXkk=
=ugcx
-----END PGP SIGNATURE-----

--fz1k6AzmkLjpZ+k2--
