From: Kenneth Heitke <kheitke-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: Getting alot of zero values from ads7846 using atmel_spi
Date: Tue, 19 Apr 2011 14:40:59 -0600
Message-ID: <4DADF35B.2000600@codeaurora.org>
References: <1299577496.13486.13.camel@SESTOWS194>	<20110310144145.GB4093601@jupiter.n2.diac24.net>
	<1303118512.19857.105.camel@SESTOWS194>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Lamparter <equinox-cEeocvCgqOOsTnJN9+BGXg@public.gmane.org>
To: Niclas Karlsson <Niclas.Karlsson-AM1FMPraTHU@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1303118512.19857.105.camel@SESTOWS194>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 04/18/2011 03:21 AM, Niclas Karlsson wrote:
> tor 2011-03-10 klockan 15:41 +0100 skrev David Lamparter:
>> On Tue, Mar 08, 2011 at 10:44:56AM +0100, Niclas Karlsson wrote:
>>> Do anyone know why I read so many zeroes?
>>
>> You're probably reading values faster than the chip supports. Check the
>> chip documentation for a maximum readout frequency or a ready flag.
>>> I have made some printk in ads7846.c to trace the problem. It seemed to
>>> read more correct values when I added the printks.
>>
>> A printk takes quite some time on an ARM like yours. The throttle makes
>> it work...
>
> I've made som further investigations. The atmel_spi.c driver utilize PDC
> (Peripheral DMA Controller) and when I was tracing the problem I
> discovered that the interrupt indicating the PDC has written the data to
> memory is fired before the data actually is written to memory. If a
> small delay is added after the interrupt (like a trace printk("The value
> is\n")) the PDC have enough time to write the data to the memory and I
> get correct values from the ADC connected to the SPI.
> Thoughts how to solve this?

Is it really the interrupt firing early or is it possible that you are 
still reading cached data.  I'm not familiar with the device or driver 
so I'm just throwing that out as a possibility.

>>
>>
>> David
>>
>> P.S.: you're lucky to not get crap values - seems they got the chip
>> design right...
>>
> /Niclas
> ------------------------------------------------------------------------------
> Benefiting from Server Virtualization: Beyond Initial Workload
> Consolidation -- Increasing the use of server virtualization is a top
> priority.Virtualization can reduce costs, simplify management, and improve
> application availability and disaster protection. Learn more about boosting
> the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
>


-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
