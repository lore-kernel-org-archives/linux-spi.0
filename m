From: Cyrille Pitchen <cyrille.pitchen-yU5RGvR974pGWvitb5QawA@public.gmane.org>
Subject: Re: [PATCH 1/3] mtd: spi-nor: add optional DMA-safe bounce buffer for
 data transfer
Date: Thu, 28 Dec 2017 11:39:08 +0100
Message-ID: <1a7dc424-1ce0-6c64-fc52-bb88ec7db8fa@wedev4u.fr>
References: <cover.1514087323.git.cyrille.pitchen@wedev4u.fr>
 <fc2440c6f52877f28286d89691049e5cba10e6a7.1514087323.git.cyrille.pitchen@wedev4u.fr>
 <1514317385.26695.39.camel@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org" <nicolas.ferre-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        "robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org" <radu.pirea-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>,
        "linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org" <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>,
        "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
        "computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org"
        <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        "vigneshr-l0cyMroinI0@public.gmane.org" <vigneshr-l0cyMroinI0@public.gmane.org>,
        "richard-/L3Ra7n9ekc@public.gmane.org" <richard-/L3Ra7n9ekc@public.gmane.org>,
        "marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1514317385.26695.39.camel-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Trent,

Le 26/12/2017 à 20:43, Trent Piepho a écrit :
> On Sun, 2017-12-24 at 05:36 +0100, Cyrille Pitchen wrote:
>>
>> Then the patch adds two hardware capabilities for SPI flash controllers,
>> SNOR_HWCAPS_WR_BOUNCE and SNOR_HWCAPS_RD_BOUNCE.
> 
> Are there any drivers for which a bounce buffer is NOT needed when the
> tx/rx buffer is not in DMA safe memory?  Maybe it would make more sense
> to invert the sense of these flags, so that they indicate the driver
> does not need DMA safe buffers, if that is the uncommon/non-existent
> case, so that fewer drivers need to be modified to to be fixed?
>

It doesn't sound safe for a first step. I don't know if some of the
spi-flash controllers are embedded inside systems with small memory and
don't care about DMA transfers. Maybe they don't plan to use anything else
but PIO transfers. Then why taking the risk to exhaust the memory on systems
that would not use the bounce buffer anyway?

Later, if we see that most spi-flash drivers actually need this bounce
buffer, I agree with you: we could invert the logic of the flags but
currently I guess this is too soon and to be safe I would have to add the
negative flags to all other spi-flash drivers. I would like a smooth and
safe transition to avoid unexpected and unwanted side effects.


About the memory loss when forcing the SNOR_HWCAPS_*_BOUNCE in m25p80.c, I
justify it because the m25p80 has to be compliant with the SPI sub-system
requirements but currently is not. However I've taken care not to allocate
the bounce buffer as long as we use only DMA-safe buffers.

Here at the MTD side, the main (only ?) source of DMA-unsafe buffers is
the UBIFS (JFFS2 too ?) layer. Then I've assumed that systems using such a
file-system should already have enough system memory.

However I wanted to take all other use cases into account.

>> +static bool spi_nor_is_dma_safe(const void *buf)
>> +{
>> +	if (is_vmalloc_addr(buf))
>> +		return false;
>> +
>> +#ifdef CONFIG_HIGHMEM
>> +	if ((unsigned long)buf >= PKMAP_BASE &&
>> +	    (unsigned long)buf < (PKMAP_BASE + (LAST_PKMAP * PAGE_SIZE)))
>> +		return false;
>> +#endif
> 
> It looks like:
> 
> (unsigned long)addr >= PKMAP_ADDR(0) &&
> (unsigned long)addr < PKMAP_ADDR(LAST_PKMAP)
> 
> is the expression used in the highmem code.  But really, isn't this
> begging for is_highmem_addr() in include/linux/mm.h that can always
> return false when highmem is not enabled?
>

Vignesh has suggested to call virt_addr_valid() instead.
I think Boris has also told me about this function.
So it might be the right solution. What do you think about their proposal?

> In order to be safe, this must be called when nor->lock is held, right?

Indeed, in all cases (spi_nor_read(), sst_write() and spi_nor_write()),
spi_nor_get_bounce_buffer() is always called with nor->lock held, precisely
to avoid races and allocating the bounce buffer twice by mistake.

>  Otherwise it could race against two callers allocating the buffer at
> the same time.  That should probably be noted in the kerneldoc comments
> for this function, which should also be written.
>

I can add kernel-doc.

>> +static int spi_nor_get_bounce_buffer(struct spi_nor *nor,
>> +				     u_char **buffer,
>> +				     size_t *buffer_size)
>> +{
> 
>> +
>> +	*buffer = nor->bounce_buffer;
>> +	*buffer_size = size;
> 
> So the buffer is returned via the parameter, and also via a field
> inside nor.  Seems redundant.  Consider address could be returned via
> the function return value coupled with PTR_ERR() for the error cases. 
> Or not return address at all since it's available via nor-
>> bounce_buffer.
>

Why not. It would require more lines though. I guess it's purely a matter of taste.

	u_char *buffer = buf;

	if (use_bounce) {
		buffer = spi_nor_get_bounce_buffer(nor, &buffer_size);
		if (IS_ERR(buffer)) {
			err = PTR_ERR(buffer);
			goto read_err;
		 }
	}

>>  {
>>  	struct spi_nor *nor = mtd_to_spi_nor(mtd);
>> +	bool use_bounce = (nor->flags & SNOR_F_USE_RD_BOUNCE) &&
>> +			  !spi_nor_is_dma_safe(buf);
>> +	u_char *buffer = buf;
>> +	size_t buffer_size = 0;
>>  	int ret;
>>  
>>  	dev_dbg(nor->dev, "from 0x%08x, len %zd\n", (u32)from, len);
>> @@ -1268,13 +1324,23 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
>>  	if (ret)
>>  		return ret;
>>  
>> +	if (use_bounce) {
>> +		ret = spi_nor_get_bounce_buffer(nor, &buffer, &buffer_size);
>> +		if (ret < 0)
>> +			goto read_err;
>> +	}
> 
> This pattern, check if bounce is enabled, check if address is dma-
> unsafe, get bounce buffer, seems to be very common.  Could it be
> refactored into one helper?
>
> u_char *buffer = spi_nor_check_bounce(nor, buf, len, &buffer_size);

The conditions that define the value of 'use_bounce' also depend on the type
of operation, read or write, hence on the two different flags
SNOR_F_USE_RD_BOUNCE and SNOR_F_USE_WR_BOUNCE.

Besides, 'use_bounce' is also tested later in spi_nor_read(), sst_write()
and sst_write().

So I don't really see how the spi_nor_check_bounce() function you propose
could be that different from spi_nor_get_bounce_buffer().

> if (IS_ERR(buffer)) 
>     return PTR_ERR(buffer);
> // buffer = nor->bounce_buffer or buf, whichever is correct
> // buffer_size = len or bounce buffer size, whichever is correct
> 
> Could spi_nor_read_sfdp_dma_unsafe() also use this buffer?
> 

I didn't use the bounce buffer in spi_nor_read_sfdp_dma_unsafe() on
purpose: the bounce buffer, when needed, is allocated once for all to limit
performance loss. However, to avoid increasing the memory footprint, if not
absolutely needed the bounce buffer is not allocated at all.

For a SFDP compliant memory, spi_nor_parse_sfdp() is always called during
spi_nor_scan() even if later, only DMA-safe buffers are provided. In such a
case, allocating the bounce buffer would have been a waste of memory.

Best regards,

Cyrille
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
