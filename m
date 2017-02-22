From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi/bcm63xx-hsspi: allow providing clock rate
 through a second clock
Date: Wed, 22 Feb 2017 10:26:02 -0800
Message-ID: <20170222182602.p4wlcjfkxx6ulj4x@sirena.org.uk>
References: <20170222131940.31085-1-jonas.gorski@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3xwia6sgjr3aza2x"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
To: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170222131940.31085-1-jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--3xwia6sgjr3aza2x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 22, 2017 at 02:19:38PM +0100, Jonas Gorski wrote:
> Instead of requiring the hsspi clock to have a rate, allow using a second
> clock for providing the Hz rate, which is probably more correct anyway.

I'm sorry but I just can't follow the logic here at all - why would we
use "a second clock" to get the rate of a clock and why would that be
more correct?  There's a few steps in the reasoning missing here I
think!

--3xwia6sgjr3aza2x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlit17kACgkQJNaLcl1U
h9AYtAf+KZqRZkawjaCxCt27lznchtEv8uL9KMWAbRG4mVYD1aKz4lBmqg7X0GKw
FqZEWpMh+4vlLC5vs2ih+HIz/Ucc3QM9T1Ry5tO8Gk/vz/a46NuodIx+NndeNkW1
X/PAl7zoFhBbsvjuUM2VD7TH22wDKBT00VxCEcO6/bGt0jVep6akvPaUcMJr6Gq2
w4T2j2Qh1G5vwVGOhXw1GdLc8DaY9mYd34Bef6NXen4/o1EaEC0qUmwgFwYoggg0
cXTiID7+yd/DwywK0I1et5PWR4dzypZFpdz2/pX4GlDdACc8QBAVYtlEA79a2RoL
E7Ew1JCLSRa+OxzaCRBoMrPXv8gJSQ==
=Qsq8
-----END PGP SIGNATURE-----

--3xwia6sgjr3aza2x--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
