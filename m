From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: kernel-panic on pxa2xx_spi.c on pxa9xx cpu
 with dma enable
Date: Wed, 08 Apr 2009 11:19:57 -0400
Message-ID: <49DCC09D.1040701@whoi.edu>
References: <69f617130904042032o382f5084v4fe21884e2356c77@mail.gmail.com>	
	<49D8E537.1010307@whoi.edu>
	<69f617130904051922w72810b52v576546c10c069941@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: Mok Keith <ek9852-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <69f617130904051922w72810b52v576546c10c069941-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Sorry for the delayed response.

Mok Keith wrote:
> Hi Ned,
> 
>> Is your application using the SSP in some unusual way that allows the RX
>> FIFO to overrun?  I am not familiar with any PXA9xx chips.  What clock
>> speed are you using.  What timeout setting are you using?  Are you using
>> power management with suspend/resume?
> 
> No, it is not allow RX FIFO overrun.
> 
> Here is the settings in arch:
> static struct pxa2xx_spi_chip libertas_spi= {
>         .tx_threshold           = 7,
>         .rx_threshold           = 8,
>         .cs_control             = libertas_spi_cs,
>         .dma_burst_size         = 8,
>         .timeout                = 230,
> };

Keep in mind that threshold is measured in "registers", of which there
are 16 in the FIFO (at least on PXA2xx devices), regardless of
byte-width, while burst_size is measured in bytes.  So if you are doing
16 bits_per_word (below), then the threshold should be 8 with a matching
burst of 16; these values each equal 1/2 of the FIFO.  Also, matching
the tx and rx thresholds at 8 and 8 makes more sense to me, however...

In DMA mode, the burst is significant, while the thresholds are ignored
and computed from burst in set_dma_burst_and_threshold().  If the
requested burst is more than 1/2 the FIFO for a given bits/word, then it
is reduced accordingly before computing threshold.  If you give it burst
of 8 at 16bits/word, it will compute a matching rx_threshold of 4, and a
tx_threshold of 12 (not to be confused with the actual register values,
which are one less: 3 and 11).

Try setting dma_burst_size to 16.  That will compute tx and rx
thresholds of 8, representing half the FIFO.  That is the way I normally
use the driver.  If there is a bug in the computation of burst and
threshold, then this might change the behavior.

--

You did not show your values for struct pxa2xx_spi_master.  I assume you
have enable_dma = 1, in this structure.

> Here is the settings in driver:
>         spi->mode = SPI_MODE_0;
>         spi->max_speed_hz = 1000000; /* REVISIT max=50MHz */
>         spi->bits_per_word = 16;
>         ret = spi_setup(spi);
> 
> I set the speed to : "spi->max_speed_hz = 1000000;" only, should be very low.
> No power management has been enable, it just happen at the very
> beginning during firmware download to chip.
> I got a hint that if I enlarge the timeout to 1000, panic will not
> happen and FIFO overrun
> will not happen. But the chip just cannot run after firmware
> downloaded. (It is okay in pure PIO mode).

Timeout is an important setting.  It is used to clean up any trailing
bytes at the end of a transfer that were not handled by DMA (due to
transfer length not being divisible by burst-size, or whatever other
cause).  If the timeout is too short, so that the timeout occurs between
words, then spurious interrupts will be fielded and ignored; because you
have 16bits/word at 1MHz, = 16us, this might be happening if you have a
short timeout.  If the timeout is too long, you waste time at the end of
any transfer with trailing bytes.

The difficult issue with the timeout is that it is not specified what
clock is counted within the chip to generate the timeout.   That may
seem strange, but the developer's manuals for the PXA255 and PXA270 say
that the clock used for timing is the "peripheral clock" but never say
what that clock is.  On the PXA255, running at 400MHz, I carefully
measured the clock (using long timeouts) to be 99.5MHz, which is
run-clock/4.  I have no idea what clock is used on a PXA3xx or PXA9xx.
At 99.5MHz, the default timeout setting of 1000 results in a 10usec
timeout, which is shorter than the time between your arriving 16-bit
words.  If you really use a value of 230, and *if* the PXA9xx uses a
similar clock to count from, then your timeout is only 2.3usec.  You
probably want to use a value of at least 10,000.

I have no theory about why timeout interrupts might contribute to
receiver FIFO overruns in DMA mode, however.

>> I would bet that the fundamental cause of your problem is the FIFO
>> overrun.  With some more information about your setup and use of
>> pxa2xx_spi, I might be able to provide more clues.  I would hesitate to
>> simply patch the above assignments without first understanding why
>> pump_transfers() is being executed out of sequence.
> 
> I agree, it is meaningless to just add a null pointer checking without
> knowning the execution sequence that leads to the problem.
> 
> Thanks,
> Keith
> 
> 


-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


------------------------------------------------------------------------------
This SF.net email is sponsored by:
High Quality Requirements in a Collaborative Environment.
Download a free trial of Rational Requirements Composer Now!
http://p.sf.net/sfu/www-ibm-com
