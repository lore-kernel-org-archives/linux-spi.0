From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: atmel: improve internal vs gpio chip-select
 choice
Date: Mon, 11 Jan 2016 16:13:33 +0000
Message-ID: <20160111161333.GK6588@sirena.org.uk>
References: <1452528102-26458-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DQ8UAJma2QEM50Gm"
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	"Yang, Wenyou" <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mans Rullgard <mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1452528102-26458-1-git-send-email-mans-2StjZFpD7GcAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--DQ8UAJma2QEM50Gm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 11, 2016 at 04:01:42PM +0000, Mans Rullgard wrote:
> The driver currently chooses between internal chip-select or gpio
> based on the existence of the cs-gpios DT property which fails on
> non-DT systems and also enforces the same choice for all devices.

Normally you shouldn't send incremental patches against patches that
have already been applied.  However in this case I'm going to drop your
original patch anyway due to the issue that was found so it's OK.

--DQ8UAJma2QEM50Gm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWk9SsAAoJECTWi3JdVIfQv9IH/03S9sTOqHBFBz+AY8njruMB
dq16VuDFJ0Ys6B78pWqWSUkxehdhwC2VB8OzrA31bvAsmC8lzKxiGLUWCf5qLYzx
JLb6TRZ/0yIWX8KVX+lj7SN98Tbem5qSj0HJUz2ODeJWFf4WROwr/RU+u0sN1dLK
UYpSA6Ox2ENF9AA3zuu/CpcmmwUTi9KizHcDCVsYOJFXAp1V8Q8Cxla9YIwz0/su
pezqv6zUO4lD6sEfAiHdBvCv1BbzGfJpf3OIxJQNP80DChTt4CwLTnXECDEr2giS
fccTzqx8SL3QSdH7n6UNFTqTkWXusgnSAKkyqrcnjdqLi27uXfkzUELbW/ySQMs=
=qp7y
-----END PGP SIGNATURE-----

--DQ8UAJma2QEM50Gm--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
