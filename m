From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 3/4] Added input buffer from the terminal.
Date: Mon, 9 Mar 2015 18:38:30 +0000
Message-ID: <20150309183830.GY28806@sirena.org.uk>
References: <1425750995-18176-1-git-send-email-adrianremonda@gmail.com>
 <1425750995-18176-2-git-send-email-adrianremonda@gmail.com>
 <1425750995-18176-3-git-send-email-adrianremonda@gmail.com>
 <1425750995-18176-4-git-send-email-adrianremonda@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UEl6xVrmin0CpRyj"
Cc: corbet@lwn.net, linux-spi@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
To: Adrian Remonda <adrianremonda@gmail.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425750995-18176-4-git-send-email-adrianremonda@gmail.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--UEl6xVrmin0CpRyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 07, 2015 at 12:56:34PM -0500, Adrian Remonda wrote:

> +	int ret = 0;
> +	char *pSrc = src;

The kernel coding style doesn't use Hungarian notation...

> +	if (input_tx) {
> +		size = strlen(input_tx+1);
> +		tx = (uint8_t *)malloc(size);
> +		rx = (uint8_t *)malloc(size);

You should never need to cast the return value of malloc() - if it's
needed it's masking some other problem.

--UEl6xVrmin0CpRyj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/eilAAoJECTWi3JdVIfQ4QoH+wTQumyTNaxzzRFYj6EDiUcA
i4uxs0BnnkdnMisgCmwDhE/+0HD8KpsR9KW+H5ZTmbvDwxYHsvN3v/l0A56Q9zB6
H9LXnfytRdR50ODNZEty13g6A6Xh/7vUzVqP8sIuZy0dzF963NQFoMoLH6HAr7/r
HWfOCObkMYu8HO6hakwLR6n1VPs+uYqlRhDwpyAGvjY1YMhuIWuAVSTscFo7qe0U
1c8XMmb507Qyv6n4U9/HEtbVoaRkCHGtJWD8xzWthkUQHW3CW4xlhlAnMyvM0Jds
ckITA4QfpHX6QJaK+iOSfKlV99xTIMUbvfbsojsnuwmb0h5hXTTj91XdnzBi3P0=
=6lcs
-----END PGP SIGNATURE-----

--UEl6xVrmin0CpRyj--
