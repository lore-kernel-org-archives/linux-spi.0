From: Oleksij Rempel <ore-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCHv3 1/2] spi: imx: fix use of native chip-selects with
 devicetree
Date: Thu, 20 Jul 2017 08:34:50 +0200
Message-ID: <20170720063449.qvi3s7faapcncoqm@pengutronix.de>
References: <1499746932-14850-1-git-send-email-gerg@linux-m68k.org>
 <1499746932-14850-2-git-send-email-gerg@linux-m68k.org>
 <CAOMZO5Dq8mAULR+L6HJUMc6f=-d9QPZmn92+jzwKLuGYDA_AaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5Dq8mAULR+L6HJUMc6f=-d9QPZmn92+jzwKLuGYDA_AaA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Greg,

On Tue, Jul 18, 2017 at 09:53:58PM -0300, Fabio Estevam wrote:
> Adding Pengutronix folks on Cc.
> 
> On Tue, Jul 11, 2017 at 1:22 AM, Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> > The commonly used mechanism of specifying the hardware or native
> > chip-select on an SPI device in devicetree (that is "cs-gpios = <0>")
> > does not result in the native chip-select being configured for use.
> > So external SPI devices that require use of the native chip-select
> > will not work.
> >
> > You can successfully specify native chip-selects if using a platform
> > setup by specifying the cs-gpio as negative offset by 32. And that
> > works correctly. You cannot use the same method in devicetree.
> >
> > The logic in the spi-imx.c driver during probe uses core spi function
> > of_spi_register_master() in spi.c to parse the "cs-gpios" devicetree tag.
> > For valid GPIO values that will be recorded for use, all other entries in
> > the cs_gpios list will be set to -ENOENT. So entries like "<0>" will be
> > set to -ENOENT in the cs_gpios list.
> >
> > When the SPI device registers are setup the code will use the GPIO
> > listed in the cs_gpios list for the desired chip-select. If the cs_gpio
> > is less then 0 then it is intended to be for a native chip-select, and
> > its cs_gpio value is added to 32 to get the chipselect number to use.
> > Problem is that with devicetree this can only ever be -ENOENT (which
> > is -2), and that alone results in an invalid chip-select number. But also
> > doesn't allow selection of the native chip-select at all.
> >
> > To fix, if the cs_gpio specified for this spi device is not a
> > valid GPIO then use the "chip_select" (that is the native chip-select
> > number) for hardware setup.
> >
> > Signed-off-by: Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
> > ---
> >  drivers/spi/spi-imx.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> > index b402530..f4fe66c 100644
> > --- a/drivers/spi/spi-imx.c
> > +++ b/drivers/spi/spi-imx.c
> > @@ -524,8 +524,8 @@ static int mx31_config(struct spi_device *spi, struct spi_imx_config *config)
> >                 reg |= MX31_CSPICTRL_POL;
> >         if (spi->mode & SPI_CS_HIGH)
> >                 reg |= MX31_CSPICTRL_SSPOL;
> > -       if (spi->cs_gpio < 0)
> > -               reg |= (spi->cs_gpio + 32) <<
> > +       if (!gpio_is_valid(spi->cs_gpio))
> > +               reg |= (spi->chip_select) <<
> >                         (is_imx35_cspi(spi_imx) ? MX35_CSPICTRL_CS_SHIFT :
> >                                                   MX31_CSPICTRL_CS_SHIFT);
> >
> > @@ -616,8 +616,8 @@ static int mx21_config(struct spi_device *spi, struct spi_imx_config *config)
> >                 reg |= MX21_CSPICTRL_POL;
> >         if (spi->mode & SPI_CS_HIGH)
> >                 reg |= MX21_CSPICTRL_SSPOL;
> > -       if (spi->cs_gpio < 0)
> > -               reg |= (spi->cs_gpio + 32) << MX21_CSPICTRL_CS_SHIFT;
> > +       if (!gpio_is_valid(spi->cs_gpio))
> > +               reg |= spi->chip_select << MX21_CSPICTRL_CS_SHIFT;
> >
> >         writel(reg, spi_imx->base + MXC_CSPICTRL);
> >

hm... do I see this correctly, all native chip_selects should
be registered before gpio based CS?

For example like this?
cs-gpios = <0>, <&gpio1 1 0>, <&gpio1 2 0>;

Looks like we don't have any sanity checks for this kind of
configuration:
cs-gpios = <&gpio1 1 0>, <&gpio1 2 0>, <0>;

We may shift some wired numbers here:
reg |= spi->chip_select << MX21_CSPICTRL_CS_SHIFT;

this should be reflected in the documentation too:
Documentation/devicetree/bindings/spi/spi-bus.txt

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
