From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Applied "spi: sh-msiof: Add compatible strings for r8a774[35]"
 to the spi tree
Date: Tue, 26 Sep 2017 10:30:09 -0700
Message-ID: <20170926173009.xdw6mtvcyixpenr7@sirena.org.uk>
References: <1506329660-4064-2-git-send-email-fabrizio.castro@bp.renesas.com>
 <20170925161637.D7471440058@finisterre.ee.mobilebroadband>
 <CAMuHMdVsRwW+10ERyTJAa8XhhkPMn4ruymUwPKot+kmczBwbcA@mail.gmail.com>
 <20170925184545.5k4nke27rgud3uwp@sirena.org.uk>
 <CAMuHMdUv-5COUuzJOWx=BTb5oJ7tFOi1BpocuJ7+VuCZ3fEuPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="flc5unealuztpgbg"
Cc: Fabrizio Castro <fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Chris Paterson <Chris.Paterson2-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUv-5COUuzJOWx=BTb5oJ7tFOi1BpocuJ7+VuCZ3fEuPg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--flc5unealuztpgbg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 25, 2017 at 09:15:53PM +0200, Geert Uytterhoeven wrote:

> My rebuttal is threefold:
>   1. Listing the fallback property is mandatory for new SoCs. We only keep
>      the per-SoC compatible values in the driver for older SoCs that predate
>      the introduction of fallback properties.

So good practice is always good practice, but I'd argue that it's not
bad practice to also explicitly enumerate all the documented compatibles
in the driver.  Being liberal in what you accept and all that.

>   2. Some harm is involved, in the form of increased kernel image size.

Is this really a meaningful impact?

>   3. When updating DT bindings for new SoCs, we usually add "No driver
>      update is needed" to the patch description to clarify. Unfortunately
>      that was missed here.

That's basically the same good practice thing, it's just documenting
what you're trying to do here with not putting things in code but
writing things in changelogs doesn't make them so!

--flc5unealuztpgbg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnKjp4ACgkQJNaLcl1U
h9CyOQf+KF7TH4e1LUiEusbvfDIIFdd+l5LEKQIJqQP/5OoKznc7+7vQKftJuqqM
Wobnz0aQOhA1AMgXh0YnKyxx8CJIiEFq3DA+W3eLt6BABkRTPTkfSGjP/kYPa31w
Px/pPoPFiNK3ldlhKAa2HkPoYA8MjlhcrX0U+fCa129JDFm8EKEmS6e6ThEnL5bW
E48g6EGj8uImSSYnz+vBRnZ+GxkGuMkz41h+3735uXYUqvj9om6gIGSgSetH2l1y
Mf6YW9h4YPybdui9n1ROLjZH8ELKCtLMhexyyDWZGlgmUOMkMEfSVfpXStb1hwRh
C0eLU6+cRxHyjbStxq+Hacz2c2W/9A==
=2Ur+
-----END PGP SIGNATURE-----

--flc5unealuztpgbg--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
