From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi: reorganize drivers
Date: Sun, 5 Jun 2011 14:55:37 -0600
Message-ID: <BANLkTimgbxmBnTN9Sb55-hkbBi1AEfiPdg@mail.gmail.com>
References: <20110605071725.26517.11573.stgit@ponder> <BANLkTinoEQf2a65KwQZOVK_4H9DSfqybjA@mail.gmail.com>
 <20110605075458.GA2712@tarshish> <BANLkTi=5XLxcZiBcZT8W4Gh+Ph_BUjs-yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Baruch Siach <baruch@tkos.co.il>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BANLkTi=5XLxcZiBcZT8W4Gh+Ph_BUjs-yw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sun, Jun 5, 2011 at 5:49 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Sun, Jun 5, 2011 at 09:54, Baruch Siach <baruch@tkos.co.il> wrote:
>> On Sun, Jun 05, 2011 at 01:13:28PM +0530, Jassi Brar wrote:
>>> On Sun, Jun 5, 2011 at 12:48 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
>>> > [repost: I had a typo on the spi-devel-general mailing list address]
>>> >
>>> > Sort the SPI makefile and enforce the naming convention spi_*.c for
>>> > spi drivers.
>>
>> [snip]
>>
>>> Though the spi_ prefix seems redundant considering the files are in
>>> 'spi' directory.
>>> Just a thought, no objection.
>>
>> When looking at the list of loaded modules (e.g. in an Oops message), the name
>> "spi_xilinx" is much more meaningful than just "xilinx", for example.
>
> Plus, when dropping the prefix, spi_xilinx.ko and gpio-xilinx.ko
> become the same...

Exactly.  We essentially have a flat namespace for modules, despite
the fact of them being organized into directories.  At least for the
subsystems I maintain, I'd like to have a consistent prefix for that
reason.

> So now we have spi_<name>.c (with underscore) and gpio-<name>.c (with dash)?
> And other subsystems go with <name>-<type>.c instead, e.g.
> drivers/mfd/wm831x-spi.c?

On a brief survey of drivers:

apci: *.c
ata: pata_*.c, sata_*.c
atm: *.c
block: *.c
bluetooth: *.c
crypto: *.c
dma: *dma.c
gpio: gpio-*.c (after applying my patch)
hid: hid-*.c
hwmon: *.c
i2c: i2c-*.c
ide: *.c and ide-*.c
input: *.c
leds: leds-*.c
mca: mca-*.c
md: largely dm-*.c
mfd: *.c
mmc: *.c
mtd: *.c
net: *.c
rtc: rtc-*.c
scsi: *.c and scsi_*.c for core code
spi: (before patch) mix of spi_*.c and *_spi.c and *.c
uio: uio_*.c
virtio: virtio_*.c
wdt: *wdt.c and *_wdt.c

So, in this (admittedly incomplete) survey, I see 5 users of the
"prefix_" pattern, 8 of the "prefix-" pattern, a small number using a
suffix, and a whole lot without any pattern at all.  Personally, I
prefer the using a prefix with a '-', but in the spi directory there
was already a number of drivers using '_', so it was smaller impact to
change to using that instead of a dash.  If people don't think it is a
big deal though, then I'll change it to '-' to match the gpio change.

g.
