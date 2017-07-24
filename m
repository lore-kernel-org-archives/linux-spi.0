From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: core: use gpio_request_one for configured gpio cs
Date: Mon, 24 Jul 2017 22:28:34 +0100
Message-ID: <20170724212834.yskzvc76tpxixe3u@sirena.org.uk>
References: <20170724095327.18602-1-mnhu@prevas.dk>
 <CAHp75VdQbw9rkxq0tvYquacYViZqWKAqOTKHjLPtP=uZi8zzsg@mail.gmail.com>
 <20170724120148.avqvi53wkdgctsir@sirena.org.uk>
 <e668b7529837444085b9df3a563c3fe3@svr-chch-ex1.atlnz.lc>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xbi7jjbzwy7h3ul2"
Cc: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mnhu-rjjw5hvvQKZaa/9Udqfwiw@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <e668b7529837444085b9df3a563c3fe3-5g7mGxlPNYb6GjIOKuZY+ItlCAj8ZROq@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--xbi7jjbzwy7h3ul2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 24, 2017 at 09:16:17PM +0000, Chris Packham wrote:
> On 25/07/17 00:42, Mark Brown wrote:

> > The best way would be to test the work that Chris Packham submitted in
> > May to do this, it'll need a refresh now and it ought to get some
> > testing on ep93xx but sadly nobody working on ep93xx has responded - I
> > think at this point I'd probably just apply and let people test -next.

> My patchset kind of stalled. I can do a refresh if there's interest. But=
=20
> I really do need some help from people with access to hardware (I can=20
> cover spi-orion and spi-fsl-espi but that's about it). After the initial=
=20

It's definitely something that'd be really helpful.  If we get it merged
near the start of a development cycle that should give plenty of
opportunities for people to test.

> RFC series I posted in May I found that iMX platforms use the integer=20
> cs_gpio field for both native chipselects and gpio based ones (values <=
=20
> 0 indicate native CS) so again I'd be coding blind trying to disentangle=
=20
> that.

i.MX is actively developed (even the SPI driver in particular) so that
should be no problem at least.

--xbi7jjbzwy7h3ul2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll2ZoEACgkQJNaLcl1U
h9AhSgf+KyDK+jYitm/sgBjmBFdlHdUhHyuOo2dZrGJYQ0q35TanxyhGpGYWC6I4
QnZdDwhDZfyoHSAjHCdQ0GYVnKMZiYKo4FPak34Lqtq1judHT6z8cXUMm8cY7DvV
zP79GXjldeznCGIGSwAedhEZzTP+mrnK3OxJxTbGGy8Y5BvIL9vBmzU2PGqfoaeu
VYtpJadYmqwUhvl4e3fQqfwdva1mKq998EiDxI9XWMdVBJEEuO8D5DPnCOW+GWde
8EYN49YnFJUueKNz6ABBR39q7GT9oJM6LJBJgQxoKspGoAOu/b9mdelybgQiIwZh
epv9PDi4YrAm6y3rP2eoacPDwpFt1g==
=grnE
-----END PGP SIGNATURE-----

--xbi7jjbzwy7h3ul2--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
