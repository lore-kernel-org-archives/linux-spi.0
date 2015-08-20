From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: Re: [PATCH 18/18] spi: (RFC, don't apply) report OF style modalias
 when probing using DT
Date: Thu, 20 Aug 2015 23:45:09 +0200
Message-ID: <55D64A65.7030905@osg.samsung.com>
References: <1440054451-1223-1-git-send-email-javier@osg.samsung.com>
 <1440054451-1223-19-git-send-email-javier@osg.samsung.com>
 <20150820183634.GN12027@sirena.org.uk> <20150820210822.GH74600@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150820210822.GH74600-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 08/20/2015 11:08 PM, Brian Norris wrote:
> On Thu, Aug 20, 2015 at 11:36:34AM -0700, Mark Brown wrote:
>> On Thu, Aug 20, 2015 at 09:07:31AM +0200, Javier Martinez Canillas wrote:
>>> From: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
>>>
>>> An SPI driver that supports both OF and legacy platforms, will have
>>> both an OF and SPI ID table. This means that when built as a module,
>>> the aliases will be filled from both tables, e.g:
>>
>> This is tagged as something that can't be applied but you've not
>> explained why it can't be applied or what comments might be useful :(
>

As Brian pointed out it was in the cover letter so I thought it would
just be duplicated information. But you are right, I should had added
a brief note as well just to make the patch self contained.
 
> I believe that's mostly addressed in the cover letter [1].
> 
>   Patch #18 changes the logic of spi_uevent() to report an OF modalias
>   if the device was registered using OF. But this patch is included in
>   the series only as an RFC for illustration purposes since changing
>   that without first applying all the other patches in this series, will
>   break module autoloading for the drivers of devices registered using
>   OF but that lacks an of_match_table. I'll repost patch #18 once all
>   the patches in this series have landed.
> 
> IOW, it's labeled as such mostly for safety, since it has quite a few
> distributed dependencies.
>

That's correct. If is merged before the other patches, module autoloading
will break for the drivers that are relying on the current behavior.

I just added for illustration purposes to show what was the plan.

> Brian
> 
> [1] https://lkml.org/lkml/2015/8/20/109
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
