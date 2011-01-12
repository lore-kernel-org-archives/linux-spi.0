From: Nicholas Kinar <n.kinar-/KKvz3x1pcI@public.gmane.org>
Subject: Embedded system control loops and reading from daisy-chained ADCs
Date: Wed, 12 Jan 2011 10:45:18 -0600
Message-ID: <4D2DDA9E.4090504@usask.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello,

I am in the process of designing an embedded system that needs to read 
values over SPI from 5 daisy-chained ADCs.  The ADCs are the AD7685 from 
Analog Devices 
(http://www.analog.com/en/analog-to-digital-converters/ad-converters/ad7685/products/product.html).  
These are 16-bit ADC slave devices that are read over a SPI bus.  I 
would like to read these devices at a rate of 1 kHz.  I am using the ARM 
AT91SAM9RL processor.  This processor will run the Linux kernel.

To read values from these ADCs, the processor must first toggle a port 
pin (CNV) to initiate a conversion.  The processor needs to toggle the 
port pin at a rate of 1 kHz, perhaps using a high-resolution timer.  
After every conversion, the processor needs to lower a chip select pin 
and read data consisting of a (16 bit)(5) =  80-bit word.  The chip 
select pin then goes high.  I assume that the daisy-chained ADCs would 
appear to the kernel driver as a single SPI slave with MISO, MOSI, and 
\CS pins.  The only difference is the CNV pin that is needed to initiate 
a conversion.

After every conversion, the kernel driver needs to make a comparison (is 
the value from each ADC above or below a certain value).  The kernel 
driver needs to then select an SPI slave DAC (AD5621) or I2C slave DAC 
(AD5622) and update the voltage output of the DAC.

I need to read data from the ADC slaves at a rate of 1 kHz.  What is the 
best way to do this without introducing too much jitter, and is it 
possible to do this all with one kernel driver?

Nicholas


------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
