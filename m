From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv3 2/2] spi: imx: document use of native chip-selects in devicetree
Date: Tue, 18 Jul 2017 21:37:37 -0300
Message-ID: <CAOMZO5A6CZAQUh3mBpH3AdEtcTH-=tdMdqL-SV+4=zcstVQEaQ@mail.gmail.com>
References: <1499746932-14850-1-git-send-email-gerg@linux-m68k.org> <1499746932-14850-3-git-send-email-gerg@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1499746932-14850-3-git-send-email-gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Greg,

On Tue, Jul 11, 2017 at 1:22 AM, Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
> Document the "<0>" notation for specifying use of a native chip-select
> in the "cs-gpios" tag of an SPI device in devicetree. This isn't unique
> to the spi-imx driver, but this clearly spells out that you can use it
> with this driver.
>
> Signed-off-by: Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>

Whic SoC did you use to test the native chip-select?

I remember that some old SoCs (mx27/mx31) used to have issues with
native chip-select.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
