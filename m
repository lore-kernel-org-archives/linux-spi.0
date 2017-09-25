From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Applied "spi: sh-msiof: Add compatible strings for r8a774[35]"
 to the spi tree
Date: Mon, 25 Sep 2017 11:45:45 -0700
Message-ID: <20170925184545.5k4nke27rgud3uwp@sirena.org.uk>
References: <1506329660-4064-2-git-send-email-fabrizio.castro@bp.renesas.com>
 <20170925161637.D7471440058@finisterre.ee.mobilebroadband>
 <CAMuHMdVsRwW+10ERyTJAa8XhhkPMn4ruymUwPKot+kmczBwbcA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dsaqr4lnrmkz2tik"
Cc: Fabrizio Castro <fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Chris Paterson <Chris.Paterson2-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdVsRwW+10ERyTJAa8XhhkPMn4ruymUwPKot+kmczBwbcA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--dsaqr4lnrmkz2tik
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 25, 2017 at 07:48:44PM +0200, Geert Uytterhoeven wrote:

> Please drop this patch, as there's no need to add explicit matching for these
> compatible values. The family-specific compatible values (which the driver
> already matches against) are sufficient.

While the patch is not needed if people list the fallback property it
also does no harm and provides a marginal documentation benefit in
saying that someone has considered if any special handling is useful and
decided that it isn't.

--dsaqr4lnrmkz2tik
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnJTtYACgkQJNaLcl1U
h9D+zQf9H+eHZt3G9Ts391WXqEIE0MvIkpN6hFrNq8CMmQoB59GMDb4hXJY1MUyR
omEoy4eeWKixmvZWxcZOpXWaHuDc9pxM9rAgjd8dns2wANydt5pvk9Aw7oFyZnmT
g6zt+ZZ6oHQFHmO34ucHMx7FEYg41Im2hWkAOQupnnDK8TbmmFOxsnC/MXHyU/Su
b30pVzjKxIsYxeOM6xA5noY6LO+VVW1cwZSPb6yxJXnKT4cQiBKYgFVgvrIY3thI
n7lGDp8Mbaa/XrryFjSl/JgND5R0dEjiotYs8Gpfe+1OjVUVIvn5ow3ko3siC69k
j8+W39myoqf519iCvp9oXDII+KYbnA==
=Qu7o
-----END PGP SIGNATURE-----

--dsaqr4lnrmkz2tik--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
