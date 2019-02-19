From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] drivers: spi: core: Add optional stall delay between
 cs_change transfers
Date: Tue, 19 Feb 2019 20:58:27 +0100
Message-ID: <CAMuHMdWPoN8LVmDKv14eaGDmona096AVw=aPL6q5nSnSRUtt7Q@mail.gmail.com>
References: <1550595636-23598-1-git-send-email-stefan.popa@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550595636-23598-1-git-send-email-stefan.popa@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Stefan,

Thanks for your patch!

On Tue, Feb 19, 2019 at 6:02 PM Stefan Popa <stefan.popa@analog.com> wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
>
> Some devices like the ADIS16460 IMU require a stall period between
> transfers.

This is not just about the period between transfers (which is handled by
delay_usecs), but about the period in between chipselect pulses if
cs_change is set.

> The default value of 10us are not enough. Introduce a per

... is not enough.

> transfer configurable delay.

> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1144,7 +1144,8 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
>                                 keep_cs = true;
>                         } else {
>                                 spi_set_cs(msg->spi, false);
> -                               udelay(10);
> +                               udelay(xfer->cs_change_stall_delay_us ?
> +                                      xfer->cs_change_stall_delay_us : 10);
>                                 spi_set_cs(msg->spi, true);
>                         }
>                 }
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 314d922..273774c 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -702,6 +702,8 @@ extern void spi_res_release(struct spi_controller *ctlr,
>   *      transfer. If 0 the default (from @spi_device) is used.
>   * @bits_per_word: select a bits_per_word other than the device default
>   *      for this transfer. If 0 the default (from @spi_device) is used.
> + * @cs_change_stall_delay_us: microseconds to delay between cs_change
> + *     transfers.

I think this needs some better wording, too.
Else it is hard to understand how this is different from delay_usecs,
without looking at the implementation.

>   * @cs_change: affects chipselect after this transfer completes
>   * @delay_usecs: microseconds to delay after this transfer before
>   *     (optionally) changing the chipselect status, then starting
> @@ -788,6 +790,7 @@ struct spi_transfer {
>  #define        SPI_NBITS_DUAL          0x02 /* 2bits transfer */
>  #define        SPI_NBITS_QUAD          0x04 /* 4bits transfer */
>         u8              bits_per_word;
> +       u8              cs_change_stall_delay_us;
>         u16             delay_usecs;
>         u32             speed_hz;
>         u16             word_delay;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
