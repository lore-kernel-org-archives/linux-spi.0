From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: dt-bindings: spi-controller: Fix #address-cells for
 slave mode
Date: Thu, 27 Feb 2020 14:19:08 +0100
Message-ID: <CAMuHMdUVW_51dqMK=ziz_JVT3LuXX7vOF3-Ei-aHiiBuSepGpg@mail.gmail.com>
References: <20200227130323.15327-1-geert+renesas@glider.be> <20200227130937.qvrjyxcwim7rfum7@gilmour.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux-renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Maxime Ripard <maxime-R63rPqgGiG5yDzI6CaY1VQ@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200227130937.qvrjyxcwim7rfum7-2DbqMqoCcjvhXIiyNabO3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Maxime,

On Thu, Feb 27, 2020 at 2:09 PM Maxime Ripard <maxime-R63rPqgGiG5yDzI6CaY1VQ@public.gmane.org> wrote:
> On Thu, Feb 27, 2020 at 02:03:23PM +0100, Geert Uytterhoeven wrote:
> > Currently, the DT bindings for an SPI controller specify that
> > "#address-cells" must be fixed to one.  However, that applies to an SPI
> > controller in master mode only.  When running in SPI slave mode,
> > "#address-cells" should be zero.
> >
> > Fix this making the value of "#address-cells" dependent on the presence
> > of "spi-slave".
> >
> > Fixes: 0a1b929356830257 ("spi: Add YAML schemas for the generic SPI options")
> > Reported-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

> > --- a/Documentation/devicetree/bindings/spi/spi-controller.yaml
> > +++ b/Documentation/devicetree/bindings/spi/spi-controller.yaml

> > @@ -52,6 +53,18 @@ properties:
> >      description:
> >        The SPI controller acts as a slave, instead of a master.
> >
> > +if:
> > +  required:
> > +    [ spi-slave ]
>
> Nit: Usually, that notation is when you would do it on the same line,
> if you want to go to a new line, it would make more sense to use -

Sorry, being a poor yaml-by-example programmer, I don't understand what
you mean.  Which part do you refer to by "that notation"?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
