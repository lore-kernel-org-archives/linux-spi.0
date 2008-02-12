From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: PXA270 SSPSFRM gates chip select ?
Date: Mon, 11 Feb 2008 22:24:40 -0500
Message-ID: <47B11178.6090904@whoi.edu>
References: <20080211174339.73ca7ed5.merrij3@rpi.edu>	<33e9dd1c0802111454k5deeaa38o9d21cee610b79da7@mail.gmail.com>
	<200802111851.10155.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200802111851.10155.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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
> On Monday 11 February 2008, Zik Saleeba wrote:
>> While we're on the subject of the pxa2xx_spi driver, I've found that
>> it has incredibly slow throughput. The problem appears to be related to
>> the use of a tasklet in pumping messages. The initial setup and
>> transfer is quick but then the tasklet is started and a context switch
>> causes terrible latency. It takes around a millisecond for the tasklet
>> to get control at which point the chip select is released and the SPI
>> bus is available for the next transfer. This means that running as
>> hard as it can the bus is idle 99% of the time. I've experimented with
>> removing the tasklet from the driver and it does improve the situation
>> markedly.
> 
> Got patch?  :)
> 
> - Dave

I thought it was generally considered good practice to separate 
interrupt service into a top-half that executes only the code required 
to satisfy the short-term hardware requirements, and a bottom-half that 
is executed in a tasklet and that executes all data related code that is 
not required to be executed immediately.  This separation allows 
interrupts to be re-enabled as quickly as possible so that interrupt 
latency for other parts of the kernel is not impacted any more than 
necessary.  Is this not still the practice in the modern kernel?

I assume that "removing the tasklet" means calling pump_transfers() 
directly from the interrupt service routines, rather than having the 
ISRs schedule a tasklet to make that call.  Right?

I have been working with this driver for a couple of years and have not 
noticed this problem, though I guess in my application it takes 3ms for 
DMA to load a 4096byte buffer, so I might not have noticed an overall 
effect.  However, during earlier work, 95% of the time I was able to 
service the DMA interrupt and set up the next DMA (requiring the tasklet 
to run) within the 366us that would have caused a hardware fifo overrun. 
  That would indicate that tasklet execution was occurring in far less 
than 1ms most of the time.  This is on a 400MHz PXA255.

The latency of tasklet service must depend on what else the processor is 
doing.  You might want to look at what else your system is doing, and 
whether there are any scheduling parameters that might make sense to 
adjust.  I believe tasklets will never run later than the next timer 
tick, which I believe is 1ms on most moder processors (but which can be 
changed).  Thus 1ms should be the maximum latency; I would expect better 
than 1ms most of the time.

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
