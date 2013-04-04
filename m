From: Girish KS <girishks2000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V3 2/5] spi: s3c64xx: added support for polling mode
Date: Thu, 4 Apr 2013 11:15:46 +0530
Message-ID: <CAKrE-Kc-QJ1ZkAZ1jYjRy+7V+6SuVk0oytfD8_vcp3ZWf6aSPQ@mail.gmail.com>
References: <1363157014-9615-1-git-send-email-ks.giri@samsung.com>
	<1363157014-9615-3-git-send-email-ks.giri@samsung.com>
	<20130401131207.GI18636@opensource.wolfsonmicro.com>
	<CAKrE-KdWe6aCg0p99BFEeQP-P2nwvdhs2itH3XnHsJMCUjWPAA@mail.gmail.com>
	<20130403114935.GA11305@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130403114935.GA11305-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Apr 3, 2013 at 5:19 PM, Mark Brown
<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> On Wed, Apr 03, 2013 at 05:00:04PM +0530, Girish KS wrote:
>> On Mon, Apr 1, 2013 at 6:42 PM, Mark Brown
>
>> >> -     if (!sdd->pdev->dev.of_node) {
>> >> +     if (!sdd->pdev->dev.of_node && !is_polling(sdd)) {
>> >>               res = platform_get_resource(pdev, IORESOURCE_DMA,  0);
>> >>               if (!res) {
>> >>                       dev_err(&pdev->dev, "Unable to get SPI tx dma "
>
>> > It seems like it'd be sensible to also handle failure to get the DMA
>> > resource by going into polling mode.
>
>> There are 2 cases currently i have identified and handled,
>> 1. The SoC's dont have DMA support for spi controller. For such SoC's we
>>  would not add the dma resource in the spi dts node. In this case the probe
>>  would return error if failure for DMA resuorce is handled.
>
> That's not what the code currently does...
>
>> 2. The SoC has a DMA support for SPI controller, but due to some x
>> reason(H/W bug),
>>  the driver would force polling mode by enabling
>> S3C64XX_SPI_QUIRK_POLL in driver
>>  data. For such SoC's there would be a dma entry in the spi controller
>> dts node, and
>>  probe can handle failure for DMA resource successfully.
>
>> To handle above both situations successfully if
>> (!sdd->pdev->dev.of_node && !is_polling(sdd)) is used.
>
> Right, that's what the code currently does but what I'm suggesting is
> that this isn't the most helpful thing to do and that printing a big
> warning then soldiering on in polling mode might be more useful.

Ok I got it. will do it.

Thanks Mark

------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
