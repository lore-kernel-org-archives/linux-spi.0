From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH 7/12] neo1973: JBT6K74 LCM control
	interface driver
Date: Wed, 19 Dec 2007 12:04:04 -0800
Message-ID: <200712191204.04353.david-b@pacbell.net>
References: <20071218110800.GN29882@prithivi.gnumonks.org>
	<20071218235954.5351225EA51@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<20071219095721.GU29882@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: Harald Welte <laforge-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20071219095721.GU29882-jI4mzJ+yNOMOwssVsN95jSCwEArCW2h5@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wednesday 19 December 2007, Harald Welte wrote:
> > > +config SPI_SLAVE_JBT6K74
> > > +	tristate "tpo JP6K74 LCM ASIC control interface"
> > > +	depends on SPI_MASTER && SYSFS
> > > +	help
> > > +	  Driver for the tpo JP6K74-AS LCM SPI control interface.
> > 
> > It's not a slave-side driver though ... it's a master-side driver,
> > depending on SPI_MASTER, and making bus master calls like spi_write().
> 
> I'm sorry, I must have misread/misinterpreted the terminology then. 

See Documentation/spi/spi-summary ...


> I thought master is the master controller driver, and 'slave driver' is
> the driver for an SPI slave attached to that master.

There are potentially four drivers involved.  A "controller" driver
touches the hardware directly, and there can be both master and
slave versions (based on which side of the link is involved).  The
layer on top of each (master or slave sides) is a different flavor
of driver, insulated from the hardware ... I call those "protocol"
drivers, for lack of better terms.  That way terminology can at least
be consistent:  {Master,Slave} x {Controller,Protocol} Driver gives
four driver types.  The JBT6K74 driver is a "master protocol driver".

There are protocol stacks that adopt confusing terminology, like
having the "slave" driver not actually run inside the slave.  (So
what would you call firmware drivers, inside the slaves?)  This
doesn't happen to be one of those stacks.  ;)

 
> However, you seem to intend the names as 'slave driver' == driver for an
> SPI unit running in slave mode on the Linux-controlled CPU/SoC itself.
> Correct?

Yes; though there are two types of slave drivers:  controller (touching
hardware) and protocol (just sending/receiving messages).  If the slave
code is on a resource-scarce system it might use an integrated driver to
cut corners, at the cost of reusability.

 
> > I think the Kconfig could stand to be more informative too.  "LCM" is
> > as cryptic as "tpo", 
> 
> LCM == LCD Module.  I will expand that abbreviation in my patchset.
> 
> TPO == Name of the manufacturer. I think one of the biggest display
> manufacturers in the hardware world (http://www.tpo.biz/) producing
> about 17 Million LCD displays per month.  I can't rename or explain the
> manufacturer.  What is your suggestion for this?

"Driver for the JBT6K74 LCD Control Module, manufactured by TPO..."

 
> > there's no clue about what is controlled (SPI?),
> 
> I thought "LCM SPI control interface" is quite explicit. 

If you already know what's going on, sure.  People reading Kconfig
helptext are less likely than usual to know that.


> Many modern 
> LCM's (especially the small-size models for embedded devices) have a SPI
> control interface in addition to the actual RGB data interface.  The
> control interface is used for power management, gamma calibration as
> well as video timing configuration.

Absolutely.  Same thing happens with audio codecs:  one interface
streams data (I2S or whatever), and there's a separate control
interface using an entirely different bus(*).  One sentence saying
that's what is going on here would clarify things a lot.

- Dave

(*) And to confuse things even more ... some platforms use the same
    type serial interface controller, configured very differently, to
    talk to the two different interfaces.  One SSP implements I2S,
    another SSP implements SPI.

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
