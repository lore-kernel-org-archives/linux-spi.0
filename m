From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] spi: Add call to spi_slave_abort() function when
 spidev driver is released
Date: Thu, 26 Sep 2019 08:52:48 +0200
Message-ID: <CAMuHMdXseZppE74D8XW=5ZWNNNLXZFLTSiqqe_qoZ8C1rAFQSg@mail.gmail.com>
References: <20190924110547.14770-1-lukma@denx.de> <20190924110547.14770-2-lukma@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190924110547.14770-2-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Lukasz,

On Thu, Sep 26, 2019 at 3:33 AM Lukasz Majewski <lukma@denx.de> wrote:
> This change is necessary for spidev devices (e.g. /dev/spidev3.0) working
> in the slave mode (like NXP's dspi driver for Vybrid SoC).
>
> When SPI HW works in this mode - the master is responsible for providing
> CS and CLK signals. However, when some fault happens - like for example
> distortion on SPI lines - the SPI Linux driver needs a chance to recover
> from this abnormal situation and prepare itself for next (correct)
> transmission.
>
> This change doesn't pose any threat on drivers working in master mode as
> spi_slave_abort() function checks if SPI slave mode is supported.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Thanks for your patch!

Yesterday I saw this appear on spi/for-next, but I couldn't find the
email in my mbox.  Today it has arrived. Looks like gmail had some troubles
("Delivered after 138401 seconds", ugh).

> --- a/drivers/spi/spidev.c
> +++ b/drivers/spi/spidev.c
> @@ -627,6 +627,7 @@ static int spidev_release(struct inode *inode, struct file *filp)
>                 if (dofree)
>                         kfree(spidev);
>         }
> +       spi_slave_abort(spidev->spi);

Looks good to me.  Just wondering if this should be done for the last user only,
i.e. in the "if" block above, like resetting speed_hz?

>         mutex_unlock(&device_list_lock);
>
>         return 0;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
