From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 0/6] spi: sh-msiof: Add support for R-Car H2 and M2
Date: Wed, 26 Feb 2014 17:13:18 +0900
Message-ID: <CANqRtoSBrLA_LsL1HiYbHqADPmiyLhAr_MszMuae-8zMTQn=bw@mail.gmail.com>
References: <1393323673-2751-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Takashi Yoshii <takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1393323673-2751-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Feb 25, 2014 at 7:21 PM, Geert Uytterhoeven
<geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
>         Hi Mark,
>
> This patch series refactors the sh-msiof SPI driver and adds support for
> the MSIOF variant in the Renesas R-Car H2 (r8a7790) and M2 (r8a7791) SoCs.
>
> It was tested on the Lager and Koelsch development boards, using a dummy
> driver for the Renesas r2a11302ft PMIC that reads out the PMIC's version ID.
>
>     [1/6] spi: sh-msiof: Improve bindings
>     [2/6] spi: sh-msiof: Move default FIFO sizes to device ID data
>     [3/6] spi: sh-msiof: Add support for R-Car H2 and M2
>     [4/6] spi: sh-msiof: Move clock management to (un)prepare_message()
>     [5/6] spi: sh-msiof: Convert to let spi core validate xfer->bits_per_word
>     [6/6] spi: sh-msiof: Use core message handling instead of spi-bitbang
>
> These are (reworked versions of) the remaining patches not taken from v1.
> Changelogs are available in the individual patches.
>
> Some of this work was based on a patch series by Takashi Yoshii
> <takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>.

Hi Geert,

Thanks for this updated version. I like the way you reworked the DT
bindings to let the FIFO configuration stay in the driver. Also
getting rid of the now-not-needed bitbang dependency is a great thing.
All these patches look good to me.

Acked-by: Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>

Cheers,

/ magnus
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
