From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] eeprom: at25: Convert the driver to the spi-mem interface
Date: Tue, 3 Sep 2019 17:06:52 +0200
Message-ID: <CAMuHMdViBLGurV+w=EN4TMOsDey9vC=YS6qoX6wA4gwvirOoAA@mail.gmail.com>
References: <20190330141637.22632-1-boris.brezillon@collabora.com> <20190425194451.GA14552@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190425194451.GA14552@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Apr 25, 2019 at 9:44 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Sat, Mar 30, 2019 at 03:16:37PM +0100, Boris Brezillon wrote:
> > The AT25 protocol fits pretty well in the spi-mem model. Convert the
> > at25 spi driver to a spi-mem driver and use the dirmap API instead of
> > forging SPI messages manually.
> > This makes the driver compatible with spi-mem-only controllers
> > (controllers implementing only the spi_mem ops).
> >
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> > ---
> >  drivers/misc/eeprom/at25.c | 282 +++++++++++++++++++++++--------------
> >  1 file changed, 176 insertions(+), 106 deletions(-)
>
> Will there be a new version of this to fix up the problems that 0-day
> found in it?

gmail-whitespace-damaged fix:

diff --git a/drivers/misc/eeprom/Kconfig b/drivers/misc/eeprom/Kconfig
index f2abe27010eff133..98145d7d43d0c728 100644
--- a/drivers/misc/eeprom/Kconfig
+++ b/drivers/misc/eeprom/Kconfig
@@ -36,6 +36,7 @@ config EEPROM_AT25
        depends on SPI && SYSFS
        select NVMEM
        select NVMEM_SYSFS
+       select SPI_MEM
        help
          Enable this driver to get read/write support to most SPI EEPROMs,
          after you configure the board init code to know about each eeprom

Boris: what's the plan?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
