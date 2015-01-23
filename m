From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Backport of spi-fsl-spi bugfix to 3.14.y
Date: Fri, 23 Jan 2015 12:45:29 +0000
Message-ID: <20150123124529.GU21293@sirena.org.uk>
References: <1420472564.803.9.camel@gmail.com>
 <20150105154834.GV11764@sirena.org.uk>
 <CAOR3GqUBWyfUvNG-8JiPVkis6b_25Eq_REtcp=kLN3CUoqsG6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2DJuma0xDHN2clgl"
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
To: Esben Haabendal <esben.haabendal-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOR3GqUBWyfUvNG-8JiPVkis6b_25Eq_REtcp=kLN3CUoqsG6g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--2DJuma0xDHN2clgl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 06, 2015 at 10:15:47PM +0100, Esben Haabendal wrote:
> On 5 January 2015 at 16:48, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> >> Please consider commit 4302a59629f7a0bd70fd1605d2b558597517372a
> >> (spi: fsl: Fix problem with multi message transfers) for inclusion in
> >> stable kernel 3.14.

> >> It fixes a regression when using mmc_spi driver on top of spi-fsl-spi
> >> driver (tested with powerpc mpc8313 based board).

> > Has this ever worked?

> Yes, I have used mmc_spi with spi-fsl-spi on the same board with success
> with in 2.6.33, 3.0 and 3.4.

> I have no idea what has caused this to break.  Maybe mmc_spi driver was
> not doing multi message transfers earlier?

So, I now see this has actually been merged into stable without getting
to the bottom of why it's helping anything...  this is a bit worrying
since it's adding new functionality and not really a bug fix.  It'd have
been good to at least get a followup here.

--2DJuma0xDHN2clgl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUwkJpAAoJECTWi3JdVIfQPo8H/RffkPqLY2puXJqYxZVPSKSw
sJMTg3QCJ9I7FW9FfU2wz4wrDFtV8hvMmfnnjZgv8uQVlbgkAGxO4S7K+UuQq+z9
g+Yu7AYzgJC3n9OURVc9u1S3tFUULFM3isbIW7eTQNHa2De3GfEEjIjAepfAy2uE
e7DNgA3OHceEBQ3LHflonH7qyBzPl6wEGxMp8BYfT4fmxEGeYn7aKZJlYT4rXDa0
MJoSgkeK3XmhOt2VYwKXRLwccvMHn78MSEsR2g23EY6txWsJmYX/K3gNUvPAcT3K
xzTplu/mOgakJgQ4aOwsqHBnkGSs0Bo1g0DZj3eN4UrNa4m0AsMIkd6McUAU9rs=
=QO5v
-----END PGP SIGNATURE-----

--2DJuma0xDHN2clgl--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
