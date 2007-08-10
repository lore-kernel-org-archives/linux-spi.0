From: llandre <r&d2-4VKA1VU3ct/j+vYz1yj4TQ@public.gmane.org>
Subject: Re: spi_async and heavy CPU occupation by
	ksoftirqd
Date: Fri, 10 Aug 2007 10:52:02 +0200
Message-ID: <46BC2732.5070504@dave-tech.it>
References: <46B97D01.5000208@dave-tech.it>
	<200708080927.36737.david-b@pacbell.net>
	<46BB1F10.3030608@dave-tech.it>
	<200708090823.29708.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrea Paterniani <a.paterniani-03BXCEkGbFHYGGNLXY5/rw@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200708090823.29708.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

> That seems to be the most precise tool you have, unless you
> have access to the JTAG-style hardware tools giving access
> to the on-chip instruction trace buffers found in many ARMs.
Unfortunatley trace port is not available so I have to use the old 
fashioned debug pin technique.

>> or does the kernel provides some  
>> tools to do that? Could oprofile come to help?
> 
> Statistical profiling probably wouldn't help.  I'm not sure that
> anything like gprof is working in the kernel.  Folk that I know
> have done that level analysis tend to rely on hardware trace tools.
I see.

>>> I'd expect that using spi_sync() wouldn't save much, but it might
>>> be worth verifying that.
>> Initially my driver used spi_sync. When I realized the huge CPU 
>> occupation I modified it in order to use spi_async instead but, again, 
>> nothing changed.
> 
> And that should have been a HUGE clue that the way you were calling
> it wasn't a factor at all.  
I moved the set/clear pin functions inside the iMXL master driver and I 
found the problem is at line 804 inside the interrupt handler:

	qt510_debug_pin(1);
	while ((read(drv_data) == 0) && limit--);
	qt510_debug_pin(0);

Usually the high pulse lasts about 10ms. Occasionally (about 1 time out 
of 3) it lasts about 300 ms ! That would explain the ksoftirqd abnormal 
CPU occupation.
I hope Andrea can come to help.



-- 
llandre

DAVE Electronics System House - R&D Department
web:   http://www.dave-tech.it
email: r&d2-4VKA1VU3ct/j+vYz1yj4TQ@public.gmane.org

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
