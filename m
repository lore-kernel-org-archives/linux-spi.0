From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: mcspi
Date: Thu, 10 Apr 2014 19:58:55 +0200
Message-ID: <CAMuHMdW-jazHP8Z1jfYACNme9f+swq+sEWsAUx9e5dBWaOW7=A@mail.gmail.com>
References: <CAL22ZL+5jWkbnt69HeULeEtEqOSL5dEbs4DcCw79wN9dFP+kYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: maxim maxim <look2004il-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL22ZL+5jWkbnt69HeULeEtEqOSL5dEbs4DcCw79wN9dFP+kYA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Apr 9, 2014 at 6:40 PM, maxim maxim <look2004il-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> When I'm using with spi_sync(), while the master writes to MOSI, at
> the same time reads from MISO, doesn't it?

Yes it does.

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
