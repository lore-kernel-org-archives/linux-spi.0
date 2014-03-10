From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: coldfire-qspi: Prevent NULL pointer dereference
Date: Mon, 10 Mar 2014 17:06:35 +0100
Message-ID: <CAMuHMdVNE8XHJSurVJ-o0E6oD5+5ZxLeA5Pjr8QMMFkBHCV2yw@mail.gmail.com>
References: <1394345470.15686.1.camel@phoenix>
	<201403100904.05819.sfking@fdwdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201403100904.05819.sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Mar 10, 2014 at 5:04 PM, Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org> wrote:
> On Saturday 08 March 2014 10:11:10 pm Axel Lin wrote:
>> If pdata->cs_control is NULL, we will hit NULL pointer dereference in
>> mcfqspi_cs_select() and mcfqspi_cs_deselect(). Thus add NULL test for
>> pdata->cs_control in probe().
>
> D'oh!  My bad.  Actually you're right there would be a NULL pointer
> dereference in cs_select and cs_deselect  (I was looking at the cs_setup and
> cs_teardown in the patch) and so cs_control must not be NULL.  Thats want I
> get for replying before I've had my coffee and when I haven't looked at the
> code in awhile.  So yeah, the patch is GTG.

I had the same first impression. But after looking through the code, the
changes is fine. Furthermore, there's only on in-tree user it, which does
provide cs_control.

There's more opportunity for cleanup, though, as cs_control provides control
of a GPIO, which can be handled by the SPI core, too.

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
