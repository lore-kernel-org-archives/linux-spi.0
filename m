From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: Not really following Mark Brown's spidev patch
Date: Thu, 27 Aug 2015 13:24:55 +0200
Message-ID: <CAMuHMdW1qTzcqeyt=9Xt9X5xOKySzZfCnZHE1ozhm-=9P_5diw@mail.gmail.com>
References: <CAFZh4h8D=rGwjG7eRGPyC3QP6Cj-4kHe3N7MhMELQNWgv76VhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Brian Hutchinson <b.hutchman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFZh4h8D=rGwjG7eRGPyC3QP6Cj-4kHe3N7MhMELQNWgv76VhQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Brian,

On Tue, Aug 25, 2015 at 11:53 PM, Brian Hutchinson <b.hutchman-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> &mcspi1 {
>     pinctrl-names = "default";
>     pinctrl-0 = <&mcspi1_pins>;
>
>     spidev@0

Missing opening curly brace

>         compatible = "spidev";

The "compatible" value should match the real SPI slave that is connected.
After that, you can may add that value to drivers/spi/spidev.c if no other
driver exists.

>         spi-max-frequency = <100000>;
>         reg = <0>;
>         #address-cells = <1>;
>         #size-cells = <1>;

Why do you need these two properties?

>     };

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
