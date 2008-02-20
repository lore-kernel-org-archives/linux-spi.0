From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: R: [patch 2.6.25-rc2] SPI -- Freescale iMX
	SPI controller driver
Date: Wed, 20 Feb 2008 14:20:21 -0800
Message-ID: <200802201420.22158.david-b@pacbell.net>
References: <FLEPLOLKEPNLMHOILNHPGEKJECAA.a.paterniani@swapp-eng.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>,
	SPI Devel General <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Linux ARM Kernel <linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
To: "Andrea Paterniani" <a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <FLEPLOLKEPNLMHOILNHPGEKJECAA.a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>
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

On Tuesday 19 February 2008, Andrea Paterniani wrote:

> > > +	u32 control;
> > > 
> > >  	dev_dbg(&drv_data->pdev->dev, "flush\n");
> > > +
> > > +	/* Wait for end of transaction */
> > >  	do {
> > > -		while (readl(regs + SPI_INT_STATUS) & SPI_STATUS_RR)
> > > -			d = readl(regs + SPI_RXDATA);
> > > -	} while ((readl(regs + SPI_CONTROL) & SPI_CONTROL_XCH) && limit--);
> > 
> > No endless looping, good (although done badly, since the
> > timeout should be fixed and not dependent on whatever 2/HZ
> > happens to be) ...
> 
> Please give me example code on how to define fix timeout.

I tend to just use a variant of what's in drivers/usb/host/ehci-hcd.c
near the top --

   static int handshake(struct ehci_hcd *ehci, void __iomem *ptr,
                      u32 mask, u32 done, int usec)

You may not need the "CardBus ejection" case, but the rest is
generic to most "wait till bits set" or "wait till bits clear"
handshakes.  Likewise you might prefer an "ndelay" or somesuch.


> > > +	/* Release chip select if requested, transfer delays are
> > > +	   handled in pump_transfers */
> > > +	if (drv_data->cs_change)
> > > +		drv_data->cs_control(SPI_CS_DEASSERT);
> > > 
> > > -	return limit;
> > > +	/* Disable SPI to flush FIFOs */
> > > +	writel(control & ~SPI_CONTROL_SPIEN, regs + SPI_CONTROL);
> > > +	writel(control, regs + SPI_CONTROL);
> > 
> > I'm not following.  If you're going to flush FIFOs, that
> > needs to be done before deasserting chipselect.  But on the
> > other hand, once the transaction has ended, why would a FIFO
> > possibly be non-empty?  If the idea is to discard RX data,
> > that should show up in the comments... and maybe even as a
> > better function name.  (You're changing all callers anyway,
> > to have no return value, so fixing the name is easy.)
> > 
> 
> Transaction is the shifting in/out of a word to/from the SPI shift register.
> When the last word is transfered from TXFIFO to the shift-register causing
> TXFIFO empty interrupt it's necessary to monitor SPI_CONTROL_XCH to detect
> the actual end of transfer.

That is, XCH is the difference between FIFO empty and last-bit-transferred.
Fine, that difference is routine.


> Chip-select is deasserted before flush because SPI disable may cause a spurius
> SPI_CLK edge if using SPI_CPOL=1.
> For Good HW design SPI_nSS should be combined with SW chip-select to obtain a
> clean timing; however I prefer to deselect (if required) before flushing fifos
> to avoid spurius SPI_CLK edge while SW chip-select is asserted.

That doesn't address my issue though:  that's not a "flush"
operation, it's a "SPI disable"...


> Disabling SPI both TX and RX fifos are flushed, but obviously the main scope
> of the function is to flush RX fifo.

Then rename it to reflect its purpose:  flush_rx_and_disable(),
rather than flush().


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
