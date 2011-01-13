From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: Embedded system control loops and reading from daisy-chained ADCs
Date: Wed, 12 Jan 2011 21:33:18 -0500
Message-ID: <4D2E646E.40505@whoi.edu>
References: <4D2DDA9E.4090504@usask.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Nicholas Kinar <n.kinar-/KKvz3x1pcI@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4D2DDA9E.4090504-/KKvz3x1pcI@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 01/12/2011 11:45 AM, Nicholas Kinar wrote:
> Hello,
> 
> I am in the process of designing an embedded system that needs to read 
> values over SPI from 5 daisy-chained ADCs.  The ADCs are the AD7685 from 
> Analog Devices 
> (http://www.analog.com/en/analog-to-digital-converters/ad-converters/ad7685/products/product.html).  
> These are 16-bit ADC slave devices that are read over a SPI bus.  I 
> would like to read these devices at a rate of 1 kHz.  I am using the ARM 
> AT91SAM9RL processor.  This processor will run the Linux kernel.
> 
> To read values from these ADCs, the processor must first toggle a port 
> pin (CNV) to initiate a conversion.  The processor needs to toggle the 
> port pin at a rate of 1 kHz, perhaps using a high-resolution timer.  
> After every conversion, the processor needs to lower a chip select pin 
> and read data consisting of a (16 bit)(5) =  80-bit word.  The chip 
> select pin then goes high.  I assume that the daisy-chained ADCs would 
> appear to the kernel driver as a single SPI slave with MISO, MOSI, and 
> \CS pins.  The only difference is the CNV pin that is needed to initiate 
> a conversion.
> 
> After every conversion, the kernel driver needs to make a comparison (is 
> the value from each ADC above or below a certain value).  The kernel 
> driver needs to then select an SPI slave DAC (AD5621) or I2C slave DAC 
> (AD5622) and update the voltage output of the DAC.
> 
> I need to read data from the ADC slaves at a rate of 1 kHz.  What is the 
> best way to do this without introducing too much jitter, and is it 
> possible to do this all with one kernel driver?

I would be doubtful of guaranteeing 1ms response time, more from the
standpoint of interrupt and process latency, than from the speed and
timing of the SPI.  I have an application running on a 400MHz PXA255
that streams much more data than you have, but the key is streaming:
many ADCs are sending continuous data that are received by hardware
chained DMA buffers.  You have to interact with every sample to do the
comparison.  I'm not familiar with the processor you are using; perhaps
it is faster.

One thing that might (or might not) help is to check the scheduler
resolution on your machine.  For the PXA255 the kernel defaults to 10ms
(CONFIG_HZ=100).  It may help to set that to 1000 (though it can be hard
to track down what file really sets that for the kernel, I found it in
arch/arm/Kconfig by searching for "HZ").  This may only help if there is
a user-space portion of your code.

If you can't get it to work in software, it is likely possible to add a
CPLD to do the job of collecting the data, making the comparison and
loading the DAC.  Xilinx has the Coolrunner series that draws very
little (CMOS) power at low clock rates; unfortunately, they don't seem
to have chips with lots of gates and few pins.  Atmel has a similar low
power series that is available with plenty of cells in smaller packages.
 I'm assuming that you still have control over the hardware that might
be added between the CPU and the ADCs/DAC.

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
