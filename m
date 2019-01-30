From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 0/2] eeprom: at25: SPI transfer improvements
Date: Wed, 30 Jan 2019 15:50:54 +0100
Message-ID: <20190130145054.GA990@kroah.com>
References: <20190118140525.29189-1-geert+renesas@glider.be>
 <20190118230740.44239fcf@bbrezillon>
 <CAMuHMdVfVHUQnjwvFikqQJ8HBD+0A7DSCTcdDN4e7V4c=4Usug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Boris Brezillon <bbrezillon@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Nguyen An Hoan <na-hoan@jinso.co.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdVfVHUQnjwvFikqQJ8HBD+0A7DSCTcdDN4e7V4c=4Usug@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jan 29, 2019 at 08:02:37PM +0100, Geert Uytterhoeven wrote:
> Hi Boris,
> 
> On Fri, Jan 18, 2019 at 11:07 PM Boris Brezillon <bbrezillon@kernel.org> wrote:
> > Did you consider converting this driver to spimem? Looks like the
> > protocol used to communicate with the memory resembles the one used on
> > SPI NANDs/NORs and fits pretty well in the spi_mem_op representation.
> >
> > By doing this conversion you'd allow people to connect an AT25 EEPROM
> > to an advanced SPI controller that does not support regular SPI
> > transfers and you wouldn't have to forge SPI messages manually.
> >
> > Here is a patch (only compile tested) doing that. The diffstat is not in
> > favor of this conversion, but I find the resulting code cleaner and more
> > future proof.
> 
> Thanks, seems to work fine, with the 512-byte 25LC040 I have!
> 
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> I did notice that the first two-byte transfer (command+offset) of each
> message is now split in two one-byte transfers, though.

Ok, I'll drop this patch series and wait for the updated version to be
sent out :)

thanks,

greg k-h
