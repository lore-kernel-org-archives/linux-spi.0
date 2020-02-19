From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: Fix CS polarity if GPIO descriptors are used
Date: Wed, 19 Feb 2020 16:47:50 +0100
Message-ID: <CACRpkdZmzL_bDRuiBehmd-QC93K_xJ5VHM0HaypCFXLU6sZvkQ@mail.gmail.com>
References: <fca3ba7cdc930cd36854666ceac4fbcf01b89028.1582027457.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Simon Han <z.han-pnUOlEj4XnTQT0dZR+AlfA@public.gmane.org>
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <fca3ba7cdc930cd36854666ceac4fbcf01b89028.1582027457.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Feb 18, 2020 at 1:08 PM Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> wrote:

> Commit f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")
> amended of_spi_parse_dt() to always set SPI_CS_HIGH for SPI slaves whose
> Chip Select is defined by a "cs-gpios" devicetree property.
>
> This change broke userspace applications which issue an SPI_IOC_WR_MODE
> ioctl() to an spidev:  Chip Select polarity will be incorrect unless the
> application is changed to set SPI_CS_HIGH.  And once changed, it will be
> incompatible with kernels not containing the commit.
>
> Fix by setting SPI_CS_HIGH in spidev_ioctl() (under the same conditions
> as in of_spi_parse_dt()).
>
> Fixes: f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")
> Reported-by: Simon Han <z.han-pnUOlEj4XnTQT0dZR+AlfA@public.gmane.org>
> Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org # v5.1+
> Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
(...)

Nit: I would also insert a comment in the code to tell what is going on.

> +                       if (ctlr->use_gpio_descriptors && ctlr->cs_gpiods &&
> +                           ctlr->cs_gpiods[spi->chip_select])
> +                               tmp |= SPI_CS_HIGH;

Should this be tmp ^= SPI_CS_HIGH?

If the device tree node for cs-gpios is actually active high, which
happens, then you probably want the opposite of what was
requested, right?

Yours,
Linus Walleij
