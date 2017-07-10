From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: pxa2xx: Only claim CS GPIOs when the slave device
 is created
Date: Mon, 10 Jul 2017 13:09:14 +0100
Message-ID: <20170710120913.g35ftcbs7pngrtsm@sirena.org.uk>
References: <90b3e14d-0077-9a25-9d90-ab340577af57@web.de>
 <CAHp75Vd8GRCwGp8eDFOL=dsgxCR+VqqUy+O50PEW=p99a8xAwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a74ndxxrjsckcg5o"
Cc: Jan Kiszka <jan.kiszka-S0/GAf8tV78@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vd8GRCwGp8eDFOL=dsgxCR+VqqUy+O50PEW=p99a8xAwQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--a74ndxxrjsckcg5o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 09, 2017 at 12:48:10AM +0300, Andy Shevchenko wrote:
> On Sat, Jul 8, 2017 at 11:41 AM, Jan Kiszka <jan.kiszka-S0/GAf8tV78@public.gmane.org> wrote:

> > Tested on the IOT2000 where the second SPI bus is connected to an
> > Arduino-compatible connector and multiplexed between SPI, GPIO and PWM
> > usage.

> Can we first switch the driver to use GPIO descriptors instead of
> plain integers?

Only if you also convert the SPI core to use descriptors, Chris Packham
was looking at that but he needed update the ep93xx drivers among others
and getting reviewers was hard.

--a74ndxxrjsckcg5o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlljbmkACgkQJNaLcl1U
h9BF2gf+JZFADwVsCE0rl5duVwxXeGuJJaUDoCWpfDInMYFuO+F82OVlmMxVwdv8
ILsn9JDk40KJn3J2EC0f7FTU1OGHPC6f4Bl8qsjXythd5s6omUt0EwNTbmrHHz6y
D/NORxiaMXdgfMS7QckSvXUaAnA2aUT2eJF0SAEiwLsbEV9CDEkBIzmgkjfzzdM4
YI+NxzpTcZnb9m78gI4NDgQ90fievHE232arFDJxtzTUgtbR78mrzUeKxkvIHyZx
4rJA5eocDI+9aPC/rYDjD2AmXXlj2vVu5M/5HmWDA60c46ZAfq8lfe57TP614UNJ
bOrDfiWwfhEgnQeQDWw4z+x2Uc4n/Q==
=6+si
-----END PGP SIGNATURE-----

--a74ndxxrjsckcg5o--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
