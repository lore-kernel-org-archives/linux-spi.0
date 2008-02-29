From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: SPI Framework chip select
Date: Fri, 29 Feb 2008 15:53:41 -0500
Message-ID: <47C870D5.7000109@whoi.edu>
References: <47C85451.1030809@whoi.edu>
	<200802291204.33911.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200802291204.33911.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

David Brownell wrote:
> On Friday 29 February 2008, Ned Forrester wrote:
>> Can someone explain to me how the SPI Framework chip select is
>> supposed to work?
>>
>> My pxa2xx_spi device does not use a chip_select at all, hence I have
>> no cs_control routine defined in struct pxa2xx_spi_chip.cs_control.  I
>> have never understood how chip select is supposed to work in the SPI
>> framework, other than explicit code in the controller driver calling a
>> user defined function, as in pxa2xx_spi.c.
> 
> That's specific to that driver.  PXA doesn't talk "native SPI" but
> does so with some external assistance ... like those callbacks.

I know, but are you saying that there is something limiting in the PXA
architecture that requires the "external assistance" provided by the
cs_control function in pxa2xx_spi.c, or are you saying that pxa2xx_spi.c
chooses to implement chip select this way, but could use something
higher up in the framework?

>> I gather there is a 
>> mechanism involving the struct spi_board_info.chip_select which
>> selects an index for a chip select at a higher level of the SPI
>> framework.  I don't know where the connection is between this and a
>> physical GPIO line connected to an external chip.
>
> SPI involves three signal lines -- MOSI, MISO, SCK -- all of which
> are conceptually gated by a chipselect line (active low, usually).

I thought the chip select, when used, is not conceptual, but is a
physical wire, and a separate one for each chip on the SPI bus.

So where does spi_board_info.chip_select enter the picture?

Sorry to be so dense, but I figured spi_board_info.chip_select was a
flag to higher level code to request that a certain CS be manipulated.
Is this just a flag for the sole use of the controller driver in doing
whatever is needed to manipulate dedicated CS lines?

>> Also, in connection with the Framework chip select mechanism, I have
>> never understood, even if a correspondence is made between a
>> spi_board_info.chip_select index and a physical IO line, how that CS
>> is supposed to know when to change state. 
> 
> Primarily, it changes at the begining and end of a message.  Some
> transfers may require temporary mid-message deselection ... for
> example, if the SPI device has commands to write (tx command then
> tx data) and read (tx command then rx data) that are terminated by
> chip deselect, it can be important to issue an un-interrupted series
> of writes and reads.  (That's what spi_transfer.cs_change assists.)

But what makes it change if there is no explicit function changing
something?  I don't see any functions to call in spi.c or spi.h that
utilize spi_board_info.chip_select.

Does some hardware provide a bunch of dedicated chip select pins that
the controller driver must manipulate as required?

If so, is spi_board_info.chip_select just an selection index used only
by the controller driver to tell it which dedicated pin to use?

>> It is clear in pxa2xx_spi.c 
>> that when a user supplied cs_control function is called, the
>> appropriate action defined in the function will take place.  However,
>> the null_cs_control routine in pxa2xx_spi.c, which is called if the
>> user does not specify a routine in struct pxa2xx_spi_chip.cs_control,
>> simply returns without calling any function defined in the SPI
>> framework.
> 
> I'd sure hope the null_cs routine is only used for dedicated
> busses ... it sure can't be correct when there are two or more
> devices on the bus.

Well, that is what I am trying to figure out.  If my above, newest
assumptions are correct, then I guess that for PXA, there is no other
way than struct pxa2xx_spi_chip.cs_control to specify which GPIO pin to
manipulate, as there are so many to choose from, and they might be
controlled by other drivers.

If there is hardware that has specific, dedicated pins for chip selects,
and those pins are always known to be under the sole control of the
controller driver, then I guess that would explain why
spi_board_info.chip_select is useful in those cases.

If the above is true, then it would certainly be an error to pass NULL
cs_control functions to pxa2xx_spi.c, if there is more than one chip on
the bus.

Sorry to go on about this, but I have been confused about this for a
while.  Maybe PXA was a degenerate example to start with.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
