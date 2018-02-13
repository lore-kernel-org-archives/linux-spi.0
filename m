From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: spi-gpio: Rewrite to use GPIO descriptors
Date: Tue, 13 Feb 2018 16:17:11 +0000
Message-ID: <20180213161711.GG5988@sirena.org.uk>
References: <20180212124532.25776-1-linus.walleij@linaro.org>
 <20180212124532.25776-2-linus.walleij@linaro.org>
 <CAHp75VeOf6Zywgn9LWWX1kOwsqw28dhZ5EE+N-0KFX_0m-JxOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vSsTm1kUtxIHoa7M"
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
        Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>,
        Harald Welte <laforge-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>,
        Manuel Lauss <manuel.lauss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Paul Cercueil <paul-icTtO2rgO2OTuSrc4Mpeew@public.gmane.org>,
        Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VeOf6Zywgn9LWWX1kOwsqw28dhZ5EE+N-0KFX_0m-JxOw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--vSsTm1kUtxIHoa7M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 13, 2018 at 04:17:38PM +0200, Andy Shevchenko wrote:
> On Mon, Feb 12, 2018 at 2:45 PM, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

> > +               { },

> As commented earlier to the similar change, terminator would terminate
> even at compile time.
> To achieve that just remove comma.

It's fine either way - not having the comma bothers some people just for
the consistency.

> > +               /* SPI chip selects are normally active-low */
> > +               gpiod_set_value_cansleep(cs, (spi->mode & SPI_CS_HIGH) ? is_active : !is_active);

>   bool invert = !(spi->mode & SPI_CS_HIGH);

>   gpiod_set_value_cansleep(cs, !!is_active ^ invert);

Neither of these options is a triumph of legibility but even with my
antipithy for the use of the ternery operator the new suggestion is
still not great - the combination of double negation and exclusive or
is really not super obvious what it's supposed to do.

> But I guess most used pattern is just explicit conditional

> if (spi->mode & SPI_CS_HIGH)
>         gpiod_set_value_cansleep(cs, is_active);
> else
>         gpiod_set_value_cansleep(cs, !is_active);

Yup, that's very clear.

--vSsTm1kUtxIHoa7M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqDD4YACgkQJNaLcl1U
h9BsTQf/ScVSQmsgRQ39syVN+1pfKm8LjVXzENz+/ts2bLOpP7Os92rMmI3UrrUv
sJfgDouOZUqNh7hnlZSQ60ftzX30qM1IOGM+rctReUwxa2H7SOAWMTrjxAFSeibD
ymbZ+o7bGHFkv3zAHPCO54rIouI6Z7iOdeFK85ORl69zLtIN5VCr6WdUoA0BWomm
fRtHha/7P66OMo/I0oepIvWkLvo4W+aHSsD0Qd1qde2k2HEfqogj5sbaSiE2DhOX
6n/AP+qAxAh74I/PISFvwoh2US7MFzWIMBERBAp/UVQSz9GSVs/K1eZTnP/KHqU0
RQCJYP1DFtyeRAmZxPwyZYZ03qPLXA==
=Sz4h
-----END PGP SIGNATURE-----

--vSsTm1kUtxIHoa7M--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
