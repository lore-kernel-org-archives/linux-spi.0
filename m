From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Linux SPI slave support
Date: Tue, 17 Jul 2012 14:30:57 +0530
Message-ID: <CAM=Q2csOFt5hnvS-Ah8ghrSympgkfv0zAYgb7sMu_GacWkLCBA@mail.gmail.com>
References: <201206300515.41575.marex@denx.de>
	<201207160226.19409.marex@denx.de>
	<CAM=Q2ctBCOtSkC-vK4+drsuAmEkk4e=Tk3ZQtZYfqqOejhS_xw@mail.gmail.com>
	<201207171052.49859.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <201207171052.49859.marex-ynQEQJNshbs@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jul 17, 2012 at 2:22 PM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
> Dear Shubhrajyoti Datta,
>
>> On Mon, Jul 16, 2012 at 5:56 AM, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org> wrote:
>> > Dear Shubhrajyoti Datta,
[..]
>> The other option is to have something like a gpio  for synchronization.
>
> Synchronisation of what exactly? With my hardware (that doesn't exist yet I
> guess), the idea is to simply cross-connect the MISO/MOSI pins and connect the
> CLK signal. Is that possible btw?

IIUC , the clock is to be driven by master. The slave gets the clock.
Master knows when to start and stop the transaction.

However for the slave the options are to
1) Keep listening always.
2) Use something to syncronize( I may have used the word loosely)
master and slave.
So that it doesnt have to listen always.

Btw it is just a suggestion. I am not opposed to any other implementation.

Thanks and Regards,

>
> Thanks!
>

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
