From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] spi: reorganize drivers
Date: Mon, 6 Jun 2011 13:21:07 +0200
Message-ID: <201106061321.07400.arnd@arndb.de>
References: <20110605071725.26517.11573.stgit@ponder>
	<201106061100.38249.arnd@arndb.de>
	<1307352547.7586.6.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Russell King <linux@arm.linux.org.uk>,
	Michael Buesch <mb@bu3sch.de>, linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org, Florian Fainelli <florian@openwrt.org>,
	Grant Likely <grant.likely@secretlab.ca>,
	Alexandre Bounine <alexandre.bounine@idt.com>,
	Stefan Richter <stefanr@s5r6.in-berlin.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>,
	"Jean Delvare \(PC drivers, core\)" <khali@linux-fr.org>,
	spi-devel-general@lists.sourceforge.net,
	Matt Porter <mporter@kernel.crashing.org>,
	"David S. Miller" <davem@davemloft.net>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Return-path: <linux-pcmcia-bounces+glkpd-linux-pcmcia=m.gmane.org@lists.infradead.org>
In-Reply-To: <1307352547.7586.6.camel@mulgrave.site>
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

On Monday 06 June 2011, James Bottomley wrote:
> I'd say it only makes sense if we do it for all busses ... so USB and
> PCI would have to move too.  Logically, the bus code should move and we
> should be left with the drivers in both of those directories.  I'd also
> say that we don't have to deepen the tree: /bus would be fine.  That
> way, /drivers/<bus> would be only for <bus> specific drivers, with non
> bus specific drivers we just group them by function as now.

A top-level /bus would work for me, and I guess would also address Russell's
concern. Regarding bus-specific drivers, we're gradually moving those out
of the bus specific directories anyway, basically the only bus directory
that really has device driver in it is USB at this point. It makes some
sense to have a bus-specific low-level user space interface driver like
sg or uio in the bus directory, but everything else should really belong
into some other subsystem.

> What about the half busses (like SCSI)?

I think SCSI is a really special case, not just because of its size
of more than twice the code than everything else I would suggest to
move, but also because it contains mostly host drivers but very few
device drivers (sd, sr, osst, st, and sg). In that sense it's more
a class of devices than a bus and fits in the same category as
mmc and ata than a bus like pci or i2c that have a multitude of
device drivers.

> Finally, is there any real point (other than we can do it)?  what is
> actually helped by having the bus code obviously separated from the
> driver code (assuming we sort out what is bus and what is driver)?

Mostly I think the drivers/ subdirectory is getting a bit cluttered with
stuff that doesn't really fit together, and bus drivers are typically
directories with less than five files in them, apart from the few
exceptions that already came up.

This is about to get worse as we introduce new subsystems (e.g. iommu,
irq, clocksource, eeprom, nvram, ...) into which we are moving
code from arch/arm, drivers/char and drivers/misc. Having buses and
drivers in a separate hierarchy would make the drivers directory and
the respective menuconfig list more clearly structured IMHO.

	Arnd
