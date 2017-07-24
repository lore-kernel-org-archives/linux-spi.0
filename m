From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: core: use gpio_request_one for configured gpio cs
Date: Mon, 24 Jul 2017 13:02:49 +0100
Message-ID: <20170724120249.mpyv7f3t4q3eihrg@sirena.org.uk>
References: <20170724095327.18602-1-mnhu@prevas.dk>
 <CAHp75VdQbw9rkxq0tvYquacYViZqWKAqOTKHjLPtP=uZi8zzsg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lhplvlcd6roeg4jk"
Cc: Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mnhu-rjjw5hvvQKZaa/9Udqfwiw@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VdQbw9rkxq0tvYquacYViZqWKAqOTKHjLPtP=uZi8zzsg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--lhplvlcd6roeg4jk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 24, 2017 at 01:49:14PM +0300, Andy Shevchenko wrote:

> More and more hacks around plain GPIO integers... :-(

I have to say now I've looked at the patch I'm also struggling to see
how this is a hack around anything...

--lhplvlcd6roeg4jk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll14egACgkQJNaLcl1U
h9Bk1gf/QjnYRNCX0YwZVHwSW0co991l1JPwj1nE2DV8kB+I9K1AxiIyCHHNylxp
ZayLuvVhAK4/gqP24+5NxHa7Mg+cxHK1TDtrQsFGS0JsPcWVurRWdYlBO7ptObFq
dC99DW2He0IZupY+GhfObwwDK6zqcmBkjwHEKs79hKxUf80ErJbBroZ/q+AACJ/0
+echpnQ8ouuJoH1w/NaQ8JIfVUx4wQrzxzb9WQZjo7rE3SGx9Yug/ESRBIPMOayG
mUUAVvfeCAzPcNE2W3MdRFo1KhpWvIydtmwZ7+WRCzBYNb+lGlPyFKYN7IG7+7zM
NBcl7I7+DaPRfqYln7Bzugdyg6HNBQ==
=cn2/
-----END PGP SIGNATURE-----

--lhplvlcd6roeg4jk--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
