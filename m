From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND PATCH 1/2] spi: rockchip: Convert to late and early
 system PM callbacks
Date: Fri, 13 Oct 2017 17:42:35 +0100
Message-ID: <20171013164235.thgqha7sl5tdptwv@sirena.co.uk>
References: <20171013104138.3216-1-jeffy.chen@rock-chips.com>
 <20171013104138.3216-2-jeffy.chen@rock-chips.com>
 <CAD=FV=X6pkaY3t=ceh3QEUws+_gqRGMN9zveW0fXR1noF1T6ew@mail.gmail.com>
 <20171013155120.GA137489@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qedpaalsvul4jrza"
Cc: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171013155120.GA137489-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--qedpaalsvul4jrza
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 13, 2017 at 08:51:21AM -0700, Brian Norris wrote:

> Yes, this does seem odd to me too. This looks like an arms race hack
> that should be avoided unless we know a legit root cause. Also,
> "probe order implies suspend order" doesn't quite work for async suspend
> anyway, so we'd probably want to express the dependency properly
> anyway.

Yeah, it's the same stuff as we get with initcall ordering.  This sort
of thing does happen with things like PMICs which tend to have hardware
that the system wants to manipulate in the IRQs off part of suspend.
Ideally the dependency annotation stuff would figure things out though
I'm not sure what the status of that is.

> Any chance this is related? Seems like that might break the parent/child
> relationship for master/slave:

> commit d7e2ee257038baeb03baef602500368a51ee9eef
> Author: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Date:   Mon Apr 11 13:51:03 2016 +0200

>     spi: let SPI masters ignore their children for PM

That's for runtime PM, I'd not expect it to affect system suspend.

--qedpaalsvul4jrza
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlng7PoACgkQJNaLcl1U
h9Dq1Qf/WlAli0ps/z9plnp+po4947v6VjWtAjMpTToL2RHmfR75ptL+g36BjfLQ
I/FK2ykCIAcRfiz2AIshjFQMDt6niTenWU1ykzlGl9h4fa0AUJD8qYKRnoesr6C0
kJHfpcBXcg1J8iD6kr4GhJRJhg547x+DMYrF0mBG1GFp5UAPHuH6D8ruIDwz27Ve
PmGNuven0Zoxf0GJFooJ+MIWaKd5QdEOukz+ivTZA/5RBNR1U2Rd840C+OfcrNhp
nUe31/k0XbgOEOXxWYP0LbaqcA3RyKkUgX8XGZju3uM0u6OY37i6JNLdzj0oZSgC
FbdE3L5e5ur25pySjmutVi+3YC2ccg==
=EVbi
-----END PGP SIGNATURE-----

--qedpaalsvul4jrza--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
