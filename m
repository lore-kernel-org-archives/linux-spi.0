From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: Use %u for unsigned int, %zu for size_t
Date: Thu, 18 Feb 2016 14:58:41 +0100
Message-ID: <20160218135841.GA3941@ulmo.nvidia.com>
References: <1455802378-17780-1-git-send-email-thierry.reding@gmail.com>
 <20160218133619.GB7129@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160218133619.GB7129-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 18, 2016 at 01:36:19PM +0000, Mark Brown wrote:
> On Thu, Feb 18, 2016 at 02:32:57PM +0100, Thierry Reding wrote:
> > From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> >=20
> > When printing unsigned int it is more idiomatic to use %u, for size_t
> > the correct specifier is %zu (see Documentation/printk-formats.txt).
>=20
> These don't apply against current code, please check and resend.  Fabio
> sent some similar patches the other day.

I started seeing this two days ago and didn't submit because I assumed
somebody else already had. When it didn't filter out on top of today's
-next I decided to send out.

I do see that Fabio's fixes went into your tree yesterday, possibly not
quite in time to make today's -next. Both his patches fix the same
warnings that mine did. The only thing missing seems to be the %i -> %u
conversion, but I don't think I'll respin just for that.

Thierry

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWxc4NAAoJEN0jrNd/PrOhMkkQAKruztj0iXbx9ldtt9bb5roC
28e12A56wJL6W0hsFMuX7/K4Zda+oFoFnqg/q8gyGSxIfMBjEKjYOK3oX9CQ+mJw
umzfPoRFaMfkZhd9zxMbCuoXjAPscJcNHtnbZgoyoX6HX5angC5BkUIJlsc3YNNf
9B+8LN6M7lGeQmlVNikNT+0JiuXyjbk2PHN912oKBv+tPXoaYbDbiBCRCCxkCZ6t
viXdznnlzGgweVWsC7uJ/6RNjJkxpbNUh0ULrrE4WY1/CeCf9voswGea5OJ2G+1u
x4YK6edDd+CAKeHOrrmwA93M+Ia4VkHgRQGChY50oZ3FI2pXvGECh9x3ffHmaHUZ
gUKKjenfR/6W1JVw0+hWdpzMMr4etn9Li78ECGJxw/P2Qe65+2yK90r6ZlOF5fHQ
G3CiC2XIKRlrAE8xHsymnd6Nd3R8iaclYKeLXZF8aaBYnx0xr3ByNYGewjf7SG/p
jSXdxjnvjWfb04mZKKnNvd6uSceWmCGWft9chnq1Q7cxVkYOCTaO7amsGDutKj5L
Sucok1aOm1u7q/WUk5mWEivcyGrkmb2tGjzh2El0GPNpeIRgJx61otXCV+6MjN3u
yHcfjm2sgTuGEUtV6giclysbfdIPe2pKVDKqhckD6oL3mpJk9J/ZtbYY1auF0Xc2
OQyO1uFqtc2O8jFW/+kd
=i5s1
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
