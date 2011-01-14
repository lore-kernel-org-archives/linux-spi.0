From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: Embedded system control loops and reading from daisy-chained ADCs
Date: Thu, 13 Jan 2011 23:43:44 -0500
Message-ID: <4D2FD480.4020001@whoi.edu>
References: <4D2DDA9E.4090504@usask.ca> <4D2E646E.40505@whoi.edu>
	<4D2F219A.1090601@usask.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Nicholas Kinar <n.kinar-/KKvz3x1pcI@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4D2F219A.1090601-/KKvz3x1pcI@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 01/13/2011 11:00 AM, Nicholas Kinar wrote:
> On 12/01/2011 8:33 PM, Ned Forrester wrote:
>> I would be doubtful of guaranteeing 1ms response time, more from the
>> standpoint of interrupt and process latency, than from the speed and
>> timing of the SPI.  I have an application running on a 400MHz PXA255
>> that streams much more data than you have, but the key is streaming:
>> many ADCs are sending continuous data that are received by hardware
>> chained DMA buffers.  You have to interact with every sample to do the
>> comparison.  I'm not familiar with the processor you are using; perhaps
>> it is faster.
> Ned, thank you very much for your response; this is greatly 
> appreciated.  Now suppose that the entire control loop is to be 
> implemented inside of the kernel driver.  Might this help to reduce 
> latency?  

That would help, but I measured interrupt latencies of 100-600usec 
(200us typical) on the PXA255, with occasional longer delays.  That 
was with the network driver busy also.  

> If I am not mistaken, the AT91SAM9RL processor can be clocked 
> at a speed of no more than ~200 MHz, so I think that it is not as quick 
> as the one that you are using.  Would writing an SPI kernel driver help 
> to reduce latency rather than doing this all in userspace?  

Yes, but the kernel driver is still scheduled in response to an interrupt.

> If I have 
> the trigger pin of the daisy-chained ADCs tied to one of the ARM 
> processor's pulse width modulator (PWM) pins, might I be able to trigger 
> a series of samples with PWM, and then read the data over SPI?  I think 
> that a timer would be required, but how would I set up an interrupt to 
> read from SPI once the conversion has been triggered?  I would also have 
> to wait a predetermined time after triggering the conversion to be able 
> to read data from the ADCs.

If the timer controls the period and pulse width of the trigger, you 
program the trailing edge for the correct acquisition delay, and use 
the trailing edge to generate the interrupt for the driver.  
Alternatively, you could interrupt on the leading edge and then loop 
until the trailing edge (reading a GPIO pin); that would help overlap 
some of the interrupt latency.  This latter idea is only acceptable if 
the acquisition time is short, or if the processor is not busy and 
thus you don't mind generating increased latency for other interrupts 
(normally not a good idea).  

> Can an SPI kernel driver read a (16-bit)(5) = 80-bit data stream without 
> having the chip select pin go high after 16 or more bits are 
> transferred?  

It's been a while since I worked on my driver.  I recall that its 
maximum word size was 32-bits.  I don't recall if there is anything in 
the SPI core that limits that, or if it is simply a driver limit.  If 
the latter, you can write a driver to do anything you want.  

> I understand that the AT91SAM9RL has DMA as well, so would 
> it be possible to read the 80-bit data stream over SPI and then stuff 
> the data in memory?  Is there any example code available for this DMA 
> application?

I see you are not as far along as I thought.  If you need to learn how 
to write a device driver and what tools are available within the 
kernel, then I recommend "Linux Device Drivers" by Jonathan Corbet, 
Alessandro Rubini, and Greg Kroah-Hartman and published by O'Reilly.  
The third edition is available here: http://lwn.net/Kernel/LDD3/ or 
here: http://oreilly.com/ 

> Now suppose that I choose to not interact with each sample, and the data 
> is simply streamed into memory using DMA.  Does this make my application 
> easier?  The next thing that I am concerned about is being able to 
> toggle the port pin at a rate of 1 kHz to trigger each sample.  What if 
> I am to reduce the sampling rate to 500 Hz or 100 Hz?

Obviously the slower the easier, but I see no reason not to continue 
with the timer approach in this case.  Obviously streaming is easier, 
because the processor can read larger chunks of data and thus have 
longer time between required service.  You will probably want to find 
example code for your processor.  Start by looking at the existing 
kernel drivers: 
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=tree;f=drivers/spi;h=192788cd5a5b1ffd3bfb587ac72bc101fa67ab2f;hb=HEAD
or where ever in the kernel tree the drivers for your architecture are 
located.  

>> One thing that might (or might not) help is to check the scheduler
>> resolution on your machine.  For the PXA255 the kernel defaults to 10ms
>> (CONFIG_HZ=100).  It may help to set that to 1000 (though it can be hard
>> to track down what file really sets that for the kernel, I found it in
>> arch/arm/Kconfig by searching for "HZ").  This may only help if there is
>> a user-space portion of your code.
> Could high resolution timers in kernel code help to reduce the latency?

Maybe, I don't recall if they are limited by the CONFIG_HZ value or 
something else.  

>> If you can't get it to work in software, it is likely possible to add a
>> CPLD to do the job of collecting the data, making the comparison and
>> loading the DAC.  Xilinx has the Coolrunner series that draws very
>> little (CMOS) power at low clock rates; unfortunately, they don't seem
>> to have chips with lots of gates and few pins.  Atmel has a similar low
>> power series that is available with plenty of cells in smaller packages.
>>   I'm assuming that you still have control over the hardware that might
>> be added between the CPU and the ADCs/DAC.
>>
> 
> Thank you very much for these suggestions!  At this time I am engaged in 
> the process of designing and laying out the circuit boards for this 
> system.  The CPU is on one PCB, but the ADCs (and other supporting 
> analog circuitry) is on another PCB.  Both PCBs are linked together by 
> an FPC/FFC jumper cable.  There are SPI, I2C, and serial (RX/TX) buses 
> shared across this cable.

It sounds like you have a lot of options.  Good luck.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab       508-289-2226 Office / 774-392-5352 Cell
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/
http://www.whoi.edu/page.do?pid=29856
http://www.whoi.edu/hpb/Site.do?id=1532


------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
