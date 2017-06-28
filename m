From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: loopback-test: Fix kfree() NULL pointer error.
Date: Wed, 28 Jun 2017 20:14:52 +0100
Message-ID: <20170628191452.vjylivjghzzpk3g7@sirena.org.uk>
References: <36969f0624050d0ca6262e79bf4935698d063d84.1497950982.git.arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5j2nuyw7nm5ikvkw"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arvind Yadav <arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <36969f0624050d0ca6262e79bf4935698d063d84.1497950982.git.arvind.yadav.cs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--5j2nuyw7nm5ikvkw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 20, 2017 at 03:00:53PM +0530, Arvind Yadav wrote:
> Here, rx/tx allocation can fail. So avoid kvfree call
> with NULL pointer.

It's not an error to free NULL, the APIs will just ignore the value.

--5j2nuyw7nm5ikvkw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllUACsACgkQJNaLcl1U
h9BsXgf/XZdf4j/HZlLzazj5OAz1NmbvJen7zK4gYvtcZJweV6+3ZKDP+NB63OIJ
7HF8IB51eWm3ZsyEAMMgVxA+MfC56b9Qwejsqc9USFZr+8f30W/xZcGWjS5X+8BQ
uQVW0rDVOpHkVSzzBb2OwDCf+8cqU3r42k6hEbFWg20tAYgMg2Bm+sKocInCvPt5
QCu4+J57M1Ix3y+b0Ul6VcRteEItKhqYqRG7j/hn5tg/ur9NR6kQbCUYKFnH2W8l
3AwWCpDBBRjKx/BnUgcsIHOn72Tk0u1LAMphsIGlFwqSyhafXATbCEoK7AcOYYX2
pzP6C4KXiwv3UAM64O7N0A90GkFskQ==
=gd4b
-----END PGP SIGNATURE-----

--5j2nuyw7nm5ikvkw--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
