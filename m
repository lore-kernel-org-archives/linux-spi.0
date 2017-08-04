From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 1/2] spi: pxa2xx: Convert to GPIO descriptor API
 where possible
Date: Fri, 4 Aug 2017 12:43:26 +0100
Message-ID: <20170804114326.isnsz6zgstpvuftt@sirena.org.uk>
References: <cover.1501760433.git.jan.kiszka@siemens.com>
 <6bfd2b29b888c14f1a6feb9dee5bb54b74e761b0.1501760433.git.jan.kiszka@siemens.com>
 <20170804101029.GV2369@lahna.fi.intel.com>
 <b411858d-6a09-a3bc-555d-b1e648b9c8ed@siemens.com>
 <20170804102408.GX2369@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r3gpvvbww2kcdgwy"
Cc: Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>,
        Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170804102408.GX2369-3PARRvDOhMZrdx17CPfAsdBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--r3gpvvbww2kcdgwy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 04, 2017 at 01:24:08PM +0300, Mika Westerberg wrote:
> On Fri, Aug 04, 2017 at 12:18:28PM +0200, Jan Kiszka wrote:

> > It shouldn't cause problems (famous last words) because I refrained from
> > changing the interfaces to them. References that come in as legacy GPIO
> > are still treated like that.

> OK. I hope someone with a PXA2xx machine could still test it.

> Acked-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

This path should be very well covered - there's plenty of things that
convert GPIO numbers into descriptors out there.

--r3gpvvbww2kcdgwy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmEXd0ACgkQJNaLcl1U
h9AN2wf7BsZCy0ERKGHuId+DpCsDL7PLtB6zGvPM6h9ITxUS8nSahEdZTFFW0kFD
5ZfiF529WKPyvhr9LqchfZh+A4p37jRCG1DJGtAaEqQBy4rKAWo2x/zsLkFfj0Q5
CWVrIyopaKk93eEebuSSfGggfjAcqxm4NMBfY0n7NVDmGOixNagFvOK4ET9o1ceh
cfxcr3yCmMzbzKl/UG8qxyAg6xhOOTIWd/tp3t0HaTha5XKA/EBv0VYUw3yJsx7q
cy8E2VHufDAkK9H63eDNudaz3yX449ld5EY3/qB5uyD65LmQa3dDoxcyxYzLrC9y
WBirpA2WZotm6bCuFrBQ6yLfOGLM1A==
=2Kht
-----END PGP SIGNATURE-----

--r3gpvvbww2kcdgwy--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
