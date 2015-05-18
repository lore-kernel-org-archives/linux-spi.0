From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] Documentation: dt: mtd: replace "nor-jedec" binding with "jedec,spi-nor"
Date: Mon, 18 May 2015 20:51:46 +0200
Message-ID: <CAMuHMdUCj2AXk_0mAgRfAStrveHPi=Rp2g-b177zO_ode8NaCw@mail.gmail.com>
References: <1431624773-4165-1-git-send-email-computersforpeace@gmail.com>
	<20150515195541.GL11598@ld-irv-0074>
	<20150518104501.GD3551@leverpostej>
	<20150518183442.GR11598@ld-irv-0074>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150518183442.GR11598@ld-irv-0074>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Brian,

On Mon, May 18, 2015 at 8:34 PM, Brian Norris
<computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Mon, May 18, 2015 at 11:45:01AM +0100, Mark Rutland wrote:
>> On Fri, May 15, 2015 at 08:55:41PM +0100, Brian Norris wrote:
>> > It really helps if I test patches...
>> >
>> > On Thu, May 14, 2015 at 10:32:53AM -0700, Brian Norris wrote:
> [...]
>> > > @@ -305,7 +305,7 @@ static const struct spi_device_id m25p_ids[] = {
>> > >    * Generic support for SPI NOR that can be identified by the JEDEC READ
>> > >    * ID opcode (0x9F). Use this, if possible.
>> > >    */
>> > > - {"nor-jedec"},
>> > > + {"jedec,spi-nor"},
>> >
>> > So I forgot (again; we hit this before) that the SPI/OF framework strips
>> > everything before the first comma before binding devices. See
>> > of_modalias_node(). So I'll have to squash in the patch below to get a
>> > usable binding.
>>
>> Is it not possible to use the of_match_table on spi_driver::driver? If
>> not, we really should make it so.
>
> Hmm, it does look like spi.c supports multiple matching mechanisms, so I
> guess m25p80.c could match some with of_match_table and some with
> modalias/spi_driver.id_table. See:
>
> static int spi_match_device(struct device *dev, struct device_driver *drv)
> {
>         const struct spi_device *spi = to_spi_device(dev);
>         const struct spi_driver *sdrv = to_spi_driver(drv);
>
>         /* Attempt an OF style match */
>         if (of_driver_match_device(dev, drv))
>                 return 1;
>         // ^^^^ we aren't yet (but could be) using this
>
>         /* Then try ACPI */
>         if (acpi_driver_match_device(dev, drv))
>                 return 1;
>
>         if (sdrv->id_table)
>                 return !!spi_match_id(sdrv->id_table, spi);
>         // ^^^^ we're currently only using this
>
>         return strcmp(spi->modalias, drv->name) == 0;
> }
>
> I'll see about patching this for 4.2. We have a working solution for
> 4.1 at least.

When using DT:
  - spi_driver.id_table is used to match with vendor-stripped DT "compatible"
    entries.
  - spi_driver.driver.of_match_table is used to match with full DT "compatible"
    entries.

Note that stripping of vendor names from DT "compatible" entries is done
for the _first_ "compatible" entry in the device node only!
Hence

        compatible = "myvendor,m25p80";

will match against "m25p80" in m25p_ids[], while

        compatible = "myvendor,shinynewdevice", "st,m25p80";

will _not_ match against "m25p80" in m25p_ids[], and fail to probe in
the absence of a driver entry for the first (real) "compatible" entry.

I2c behaves similarly.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
