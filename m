From: Nicholas Kinar <n.kinar-/KKvz3x1pcI@public.gmane.org>
Subject: Re: Embedded system control loops and reading from daisy-chained ADCs
Date: Thu, 13 Jan 2011 23:01:41 -0600
Message-ID: <4D2FD8B5.5090701@usask.ca>
References: <4D2DDA9E.4090504@usask.ca> <4D2E646E.40505@whoi.edu>
	<4D2F219A.1090601@usask.ca> <4D2FD480.4020001@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <4D2FD480.4020001-/d+BM93fTQY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


> That would help, but I measured interrupt latencies of 100-600usec
> (200us typical) on the PXA255, with occasional longer delays.  That
> was with the network driver busy also.
Thanks for confirming this, Ned.

>> If I have
>> the trigger pin of the daisy-chained ADCs tied to one of the ARM
>> processor's pulse width modulator (PWM) pins, might I be able to trigger
>> a series of samples with PWM, and then read the data over SPI?  I think
>> that a timer would be required, but how would I set up an interrupt to
>> read from SPI once the conversion has been triggered?  I would also have
>> to wait a predetermined time after triggering the conversion to be able
>> to read data from the ADCs.
> If the timer controls the period and pulse width of the trigger, you
> program the trailing edge for the correct acquisition delay, and use
> the trailing edge to generate the interrupt for the driver.
> Alternatively, you could interrupt on the leading edge and then loop
> until the trailing edge (reading a GPIO pin); that would help overlap
> some of the interrupt latency.  This latter idea is only acceptable if
> the acquisition time is short, or if the processor is not busy and
> thus you don't mind generating increased latency for other interrupts
> (normally not a good idea).
Okay, I think that I understand.

> It's been a while since I worked on my driver.  I recall that its
> maximum word size was 32-bits.  I don't recall if there is anything in
> the SPI core that limits that, or if it is simply a driver limit.  If
> the latter, you can write a driver to do anything you want.
I'm not familiar with the SPI core either, and I would also wonder if 
the word size is limited for the ARM architecture.

>
> It sounds like you have a lot of options. Good luck.
>

Yes - I am designing, building and testing an embedded system for my own 
research.  Once again, thank you for your help!

Nicholas




------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
