From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/4] pinctrl: mcp23s08: spi: Fix duplicate pinctrl debugfs entries
Date: Wed, 7 Feb 2018 14:49:43 +0100
Message-ID: <CACRpkdaBO8z5Xgh2gn1Dt8pX=vw1kdeyU3m-x-1L7-D9EbxP5w@mail.gmail.com>
References: <cover.1516997103.git.jan.kundrat@cesnet.cz> <e3a251cf48ad518ce4205cfdf2e866e6b3bb76f8.1516997103.git.jan.kundrat@cesnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>,
        Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
To: =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e3a251cf48ad518ce4205cfdf2e866e6b3bb76f8.1516997103.git.jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Jan 26, 2018 at 4:06 PM, Jan Kundr=C3=A1t <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org> w=
rote:

> This is a bit more involved because the pinctrl core so far always
> assumed that one device (with a unique dev_name) only contains a single
> pinctrl thing. This is not true for the mcp23s08 driver for chips
> connected over SPI. They have a "logical address" which means that
> several chips can share one physical CS signal.
>
> A downside of this patch are some possibly ugly names for the debugfs
> entries, such as "spi1.1-mcp23xxx-pinctrl.2", etc.
>
> Signed-off-by: Jan Kundr=C3=A1t <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>

Patch applied with some fuzzing.

I don't know any better approach, it is definately
better than what we have today. If people think it is
too ugly they can patch it.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
