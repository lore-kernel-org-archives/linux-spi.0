From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: Fix CS polarity if GPIO descriptors are used
Date: Thu, 20 Feb 2020 07:18:30 +0100
Message-ID: <20200220061830.gzi67u555kgvrfah@wunner.de>
References: <fca3ba7cdc930cd36854666ceac4fbcf01b89028.1582027457.git.lukas@wunner.de>
 <CACRpkdZmzL_bDRuiBehmd-QC93K_xJ5VHM0HaypCFXLU6sZvkQ@mail.gmail.com>
 <20200220061122.srkb663imntm4c6a@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Simon Han <z.han-pnUOlEj4XnTQT0dZR+AlfA@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200220061122.srkb663imntm4c6a-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Feb 20, 2020 at 07:11:22AM +0100, Lukas Wunner wrote:
> -	if (spi->mode & SPI_CS_HIGH)
> +	if (spi->mode & SPI_CS_HIGH && !(ctlr->use_gpio_descriptors &&
> +					 ctlr->cs_gpiods &&
> +					 ctlr->cs_gpiods[spi->chip_select]))
> 		enable = !enable;

Sorry, I meant (spi->mode & SPI_CS_HIGH || (ctlr->...)
                                        ^^^^
