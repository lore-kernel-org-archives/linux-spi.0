From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v2] spi: orion: support armada extended baud rates
Date: Thu, 4 Sep 2014 15:17:27 +0200
Message-ID: <CAMuHMdWDOaPnmCzThqCo2848eDj6jmi-eaXM1YAXQLi41da34A@mail.gmail.com>
References: <1409835268-29555-1-git-send-email-gerg@uclinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1409835268-29555-1-git-send-email-gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Greg,

On Thu, Sep 4, 2014 at 2:54 PM,  <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org> wrote:
> The Armada SoC family implementation of this SPI hardware module has
> extended the configuration register to allow for a wider range of SPI
> clock rates. Specifically the Serial Baud Rate Pre-selection bits in the
> SPI Interface Configuration Register now also use bits 6 and 7 as well.
>
> Modify the baud rate calculation to handle these differences for the
> Armada case. Potentially a baud rate can be setup using a number of
> different pre-scalar and scalar combinations. This code tries all
> possible pre-scalar divisors (8 in total) to try and find the most
> accuate set.

Are the Orion rates and register bits a subset of the Armada ones?
I.e. does the Armada work with the Orion setup?

> This change introduces a new device tree compatible device name
> "armada-spi". This is used in place of "orion-spi" on the Armada SoC
> parts.

> -                               compatible = "marvell,orion-spi";
> +                               compatible = "marvell,armada-spi";

If the answer to my above question is yes, you want to keep
"marvell,orion-spi" as a fallback.

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
