From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: Status of Linux SPI slave
Date: Tue, 16 Oct 2007 13:28:12 -0400
Message-ID: <4714F4AC.4020402@whoi.edu>
References: <014301c80fff$ceacd710$6a8918ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Girish <girishsg-l0cyMroinI0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <014301c80fff$ceacd710$6a8918ac-tAZopdYwApTQT0dZR+AlfA@public.gmane.org>
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

Girish wrote:
> =

>> -----Original Message-----
 >> From: nforrester-/d+BM93fTQY@public.gmane.org
>> Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
>> Subject: Re: [spi-devel-general] Status of Linux SPI slave
>>
>> Roger Fr=F8ysaa wrote:
>>> Hi.
>>>
>> For example, I have an SPI master device that streams data to a Linux
>> processor at 11Mbit/sec, but never expects any response from the
>> processor; this data is written over the 100baseT network to an NFS
>> file system at an effective 5GBytes/hour.  To make it work, I have
>> heavily modified the pxa2xx-spi driver for the target Gumstix system so
>> that it can accept data driven by an external clock, and so that it uses
>> a queue of DMA descriptors to prevent interrupt latency from limiting
>> service of the receive FIFO.  I did not have to modify a single line of
>> code anywhere else in the SPI framework.  All other parts of the SPI
>> framework, as well as my protocol driver and user-space code, still
>> operate as if they were part of an SPI master; they just keep full a
>> queue of SPI messages that request buffers to be filled by SPI reads.
>> Basically, this is a VERY limited slave function, where the Linux system
>> is not in control of the timing, but also there is never any sort of
>> query/response between the master and slave.
> =

> Well, now I get the minimal use of slave side transfer. As David suggested
> of having spi_slave struct wrapping the hardware, have you thought of
> something like that and how would your existing pxa2xx-spi driver will be
> impacted?

I have not considered how to generalize slave functionality in Linux.  I =

did not feel that I needed to go that far to implement my project.  My =

goal was to make changes that would have some chance of being accepted =

into the kernel distribution, so I avoided upsetting anything I did not =

need to.  In the end, what I have in pxa2xx-spi is still a major =

departure from its base functionality, and full use of the new features =

increases the memory footprint of the driver (for buffer space), so I am =

doubtful that Steven Street (the pxa2xx-spi author) and David will be =

interested in propagating it (I have not pursued this because the driver =

is working but it is not ready to share, yet).  I probably would have =

spent much less time on the project if I had simply written a dedicated =

driver for my data stream, rather than keeping all the master capability =

of the original, as I have actually done.

As for the concept of struct spi_slave, I haven't heard enough of this =

discussion yet to have a clear image of how it might differ from =

spi_master.  Thus I don't know how my driver would be impacted.  I don't =

have a very clear view of all the ways that SPI must operate, because I =

have only worked with a few SPI devices in my career.

It seems that a slave implementation would either have to respond in a =

timely manner to an interrupt; or, there would have to be messages =

perpetually queued for service in case data arrived at the SPI port, as =

David suggested, and as my system is implemented.  The problem with =

interrupts, is that they are comparatively slow, and would probably work =

only for SPI devices with slow clocks (often an SPI master expects an =

immediate response to an inquiry).  The problem with queued messages is =

that they have to anticipate all aspects of the next transfer that the =

master will control; unless you have prior knowledge of the sequence of =

actions that the master will take, it is impossible to predict what data =

to make ready for transmission.  My application works on the queue =

principal exactly because I *can* predict what the master's actions will =

be: it will transmit another block of data and the master will only =

write and never read.

I can imagine how an SPI slave could be programmed into a =

micro-processor as a dedicated slave controller.  In this case, the =

processor can spin, waiting for SPI activity.  When activity occurs, the =

processor probably has at least one SPI clock cycle to compute the =

required response to the master's request.  On a multi-tasking system, =

like Linux, the processor is likely to be doing something else when the =

master makes a request.  I don't see how the processor can respond =

quickly enough to satisfy a non-deterministic request.  Interrupt =

latency is at least 10s to 100s of microseconds, and I have seen =

milliseconds and surprisingly nearly a full second on my PXA255 =

processor (I suspect the latter is due to a bug someplace, it happened =

during a massive network transfer, but I report what I see).

David has also raised the issue of how a Linux SPI slave would deal with =

chip select from a master.  If the Linux system is only one of several =

slaves on the SPI bus, then it must not drive the bus, and it must not =

run the receiver if it is not selected.  It seems that only a hardware =

solution can work to enable/disable the transmitter/receiver on changes =

in chip select.  I don't know if other processors implement similar =

mechanisms, but in Motorola SPI mode (the mode normally supported by =

pxa2xx-spi) the PXA255 uses the FRAME pin as the chip select input.  The =

port can be configured so that the TX pin is only asserted when FRAME is =

asserted (low).  I think, but don't explicitly see in the spec, that the =

receiver will also be enabled only when FRAME is asserted; this is =

important or else queued messages would be consumed, and/or interrupts =

asserted, even when the Linux slave is not chip selected and the clock =

and data are intended for another device on the bus.

I am not intimately familiar with SPI protocols, but I don't think that =

there is any mechanism for allowing multiple masters on a bus, except =

with some external arbitration, not defined in the SPI protocol.  (This =

is unlike the I2C bus, where there is a defined mechanism for =

arbitrating access by multiple masters.) Therefore, one might presume =

that if the Linux system will operate in slave mode, then it will only =

operate that way, and thus it will not be restrictive to assign a =

single, dedicated pin (SSPSFRM, FRAME) as the chip select input from a =

single external master.

> And thanks for starting this thread:).
> Actually, in my case I had to modify controller driver to support SPI in
> master and slave mode as well, with standard transfers (half/full duplex
> communication).

Just to be clear, it was Roger who started the thread, and I replied =

with a description of my limited slave application.  I think David =

accurately summarized my type of application as: "the current "minimal =

functionality" example is sample data streaming ... where there's always =

a message queue, and where the channel is never deselected."

-- =

Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=3D7212
http://www.whoi.edu/hpb/Site.do?id=3D1532
http://www.whoi.edu/page.do?pid=3D10079


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
