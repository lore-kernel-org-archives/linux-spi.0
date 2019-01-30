From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v5 1/2] spi: support inter-word delay requirement for devices
Date: Wed, 30 Jan 2019 08:35:25 +0100
Message-ID: <CAMuHMdXv6U-VeznbXrTNk9oY1kCkYu-b+_o3KH_R6BMgpVn7YA@mail.gmail.com>
References: <20190129205502.7741-1-jonas@norrbonn.se> <20190129205502.7741-2-jonas@norrbonn.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>
To: Jonas Bonn <jonas@norrbonn.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190129205502.7741-2-jonas@norrbonn.se>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Jonas,

On Tue, Jan 29, 2019 at 9:55 PM Jonas Bonn <jonas@norrbonn.se> wrote:
> Some devices are slow and cannot keep up with the SPI bus and therefore
> require a short delay between words of the SPI transfer.
>
> The example of this that I'm looking at is a SAMA5D2 with a minimum SPI
> clock of 400kHz talking to an AVR-based SPI slave.  The AVR cannot put
> bytes on the bus fast enough to keep up with the SoC's SPI controller
> even at the lowest bus speed.
>
> This patch introduces the ability to specify a required inter-word
> delay for SPI devices.  It is up to the controller driver to configure
> itself accordingly in order to introduce the requested delay.
>
> Note that, for spi_transfer, there is already a field word_delay that
> provides similar functionality.  This field, however, is specified in
> clock cycles (and worse, SPI controller cycles, not SCK cycles); that
> makes this value dependent on the master clock instead of the device
> clock for which the delay is intended to provide some relief.  This
> patch leaves this old word_delay in place and provides a time-based
> word_delay_us alongside it; the new field fits in the struct padding
> so struct size is constant.  There is only one in-kernel user of the
> word_delay field and presumably that driver could be reworked to use
> the time-based value instead.

Thanks for your patch!

> The time-based delay is limited to 8 bits as these delays are intended
> to be short.  The SAMA5D2 that I've tested this on limits delays to a
> maximum of ~100us, which is already many word-transfer periods even at
> the minimum transfer speed supported by the controller.

Still, the similar delay_usecs uses a u16.

> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h

> @@ -803,6 +808,7 @@ struct spi_transfer {
>  #define        SPI_NBITS_DUAL          0x02 /* 2bits transfer */
>  #define        SPI_NBITS_QUAD          0x04 /* 4bits transfer */
>         u8              bits_per_word;
> +       u8              word_delay_us;

us for µs

>         u16             delay_usecs;

usecs for µs

Can we please try to be consistent?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
