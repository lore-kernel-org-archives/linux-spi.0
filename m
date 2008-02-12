From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: PXA270 SSPSFRM gates chip select ?
Date: Mon, 11 Feb 2008 23:08:54 -0500
Message-ID: <47B11BD6.8060502@whoi.edu>
References: <20080211174339.73ca7ed5.merrij3@rpi.edu>
	<47B0D9A4.6080104@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	"J. Scott Merritt" <merrij3-IL7dBOYR4Vg@public.gmane.org>, stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org
To: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <47B0D9A4.6080104-/d+BM93fTQY@public.gmane.org>
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

Ned Forrester wrote:
> J. Scott Merritt wrote:
>> Reposted from linux-arm-kernel mailing list ... at the suggestion
>> of David Brownell.
>>
>> Using pxa2xx_spi from Kernel 2.6.21.  PXA270 is SSP Master in
>> SPI_MODE_3 (SPO=1, SPH=1) with internal clock and GPIO's used as
>> external chip selects.
>>
>> On the very first message after boot, I am receiving an extra clock
>> pulse at the slave device (causing the whole message to be "shifted").
>>
>> It appears that on the first message, the Chip Select is activated
>> before the SPO=1/SPH=1 is fully established in the PXA's SSP hardware,
>> resulting in an extra, positive-going transition of SSPSCLK as it
>> attempts to establish the proper (high) clock level for the SPH=1
>> setting.
>>
>> Testing was performed on Kernal 2.6.21, but it appears that 2.6.24
>> also performs the chip select call before updating SSCR0 & SSCR1.
>> Slave device is NXP LPC2366.
>>
>> I have tried setting the "default" in pxa2xx_spi.c to SPO=1, SPH=1;
>> but still have the clock riding low before the first chip select.
> 
> I have worked with this driver extensively, so I took a look.  It seems 
> that you are right.  The these bits are set at the end of 
> pump_transfers(), based on internal values that are configured in 
> setup().  The SSCR1 register is initialized with default data in 
> probe(), but this default value is not influenced from any other 
> configuration data.
> 
> SSCR1 contains the interrupt enables and dma service request enables. 
> As such, it is set as the very last task in pump_transfers(), after all 
> other setup, including the call to cs_control().  If I recall correctly, 
> in some modes of operation, it is important that this register not be 
> written when activity is already in progress, and so it is only set if 
> changed at the end of pump_transfers().  It appears that there needs to 
> be a check for changed clock mode in pump_transfers(), prior to setting 
> chip select.  It is important to do this carefully, so as not to 
> interfere with on-going operations.
> 
> I will take a closer look at this.  I know that normally each of these 
> SPI transfers is independent, but I worked with Stephen Street (the 
> maintainer) over a year ago to prep this driver for some external master 
> data steaming that I needed, and I know we worked in this area of the 
> driver.  It is possible that we messed this up, as I don't use chip select.

I have looked some more, and I see what happened.  In the fall of 2006 I 
worked with Stephen to fix some bugs, and to implement a few changes 
that would facilitate chaining of transfers and messages when no 
configuration changes are required between transfers.  In the process, 
we removed the function restore_state(), which was called only from 
pump_messages() and which stopped the SSP and set up the SSCRx 
registers.  All of the SSCRx changes were reduced to a single, final 
code segment at the end of pump_transfers, so as to create a 
maintainable place to manage the "set only if changed" function required 
by chaining of transfers.  However, removing the call in pump_messages() 
has the side effect of not setting up SSCCRx until *after* any CS 
change, and thus a configuration change will not occur until CS has been 
set on the first transfer that uses that config change.  These code 
changes were implemented by a patch released by Stephen on 12/7/06 (I'm 
not sure which kernel release it first appeared in).

I will try to think about a patch tomorrow.  I volunteer to be involved 
in this so that it gets fixed without breaking the other things I need 
to do.  Hopefully Stephen will be available to review any patches.

>> ... David Brownell responds:
>>
>> Actually, the SPI_CPOL mode bit controls the clock polarity
>> before the chip select coes active:  CPOL=0 should mean it's
>> forced low (if it isn't already low).
>>
>> So if that driver is doing chipselect *then* clock setup,
>> it's doing the wrong thing.  A patch would be appreciated...
>>
>> ...
>> Thanks, Scott.
>>
>> -------------------------------------------------------------------------
>> This SF.net email is sponsored by: Microsoft
>> Defy all challenges. Microsoft(R) Visual Studio 2008.
>> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
>> _______________________________________________
>> spi-devel-general mailing list
>> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
>>
>>
> 
> 


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
