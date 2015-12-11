From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH V2 1/5] spi: core: added spi_resource management
Date: Fri, 11 Dec 2015 15:55:24 +0100
Message-ID: <D2C3BEFF-D4E2-4B07-BDB2-6B12F095A12E@martin.sperl.org>
References: <1449501708-2228-1-git-send-email-kernel@martin.sperl.org> <1449501708-2228-2-git-send-email-kernel@martin.sperl.org> <CAHp75Vf4UGOAz5ZLCBtCeNitYY1h0P6Ae7_puVTfe+KweyeeAA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75Vf4UGOAz5ZLCBtCeNitYY1h0P6Ae7_puVTfe+KweyeeAA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 11.12.2015, at 15:30, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 
> On Mon, Dec 7, 2015 at 5:21 PM,  <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> wrote:
>> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>> 
>> SPI resource management framework used while processing a spi_message
>> 
> 
> I have no thoughts (*) about the whole idea, but below some comments
> regarding implementation.
> 
> (*) [Yet] For a fist glance looked a bit complicated.
Look at all the patch-sets - by now everything (besides dma_mapping) is
implemented and should come in the next version.

It then includes also the spi-loopback-test framework which I use heavily
to test the patches for functional regressions.

> 
>> 
>> Signed-off-by: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>> ---
>> drivers/spi/spi.c       |   93 +++++++++++++++++++++++++++++++++++++++++++++++
>> include/linux/spi/spi.h |   36 ++++++++++++++++++
>> 2 files changed, 129 insertions(+)
>> 
>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>> index 2b0a8ec..fb39d23 100644
>> --- a/drivers/spi/spi.c
>> +++ b/drivers/spi/spi.c
>> @@ -1007,6 +1007,8 @@ out:
>>        if (msg->status && master->handle_err)
>>                master->handle_err(master, msg);
>> 
>> +       spi_res_release(master, msg);
>> +
> 
> Why it's in this patch and not later?
Because it needs to get released when we finish the spi_message processing code.
Also it is the only place were we talk directly about spi_res and releasing it.

> 
>>        spi_finalize_current_message(master);
>> 
>>        return ret;
>> @@ -1991,6 +1993,97 @@ struct spi_master *spi_busnum_to_master(u16 bus_num)
>> }
>> EXPORT_SYMBOL_GPL(spi_busnum_to_master);
>> 
>> +/*-------------------------------------------------------------------------*/
>> +
>> +/* Core methods for SPI resource management */
>> +
>> +/**
>> + * spi_res_alloc - allocate a spi resource that is life-cycle managed
>> + *                 during the processing of a spi_message while using
>> + *                 spi_transfer_one
>> + * @spi:     the spi device for which we allocate memory
>> + * @release: the release code to execute for this resource
>> + * @size:    size to alloc and return
>> + * @gfp:     GFP allocation flags
>> + *
>> + * Return: the pointer to the allocated data
>> + *
>> + * This may get enhanced in the future to allocate from a memory pool
>> + * of the @spi_device or @spi_master to avoid repeated allocations.
>> + */
>> +void *spi_res_alloc(struct spi_device *spi,
>> +                   spi_res_release_t release,
>> +                   size_t size, gfp_t gfp)
>> +{
>> +       struct spi_res *sres;
> 
>> +       size_t tot_size = sizeof(struct spi_res) + size;
> 
> Looks like you create a variable for one use. And I'm pretty sure the
> 80 character limit is not a case here.
fixed in next version of the patchset.

> 
>> +
>> +       sres = kzalloc(tot_size, gfp);
>> +       if (!sres)
>> +               return NULL;
>> +
>> +       INIT_LIST_HEAD(&sres->entry);
>> +       sres->release = release;
>> +
>> +       return sres->data;
>> +}
>> +EXPORT_SYMBOL_GPL(spi_res_alloc);
>> +
>> +/**
>> + * spi_res_free - free an spi resource
>> + * @res: pointer to the custom data of a resource
>> + *
>> + */
>> +void spi_res_free(void *res)
>> +{
>> +       struct spi_res *sres;
>> +
>> +       if (res) {
> 
> if (!res)
> return;
> ?
matter of taste I guess - will fix it in the next version.
(I also guess it was taken from the template dev_res)

> 
>> +               sres = container_of(res, struct spi_res, data);
> 
> This might be at the definition block even if res == NULL.

I was skeptical about making this assumption - fixed.

>> +struct spi_res {
>> +       struct list_head        entry;
>> +       spi_res_release_t       release;
>> +       unsigned long long      data[]; /* guarantee ull alignment */
> 
> Isn't better to use __aligned(8)?
> And why not simple void *?
devres does it that way, so I kept it that way...

Thanks,
	Martin--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
