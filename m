From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: orion: add support for multiple chip selects
Date: Mon, 28 Jul 2014 22:48:23 +0100
Message-ID: <20140728214823.GI17528@sirena.org.uk>
References: <1406498000-13079-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1406498000-13079-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <53D5ECCA.7030806@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FrGtGUqnfnh75Pg1"
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <53D5ECCA.7030806-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--FrGtGUqnfnh75Pg1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 28, 2014 at 08:25:14AM +0200, Sebastian Hesselbarth wrote:

> So, "num-cs" describes the number of *available* chip select signals. As
> they can comprise extra cs lines that are GPIO and not dedicated
> controller signals (native above), it cannot be something the driver
> knows.

Yes, indeed.  Though given that we also need a way to pass in the GPIOs
for the chip selects which isn't standardised at the minute it's all a
bit of a mess right now.

> As long as you only use native cs lines, omit the cs-gpios property, if
> there is any GPIO cs lines, insert <0> where you want native ones.

Right, something like that should be usable.  We also need a way to say
which native chip select to set when using a GPIO chip select if the
GPIO chip selects go beyond the native ones and none of the native ones
are masked by GPIOs.

> Although, I wonder how the driver learns about reg = <1> is actually the
> controller's cs0 in the example above?

Interesting question...

--FrGtGUqnfnh75Pg1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT1sUkAAoJELSic+t+oim9kVoP/12Hv9cZLkYs4PEgIYQjUszT
jY62eKWTJwuL3jlSdHsNfLoNiRsTwZ4dtoSVtRqYYhRIqZUgNYpf2O3CX8Y3/+Iu
uabPPjObB+jdQGtWZj1LAFwXpUIB/8ZwP1eyCWiaEYauVIDl4imXqjVabgoiajEo
trGFlo/HTYIXPWNaY0VScdUGMMq4uWcBMZWd0rsozDc+6kqnFqAcO770Ll80MGMF
9MwPjPZNx5C8p3AE1GmW0yiBxkPwp8DD9TvcEbZxymIi9aviy4kSV41mbwF77GXc
+DOYVAr6tMtFDhv5XX/k70SguaefWPT4OUkjyXNWmrdkMXO5hh82wiLUjxzsWJga
QELuKPdKPX9T8tZx4tS9QfRurLTutMv5vpgWEuZv2ybbOQ7drLPtvo9M2ErOLT5h
8sVdasyuBKsqBDrr0+iKzU2cpL1erPqmPIX7NfEEK3ZlBmoA/TkSd6BdcC5RM3Xa
KLg7+P7kNOOglGkHeH9T/BxeNWJXPT7sYCgSc0fFCYqmTbGUkcs2Q8tGdHl8g/JB
Fy6wR8xKDnFAKL5D+j3DMO7ErObxlpZFnrBPl0XrPbAMvOritipJ/piLBnRoAB2m
nnNozr+8i6LxlczfqeZddvHIHiqaNjmm+Dos+b6PF8P2QA1vHs9Bk2RXGpqNeWje
Zl5JLAG4EMSeYQNOXZAf
=UZUx
-----END PGP SIGNATURE-----

--FrGtGUqnfnh75Pg1--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
