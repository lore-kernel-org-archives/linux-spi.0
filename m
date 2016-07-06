From: "Franklin S Cooper Jr." <fcooper-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC] [PATCH v2 1/3] scatterlist: Add support to clone
 scatterlist
Date: Wed, 6 Jul 2016 12:20:54 -0500
Message-ID: <577D3DF6.6000406@ti.com>
References: <1467039249-7816-1-git-send-email-fcooper@ti.com>
 <1467039249-7816-2-git-send-email-fcooper@ti.com> <577CDA45.80408@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, <david.s.gordon-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	<axboe-b10kYP2dOMg@public.gmane.org>, <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	<ming.l-Vzezgt5dB6uUEJcrhfAQsw@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <577CDA45.80408-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 07/06/2016 05:15 AM, Sekhar Nori wrote:
> On Monday 27 June 2016 08:24 PM, Franklin S Cooper Jr wrote:
> 
>> +/*
>> + * sg_table_clone - Duplicate an existing sg_table including chained sgl
> 
> This function should probably be called sg_clone_table() to be
> consistent with sg_alloc_table(), sg_free_table() etc.


Will fix.
> 
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
>> +				gfp_t gfp_mask)
>> +{
>> +	struct sg_table	*table;
>> +
>> +	table = kmalloc(sizeof(struct sg_table), gfp_mask);
> 
> Can you use sg_alloc_table() to allocate the new table? The way you have
> it now, it looks like users will need to use kfree() to free a cloned
> table and use sg_free_table() otherwise. It will be nice if
> sg_free_table() can be used consistently.


Sg_alloc_table doesn't actually allocate a struct sg_table. It allocates
a single sgl or chained sgl. Drivers that use sg_table manually allocate
it via kmalloc. One change that might make sense is to not kmalloc
sg_table but instead have a user pass a pointer to a preallocated
instance of it. This way it will mimic how sg_table is typically handled.
> 
> Regards,
> Sekhar
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
