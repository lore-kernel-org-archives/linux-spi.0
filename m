From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] spi: reorganize drivers
Date: Mon, 6 Jun 2011 14:16:36 +0200
Message-ID: <20110606141636.150c54b5@endymion.delvare>
References: <20110605071725.26517.11573.stgit@ponder>
	<201106061100.38249.arnd@arndb.de>
	<1307352547.7586.6.camel@mulgrave.site>
	<201106061321.07400.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Grant Likely <grant.likely@secretlab.ca>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Russell King <linux@arm.linux.org.uk>,
	Michael Buesch <mb@bu3sch.de>, linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org, Florian Fainelli <florian@openwrt.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Alexandre Bounine <alexandre.bounine@idt.com>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>,
	spi-devel-general@lists.sourceforge.net,
	Matt Porter <mporter@kernel.crashing.org>,
	"David S. Miller" <davem@davemloft.net>
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
In-Reply-To: <201106061321.07400.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-pcmcia/>
List-Post: <mailto:linux-pcmcia@lists.infradead.org>
List-Help: <mailto:linux-pcmcia-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-pcmcia>,
	<mailto:linux-pcmcia-request@lists.infradead.org?subject=subscribe>
Sender: linux-pcmcia-bounces@lists.infradead.org
Errors-To: linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Mon, 6 Jun 2011 13:21:07 +0200, Arnd Bergmann wrote:
> On Monday 06 June 2011, James Bottomley wrote:
> > I'd say it only makes sense if we do it for all busses ... so USB and
> > PCI would have to move too.  Logically, the bus code should move and we
> > should be left with the drivers in both of those directories.  I'd also
> > say that we don't have to deepen the tree: /bus would be fine.  That
> > way, /drivers/<bus> would be only for <bus> specific drivers, with non
> > bus specific drivers we just group them by function as now.
> 
> A top-level /bus would work for me, and I guess would also address Russell's
> concern. Regarding bus-specific drivers, we're gradually moving those out
> of the bus specific directories anyway, basically the only bus directory
> that really has device driver in it is USB at this point. It makes some
> sense to have a bus-specific low-level user space interface driver like
> sg or uio in the bus directory, but everything else should really belong
> into some other subsystem.

Err, what about I2C and SPI? Aren't drivers/i2c/busses and drivers/spi
full of "device drivers"? Or are these what you call "bus-specific
drivers"? Maybe we need to define all the terms before the discussion
continues further.

> (...)
> This is about to get worse as we introduce new subsystems (e.g. iommu,
> irq, clocksource, eeprom, nvram, ...) into which we are moving
> code from arch/arm, drivers/char and drivers/misc. Having buses and
> drivers in a separate hierarchy would make the drivers directory and
> the respective menuconfig list more clearly structured IMHO.

This gets interesting. Would you suggest for example that i2c-core.c
goes to bus/i2c, and drivers/i2c/busses becomes drivers/i2c? And that
CONFIG_I2C is somewhere in menuconfig, and the hardware driver
selection for drivers/i2c is in a totally different place?

While I am surprised, I am not necessarily objecting. But it seems that
you should better define what your actual plan is, before asking us if
we agree with it.

-- 
Jean Delvare
