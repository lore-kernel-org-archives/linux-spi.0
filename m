From: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: Add helper functions for setting up transfers
Date: Sat, 09 Feb 2013 11:14:12 +0000
Message-ID: <51162F84.8050706@kernel.org>
References: <1357752671-30222-1-git-send-email-lars@metafoo.de> <20130127033358.GA20672@sirena.org.uk> <20130205140755.33FCD3E1265@localhost> <5112ACF5.3020906@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>,
	Julia Lawall <Julia.Lawall-L2FTfq7BK8M@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>,
	linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5112ACF5.3020906-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 02/06/2013 07:20 PM, Jonathan Cameron wrote:
> On 02/05/2013 02:07 PM, Grant Likely wrote:
>> On Sun, 27 Jan 2013 03:33:59 +0000, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
>>> On Wed, Jan 09, 2013 at 06:31:09PM +0100, Lars-Peter Clausen wrote:
>>>
>>>> The second function spi_sync_transfer() takes a SPI device and an array of
>>>> spi_transfers. It will allocate a new spi_message (on the stack) and add all
>>>> transfers in the array to the message. Finally it will call spi_sync() on the
>>>> message.
>>>
>>> Reviewed-by: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
>>
>> Looks good to me also. Go ahead and merge this series through the iio
>> tree since it is the first user.
> 
> Lars, when you are back on your feet, could you respin this series against
> the latest iio tree please.  2 drivers have moved which messes up patches
> 2 and 3. Now I could fix it up, but it's your patch series and I'm lazy ;)

I had a few spare minutes so I've respun the series with the driver moves.
I have also, dropped the coccinelle script from the first patch.
I was unclear on whether the questions about that had been resolved.

Anyhow, I've temporarily pushed out to togreg branch of iio.git.
If Grant wants to add an ack, I'll pop that in before sending upstream
if not I'll just put a note in the tag message (or if he is too slow
for my arbitrary definition fo too slow ;)



Jonathan
> 
> 
>>
>> g.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
