From: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v2 1/2] spi: add check_finished() callback
Date: Sat, 4 Feb 2017 14:45:57 +0100
Message-ID: <2b2776c7-4322-e5c7-e169-7d60c1830518@hauke-m.de>
References: <20161211200350.13590-1-hauke@hauke-m.de>
 <20161211200350.13590-2-hauke@hauke-m.de>
 <20161214152156.uehjhqoxpng47pnh@sirena.org.uk>
 <7b420e94-3c33-3304-f7a0-ed87c8db425a@hauke-m.de>
 <20170110123429.t6vsyqtnavranbdn@sirena.org.uk>
 <1d4bfe6a-c5a6-8fd5-310b-748413f7c946@hauke-m.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, daniel.schwierzeck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, nbd-Vt+b4OUoWG0@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1d4bfe6a-c5a6-8fd5-310b-748413f7c946-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

ping Mark,

What should I do in the driver now?

Hauke

On 01/10/2017 11:44 PM, Hauke Mehrtens wrote:
> On 01/10/2017 01:34 PM, Mark Brown wrote:
>> On Sat, Dec 17, 2016 at 11:16:17PM +0100, Hauke Mehrtens wrote:
>>> On 12/14/2016 04:21 PM, Mark Brown wrote:
>>
>>>> Why not just have your interrupt handler schedule something on a
>>>> workqueue to check whatever it is needs checking here?
>>
>>> 2. When something went wrong and I got an error IRQ for example, I would
>>> like to add this information to the spi message that was transfered, but
>>> the only way I see it to not wake the completion and let it run into a
>>> timeout.
>>
>> Just set an error status in the message and then complete the current
>> transfer or the message.
>>
>>> I would like to have a function in which I can do some busy waiting till
>>> the last word is really written to the wire and also return if the
>>> transfer was successful or what error occurred.
>>
>> The busy waiting really is pretty specialist.
> 
> What should I do now?
> 
> I can add the transfer status in some other way, no problem, but how do
> I tell Linux that the transfer finished when it really finished. I also
> tried to just ignore the last word, but when the controller is
> configured for the next transfer, the old one gets corrupted.
> 
> There is a per transfered word IRQ, I can use that, but it is probably
> triggered very often and I do not know if it works in all situations and
> it has to get synced with the fifo IRQs which is probably complicated.
> 
> I can also start my own driver thread to do the busy waiting and trigger
> the spi_finalize_current_transfer() later after busy waiting in the driver.
> 
> I can also use transfer_one_message()
> 
> I would prefer to add an additional busy waiting after the
> wait_for_completion_timeout() like I did in this patch, but how should
> this look like?
> 
> Hauke
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
