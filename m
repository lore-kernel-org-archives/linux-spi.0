From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH RFC 1/3] spi: Allow SPI controller override device buswidth
Date: Mon, 2 Mar 2020 17:12:05 +0100
Message-ID: <CAMuHMdV9v-7eRqi3JjcNaOBpRrC2-gLDCizYOJwhQCjZiLr5dA@mail.gmail.com>
References: <1582903131-160033-1-git-send-email-john.garry@huawei.com> <1582903131-160033-2-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: John Garry <john.garry@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1582903131-160033-2-git-send-email-john.garry@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi John,

Thanks for your patch!

On Fri, Feb 28, 2020 at 4:23 PM John Garry <john.garry@huawei.com> wrote:
> Currently ACPI firmware description for a SPI device does not have any
> method to describe the data buswidth on the board.
>
> So even through the controller and device may support higher modes than
> standard SPI, it cannot be assumed that the board does - as such, that
> device is limited to standard SPI in such a circumstance.

Indeed.

> As a workaround, allow the controller driver supply buswidth override bits,
> which are used inform the core code that the controller driver knows the
> buswidth supported on that board for that device.

I feel this is a bit dangerous, and might bite us one day.

> A host controller driver might know this info from DMI tables, for example.

Can't acpi_register_spi_device() obtain that info from DMI tables,
to avoid contaminating the generic code?

> Signed-off-by: John Garry <john.garry@huawei.com>

> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -510,6 +510,7 @@ struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
>         spi->dev.bus = &spi_bus_type;
>         spi->dev.release = spidev_release;
>         spi->cs_gpio = -ENOENT;
> +       spi->mode = ctlr->buswidth_override_bits;

This could just be moved to acpi_register_spi_device(), right?

>
>         spin_lock_init(&spi->statistics.lock);
>
> @@ -2181,9 +2182,10 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
>                 return AE_NO_MEMORY;
>         }
>
> +
>         ACPI_COMPANION_SET(&spi->dev, adev);
>         spi->max_speed_hz       = lookup.max_speed_hz;
> -       spi->mode               = lookup.mode;
> +       spi->mode               |= lookup.mode;
>         spi->irq                = lookup.irq;
>         spi->bits_per_word      = lookup.bits_per_word;
>         spi->chip_select        = lookup.chip_select;
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 6d16ba01ff5a..600e3793303e 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -481,6 +481,9 @@ struct spi_controller {
>         /* spi_device.mode flags understood by this controller driver */
>         u32                     mode_bits;
>
> +       /* spi_device.mode flags override flags for this controller */
> +       u32                     buswidth_override_bits;

And I'd be happy if we could avoid adding this here ;-)

> +
>         /* bitmask of supported bits_per_word for transfers */
>         u32                     bits_per_word_mask;
>  #define SPI_BPW_MASK(bits) BIT((bits) - 1)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
