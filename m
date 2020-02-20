From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: Fix CS polarity if GPIO descriptors are used
Date: Thu, 20 Feb 2020 07:11:22 +0100
Message-ID: <20200220061122.srkb663imntm4c6a@wunner.de>
References: <fca3ba7cdc930cd36854666ceac4fbcf01b89028.1582027457.git.lukas@wunner.de>
 <CACRpkdZmzL_bDRuiBehmd-QC93K_xJ5VHM0HaypCFXLU6sZvkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Simon Han <z.han-pnUOlEj4XnTQT0dZR+AlfA@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZmzL_bDRuiBehmd-QC93K_xJ5VHM0HaypCFXLU6sZvkQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Feb 19, 2020 at 04:47:50PM +0100, Linus Walleij wrote:
> On Tue, Feb 18, 2020 at 1:08 PM Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> wrote:
> > Commit f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")
> > amended of_spi_parse_dt() to always set SPI_CS_HIGH for SPI slaves whose
> > Chip Select is defined by a "cs-gpios" devicetree property.
> >
> > This change broke userspace applications which issue an SPI_IOC_WR_MODE
> > ioctl() to an spidev:  Chip Select polarity will be incorrect unless the
> > application is changed to set SPI_CS_HIGH.  And once changed, it will be
> > incompatible with kernels not containing the commit.
> >
> > Fix by setting SPI_CS_HIGH in spidev_ioctl() (under the same conditions
> > as in of_spi_parse_dt()).
> 
> Nit: I would also insert a comment in the code to tell what is going on.

Fair enough, but the below should be clarified before I respin:


> > +                       if (ctlr->use_gpio_descriptors && ctlr->cs_gpiods &&
> > +                           ctlr->cs_gpiods[spi->chip_select])
> > +                               tmp |= SPI_CS_HIGH;
> 
> Should this be tmp ^= SPI_CS_HIGH?
> 
> If the device tree node for cs-gpios is actually active high, which
> happens, then you probably want the opposite of what was
> requested, right?

I don't quite follow.  Using an XOR here would seem to be inconsistent
with what you added to of_spi_parse_dt():  In that function, you
*always* set SPI_CS_HIGH if gpio_descs are used.  So if the polarity
is specified in the cs-gpios property, anything else is considered
irrelevant and ignored.

Applying the same logic to spidev_ioctl() means that if the user
specified SPI_CS_HIGH, it is likewise ignored because the polarity
in the cs-gpios property takes precedence.  Am I missing something?

TBH the way commit f3186dd87669 abuses SPI_CS_HIGH seems clumsy to me.
Would it not have been possible to just amend spi_set_cs() like this:

-	if (spi->mode & SPI_CS_HIGH)
+	if (spi->mode & SPI_CS_HIGH && !(ctlr->use_gpio_descriptors &&
+					 ctlr->cs_gpiods &&
+					 ctlr->cs_gpiods[spi->chip_select]))
		enable = !enable;

This would have avoided the regression fixed by my patch.
Also note that spi_setup() emits a dev_dbg() which now incorrectly
reports "cs_high" if a cs-gpios property is present. :-(

Thanks,

Lukas
