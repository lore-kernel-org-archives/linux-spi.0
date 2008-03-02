From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: SPI Framework chip select
Date: Sat, 01 Mar 2008 20:14:06 -0500
Message-ID: <47C9FF5E.5060503@whoi.edu>
References: <47C85451.1030809@whoi.edu>
	<200802291338.55149.david-b@pacbell.net>
	<47C88793.1050205@whoi.edu>
	<200803011237.51349.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200803011237.51349.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
> 
>>> The chipselect number is always useful when the SPI bus has more
>>> than one slave; it's how the slaves are distinguished.
>> Ahh... Here is a place where pxa2xx-spi departs from the SPI framework
>> by choice.  That driver never uses spi_device.chip_select
> 
> Not directly.  Indirectly, since each chip_select is associated
> with a unique pxa2xx_spi_chip.cs_control().  The chipselect number
> (and signal) still distinguishes chips from each other.

Maybe we're just discussing semantics, but the last sentence does not
apply to this driver.  pxa2xx_spi.c never references the field
spi_device.chip_select.  The string "chip_select" appears nowhere in the
code.  You can assign spi_device.chip_select=0 for all chips, and as
long as you supply a unique
spi_device->controller_data->pxa2xx_spi_chip.cs_control for each chip,
chip select will work as intended.

So in the sense that I mean, spi_device.chip_select field is unused; it
does not need to be unique between chips.  Yes, of course there have to
be unique spi_device structures for each chip, and through a driver
private means (spi_device.controller_data) the chip select mechanism for
each chip becomes known to the driver.

It was this lack of example for any use of spi_device.chip_select in
pxa2xx_spi.c that led to my confusion about how spi_device.chip_select
was supposed to be used.

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
