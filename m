From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2 v2] SPI: spi-pxa2xx: SPI support for Intel Quark X1000
Date: Tue, 25 Nov 2014 21:02:22 +0000
Message-ID: <20141125210222.GO7712@sirena.org.uk>
References: <1412000548-9908-1-git-send-email-alvin.chen@intel.com>
 <1412000548-9908-3-git-send-email-alvin.chen@intel.com>
 <CAOesGMi5f_Kc1xA_JqiZYsbVYxaJgBXMZCe5TAxDkPQj7=o8sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jQ+AERLI8tlfAZXA"
Cc: Weike Chen <alvin.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mika Westerberg <mika.westerberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Hock Leong Kweh <hock.leong.kweh-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Boon Leong Ong <boon.leong.ong-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Raymond Tan <raymond.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOesGMi5f_Kc1xA_JqiZYsbVYxaJgBXMZCe5TAxDkPQj7=o8sg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--jQ+AERLI8tlfAZXA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 25, 2014 at 12:06:41PM -0800, Olof Johansson wrote:
> On Mon, Sep 29, 2014 at 7:22 AM, Weike Chen <alvin.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:

> > This piece of work is derived from Dan O'Donovan's initial work for Intel Quark
> > X1000 SPI enabling.

> How about build testing for other platforms that share this driver
> when you make changes to it? This is obviously completely broken.

> Doing these constants under ifdef seems fragile at best, braindead at
> worst. Please don't proliferate that coding style.

> Mark, can you revert until Intel learns how to play well with others?

Yeah.

> This is from a pxa3xx-defconfig build:

Ugh, why does this driver not have a COMPILE_TEST dependency?  Not that
it'd have caught this one.

--jQ+AERLI8tlfAZXA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdO5eAAoJECTWi3JdVIfQuO0H/iD7FfmC6mQk9p74nBoLFNW5
xjYCDkdQ6JKQQjj9CaKBbAaysU6co5fJGgutMgPKj4IKqWNE1RuvEYSsaPnq3D+M
JnDzXBF+x29hoc/xHcrURjxJK6zRvZdSb31gypq4ovoeE/ojaYVdpZxDRSegozSZ
x8yIdfi0v7ra7v0c2UODyWvXPbhsQ+L6zqpZtPKkbG1+8WXDYsNh9YGXX3gpCscj
5r4mR+tOt+VRAPa7iLSSuI4v2x8rDzUM+h3OX8OeX/FsRkHe/9xdQN8aDIrgyr9e
BHSIwWEkMaFhsKfWn3j/0QwywqiVE7ZJPZzSLVFGAzO6qQHHu7TL1znkPzIzNqs=
=BpI+
-----END PGP SIGNATURE-----

--jQ+AERLI8tlfAZXA--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
