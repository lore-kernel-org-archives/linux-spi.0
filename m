From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 0/9] Renesas RSPI/QSPI DT support
Date: Sun, 12 Jan 2014 13:55:19 +0100
Message-ID: <CAMuHMdWmFa-XsderYDp4jMw6r7fnwpm5XgQGfz8gEbCryXEkHg@mail.gmail.com>
References: <1389525222-3482-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389525222-3482-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sun, Jan 12, 2014 at 12:13 PM, Geert Uytterhoeven
<geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
>     [5/9] ARM: shmobile: r7s72100: Add RSPI clocks for DT
>     [6/9][V3] ARM: shmobile: r7s72100 dtsi: Add RSPI nodes
>     [7/9][V3] ARM: shmobile: genmai reference: Add RSPI nodes
>     [8/9] ARM: shmobile: r8a7791 dtsi: Add QSPI node
>     [9/9] ARM: shmobile: koelsch: Add QSPI nodes

Forgot to mention:

The ARM/shmobile part is based on renesas-devel-v3.13-rc7-20140109v2, with
Magnus' pinctrl, Wolfram's riic, Simon's sh_eth, Valentine's i2c pinctrl
and Laurent's SCIF DT work applied on top.
[Simon: I don't know in which order you will merge these. If you want me
 to rebase my patches, just ask! Thanks!]

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
