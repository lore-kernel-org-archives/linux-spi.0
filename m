From: "Franklin S Cooper Jr." <fcooper-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC] [PATCH v2 1/3] scatterlist: Add support to clone
 scatterlist
Date: Wed, 6 Jul 2016 14:39:36 -0500
Message-ID: <577D5E78.2010307@ti.com>
References: <1467039249-7816-1-git-send-email-fcooper@ti.com>
 <1467039249-7816-2-git-send-email-fcooper@ti.com>
 <CAHp75VfR=TKfVN=03jvGy5oZRA_-ASb8Vb_A4+x3OrkpZT6PoQ@mail.gmail.com>
 <577D3B5C.7080805@ti.com>
 <CAHp75VcPLV-483ihn_RmHnDOc0iFMSdYj5_SrNevyqrrpeWatQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <david.s.gordon-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Jens Axboe <axboe-b10kYP2dOMg@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Ming Lin <ming.l-Vzezgt5dB6uUEJcrhfAQsw@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>,
	Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VcPLV-483ihn_RmHnDOc0iFMSdYj5_SrNevyqrrpeWatQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 07/06/2016 12:46 PM, Andy Shevchenko wrote:
> On Wed, Jul 6, 2016 at 8:09 PM, Franklin S Cooper Jr. <fcooper-l0cyMroinI0@public.gmane.org> wrote:
> 
>>>> +               last_entry = sg_is_last(sgl);
>>>> +               *sgl = *orig_sgl;
>>>> +
>>>> +               /*
>>>> +                * If page_link is pointing to a chained sgl then set it to
>>>> +                * zero since we already compensated for chained sgl. If
>>>> +                * page_link is pointing to a page then clear bits 1 and 0.
>>>> +                */
>>>> +               if (sg_is_chain(orig_sgl))
>>>> +                       sgl->page_link = 0x0;
>>>> +               else
>>>> +                       sgl->page_link &= ~0x03;
>>>> +
>>>
>>>> +               if (last_entry) {
>>>> +                       sg_dma_len(sgl) = len;
>>>
>>> Hmm... If it's not DMA mapped and CONFIG_NEED_SG_DMA_LENGTH=y, you
>>> will set dma_length field and len otherwise. Is it on purpose?
>>
>> Thanks for pointing this out. I didn't take into consideration the above
>> scenario.
>>
>> After looking at this more it seems like on occasion dma_length !=
>> length. I see this occurring in various map_sg functions for several
>> architectures.
>>
>> I'm simply trying to reduce the overall sgl length by a certain amount.
>> I'm not sure what the proper approach would be since dma_length and
>> length can be set to different values. Simply setting sgl->dma_length to
>> sgl->length or vice a versa seems like it can be problematic in some
>> scenarios. What confuses me even more is if dma_length != length then
>> how can sg_nents_for_len only use the sgl length property.
>>
>> Any thoughts on what would be the best way to handle this?
> 
> First come to my mind is to refuse to clone if SG table is DMA mapped.
> 
> Imagine the scenario where you have for example last entry which your
> caller asked to split as
> 
> total_entry_len = 37235 (input)
> dma_length = 65536 (64k alignment)


Do you know of an example where dma_length will be set to some kind of
alignment size rather than based on the number of bytes you want
transfered? Or maybe I'm miss understanding this.

> 
> asked_len = 32768 (Split chunks: 32768 + 4467)
> resulting_dma_len = ?
> 
> What do you put here? Initially it perhaps means the same 64k. But how
> to distinguish?
> (I couldn't come with better one, but there are many alike scenarios)
> 
> Only hack we have is to supply struct device of the DMA device to this
> SG table where you can get max segment size (but I dunno about
> alignment).
> 
> P.S. I'm not familiar of the details of all these.
> 

Unfortunately, for the original purpose of this series the scatterlist I
want to clone is indeed DMA mapped.

The times I've seen dma_length != length is when the dma_map_sg is
trying to combine contiguous sgl (ex ppc_iommu_map_sg and dma_map_cont).
So maybe it is better to subtract a value from length and dma_length
rather than explicitly setting it to a value. This way it wouldn't
matter that dma_length and length aren't equal.

This looks like a similar approach used by sg_split_mapped. Although
sg_split skips first x number of bytes while I want to skip the last x
number of bytes.

Maybe Robert can add his thoughts since he created sg_split.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
