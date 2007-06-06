From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
Subject: RE: [PATCH] Simple driver for Xilinx SPI controler.
Date: Wed, 6 Jun 2007 11:06:16 -0700
Message-ID: <20070606180618.C4D861268059@mail88-blu.bigfish.com>
References: <4666F598.2000004@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	Wolfgang Reissnegger <wre@xilinx.com>, linuxppc-embedded@ozlabs.org
To: "Andrei Konovalov" <akonovalov@ru.mvista.com>
Return-path: <linuxppc-embedded-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
Content-class: urn:content-classes:message
In-Reply-To: <4666F598.2000004@ru.mvista.com>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-embedded-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-embedded-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
List-Id: linux-spi.vger.kernel.org


Yes, except that microblazes systems run in non-virtex FPGAs...

It may be that XILINX_EDK is not the right thing either, but it
seemed like the easiest way to have a superset of powerpc and microblaze
systems

What I'm trying to do is (in concert with Grant's recent configuration
changes)
having an easy way for a new board configuration to select the Kconfig
options for
all of the Xilinx drivers.  Namely:

config XILINX_ML300
	bool "Xilinx-ML300"
	select XILINX_VIRTEX_II_PRO
	select EMBEDDEDBOOT
	help
	  This option enables support for the Xilinx ML300 evaluation
board.

config XILINX_VIRTEX_II_PRO
	bool
	select XILINX_VIRTEX

config XILINX_EDK
	bool
	depends on XILINX_VIRTEX || XILINX_MICROBLAZE
	default y

config XILINX_GPIO
	tristate "Xilinx OPB GPIO Support"
	depends on XILINX_EDK
	help
	This option enables support for Xilinx GPIO.


It seems like I'm using XILINX_EDK to mean something different than you
are.
Perhaps it sould be instead:

config XILINX_DRIVERS
	bool
	depends on XILINX_VIRTEX || XILINX_MICROBLAZE
	default y

config XILINX_GPIO_EDK
	tristate "Xilinx EDK-based OPB GPIO Support"
	depends on XILINX_DRIVERS
	select XILINX_EDK
	help
	This option enables support for Xilinx GPIO using EDK OS
independent driver.

config XILINX_GPIO
	tristate "Xilinx OPB GPIO Support"
	depends on XILINX_DRIVERS
	help
	This option enables support for Xilinx GPIO.

Would this work for you?

Steve

> -----Original Message-----
> From: Andrei Konovalov [mailto:akonovalov@ru.mvista.com] 
> Sent: Wednesday, June 06, 2007 10:58 AM
> To: Stephen Neuendorffer
> Cc: spi-devel-general@lists.sourceforge.net; 
> linuxppc-embedded@ozlabs.org; Wolfgang Reissnegger
> Subject: Re: [PATCH] Simple driver for Xilinx SPI controler.
> 
> Hi Steve,
> 
> Stephen Neuendorffer wrote:
> > In order to anticipate future Microblaze support with most of these 
> > drivers, we've been moving towards having all of the Kconfig 
> > dependencies on XILINX_EDK,
> 
> There is no XILINX_EDK in the ko tree.
> 
> > rather than XILINX_VIRTEX...
> 
> Using XILINX_VIRTEX seems to be a common thing:
> 
> > -------- Original Message --------
> > Subject: [RFC] Xilinx SystemACE device driver
> > Date: Sat, 14 Apr 2007 19:23:14 -0600
> > From: Grant Likely <grant.likely@secretlab.ca>
> > To: linuxppc-embedded@ozlabs.org, Andrei Konovalov 
> <akonovalov@ru.mvista.com>,	Peter Korsgaard 
> <jacmet@sunsite.dk>,	Rick Moleres <Rick.Moleres@xilinx.com>, 
> Stefan Roese <sr@denx.de>
> > 
> > Add support for block device access to the Xilinx SystemACE Compact 
> > flash interface
> <snip>
> > diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig index 
> > 17ee97f..08ad23c 100644
> > --- a/drivers/block/Kconfig
> > +++ b/drivers/block/Kconfig
> > @@ -453,6 +453,12 @@ config ATA_OVER_ETH
> >  	This driver provides Support for ATA over Ethernet block
> >  	devices like the Coraid EtherDrive (R) Storage Blade.
> >  
> > +config XILINX_SYSACE
> > +	tristate "Xilinx SystemACE support"
> > +	depends on XILINX_VIRTEX
> > +	help
> > +	  Include support for the Xilinx SystemACE CompactFlash 
> interface
> > +
> 
> BTW the SystemACE has been successfully tested with ppc440 
> based board. So XILINX_VIRTEX doesn't imply ppc405.
> 
> On the other side,
> UART Lite driver (in the ko tree) doesn't depend on both 
> XILINX_EDK and XILINX_VIRTEX
> 
> Couldn't Microblaze port use XILINX_VIRTEX too?
> IMHO XILINX_VIRTEX is more general name for something inside 
> the Virtex chip (ppc405 core, Microblaze softcore, IP blocks 
> from EDK or elsewhere).
> 
> I've recently added XILINX_EDK to linux-xilinx-26.git 
> repository at source.mvista.com, but to include the level 1 
> drivers (aka OS independent drivers) from EDK. Haven't 
> planned to use XILINX_EDK for drivers not using EDK code.
> Here is the relevant snippet from 
> arch/ppc/platforms/4xx/Kconfig (from linux-xilinx-26.git @ 
> source.mvista.com, ko doesn't have XILINX_EDK and the rest below):
> 
> ===8<=====================================
> config XILINX_VIRTEX_II_PRO
> 	bool
> 	select XILINX_VIRTEX
> 
> config XILINX_VIRTEX_4_FX
> 	bool
> 	select XILINX_VIRTEX
> 
> config XILINX_VIRTEX
> 	bool
> 
> # The options selected by EDK based drivers. Not visible from 
> [menu]config.
> config XILINX_EDK
> 	bool
> config XILINX_IPIF_V123B
> 	bool
> config XILINX_FIFO_V200A
> 	bool
> config XILINX_DMA_V300A
> 	bool
> ===8<=====================================
> 
> If we do something like
>    config XILINX_MICROBLAZE
> 	bool
> 	select XILINX_VIRTEX
> in arch/microblaze/Kconfig
> would it work?
> 
> 
> Thanks,
> Andrei
> 
> 
> 
