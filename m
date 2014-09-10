From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Autoloading of SPI/nor driver on kirkwood (qnap devices)
Date: Tue, 9 Sep 2014 23:11:18 -0700
Message-ID: <CAN8TOE_BRyg=Ww0oOxGeRr5Xkwh5hTq0UKQAR2dFjRVfwcBZoQ@mail.gmail.com>
References: <1409673299.14324.43.camel@dagon.hellion.org.uk>
	<1409796689.27524.34.camel@decadent.org.uk>
	<CAMuHMdWBr=B0_Xivti9K5ReryHHEunQj2P26FjhmzhO-L9t+9g@mail.gmail.com>
	<20140910060004.GA5732@norris-Latitude-E6410>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	MTD Maling List <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Ian Campbell <ijc-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	debian-kernel <debian-kernel-0aAXYlwwYIJuHlm7Suoebg@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140910060004.GA5732@norris-Latitude-E6410>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

+ Huang (his Freescale address is bouncing), Rafal

On Tue, Sep 9, 2014 at 11:00 PM, Brian Norris
<computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Thu, Sep 04, 2014 at 09:02:04AM +0200, Geert Uytterhoeven wrote:
>> On Thu, Sep 4, 2014 at 4:11 AM, Ben Hutchings <ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org> wrote:
>> >> I noticed that many platforms declare the flash chip as compatible =
>> >> "st,m25pXXX" whereas the ts219.dtsi just said m25p128 but I tried
>> >> changing that and it didn't help. In any case without spi-nor.ko being
>> >> autoloaded I don't support m25p80.ko ever would be.
>> >
>> > m25p80.c has:
>> >
>> > static struct spi_driver m25p80_driver = {
>> >         ...
>> >         .id_table       = spi_nor_ids,
>> >         ...
>> > };
>> >
>> > while spi_nor_ids is defined in spi-nor.c.  Since they end up as two
>> > separate modules, modpost can't read the ID table and add the device ID
>> > aliases to m25p80.ko.
>>
>> Woops. This indeed doesn't work.
>> Note that the MODULE_DEVICE_TABLE() is also gone from m25p80.c
>>
>> So m25p80.c needs to contain the IDs, while spi-nor.c also needs the IDs
>> because it's a framework/library.
>
> Actually, m25p80.c only needs the strings (i.e., the named aliases --
> character data), and for the most part, spi-nor.c only needs the IDs (i.e.,
> the identification bytes).
>
> What's more, I don't think that any modern SPI NOR user really needs to
> be specifying exactly which SPI device it is via a specific string. Our
> driver code pretty much always re-detects the device by reading its
> device ID. All the SPI NOR code needs to know is how to read its ID.
>
>> A quick solution would be to move the ID table to a header file, and include
>> that by both, and re-add the lost MODULE_DEVICE_TABLE() to m25p80.c.
>> That duplicates the data, though.
>>
>> Hmm, for the built-in case, we can avoid the duplication by letting m25p80.c
>> refer to the table in spi-nor.c if !MODULE.
>> Does anyone see a better solution?
>
> A little bit of a shot in the dark, as I haven't fleshed this one out:
>
> Would it work to just copy the SPI ID strings into m25p80.c, keep the
> full table in spi-nor.c, stop adding SPI ID string (and DT) bindings to
> the m25p80 table (force platforms to use "m25p80"-compatible probing, or
> maybe something generic like "spi-nor-rdid", "spi-nor-sfdp", etc.) and
> eventually kill the strings from spi-nor.c entirely? I really don't want
> to propagate string-binding much further into the SPI NOR library, since
> everything should be auto-detectable--partly just by an ID table as we
> have now, but eventually we can use CFI or SFDP parameters provided by
> relatively new SPI NOR chips.
>
> I'm not sure if this is great for the short-term problem of fixing
> module-autoloading. Perhaps we should do a short-term hack to duplicate
> the SPI ID strings to m25p80.c by including them in a header (and
> backport for 3.16.y stable?), but I'd like to disentangle this.
>
> Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
