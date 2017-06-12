From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: rockchip: add support for "cs-gpios" dts
 property
Date: Mon, 12 Jun 2017 17:38:14 +0100
Message-ID: <20170612163814.rgbvb54hgxsdj6tf@sirena.org.uk>
References: <1497248057-16550-1-git-send-email-jeffy.chen@rock-chips.com>
 <dfe87919-b2cc-37e8-1598-6b3c730ff356@rock-chips.com>
 <CAMuHMdUDjtSNRiBxcBnAMdUEaCZbioPoRE1h=p9=BqHMGmQaEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v4puphklnlp5dxxt"
Cc: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>,
        Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUDjtSNRiBxcBnAMdUEaCZbioPoRE1h=p9=BqHMGmQaEQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--v4puphklnlp5dxxt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 12, 2017 at 10:18:06AM +0200, Geert Uytterhoeven wrote:
> On Mon, Jun 12, 2017 at 9:15 AM, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
> > On 2017/6/12 14:14, Jeffy Chen wrote:

> >>   +static int rockchip_spi_setup(struct spi_device *spi)
> >> +{
> >> +       int ret = 0;
> >> +       unsigned long flags = (spi->mode & SPI_CS_HIGH) ?
> >> +                             GPIOF_OUT_INIT_LOW : GPIOF_OUT_INIT_HIGH;
> >> +       struct rockchip_spi_data *data = spi_get_ctldata(spi);
> >> +
> >> +       if (!gpio_is_valid(spi->cs_gpio))
> >> +               return 0;

> > return -EINVAL?

> Isn't this check meant to fall back to hardware CS if no cs-gpios property
> is present?

I'd expect it to, otherwise the cs-gpios property is actualy mandatory.

--v4puphklnlp5dxxt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlk+w3UACgkQJNaLcl1U
h9DnCgf+OXg2QggBSu3RqoWjZVm0900QROcD7N8+ji9tg5o2HlW11YKPh7FkgdYf
UmQBFFfXP4PBvAztwodoGXFxL4s6WcUhf5xvGr0F0CXEThlI3ljWUYXyFVOm60BX
pTSUiQgToe4Z5lnMcc17T5cQ54TFNYFsP5b4U+bM4ZfVwCqbGyTSI8itXkh9eAxA
gHNkATAQgRfFtuJvo0jgryOA0cLZj7wqMWqSpk2H6V2LwuOR9bdhL36vRLt6DZP6
vUaCl99sA3IFyk70stYbuFpn9/f1U/TQjLP8UJvHKuR5TQhjERXo83BXC0tmbDKE
/QH6k+n6SzyBi5zLZnkurv0e523LUA==
=Vd63
-----END PGP SIGNATURE-----

--v4puphklnlp5dxxt--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
