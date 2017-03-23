From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: bcm2835: Allow platform to set realtime priority
Date: Thu, 23 Mar 2017 11:07:18 +0000
Message-ID: <20170323110718.sncw32gspvls75u7@sirena.org.uk>
References: <c1ca8a5522272d06f5c3fb67d8442f148b2d6cfb.1490264661.git.lukas@wunner.de>
 <1503363fcfb92adfa765d1c1c3e69fc673e72dde.1490264661.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hpz52vvcmroon77w"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Chris Blair <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
        Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Mathias Duckeck <m.duckeck-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>,
        linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
        Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1503363fcfb92adfa765d1c1c3e69fc673e72dde.1490264661.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--hpz52vvcmroon77w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 23, 2017 at 11:36:45AM +0100, Lukas Wunner wrote:

> +Optional properties:
> +- bcm2835,rt_prio: Realtime priority of the message pump to minimize latency
> +                   on the bus (0..99).
> +

This is going to depend on the software running on the board, I'd expect
it to be something configured at runtime rather than fixed in DT.

--hpz52vvcmroon77w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAljTrGUACgkQJNaLcl1U
h9BnwQf/Xy5JFaeMamWe7Nx0meATzxWLWHyz0lf1p9KW3G8lQRWbFrYpI8aJyIh3
sD0JbfVQ81JoZ/uD5dhi5LKjyXl7QO0AGbMj2REH2FjH/hp0Kd3OZPR2nz3lyZUK
xIAQg2DOk3IrNs7zgkB5+FlPI+NNezzIy/5jh2DAfWcinTW4kmGWpg+XOA9Ymo9d
rvldD5sIiRJDROvvRhzYAHDBhccT1oAfVQQ7taqke625X3vl0ORdcSys6dctmJ+x
Ux2tLu4xaqy/HWif06Dw1KhGicYN2R2Vc9/17DMzhnGZRuAnuj9Jdu6yWG5aHVh/
QS/SmAp5BFdGp/dkdEldopgTc3ZZiw==
=WFOX
-----END PGP SIGNATURE-----

--hpz52vvcmroon77w--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
