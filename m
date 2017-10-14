From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND PATCH 1/2] spi: rockchip: Convert to late and early
 system PM callbacks
Date: Sat, 14 Oct 2017 01:59:45 -0700
Message-ID: <20171014085945.grm6gtdzuunogbwf@sirena.org.uk>
References: <20171013104138.3216-1-jeffy.chen@rock-chips.com>
 <20171013183750.piabs7m3dnpabnkm@sirena.co.uk>
 <20171013234511.dxazu5wvvz7sjiiu@dtor-ws>
 <1617641.TtuYKIH8aZ@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ehqhg5udlpogih42"
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        jeffy <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1617641.TtuYKIH8aZ-yvgW3jdyMHm1GS7QM15AGw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ehqhg5udlpogih42
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Oct 14, 2017 at 02:15:34AM +0200, Rafael J. Wysocki wrote:

> The infrastructure in the core is there, the part related to getting that
> information from firmware is (mostly) missing.

Ah, yes - now I remember.  We want this for probe ordering so we don't
really want to be doing it in the subsystems when they request resources
as that's too late (though I guess duplication there won't hurt).  Fun.

--ehqhg5udlpogih42
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnh0gAACgkQJNaLcl1U
h9BlsQf/Thm/IA5trCWcbmsLRVoi8S6oRTc0OdXIhlRH+GajlRZHQkyUe2MpS9cC
7QZPvJ5ERbYFBbS0QUI8I+akbdqR8FYWt+A8PQWbBD1Au4scYlETovTVhWEH8rHu
fWBM/Z54NHJOokyrbqc6EJykJKEmflKfDt8uEcyTnrh1ZecpE6YrgcX0OmqdqwGP
iY+f6icdbXIuNHY1cwqXvkIC9/D4I/44tkZYZKkek9FaI8rpdsRI+Od/tVP9iOS4
tBLQ+6A9lMCJcCIbffDlFQ38sRZqfjbgQgytfB/OyEJq2djrRXr58I8yxy4dirS+
+rAYKX5rsKL6UBWdemTrQQPXeFmVmQ==
=nVqQ
-----END PGP SIGNATURE-----

--ehqhg5udlpogih42--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
