From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: SPI Framework chip select
Date: Fri, 29 Feb 2008 17:30:43 -0500
Message-ID: <47C88793.1050205@whoi.edu>
References: <47C85451.1030809@whoi.edu>
	<200802291204.33911.david-b@pacbell.net>
	<47C870D5.7000109@whoi.edu>
	<200802291338.55149.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200802291338.55149.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
>> David Brownell wrote:
>>> On Friday 29 February 2008, Ned Forrester wrote:
>
> The spi_board_info is used only to create a spi_device.
> 
> A SPI master controller is responsible for managing the
> spi_device.chip_select when it starts to perform the
> spi_message interactions with a given spi_device.

Oops, I forgot to distinguish between spi_board_info (used once) and
spi_device (used always).  Understood.

>> Does some hardware provide a bunch of dedicated chip select pins that
>> the controller driver must manipulate as required?
> 
> Yes.  And in PXA those chipselects are normally implemented
> using GPIO lines.

OK, this is the missing link that I never realized before.  I could
never figure out how a master driver could know what to do with a chip
select index, having no other clues.  I did not know that some hardware
has multiple dedicated CS pins.  Understood now.

>> If so, is spi_board_info.chip_select just an selection index used only
>> by the controller driver to tell it which dedicated pin to use?
> 
> Well, spi_device.chip_select ... but otherwise, yes.

Right.  Got it, I mixed up spi_board_info and spi_device again.

>> If there is hardware that has specific, dedicated pins for chip selects,
>> and those pins are always known to be under the sole control of the
>> controller driver, then I guess that would explain why
>> spi_board_info.chip_select is useful in those cases.
> 
> The chipselect number is always useful when the SPI bus has more
> than one slave; it's how the slaves are distinguished.

Ahh... Here is a place where pxa2xx-spi departs from the SPI framework
by choice.  That driver never uses spi_device.chip_select because each
chip supplies its own private struct pxa2xx_spi_chip.cs_control at board
setup time, passed as struct spi_board_info.controller_data, registered
with spi_register_board_info(), and retrieved by pxa2xx_spi.c using
spi->controller_data.  I gather you can register one of these for each
chip attached to the spi bus.

Thus the driver gets the cs_control function attached to each
spi_device.controller_data.  This data can be manipulated by the
protocol driver, if needed, to adjust the various private device
parameters in that structure, which could include cs_control().  The
driver retrieves this information from spi_device (actually from a
private structure attached to spi_device.controller_state and
initialized in setup()) each time a message is processed.

[It makes my head hurt to trace this out :-) ]

Because each chip needs its own, unique cs_control() function, and this
function pointer is available at message time, there is no need for
pxa2xx_spi.c to use the spi_device.chip_select field to distinguish the
CS functions.

I suppose that it could alternatively been implemented by storing the
cs_control pointers in an array during setup(), and then using the index
in spi_device.chip_select to access the various functions.  Either way
seems to work.

Thanks for clearing this up.  I understand now.

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
