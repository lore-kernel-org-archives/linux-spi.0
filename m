From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] mtd: m25p80: consider max_transfer_size when reading
Date: Thu, 5 May 2016 16:57:00 -0700
Message-ID: <20160505235700.GA99474@google.com>
References: <56D22823.7090005@gmail.com>
 <20160405193952.GA5243@localhost>
 <57041B43.2000109@gmail.com>
 <20160405210727.GB5243@localhost>
 <5706B084.2070909@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Han Xu <han.xu-3arQi8VN3Tc@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5706B084.2070909-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

+ Mark, linux-spi (see the last bit)

Hi Heiner,

On Thu, Apr 07, 2016 at 09:09:56PM +0200, Heiner Kallweit wrote:
> Am 05.04.2016 um 23:07 schrieb Brian Norris:
> > On Tue, Apr 05, 2016 at 10:08:35PM +0200, Heiner Kallweit wrote:
> >> Am 05.04.2016 um 21:39 schrieb Brian Norris:
> >>>
> >>> Michal has been working on a similar series, with some differences (I'll
> >>> comment below). I think his latest work is here:
> >>>
> >>> http://lists.infradead.org/pipermail/linux-mtd/2015-December/063865.html
[...]
> I had a closer look at Michal's patch set, few remarks:

I would have much preferred you send your reviews in reply to his patch
emails...

> Patch 2 changes the semantics of the return value of m25p80_read/write and the
> related change to spi_nor_read/write is part of patch 4.
> Means if the first patches are applied only we get a faulty behavior.
> Usually this is undesirable, not sure whether it's acceptable here.

I think I've fixed that up here. I'll resend.

> Patch 2
> +	ret = m.actual_length - cmd_sz;
> +	if (ret < 0)
> +		return -EIO;
> I think we should add special handling for the case ret == 0.
> Usually this would indicate an error however there might be
> intentional zero-length read's (not sure about that).
> Therefore I'd propose to change the error condition to
> if (ret < 0 || (!ret && len))
> If zero-length reads are not possible we can simply change it to
> if (ret <= 0)

Why should we do this in m25p80? I'm doing it in spi-nor.c.

> Patch 7
> W/o the proposed change to patch 2 the case that nor->read()
> returns 0 isn't handled correctly.
> We'd bail out from the read loop but return 0.
> Instead we should return an error in this case.

Right. I've fixed this in patch 7, not in patch 2.

> With the change to patch 2 the case that nor->read() returns 0
> can't happen and we should change the error condition to
> if (ret < 0) for the sake of clarity.
> 
> Patch 8
> Made it to mainline already, can be removed.

Of course.

> Patch 10
> 1. min_t isn't needed here because both arguments are of type size_t.

Fixed.

> 2. At least in the case of fsl-espi the size limit refers to one
>    physical transfer (including the command) and therefore to the sum
>    of all transfers.
> We should change
> +	t[1].len = min_t(size_t, len, spi_max_transfer_size(spi));
> to
> +	t[1].len = min(len, spi_max_transfer_size(spi) - t[0].len);
> 
> Apart from that the patch set looks good to me.

That's not what Mark specified here:

http://lists.infradead.org/pipermail/linux-mtd/2015-November/063616.html

and that's not what the API's very *name* means; it says max transfer
size (where a spi_transfer is a very well-defined concept). You need to
fix the driver or take up the API issues with Mark if you want to
suggest we interpret this differently.

I won't be changing this bit for now.

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
