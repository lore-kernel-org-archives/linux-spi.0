From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] spi: SPI_MASTER_MUST_* with scatter-gather only option and avoiding realloc
Date: Tue, 19 May 2015 16:17:33 +0200
Message-ID: <CA52E701-A9BF-45F1-AE2A-CD3E680CEAFC@martin.sperl.org>
References: <20150512165053.GE3066@sirena.org.uk> <1431597524-7907-1-git-send-email-kernel@martin.sperl.org> <20150519124632.GN2761@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150519124632.GN2761-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 19.05.2015, at 14:46, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>=20
> Like I say I'm not entirely convinced we need the extra flags over ju=
st
> using can_dma().
If you can tell me that:
	(master->flags & (SPI_MASTER_MUST_TX | SPI_MASTER_MUST_RX)) &&
	master->can_dma && master->can_dma(...)=20
means that we do NOT need real memory allocated in the first place but
we only expect a scatter list to be created=20
and memory allocated in all other cases then that be it.

I am just not convinced that this is necessarily true for all
existing (or future) drivers.

During my discovery questions you mentioned that for some drivers
it may not be as simple as
  tx =3D (xfer->tx_buf) ? xfer->tx_buf[i] : 0;

So this =E2=80=9Cextension=E2=80=9D of the API is to avoid the potentia=
l risk of
breaking other drivers by making the above assumption (with
additional calls to can_dma, which then we should start to cache)

>=20
>> It also fixes the insufficient cleanup in case __spi_map_msg returns
>> an error.
>=20
> This should be a separate patch.

The problem is that this came up while developing the patch, so
I left it in the patch, assuming there would be some feedback
that requires another version of the patch...

> This is updating a specific driver to use the new API you're adding,
> this should be in a separate patch.

At one occasion I got scolded for separating things out into different
patches (in that case api from implemetation), now the other way around=
,
but we can do that...

>=20
>> #ifdef CONFIG_HAS_DMA
>> +static int spi_map_null(struct spi_master *master, struct device *d=
ev,
>> +			struct sg_table *sgt,
>> +			struct sg_table *sgt_template,
>> +			void *buf,
>> +			enum dma_data_direction dir)
>> +{
>=20
> It's not obvious to me what this is supposed to do and it looks awful=
ly
> like it's duplicating the existing DMA mapping code (but if that's th=
e
> case the existing code should be using this not duplicating it so I
> guess not).  I think it's supposed to be for creating a scatterlist t=
hat
> repeatedly reused the same dummy page but there's this template thing=
,
> it's getting a buffer passed in and=E2=80=A6

OK, so the idea is that this situation ONLY happens when we have either
tx_buf or rx_buf for which we need to map the other transfer from a
=E2=80=9Cdummy/null=E2=80=9D page.

So maybe instead of spi_map_null it should get called spi_map_dummy.

The template is there to create an (almost) identical scatter lists for
both rx and tx (modulo PAGE_SIZE). So if we have a tx-scatter list of:
4, 8, 4103 bytes, and we need to do a dummy transfer for rx, then the
(basic) identical pattern of 4, 8, 4096, 7 would get created.

This kind avoids some restrictions that I have seen with the spi-bcm283=
5
hardware.

As for replication - the code is similar in some aspects,
but still serves a different purpose (especially with the templating).

Adding all that into one would mean actually merging tx and rx cases
into one piece of code, and I did not want to go that far.
Keep what is working.

Also if we would do that then we should also add additional features
like creating a list of scatter lists for some cases, when:
* an individual dma transfer to the HW can only be < 65536 bytes in
  length (the spi HW got a counter)
* or when individual entries in the scatter list are not a multiple
  of 4
we would need to add multiple sg lists and handle each one separately.
(again examples from spi-bcm2835)

This would be a much bigger change.

>=20
>> +	if (is_vmalloc_addr(buf)) {
>> +		vm_page =3D vmalloc_to_page(buf);
>> +		if (!vm_page) {
>> +			sg_free_table(sgt);
>> +			return -ENOMEM;
>> +		}
>> +		page_offset =3D offset_in_page(buf);
>> +	} else {
>> +		vm_page =3D NULL;
>> +		page_offset =3D 0;
>> +	}
>=20
> ...this is really weird for that case. =20
>=20
> I'd have expected to be allocating a scatterlist that transfers a
> specified length to/from a normal page sized kmalloc() buffer in whic=
h
> case we don't need to worry about vmalloc() or this template stuff.

vm_page actually serves as a flag what call should get used a little
further down - sg_set_page (in case of not null) or sg_set_buf.

This is there as I am not 100% sure that the allocation used as
buffer is ALWAYS of the same identical type on _all_ platforms
in all .config variants (and I want to avoid breaking things...

If you can tell me that it is always of one type (even when used
early during kernel initialization), then we can remove that.

> Why does the transmit handling use a scatterlist allocated for receiv=
e
> (and vice versa)?  This goes back to the lack of clarity about what
> spi_map_null() is doing.

See above about =E2=80=9Ctemplating"

>=20
>> 		if (max_tx) {
>> -			tmp =3D krealloc(master->dummy_tx, max_tx,
>> -				       GFP_KERNEL | GFP_DMA);
>> -			if (!tmp)
>> -				return -ENOMEM;
>> -			master->dummy_tx =3D tmp;
>> -			memset(tmp, 0, max_tx);
>> +			if (max_tx > PAGE_SIZE) {
>> +				tmp_tx =3D krealloc(master->dummy_tx, max_tx,
>> +						  GFP_KERNEL | GFP_DMA);
>> +				if (!tmp_tx)
>> +					return -ENOMEM;
>> +				master->dummy_tx =3D tmp_tx;
>> +				memset(tmp_tx, 0, max_tx);
>> +			} else {
>> +				tmp_tx =3D master->page_tx;
>> +			}
>=20
> This idea is fine but should be a separate patch.
>=20
> I'd expect it should be about as cheap to change the realloc to be th=
e
> max of max_tx and PAGE_SIZE (the code was written on the basis that w=
e'd
> basically get that behaviour from the allocator anyway most of the
> time though IIRC it will work in chunks smaller than a page) but this
> does save us the memset() on the transmit path which is handy.

Well - this comes mostly from the fact that we now have a PAGE that
is cleaned already (and we need it for mapping anyway), so=20
just make use of it as long as the size is small enough, which
probably happens in most cases.

Martin

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
