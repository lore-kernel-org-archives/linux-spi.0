From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] spi: Ensure that CS line is in non-active state
 after setup
Date: Sun, 8 Mar 2015 20:01:42 +0000
Message-ID: <20150308200142.GC28806@sirena.org.uk>
References: <1425656716-25363-1-git-send-email-iivanov@mm-sol.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="POjlveFHrWq2ZO+N"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
To: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425656716-25363-1-git-send-email-iivanov@mm-sol.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--POjlveFHrWq2ZO+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 06, 2015 at 05:45:15PM +0200, Ivan T. Ivanov wrote:

>  	if (spi->master->setup)
>  		status = spi->master->setup(spi);
> +	else
> +		spi_set_cs(spi, false);

Why would this be conditional on there not being a setup operation?
It's a good idea, I just don't see why the backstop isn't always useful.

--POjlveFHrWq2ZO+N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/KqlAAoJECTWi3JdVIfQsskH/A38qRARBQUjZgLdzjYCw0Wt
Xq2uLxMlmtv330Vcjoo/sNdhnGfGPTwb819Rlmd+Ozse29lpwjP7KU9yFTJOS7Mv
Ot9nlZuHKYqvNi47ik7hkTNcXEo3QyQoh2DClf2eTbobHRTc0atdP2WaYvadncQW
pB4WH3Fs8n0gXWsFanht/Wdlgm/iyJ5TEOapLr6E7nGp374mS/lXQMfhKKEtncYE
SNjNOxz9QM8HbwoBvXYLrivnZLGhFK2vGcMUyMUfd419m1CFBp5aoNjOqu1DK07Y
8T9ODWetxJbEn9PTBqQO7/5soXgbjIoPVjcqGLx7GfiEh1vv6nJT81ANzq+0tOo=
=oLXW
-----END PGP SIGNATURE-----

--POjlveFHrWq2ZO+N--
