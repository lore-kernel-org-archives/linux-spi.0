From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/4] pinctrl: mcp23s08: IRQ behavior for open-drain interrupts
Date: Wed, 7 Feb 2018 14:45:45 +0100
Message-ID: <CACRpkdYPhkOtfMEZeoSu-Zk8AhzghNUx=ooQk21V6f_f9WtLZQ@mail.gmail.com>
References: <cover.1516997103.git.jan.kundrat@cesnet.cz> <9e78a4a697c8d4d3028ea8780bd925471b49af3c.1516997103.git.jan.kundrat@cesnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>,
        Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
To: =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9e78a4a697c8d4d3028ea8780bd925471b49af3c.1516997103.git.jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Jan 25, 2018 at 4:08 PM, Jan Kundr=C3=A1t <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org> w=
rote:

> The hardware supports three different IRQ modes:
> - open drain, i.e., an active-low output which requires an external
>   pull-up and supports IRQ line sharing,
> - active low, with push-pull output,
> - active high, with push-pull output.
>
> My understanding of electronics is limited, but it is "wrong" to connect
> different push-pull outpus together. It could sort-of work if the
> chips/board actually have some resistors there, but it's an ugly thing
> to do.
>
> In the past, this driver did not touch the ODR bit (for open-drain)
> operation. During power-on-reset, it is set to zero. Unless some
> platform code actually set this bit to one, this means that the code
> never supported open drain operation.
>
> This change makes this handling explicit. If you want sharing of the IRQ
> line, then use the microchip,irq-open-drain mode and add an external
> pull-up.
>
> There's some risk here. If, e.g., the bootloader sets the ODR bit for
> some reason, the HW shares the IRQ lines, and nobody changes the DT,
> then your HW will suddenly use push-pull driver for the IRQ line. If
> there is any other chip on the same lane, the HW might suffer (my chip
> survived this when I "tested" this by accident with no bootloader code
> to set the ODR bit).
>
> Signed-off-by: Jan Kundr=C3=A1t <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>

I'm holding this patch back pending the discussion with Phil
and any alternative approach from him.

Just resend it if nothing happens for a while.

I still try to apply the other patches for now (2-4).

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
