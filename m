From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/5] m25p80,spi-nor: Fix module aliases for m25p80
Date: Tue, 30 Sep 2014 07:09:38 +0200
Message-ID: <CACna6rxBFNvF5bouv9KkS-3=TxcXVMrs30KMTS0mCjDAva4jiA@mail.gmail.com>
References: <1410714624.3040.38.camel@decadent.org.uk>
	<1410714670.3040.39.camel@decadent.org.uk>
	<20140928222150.GC3248@norris-Latitude-E6410>
	<CACna6rx=GyZ-4JpDix==WKszABseQXK6qCCkfiKCm9-WzBmM3A@mail.gmail.com>
	<1412042858.9388.79.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Ian Campbell <ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	debian-kernel <debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1412042858.9388.79.camel-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 30 September 2014 04:07, Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org> wrote:
> On Mon, 2014-09-29 at 08:36 +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
>> On 29 September 2014 00:21, Brian Norris <computersforpeace-Re5JQEeQqe8@public.gmane.org=
m> wrote:
>> > + Rafal
>> >
>> > Rafal has been looking at the same area of code. I'd really like t=
o get
>> > this patch into 3.18 if possible, so the more eyes the better.
>>
>> Thanks Brian.
>>
>> I took me a while to follow this issue, too bad I wasn't subscribed =
to
>> the ML earlier. Let me try to sum it up.
>>
>>
>>
>> 1) The main urgent issue: broken auto-loading
>> Tracked in the thread: http://www.spinics.net/lists/linux-spi/msg017=
26.html
>> Problem: m25p80.c references spi_nor_ids (from external file)
>> Short-term solution: duplicate IDs in the m25p80.c
>>
>> Ben: just like Brian, I think the patch like this one (
>> [PATCH 1/5] m25p80,spi-nor: Fix module aliases for m25p80
>> ) is the way to go. However few comments:
>>
>> a) I don't see why you modify m25p_probe in it.
>
> Because spi_nor_scan() requires a struct spi_device_id with the
> driver_data field pointing to a struct flash_info.

More friendly explanation: because spi_get_device_id uses driver's
id_table (that was now changes to pure strings).
I see the point.


>> b) I don't think the described clean solution (you described it in t=
he
>> commit message):
>> > A clean solution to this will involve defining the list of device
>> > IDs in spi-nor.h and removing struct spi_device_id from the spi-no=
r
>> > API, but this is quite a large change.
>> is the correct one. I think there should be a single string to trigg=
er
>> m25p80 load and the rest should be handled using JEDEC, with some
>> workarounds for incompatible devices only.
>
> That certainly makes sense for Linux-specific platform data, but I do=
n't
> think it works for Device Tree "compatible" strings (see
> <http://mid.gmane.org/1410660009.3040.29.camel-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>).

We could simply follow the way Linux-specific platform data works. We
could always use
compatible =3D "m25p80";
and then for some rare cases (where JEDEC fails) add something like
model =3D "at25df321a";


>> b) Removing spi_nor::read_id
>> https://patchwork.ozlabs.org/patch/389073/
>> Ben: I think this one has a NACK from me, because I'm going to use
>> custom read_id in the bcm53xxspiflash driver.
>> See following thread for bcm53xxspiflash description:
>> http://comments.gmane.org/gmane.linux.drivers.mtd/54578
>> Initial commit (it uses read_id): https://patchwork.ozlabs.org/patch=
/381902/
> [...]
>
> But it has to use spi_nor_match_id() because of the driver_data
> requirement.  This just illustrates that the read_id operation doesn'=
t
> make sense as currently defined.

I agree, however there is already a patch in progress handling that:
https://patchwork.ozlabs.org/patch/377917/


> I accept that there will be a need for a read_id operation, but I thi=
nk
> it should fill in a struct flash_info rather than requiring every chi=
p
> to be described and named in spi-nor.c.

=46lashes not supporting JEDEC are usually some weird versions of norma=
l
flashes with JEDEC support. So I think we could still have them in the
spi-nor database and let users provide the name instead of filling the
whole struct flash_info.

--=20
Rafa=C5=82
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
