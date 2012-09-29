From: Nuutti Kotivuori <naked-X3B1VOXEql0@public.gmane.org>
Subject: Re: Continuous streaming SPI transfer
Date: Sat, 29 Sep 2012 23:20:37 +0300
Message-ID: <87txugbmy2.fsf@kiiro.xen-host.de>
References: <87zk4bazje.fsf@kiiro.xen-host.de> <5064FDB1.9060304@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <5064FDB1.9060304-/d+BM93fTQY@public.gmane.org> (Ned Forrester's message of "Thu, 27
	Sep 2012 21:30:25 -0400")
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org> writes:
> On 09/27/2012 06:09 PM, Nuutti Kotivuori wrote:
>> I would like to use SPI in a streaming fashion, with a transfer being
>> active all the time. This seems very difficult with the current kernel
>> drivers. I am mainly looking at the Raspberry Pi BCM2708 SPI driver, but
>> I have also tried to find similar features from other drivers.
>
> You don't say whether you mean to transfer into or out of the external
> device (or both). Nor do you say what clock rate you want to use (what's
> the average bit/byte rate?).

I mean to transfer both in and out, but the clock rate I need is not very
high, 100 kHz should be fine, 250 kHz should be plenty.

> I am not familiar with the hardware you want to use, but I have done
> this on a PXA255 processor, at 11Mbit/sec from the external device to
> the PXA processor.  For this I had to extensively modify the pxa2xx_spi
> controller driver (that was with kernel 2.6.20, I think the name has
> changed in recent kernels), and, of course, to write my own protocol
> driver (the glue between the kernel side of Clib and the controller
> driver).  I did not have to make any changes to the SPI core.
>
> NOTE WELL: Please don't ask for this code, I cannot share it.

That sounds like a *lot* of effort, something beyond what I'm willing to
put in.

> To overcome this problem, I ran the PXA processor as a slave, with the
> clocks supplied from external hardware.  The problem then becomes
> keeping the receive FIFO from overflowing.  That was solved by enabling
> chained DMA transfers (at enormous driver-writing expense; I'd never
> written a device driver before).

[...]

> I don't think you can achieve what you want without a dedicated
> effort, because the SPI model is not intended for this type of
> application.

I agree, this is so for your data rate. However, for my 250 kHz, things
are much simpler.

Because of my own investigations and your answer, I decided to forgo the
kernel route altogether. Instead, I used the bcm2835 library from
userspace as the peripherals are simply mapped to a fixed address space.

With this, my main loop is simply

  while (!exit) {
    uint32_t state = bcm2835_peri_read(spi_cs);
    if (state & BCM2835_SPI0_CS_RXF)
      fprintf(stderr, "RX FIFO full!\n");
    if (state & BCM2835_SPI0_CS_DONE)
      fprintf(stderr, "TX FIFO empty!\n");
    if (state & BCM2835_SPI0_CS_TXD)
      bcm2835_peri_write_nb(spi_fifo, producebyte());
    if (state & BCM2835_SPI0_CS_RXD)
      processbyte(bcm2835_peri_read_nb(spi_fifo));
    if (!(state & (BCM2835_SPI0_CS_TXD | BCM2835_SPI0_CS_RXD)))
      nanosleep(&loop_wait, NULL);
  }

To explain, I simply loop in a userspace (but realtime scheduled)
process, writing to the TX FIFO if the TX FIFO can accept more input and
reading from the RX FIFO if the RX FIFO has any bytes to read. If there
is neither, I sleep for 300 microseconds.

This piece of code can easily keep both RX and TX FIFOS well tended at
250kHz - and I managed to get it stable at even 2 MHz while testing. The
solution does not use interrupts for anything (as it can't), but since
the data rate is fixed a simple timer is not much worse. The 300
microsecond sleep version uses about 7% of the CPU, and that is easily
acceptable for me.

I see no fundamental reason why a similar mode of operation could not be
supported for /dev/spidev or inside the kernel - much more efficiently -
and I would very much like to see something like this implemented.

However, for my use case I have total control of the runtime environment
and I can easily make sure no other software touches the SPI or the pins
I need - and I stand to gain nothing by implementing this inside the
kernel - so I will stick with the userland mmap() /dev/mem hack for the
time being.

Thank you for the answer, it was very enlightening.

-- Naked

------------------------------------------------------------------------------
How fast is your code?
3 out of 4 devs don\\\'t know how their code performs in production.
Find out how slow your code is with AppDynamics Lite.
http://ad.doubleclick.net/clk;262219672;13503038;z?
http://info.appdynamics.com/FreeJavaPerformanceDownload.html
