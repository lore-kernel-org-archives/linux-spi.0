From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] eeprom: at25: Convert the driver to the spi-mem interface
Date: Thu, 25 Apr 2019 21:44:51 +0200
Message-ID: <20190425194451.GA14552@kroah.com>
References: <20190330141637.22632-1-boris.brezillon@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
To: Boris Brezillon <boris.brezillon@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190330141637.22632-1-boris.brezillon@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, Mar 30, 2019 at 03:16:37PM +0100, Boris Brezillon wrote:
> The AT25 protocol fits pretty well in the spi-mem model. Convert the
> at25 spi driver to a spi-mem driver and use the dirmap API instead of
> forging SPI messages manually.
> This makes the driver compatible with spi-mem-only controllers
> (controllers implementing only the spi_mem ops).
> 
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/misc/eeprom/at25.c | 282 +++++++++++++++++++++++--------------
>  1 file changed, 176 insertions(+), 106 deletions(-)

Will there be a new version of this to fix up the problems that 0-day
found in it?

thanks,

greg k-h
