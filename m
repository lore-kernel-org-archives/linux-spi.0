From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] spi: sh-msiof: Do not redefine STR while compile testing
Date: Tue, 7 Jan 2020 21:10:37 +0100
Message-ID: <CAMuHMdXZGqqu+rWmemzxYtSNXofeCwLwerCeb-hEoubTvBqwXw@mail.gmail.com>
References: <1578416218-11112-1-git-send-email-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1578416218-11112-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Krzysztof,

On Tue, Jan 7, 2020 at 5:57 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> STR is a well-known stringify macro so it should be avoided in drivers
> to avoid warnings like this (MIPS architecture while compile testing):
>
>     drivers/spi/spi-sh-msiof.c:76:0: warning: "STR" redefined
>      #define STR 0x40 /* Status Register */
>     arch/mips/include/asm/mipsregs.h:30:0: note: this is the location of the previous definition
>      #define STR(x) __STR(x)
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks for your patch!

> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -73,7 +73,7 @@ struct sh_msiof_spi_priv {
>  #define RSCR   0x22    /* Receive Clock Select Register (SH, A1, APE6) */
>  #define CTR    0x28    /* Control Register */
>  #define FCTR   0x30    /* FIFO Control Register */
> -#define STR    0x40    /* Status Register */
> +#define STATR  0x40    /* Status Register */

The datasheets call this register "SISTR", so I prefer to use that instead.
Actually all registers have this "SI" ("Serial Interface"?) prefix.
Shall I add this to my TODO-list?

>  #define IER    0x44    /* Interrupt Enable Register */
>  #define TDR1   0x48    /* Transmit Control Data Register 1 (SH, A1) */
>  #define TDR2   0x4c    /* Transmit Control Data Register 2 (SH, A1) */
> @@ -161,19 +161,19 @@ struct sh_msiof_spi_priv {
>  #define FCTR_RFUA_SHIFT        4
>  #define FCTR_RFUA(i)   ((i) << FCTR_RFUA_SHIFT)
>
> -/* STR */
> -#define STR_TFEMP      BIT(29) /* Transmit FIFO Empty */
> -#define STR_TDREQ      BIT(28) /* Transmit Data Transfer Request */
> -#define STR_TEOF       BIT(23) /* Frame Transmission End */
> -#define STR_TFSERR     BIT(21) /* Transmit Frame Synchronization Error */
> -#define STR_TFOVF      BIT(20) /* Transmit FIFO Overflow */
> -#define STR_TFUDF      BIT(19) /* Transmit FIFO Underflow */
> -#define STR_RFFUL      BIT(13) /* Receive FIFO Full */
> -#define STR_RDREQ      BIT(12) /* Receive Data Transfer Request */
> -#define STR_REOF       BIT(7)  /* Frame Reception End */
> -#define STR_RFSERR     BIT(5)  /* Receive Frame Synchronization Error */
> -#define STR_RFUDF      BIT(4)  /* Receive FIFO Underflow */
> -#define STR_RFOVF      BIT(3)  /* Receive FIFO Overflow */
> +/* STATR */
> +#define STATR_TFEMP    BIT(29) /* Transmit FIFO Empty */
> +#define STATR_TDREQ    BIT(28) /* Transmit Data Transfer Request */
> +#define STATR_TEOF     BIT(23) /* Frame Transmission End */
> +#define STATR_TFSERR   BIT(21) /* Transmit Frame Synchronization Error */
> +#define STATR_TFOVF    BIT(20) /* Transmit FIFO Overflow */
> +#define STATR_TFUDF    BIT(19) /* Transmit FIFO Underflow */
> +#define STATR_RFFUL    BIT(13) /* Receive FIFO Full */
> +#define STATR_RDREQ    BIT(12) /* Receive Data Transfer Request */
> +#define STATR_REOF     BIT(7)  /* Frame Reception End */
> +#define STATR_RFSERR   BIT(5)  /* Receive Frame Synchronization Error */
> +#define STATR_RFUDF    BIT(4)  /* Receive FIFO Underflow */
> +#define STATR_RFOVF    BIT(3)  /* Receive FIFO Overflow */

[...]

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
