From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: add initial set of spi_transfer transformation methods
Date: Thu, 3 Dec 2015 07:22:10 +0100
Message-ID: <91B0D66C-97E5-4683-8896-091C4BD7FCAF@martin.sperl.org>
References: <1448888695-2260-1-git-send-email-kernel@martin.sperl.org> <1448888695-2260-3-git-send-email-kernel@martin.sperl.org> <20151201212929.GV1929@sirena.org.uk> <35C5C134-8291-4856-8916-7EDDFB07A0A9@martin.sperl.org> <20151203003618.GQ1929@sirena.org.uk>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151203003618.GQ1929-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 03.12.2015, at 01:36, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> 
> On Wed, Dec 02, 2015 at 08:25:08AM +0100, Martin Sperl wrote:
>>>> On 01.12.2015, at 22:29, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>>> On Mon, Nov 30, 2015 at 01:04:53PM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> 
> Please use normal formatting for e-mails with blank lines between
> paragraphs, it makes things much easier to read.
> 
>>>> +/* the spi_resource structure used */
>>>> +struct spi_res_replaced_transfers {
>>>> +    spi_res_release_t release;
>>>> +    struct list_head replaced_transfers;
>>>> +    int inserted;
>>>> +    struct spi_transfer xfers[];
>>>> +};
> 
>>> This quite clearly isn't a struct spi_resource, nor does it contain
>>> one...
> 
>> It is done the same way as devm_kalloc uses struct devres:
>> the magic devres struct is hidden by the devres framework. 
>> Only the payload data pointer is returned, which is what this
>> structure describes.
> 
>> You want it as a more explicit member instead?
> 
> If it's not actually a resource and is really just a structure that
> happens to be managed with a resource then describe it as such, I'm
> complaining about the confusing naming here.

Ok understood now - I feared you meant you disliked the whole approach. 

> 
>>>> +static void __spi_split_transfers_fixup_transfer_addr_and_len(
>>>> +    struct spi_transfer *xfer, int count, int shift)
>>>> +{
>>>> +    int i;
> 
>>>> +    /* fix up transfer length */
>>>> +    xfer[0].len = shift;
> 
>>> It's really not clear what this is supposed to do.  Among other things
>>> "shift" appears to be misnamed and anything using tx_dma and rx_dma is
>>> worrying.
> 
>> Essentially this will handle count spi-transfers that have all identical data
>> (Except for transfer_list) initially - especially Len and tx/rx buf.
>> The first of those transfers is set its length to shift 
>> (no need to modify rx/tx_buf)
>> The others are reduced by that length and the pointers are shifted up,
>> So that they are now starting at the address after the first transfer and
>> Transfer the correct number of bytes.
> 
> I'm sorry but the above is still very opaque - why would we have some
> list of transfers that all have identical data?  I *think* the intention
> here is to do some realignment and that shift is really an offset to
> move things by?

Yes, so probably the naming is wrong.
As for identical data: the spi_transfer_replace method also copies the
first transfer to to be replaced to all the newly created transfers
Before replacing/splicing them into spi_message.transfers.

Anyway: there is something probably not working for the alignment
code when rx/tx_buf are mis-aligned by different offsets (say 1 and 2)
even though I ran all those extensive transfer tests on bcm2835 and
they run fine there.

> 
>> Rx/tx_dma is handled because it is there and it's address needs also to be
>> accurately Shifted by that offset. I know that it is a depreciated interface,
>> but as it is still there it needs to be supported...
> 
> It's really quite broken already for most users.
If it is broken, then why not remove those members?
Or set those pointers to null in spi_verify (or at least croak about it
being depreciated)

With the current situation the code needs to handle those transfers
correctly - especially if we want to enable it by default in spi-core
for all spi-masters eventually.

One last thing:
Where do you prefer to run those transfer transformations?
In the master-loop (before/after prepare message)?
During spi_verify (or after it)?

The advantage of spi-verify would be that we potentially run those
transformations in a different thread than message-pump allowing
to make better use of multiple CPUs. (This assumes that spi-async
is used or multiple drivers submit to spi_master concurrently,
so that queueing occurs and the message-pump thread is woken).

Actually the same argument of potential concurrency would also 
support the move of scatter/gather list generation into the same
place (which is essentially just another transformation)

I will rewrite those patches separating them out a bit more
and resubmitting them still based on the dev-res approach,
But renaming those structures.--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
