From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] pinctrl: mcp23s08: spi: Fix regmap debugfs entries
Date: Wed, 7 Feb 2018 14:43:02 +0100
Message-ID: <CACRpkdaj2+2bfPX2R-fx8V-VAD2M=+nT+AW9PBM00da9rKOQ5g@mail.gmail.com>
References: <cover.1516997103.git.jan.kundrat@cesnet.cz> <de8fbb7902652b5a512f67e2ee0813571e9d2372.1516997103.git.jan.kundrat@cesnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Cc: linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>,
        Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
To: =?UTF-8?B?SmFuIEt1bmRyw6F0?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <de8fbb7902652b5a512f67e2ee0813571e9d2372.1516997103.git.jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Jan 25, 2018 at 6:29 PM, Jan Kundr=C3=A1t <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org> w=
rote:

> The SPI version of this chip allows several devices to be present on the
> same SPI bus via a local address. If this is in action and if the kernel
> has debugfs, however, the code attempts to create duplicate entries for
> the regmap's debugfs:
>
>   mcp23s08 spi1.1: Failed to create debugfs directory
>
> This patch simply assigns a local name matching the device logical
> address to the `struct regmap_config`.
>
> No changes are needed for MCP23S18 because that device does not support
> any logical addressing. Similarly, I2C devices do not need any action,
> either, because they are already different in their I2C address.
>
> A similar problem is present for the pinctrl debugfs instance, but that
> one is not addressed by this patch.
>
> Signed-off-by: Jan Kundr=C3=A1t <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>

This looks good and straight-forward.

Patch applied for v4.17.

Hope it doesn't clash with Phil et al's parallel developments.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
