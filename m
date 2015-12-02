From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: add initial set of spi_transfer transformation methods
Date: Wed, 2 Dec 2015 08:25:08 +0100
Message-ID: <35C5C134-8291-4856-8916-7EDDFB07A0A9@martin.sperl.org>
References: <1448888695-2260-1-git-send-email-kernel@martin.sperl.org> <1448888695-2260-3-git-send-email-kernel@martin.sperl.org> <20151201212929.GV1929@sirena.org.uk>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151201212929.GV1929-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



> On 01.12.2015, at 22:29, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> 
>> On Mon, Nov 30, 2015 at 01:04:53PM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
>> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>> 
>> added the following spi_transformation methods:
>> * spi_split_transfers_first_page_len_not_aligned -
>>  this splits spi_transfers that are not aligned on rx_buf/tx_buf
>>  this will create 2 or 3 transfers, where the first 1/2 transfers are
>>  just there to allow the last transfer to be fully aligned. These first
>>  transfers will have a length less than alignment.
>> * spi_split_transfers_maxsize
>>  this splits the spi_transfer into multiple independent spi_transfers
>>  all of which will be of size max_size or smaller.
> 
> Please split this up for review, as I'm fairly sure has been discussed
> before smaller, more focused patches with clear changelogs describing
> what they are suppose to do are much easier to review.  Start by adding
> the framework changes, then add one transformation at once.  This is a
> very big patch full of fiddly, unexplained code.

I can split this in two or 3, as I already have a prototype that allows for
merging multiple transfers into one transfer by copying data arround.

> 
>> To start these shall get used by the individual drivers in prepare_message,
>> but some may get moved into spi-core with the correct parametrization in
>> spi_master.
> 
> As discussed I'm not a big fan of this approach.
It is just a first step.

As far as I can see different hw may require different policies.

If there is a common code to handle all the variations then we can
Implement that, but I have no idea what that could be.

That is why I took this prepare message approach for now as it
allows most control from the driver perspective (and is not 
breaking existing drivers)

As said: this can get moved to the core when we have found the
correct parametrization for driver.
Parameters that come to mind are:
* dma_alignment
* max_transfersize (for which there exists a patch already)

> 
>> +/* the spi_resource structure used */
>> +struct spi_res_replaced_transfers {
>> +    spi_res_release_t release;
>> +    struct list_head replaced_transfers;
>> +    int inserted;
>> +    struct spi_transfer xfers[];
>> +};
> 
> This quite clearly isn't a struct spi_resource, nor does it contain
> one...
It is done the same way as devm_kalloc uses struct devres:
the magic devres struct is hidden by the devres framework. 
Only the payload data pointer is returned, which is what this
structure describes.

You want it as a more explicit member instead?

> 
>> +static void __spi_split_transfers_fixup_transfer_addr_and_len(
>> +    struct spi_transfer *xfer, int count, int shift)
>> +{
>> +    int i;
>> +
>> +    /* fix up transfer length */
>> +    xfer[0].len = shift;
>> +
>> +    /* shift all the addresses arround */
>> +    for (i = 1; i < count; i++) {
>> +        xfer[i].len -= shift;
>> +        xfer[i].tx_buf += xfer[i].tx_buf ? shift : 0;
>> +        xfer[i].rx_buf += xfer[i].rx_buf ? shift : 0;
>> +        xfer[i].tx_dma += xfer[i].tx_dma ? shift : 0;
>> +        xfer[i].rx_dma += xfer[i].rx_dma ? shift : 0;
>> +    }
>> +}
> 
> It's really not clear what this is supposed to do.  Among other things
> "shift" appears to be misnamed and anything using tx_dma and rx_dma is
> worrying.
Essentially this will handle count spi-transfers that have all identical data
(Except for transfer_list) initially - especially Len and tx/rx buf.
The first of those transfers is set its length to shift 
(no need to modify rx/tx_buf)
The others are reduced by that length and the pointers are shifted up,
So that they are now starting at the address after the first transfer and
Transfer the correct number of bytes.

Rx/tx_dma is handled because it is there and it's address needs also to be
accurately Shifted by that offset. I know that it is a depreciated interface,
but as it is still there it needs to be supported...


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
