From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH] spi: reorganize drivers
Date: Sun, 5 Jun 2011 15:08:07 +0200
Message-ID: <20110605150807.0cb01ba0@stein>
References: <20110605071725.26517.11573.stgit@ponder>
	<BANLkTinoEQf2a65KwQZOVK_4H9DSfqybjA@mail.gmail.com>
	<20110605075458.GA2712@tarshish>
	<BANLkTi=5XLxcZiBcZT8W4Gh+Ph_BUjs-yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Baruch Siach <baruch@tkos.co.il>,
	Grant Likely <grant.likely@secretlab.ca>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BANLkTi=5XLxcZiBcZT8W4Gh+Ph_BUjs-yw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Jun 05 Geert Uytterhoeven wrote:
> On Sun, Jun 5, 2011 at 09:54, Baruch Siach <baruch@tkos.co.il> wrote:
> > On Sun, Jun 05, 2011 at 01:13:28PM +0530, Jassi Brar wrote:
> >> On Sun, Jun 5, 2011 at 12:48 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> >> > [repost: I had a typo on the spi-devel-general mailing list address]
> >> >
> >> > Sort the SPI makefile and enforce the naming convention spi_*.c for
> >> > spi drivers.
> >
> > [snip]
> >
> >> Though the spi_ prefix seems redundant considering the files are in
> >> 'spi' directory.
> >> Just a thought, no objection.
> >
> > When looking at the list of loaded modules (e.g. in an Oops message), the name
> > "spi_xilinx" is much more meaningful than just "xilinx", for example.
> 
> Plus, when dropping the prefix, spi_xilinx.ko and gpio-xilinx.ko
> become the same...

In drivers/firewire/Makefile for example, there is this:

	firewire-core-y += core-card.o core-cdev.o core-device.o \
	                   core-iso.o core-topology.o core-transaction.o
	firewire-ohci-y += ohci.o
	firewire-sbp2-y += sbp2.o
	firewire-net-y  += net.o

Which is impractical though if there are more than a handful of drivers
involved.
-- 
Stefan Richter
-=====-==-== -==- --=-=
http://arcgraph.de/sr/
