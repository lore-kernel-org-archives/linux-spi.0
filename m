From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/2] spi: bitbang: simplify pointer arithmetics
Date: Thu, 10 Jan 2013 12:04:03 +0000
Message-ID: <20130110120403.GM20956@opensource.wolfsonmicro.com>
References: <Pine.LNX.4.64.1301091502020.13376@axis700.grange>
 <CACRpkdYdRnjTA3xcSm+nQpWrYEYvBNmSTUcY7aVnA3evP9aOog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AQYPrgrEUc/1pSX1"
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYdRnjTA3xcSm+nQpWrYEYvBNmSTUcY7aVnA3evP9aOog@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--AQYPrgrEUc/1pSX1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 10, 2013 at 12:55:15PM +0100, Linus Walleij wrote:
> On Wed, Jan 9, 2013 at 3:08 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:

> > Add a pointer variable to make spi_bitbang_start() look simpler.

> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

> Acked-by: Linus Walleij <linus.walleij@linaro.org>

> I think Mark Brown is still backing up Grant sometimes, so include
> him on CC.

I am, yes (mainly for driver updates) - can someone send me the patch
please?

--AQYPrgrEUc/1pSX1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQ7q4DAAoJELSic+t+oim9qRQP/R9Zju2JAgLKUby2zPUk9cjc
cPgJhFo5Uif6pY9wjVJdMG8OwkGgguFGFsQjgRA91JA10gV12K0iFZQWz4qR9Gwq
FeXXtSKQTgLxWq+7CMyXQ2gIfXsMT7hkD8WrX6y6/94aebtKzU28nYJu1NDS1FWw
omcfn+Got+Zr5BJGnGsHmq0BAeYOuXpchKBsu+lV+1Qi7s4zr1b8o3gQk62u9jBz
cUNKkyEI9Po8xQW5nrNaRuGvx/qkANK0sjOC99NmIGC2/2Ea4hVOQzFlVHL6Ndto
7NKnf2fROBG5NIgAFbJInvev/fu1Yj9cCa+LoyTggL/bDKSTEsDVXK/GIctMMGbB
dRDvDGDY2xQMdM0qUjH9bG4wQqmj+lTdfPGxhuf/DrFMkTmvFCpmxiCvkC5HWZ9k
OnETDymBK2TNdnZQ1+SbG/ND8mQjhIhi43wFY0NwcSsd7j3sLQ+wdlF6orOb7HoR
+F+5sbfqznttU3JVYFFw96uYLC5YpvG71UrVTf+WupSGZjCgsFEg7E1tmtOYGKf7
IUTtm/ta+YdkOHzIStCv5ld1+Wn/ewPUyJ8DJOyDSDC5Ujrig3qY7kp1zkv7wmkv
OmHE+e0uJewkEzhV+7KXSUTRASjpHKscGOeFXDrOdkUV1zLOax3H3gS/ne5L7r2f
EqMmWrE5HtAofQUFSrRH
=ZL9v
-----END PGP SIGNATURE-----

--AQYPrgrEUc/1pSX1--
