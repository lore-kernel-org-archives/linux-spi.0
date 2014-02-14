From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: core: Validate lenght of the transfers in message
Date: Fri, 14 Feb 2014 15:06:40 +0000
Message-ID: <20140214150640.GE4451@sirena.org.uk>
References: <1392302806-17267-1-git-send-email-iivanov@mm-sol.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KlAEzMkarCnErv5Q"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392302806-17267-1-git-send-email-iivanov@mm-sol.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--KlAEzMkarCnErv5Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 13, 2014 at 04:46:46PM +0200, Ivan T. Ivanov wrote:

> +		/* No partial transfers accepted */
> +		if (!n_words || xfer->len & (w_size - 1))
> +			return -EINVAL;

Please write this using % rather than the & - it's a lot clearer what
it's checking for, I had to think what the above meant.  Hopefully the
compiler will make it equally fast either way.

--KlAEzMkarCnErv5Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS/jD8AAoJELSic+t+oim9xJoQAISEKUjUtcLd10+GOmF/+rM3
bGtog4t0fzy37ZBejdK7Kn9f5j2RLDWlJsMfMw00ytFVdsqq00VsE+dto5hLePCT
iI7HiCcVR0/5uh8/egvewOjODzstMvJrFNdiI50AERsXxMzl+fzNoimD2v0qflcF
kmaTOdh7nZ8owZfB9kCQQZt+5HzfcBcm35JHLYjjNB8PDahC78xP1548cgyxBTsu
HJ0rQWAhpEBpwHghcRbspurpbOjAZlgrbRsfpwS4e1NZiH6KzRhawcEjSxmFYhUZ
ApzyIzc+6sMK+GTaMAP7x1ypxSHfSfPL8jtQfsB7WWxsGcY4Z8wiofMyVp5tFesL
VZGtj3L6kbgN9AflEDddnX9V0RV9pDIKWEWarRcizZv16o9NIse0tYIwYiA3lDSS
p65UkwoLvqIwWNFIQEBeidxNYS010n2OYM5tB4CO51P41+wHOa1ZwSyQ90j3DKfG
pfsjk8sO9Iu3Us41Hv45IvJju3AJj+Lb+DOeLZNrj48MaInw/sMZr4dLtmhuU9jU
7DfyBHrSL79U1chTzl8XAqWsbzZlcU/mqjdAfyiGFJ7AzWUrTIy8YjESgPvVy+th
ivlB0b4A6xPeIgweb/g/Qy3ZzSMYLvQrds10+M2Oxey8iSy2hoL/TPKQAhCkv+7M
ebApivjPbZCuHX5gG015
=hexG
-----END PGP SIGNATURE-----

--KlAEzMkarCnErv5Q--
