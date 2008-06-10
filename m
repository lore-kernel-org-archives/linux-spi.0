From: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] au1550-spi: proper platform driver
Date: Tue, 10 Jun 2008 14:19:52 +0200
Message-ID: <484E7168.3050200@gmail.com>
References: <20080610114602.6fb327df@nikitenko>
	<20080610100004.GA4637@roarinelk.homelinux.net>
	<484E61A4.9080707@gmail.com>
	<20080610112702.GB4637@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080610112702.GB4637-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
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

Manuel Lauss wrote:
> On Tue, Jun 10, 2008 at 01:12:36PM +0200, Jan Nikitenko wrote:
>> Manuel Lauss wrote:
>>> Hello Jan,
>>> On Tue, Jun 10, 2008 at 11:46:02AM +0200, Jan Nikitenko wrote:
>>>> From: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
>>>> Date: Sat, 7 Jun 2008 12:14:37 +0200
>>>> Subject: [PATCH] au1550_spi: proper platform device
>>>>
>>>> Remove the Au1550 resource table and instead extract MMIO/IRQ/DMA
>>>> resources from platform resource information like any well-behaved
>>>> platform driver.
>>>>
>>>> Signed-off-by: Manuel Lauss <mano-nEyxjcs6f3Vin2gBucwGBecsttgLyre6@public.gmane.org>
>>>> [jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org: fixed request_mem_region() call arg,
>>>>  removed ioremap of memio (kseg1) resources,
>>> Please leave it in.  Although it may seem pointless (now), ioremap()ing
>>> the physical base address will yield the KSEG1 address,  and as a nice
>>> side-effect /proc/iomem will also display the correct base address of the
>>> PSC.  (And to me the whole thing looks "cleaner" with it ;-) )
>> Having the ioremap() there, I got 0xc41da000 for 0xb1b00000 address of psc1 
>> and that did not work on au1550 unfortunately. So we can't have it there...
> 
> Well, remapping a KSEG1 address is not a good idea; use 0x11b00000 instead (which
> is the physical address of the PSC). (i.e. use CPHYSADDR(PSC0_BASE) for
> mmio if you like using the constants from the au1x00 headers...)
> 
Thanks for the tip.
Could you, please, resend the patch with ioremap() included, but using right 
parameter also for release_mem_region() calls?

Thanks and best regards,
Jan

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
