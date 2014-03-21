From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: nuc900: Fix setting multiple bits settings in register
Date: Fri, 21 Mar 2014 09:13:00 +0100
Message-ID: <CAMuHMdVYHnv2PGaerL50PhK_a1E=LaEwdkhHNgyaqX=WO-FOXA@mail.gmail.com>
References: <1395379454.30136.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Wan ZongShun <mcuos.com-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1395379454.30136.2.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Axel,

On Fri, Mar 21, 2014 at 6:24 AM, Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org> wrote:
> -       val = __raw_readl(hw->regs + USI_CNT);
> +       val = __raw_readl(hw->regs + USI_CNT) & ~TXNUM;
>
> -       if (!txnum)
> -               val &= ~TXNUM;
> -       else
> +       if (txnum)
>                 val |= txnum << 0x08;

I think it's easier to read if you keep the masking and setting together,
and remove the conditional, e.g.

        val = __raw_readl(hw->regs + USI_CNT);
        val = (val & ~TXNUM) | (txnum << 0x08);
        __raw_writel(val, hw->regs + USI_CNT);

Just my personal thoughts, too.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
