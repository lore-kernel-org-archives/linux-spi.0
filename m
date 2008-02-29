From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: SPI Framework chip select
Date: Fri, 29 Feb 2008 12:04:33 -0800
Message-ID: <200802291204.33911.david-b@pacbell.net>
References: <47C85451.1030809@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <47C85451.1030809-/d+BM93fTQY@public.gmane.org>
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

On Friday 29 February 2008, Ned Forrester wrote:
> Can someone explain to me how the SPI Framework chip select is
> supposed to work?
> 
> My pxa2xx_spi device does not use a chip_select at all, hence I have
> no cs_control routine defined in struct pxa2xx_spi_chip.cs_control.  I
> have never understood how chip select is supposed to work in the SPI
> framework, other than explicit code in the controller driver calling a
> user defined function, as in pxa2xx_spi.c.

That's specific to that driver.  PXA doesn't talk "native SPI" but
does so with some external assistance ... like those callbacks.


> I gather there is a 
> mechanism involving the struct spi_board_info.chip_select which
> selects an index for a chip select at a higher level of the SPI
> framework.  I don't know where the connection is between this and a
> physical GPIO line connected to an external chip.

SPI involves three signal lines -- MOSI, MISO, SCK -- all of which
are conceptually gated by a chipselect line (active low, usually).

So a transfer begins by setting those lines to their initial state,
then activating the chipselect and starting a bunch of clock cycles
that transfer data bits.  And the transfer ends when the chipselect
is de-activated.

There are some variations to that sequence ... stuff like chipselect
being active high is rare, but sometimes there are dedicated busses
that don't use a chipselect at all.  Sometimes a chipselect doesn't
quite gate signals but instead acts as another signal line ... JTAG
has TMS, which sometimes gates state transitions, and MMC in its "SPI"
variant has a few cases that require clocks be sent to devices when
their chips are deselected.


> Also, in connection with the Framework chip select mechanism, I have
> never understood, even if a correspondence is made between a
> spi_board_info.chip_select index and a physical IO line, how that CS
> is supposed to know when to change state. 

Primarily, it changes at the begining and end of a message.  Some
transfers may require temporary mid-message deselection ... for
example, if the SPI device has commands to write (tx command then
tx data) and read (tx command then rx data) that are terminated by
chip deselect, it can be important to issue an un-interrupted series
of writes and reads.  (That's what spi_transfer.cs_change assists.)


> It is clear in pxa2xx_spi.c 
> that when a user supplied cs_control function is called, the
> appropriate action defined in the function will take place.  However,
> the null_cs_control routine in pxa2xx_spi.c, which is called if the
> user does not specify a routine in struct pxa2xx_spi_chip.cs_control,
> simply returns without calling any function defined in the SPI
> framework.

I'd sure hope the null_cs routine is only used for dedicated
busses ... it sure can't be correct when there are two or more
devices on the bus.

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
