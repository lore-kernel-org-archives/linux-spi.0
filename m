From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RFC 04/25] spi: gpio: Implement LSB First bitbang support
Date: Thu, 12 Dec 2019 09:40:20 +0100
Message-ID: <CAMuHMdWdxJ9AaWhyCW-u8fCpXSDCPd-D6Dx129SF5nRssZsK=g@mail.gmail.com>
References: <20191212033952.5967-1-afaerber@suse.de> <20191212033952.5967-5-afaerber@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: linux-realtek-soc@lists.infradead.org, linux-leds@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Dan Murphy <dmurphy@ti.com>
To: =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191212033952.5967-5-afaerber@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Andreas,

On Thu, Dec 12, 2019 at 4:41 AM Andreas Färber <afaerber@suse.de> wrote:
> Add support for slave DT property spi-lsb-first, i.e., SPI_LSB_FIRST mode.
>
> Duplicate the inline helpers bitbang_txrx_be_cpha{0,1} as LE versions.
> Make checkpatch.pl happy by changing "unsigned" to "unsigned int".
>
> Conditionally call them from all the spi-gpio txrx_word callbacks.
>
> Signed-off-by: Andreas Färber <afaerber@suse.de>

Thanks for your patch!

> --- a/drivers/spi/spi-gpio.c
> +++ b/drivers/spi/spi-gpio.c
> @@ -135,25 +135,37 @@ static inline int getmiso(const struct spi_device *spi)
>  static u32 spi_gpio_txrx_word_mode0(struct spi_device *spi,
>                 unsigned nsecs, u32 word, u8 bits, unsigned flags)
>  {
> -       return bitbang_txrx_be_cpha0(spi, nsecs, 0, flags, word, bits);
> +       if (unlikely(spi->mode & SPI_LSB_FIRST))
> +               return bitbang_txrx_le_cpha0(spi, nsecs, 0, flags, word, bits);
> +       else
> +               return bitbang_txrx_be_cpha0(spi, nsecs, 0, flags, word, bits);
>  }

Duplicating all functions sounds a bit wasteful to me.

What about reverting the word first, and calling the normal functions?

    if (unlikely(spi->mode & SPI_LSB_FIRST)) {
            if (bits <= 8)
                    word = bitrev8(word) >> (bits - 8);
            else if (bits <= 16)
                    word = bitrev16(word) >> (bits - 16);
            else
                    word = bitrev32(word) >> (bits - 32);
    }
    return bitbang_txrx_be_cpha0(spi, nsecs, 0, flags, word, bits);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
