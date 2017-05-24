From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC 0/5] *** SPI Slave mode support ***
Date: Wed, 24 May 2017 18:29:40 +0100
Message-ID: <20170524172940.6vypisacs3rmmjws@sirena.org.uk>
References: <1492085644-4195-1-git-send-email-jiada_wang@mentor.com>
 <20170413125929.dygodgj6c35ydh5p@sirena.org.uk>
 <CAMuHMdUm=90ddNWM5KWqT+W0hqZ-QO6vPHj5OisbYquDYq1ZmA@mail.gmail.com>
 <58F06092.9080409@mentor.com>
 <CAMuHMdXa_O6RsqUciiNWQ0Zp6dniS47AUmPN9UWAWitP0csx=Q@mail.gmail.com>
 <20170425103113.lxpwoq6sbxvg3ihl@sirena.org.uk>
 <59019306.2050309@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mgdh43wcnsoiuwtw"
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <59019306.2050309-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--mgdh43wcnsoiuwtw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 26, 2017 at 11:43:18PM -0700, Jiada Wang wrote:

> The reason I gave the example use case is want to point out that
> with Geert's patch set, a SPI device (with only one controller) can no
> longer
> act as master and slave at the same time. because IMO as a SPI core
> function,
> it needs to cover all the use cases, and to be as generic as possible.

> BUT if you think the use case don't need to be supported from SPI core,
> then I don't have objection either, I will only submit imx SPI slave support
> patch,
> after your SPI slave support patch set been applied

I think there's a bunch of other problems with how that works reliably
that'd need to be addressed before someone could actually do that, and
it seems like such hardware will be very unusual.

--mgdh43wcnsoiuwtw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlklwwMACgkQJNaLcl1U
h9CqZwf/V8h7gKz4OzsrRdGWD6M7HOKcrIsaVsVSBlqfRzWuQjwZygr8EGIOfwKP
TgURwqNMVfgRP1zWFjvTJcWrBdrO2rE9bZ5igFzSQ7Y+9IHmQ/S9XmND8Sbmp8yu
iXnBMs1Qza18ZH84t1X72me8rwyho6TdWOiJfcR5VFrWRuT5lb6U0lQmkmgEd4CG
g1n6g20jXlx1AOYhZTEmceD6KHqt5ZYTQ6TaCxw08+wk85gSI4IsPbWZu8CykFtJ
JDc0S623T4eeYWA15xb6edCaKLNB3Tew0vJMrmG+97ysD0KmKPej/uF1r5Kl9Y5E
fT8aGR537I9llX/GQT+i76duNG9tkQ==
=7JNs
-----END PGP SIGNATURE-----

--mgdh43wcnsoiuwtw--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
