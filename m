From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [RFC] [PATCH v2 1/3] scatterlist: Add support to clone scatterlist
Date: Wed, 6 Jul 2016 20:46:57 +0300
Message-ID: <CAHp75VcPLV-483ihn_RmHnDOc0iFMSdYj5_SrNevyqrrpeWatQ@mail.gmail.com>
References: <1467039249-7816-1-git-send-email-fcooper@ti.com>
 <1467039249-7816-2-git-send-email-fcooper@ti.com> <CAHp75VfR=TKfVN=03jvGy5oZRA_-ASb8Vb_A4+x3OrkpZT6PoQ@mail.gmail.com>
 <577D3B5C.7080805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: david.s.gordon@intel.com, Jens Axboe <axboe@fb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ming Lin <ming.l@ssi.samsung.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	Sekhar Nori <nsekhar@ti.com>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>
To: "Franklin S Cooper Jr." <fcooper@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <577D3B5C.7080805@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jul 6, 2016 at 8:09 PM, Franklin S Cooper Jr. <fcooper@ti.com> wrote:

>>> +               last_entry = sg_is_last(sgl);
>>> +               *sgl = *orig_sgl;
>>> +
>>> +               /*
>>> +                * If page_link is pointing to a chained sgl then set it to
>>> +                * zero since we already compensated for chained sgl. If
>>> +                * page_link is pointing to a page then clear bits 1 and 0.
>>> +                */
>>> +               if (sg_is_chain(orig_sgl))
>>> +                       sgl->page_link = 0x0;
>>> +               else
>>> +                       sgl->page_link &= ~0x03;
>>> +
>>
>>> +               if (last_entry) {
>>> +                       sg_dma_len(sgl) = len;
>>
>> Hmm... If it's not DMA mapped and CONFIG_NEED_SG_DMA_LENGTH=y, you
>> will set dma_length field and len otherwise. Is it on purpose?
>
> Thanks for pointing this out. I didn't take into consideration the above
> scenario.
>
> After looking at this more it seems like on occasion dma_length !=
> length. I see this occurring in various map_sg functions for several
> architectures.
>
> I'm simply trying to reduce the overall sgl length by a certain amount.
> I'm not sure what the proper approach would be since dma_length and
> length can be set to different values. Simply setting sgl->dma_length to
> sgl->length or vice a versa seems like it can be problematic in some
> scenarios. What confuses me even more is if dma_length != length then
> how can sg_nents_for_len only use the sgl length property.
>
> Any thoughts on what would be the best way to handle this?

First come to my mind is to refuse to clone if SG table is DMA mapped.

Imagine the scenario where you have for example last entry which your
caller asked to split as

total_entry_len = 37235 (input)
dma_length = 65536 (64k alignment)

asked_len = 32768 (Split chunks: 32768 + 4467)
resulting_dma_len = ?

What do you put here? Initially it perhaps means the same 64k. But how
to distinguish?
(I couldn't come with better one, but there are many alike scenarios)

Only hack we have is to supply struct device of the DMA device to this
SG table where you can get max segment size (but I dunno about
alignment).

P.S. I'm not familiar of the details of all these.

-- 
With Best Regards,
Andy Shevchenko
