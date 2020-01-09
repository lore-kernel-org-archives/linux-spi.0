From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v2] spi: sh-msiof: Do not redefine STR while compile testing
Date: Thu, 9 Jan 2020 13:42:48 +0100
Message-ID: <CAMuHMdWM97k7iG_Er=VCLF0EPo6R1sK7+ZsSwjQB0b4WO88U6A@mail.gmail.com>
References: <20200108194319.3171-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200108194319.3171-1-krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Krzysztof,

On Wed, Jan 8, 2020 at 8:43 PM Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> STR is a well-known stringify macro so it should be avoided in drivers
> to avoid warnings like this (MIPS architecture while compile testing):
>
>     drivers/spi/spi-sh-msiof.c:76:0: warning: "STR" redefined
>      #define STR 0x40 /* Status Register */
>     arch/mips/include/asm/mipsregs.h:30:0: note: this is the location of the previous definition
>      #define STR(x) __STR(x)
>
> To maintain consistency between all register names add a SI prefix to
> all of them.  This also matches register names in datasheet.
>
> Signed-off-by: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>
> ---
>
> Changes since v1:
> 1. Use SI prefix,
> 2. Adjust all register names.

Thanks for the update!

Reviewed-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

No changes in object file, so:
Tested-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
