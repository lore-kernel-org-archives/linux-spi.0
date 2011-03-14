From: Michael Williamson <michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
Subject: Re: [PATCH] spi: davinci: Support DMA transfers larger than 65535
	words
Date: Mon, 14 Mar 2011 07:06:48 -0400
Message-ID: <4D7DF6C8.2040505@criticallink.com>
References: <1300026862-1179-1-git-send-email-michael.williamson@criticallink.com>
	<1300026862-1179-2-git-send-email-michael.williamson@criticallink.com>
	<4D7DED07.7020000@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4D7DED07.7020000-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 3/14/2011 6:25 AM, Sergei Shtylyov wrote:

> Hello.
>
> On 13-03-2011 17:34, Michael Williamson wrote:
>
>> The current davinci SPI driver, in DMA mode, is limited to 65535
>> words for a single transfer.  Modify the driver by configuring a
>> 3 dimensional EDMA transfer to support up to 65535x65535
>> words.
>
>> Signed-off-by: Michael Williamson<michael.williamson-wZX4cNJlHJ2sVWG7oymsAA@public.gmane.org>
> [...]
>
>> diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
>> index 037ba82..411cc32 100644
>> --- a/drivers/spi/davinci_spi.c
>> +++ b/drivers/spi/davinci_spi.c
> [...]
>> @@ -599,14 +600,30 @@ static int davinci_spi_bufs(struct spi_device *spi, struct spi_transfer *t)
>>               }
>>           }
>>
>> +        /*
>> +         * If number of words is greater than 65535, then we need
>> +         * to configure a 3 dimension transfer.  Use the BCNTRLD
>> +         * feature to allow for transfers that aren't even multiples
>> +         * of 65535 (or any other possible b size) by first transferring
>> +         * the remainder amount then grabbing the next N blocks of
>> +         * 65535 words.
>> +         */
>> +
>> +        c = dspi->wcount/(SZ_64K-1);    /* N 65535 count Blocks */
>> +        b = dspi->wcount-c*(SZ_64K-1);    /* Remainder */
>
>    The driver style (and general Linux kernel style) assumes spaces around operators.



Sure enough.  I am relying on checkpatch.pl too much.  I will fix and
re-post.  Thanks for the style check.

>
> WRB, Sergei





------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
