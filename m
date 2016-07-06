From: "Franklin S Cooper Jr." <fcooper-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC] [PATCH v2 1/3] scatterlist: Add support to clone
 scatterlist
Date: Wed, 6 Jul 2016 12:09:48 -0500
Message-ID: <577D3B5C.7080805@ti.com>
References: <1467039249-7816-1-git-send-email-fcooper@ti.com>
 <1467039249-7816-2-git-send-email-fcooper@ti.com>
 <CAHp75VfR=TKfVN=03jvGy5oZRA_-ASb8Vb_A4+x3OrkpZT6PoQ@mail.gmail.com>
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
	Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VfR=TKfVN=03jvGy5oZRA_-ASb8Vb_A4+x3OrkpZT6PoQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 07/05/2016 12:10 PM, Andy Shevchenko wrote:
> On Mon, Jun 27, 2016 at 5:54 PM, Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org> wrote:
>> Occasionally there are times you need to tweak a chained S/G list while
>> maintaining the original list. This function will duplicate the passed
>> in chained S/G list and return a pointer to the cloned copy.
>>
>> The function also supports passing in a length that can be equal or less
>> than the original chained S/G list length. Reducing the length can result
>> in less entries of the chained S/G list being created.
> 
> My comments below.
> 
>> +struct sg_table *sg_table_clone(struct sg_table *orig_table, u64 len,
>> +                               gfp_t gfp_mask);
> 
> size_t len ?
> Or it would be commented somewhere why u64.


No reason other than sg_nents_for_len required u64. But I see other
users of that function using size_t so I'll fix this.

> 
>> +/*
>> + * sg_clone -  Duplicate an existing chained sgl
>> + * @orig_sgl:  Original sg list to be duplicated
>> + * @len:       Total length of sg while taking chaining into account
>> + * @gfp_mask:  GFP allocation mask
>> + *
>> + * Description:
>> + *   Clone a chained sgl. This cloned copy may be modified in some ways while
>> + *   keeping the original sgl in tact. Also allow the cloned copy to have
>> + *   a smaller length than the original which may reduce the sgl total
>> + *   sg entries.
>> + *
>> + * Returns:
>> + *   Pointer to new kmalloced sg list, ERR_PTR() on error
> 
> Maybe "...new allocated SG list using kmalloc()..." ?


Will fix
> 
>> + *
> 
> Extra line.


Will fix along with all the other extra line comments.
> 
>> + */
>> +static struct scatterlist *sg_clone(struct scatterlist *orig_sgl, u64 len,
>> +                                   gfp_t gfp_mask)
>> +{
>> +       unsigned int            nents;
>> +       bool                    last_entry;
>> +       struct scatterlist      *sgl, *head;
>> +
>> +       nents = sg_nents_for_len(orig_sgl, len);
>> +
> 
> Ditto.
> 
>> +       if (nents < 0)
> 
>> +               return ERR_PTR(-EINVAL);
> 
> return ERR_PTR(nents);


Will fix
> 
>> +
>> +       head = sg_kmalloc(nents, gfp_mask);
>> +
> 
> Extra line.
> 
>> +       if (!head)
>> +               return ERR_PTR(-ENOMEM);
>> +
> 
>> +       sgl = head;
>> +
>> +       sg_init_table(sgl, nents);
>> +
>> +       for (; sgl; orig_sgl = sg_next(orig_sgl), sgl = sg_next(sgl)) {
> 
> Maybe
> 
>   sg_init_table(head, nents);
> 
>   for (sgl = head; sgl; ...


Yeah that will probably look better. Will fix.
> 
>> +
>> +               last_entry = sg_is_last(sgl);
>> +               *sgl = *orig_sgl;
>> +
>> +               /*
>> +                * If page_link is pointing to a chained sgl then set it to
>> +                * zero since we already compensated for chained sgl. If
>> +                * page_link is pointing to a page then clear bits 1 and 0.
>> +                */
>> +               if (sg_is_chain(orig_sgl))
>> +                       sgl->page_link = 0x0;
>> +               else
>> +                       sgl->page_link &= ~0x03;
>> +
> 
>> +               if (last_entry) {
>> +                       sg_dma_len(sgl) = len;
> 
> Hmm... If it's not DMA mapped and CONFIG_NEED_SG_DMA_LENGTH=y, you
> will set dma_length field and len otherwise. Is it on purpose?

Thanks for pointing this out. I didn't take into consideration the above
scenario.

After looking at this more it seems like on occasion dma_length !=
length. I see this occurring in various map_sg functions for several
architectures.

I'm simply trying to reduce the overall sgl length by a certain amount.
I'm not sure what the proper approach would be since dma_length and
length can be set to different values. Simply setting sgl->dma_length to
sgl->length or vice a versa seems like it can be problematic in some
scenarios. What confuses me even more is if dma_length != length then
how can sg_nents_for_len only use the sgl length property.

Any thoughts on what would be the best way to handle this?


How about something like the following to address your original question?

sgl->length = len

if (sgl->dma_address)
	sg_dma_len(sgl) = sgl->length
> 
>> +                       /* Set bit 1 to indicate end of sgl */
>> +                       sgl->page_link |= 0x02;
>> +               } else {
> 
>> +                       len -= sg_dma_len(sgl);

len -= sgl->length
> 
> Ditto.
> 
>> +               }
>> +       }
>> +
>> +       return head;
>> +}
>> +
>> +/*
>> + * sg_table_clone - Duplicate an existing sg_table including chained sgl
>> + * @orig_table:     Original sg_table to be duplicated
>> + * @len:            Total length of sg while taking chaining into account
>> + * @gfp_mask:       GFP allocation mask
>> + *
>> + * Description:
>> + *   Clone a sg_table along with chained sgl. This cloned copy may be
>> + *   modified in some ways while keeping the original table and sgl in tact.
>> + *   Also allow the cloned sgl copy to have a smaller length than the original
>> + *   which may reduce the sgl total sg entries.
>> + *
>> + * Returns:
>> + *   Pointer to new kmalloced sg_table, ERR_PTR() on error
>> + *
>> + */
>> +struct sg_table *sg_table_clone(struct sg_table *orig_table, u64 len,
>> +                               gfp_t gfp_mask)
>> +{
>> +       struct sg_table *table;
>> +
>> +       table = kmalloc(sizeof(struct sg_table), gfp_mask);
>> +
> 
> Extra line.
> 
>> +       if (!table)
>> +               return ERR_PTR(-ENOMEM);
>> +
>> +       table->sgl = sg_clone(orig_table->sgl, len, gfp_mask);
>> +
> 
> Ditto.
> 
>> +       if (IS_ERR(table->sgl)) {
>> +               kfree(table);
>> +               return ERR_PTR(-ENOMEM);
>> +       }
>> +
>> +       table->nents = table->orig_nents = sg_nents(table->sgl);
>> +
>> +       return table;
>> +}
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
