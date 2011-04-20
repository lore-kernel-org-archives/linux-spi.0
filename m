From: Niclas Karlsson <niclas.karlsson-h3aQMNCITb4@public.gmane.org>
Subject: Re: Getting alot of zero values from ads7846 using atmel_spi
Date: Wed, 20 Apr 2011 16:34:57 +0200
Message-ID: <1303310097.19857.123.camel@SESTOWS194>
References: <1299577496.13486.13.camel@SESTOWS194>
	<20110310144145.GB4093601@jupiter.n2.diac24.net>
	<1303118512.19857.105.camel@SESTOWS194>
	<4DADF35B.2000600@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Kenneth Heitke <kheitke-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4DADF35B.2000600-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

tis 2011-04-19 klockan 14:40 -0600 skrev Kenneth Heitke:
> On 04/18/2011 03:21 AM, Niclas Karlsson wrote:
> > tor 2011-03-10 klockan 15:41 +0100 skrev David Lamparter:
> >> On Tue, Mar 08, 2011 at 10:44:56AM +0100, Niclas Karlsson wrote:
> >>> Do anyone know why I read so many zeroes?
> >>
> >> You're probably reading values faster than the chip supports. Check the
> >> chip documentation for a maximum readout frequency or a ready flag.
> >>> I have made some printk in ads7846.c to trace the problem. It seemed to
> >>> read more correct values when I added the printks.
> >>
> >> A printk takes quite some time on an ARM like yours. The throttle makes
> >> it work...
> >
> > I've made som further investigations. The atmel_spi.c driver utilize PDC
> > (Peripheral DMA Controller) and when I was tracing the problem I
> > discovered that the interrupt indicating the PDC has written the data to
> > memory is fired before the data actually is written to memory. If a
> > small delay is added after the interrupt (like a trace printk("The value
> > is\n")) the PDC have enough time to write the data to the memory and I
> > get correct values from the ADC connected to the SPI.
> > Thoughts how to solve this?
> 
> Is it really the interrupt firing early or is it possible that you are 
> still reading cached data.  I'm not familiar with the device or driver 
> so I'm just throwing that out as a possibility.
I have thought about it but I don't know how to test it. I disabled the
 whole d-cache in the kernel configuration, but everything ran so slow
that I don't know if it was the disabled of d-cache or if the timing
became so much different.
If I want to bring the d-cache up to sync, how do I do that?
Is it possible to allocate memory which never will be stored in d-cache?
/Niclas
> >>
> >>
> >> David
> >>
> >> P.S.: you're lucky to not get crap values - seems they got the chip
> >> design right...
> >>
> > /Niclas
> > ------------------------------------------------------------------------------
> > Benefiting from Server Virtualization: Beyond Initial Workload
> > Consolidation -- Increasing the use of server virtualization is a top
> > priority.Virtualization can reduce costs, simplify management, and improve
> > application availability and disaster protection. Learn more about boosting
> > the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
> > _______________________________________________
> > spi-devel-general mailing list
> > spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/spi-devel-general
> >
> 
> 


------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
