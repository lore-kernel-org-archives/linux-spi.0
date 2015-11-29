From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: Dynamically adding SPI buses (was: Re: [PATCH v8 0/8] Device Tree
 Overlays - 8th time's the charm)
Date: Sun, 29 Nov 2015 10:47:07 +0100
Message-ID: <CAMuHMdVxjzmOO5gwUs=sWU9hN+-xmEnMzMBn0C0Cc+J_wFuSYw@mail.gmail.com>
References: <CAMuHMdUPa6YMa98v+qXMnxeMZ41AKFY1ni12rJewSEnqSB7TRA@mail.gmail.com>
	<20151127132441.GS1929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Fiore <mfjord02-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>,
	Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151127132441.GS1929-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Mark,

On Fri, Nov 27, 2015 at 2:24 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Nov 27, 2015 at 02:06:41PM +0100, Geert Uytterhoeven wrote:
>> (replaying to an old mail, as I'm seeing the exact same behavior with current
>>  overlay code)
>
> I don't seem to have this mail...  I'm not even sure that mailing list
> archive does (at least
>
>    http://thread.gmane.org/gmane.linux.kernel.spi.devel/18597
>
> anyway).

It was sent to the devicetree mailing list only, without anyone else CCed.
Probably that's why no one noticed or replied to it before...

>> When adding an SPI master device node to DT, or changing its status to "okay",
>> of_register_spi_devices() will scan for SPI slaves, and will add all of them.
>> Later, the notifier kicks:
>
>>     static int of_spi_notify(struct notifier_block *nb, unsigned long action,
>>                              void *arg)
>>     {
>>             ...
>>
>>             case OF_RECONFIG_CHANGE_ADD:
>>                     master = of_find_spi_master_by_node(rd->dn->parent);
>>                     if (master == NULL)
>>                             return NOTIFY_OK;       /* not for us */
>>
>>                     spi = of_register_spi_device(master, rd->dn);
>
>> Woops, this fails, as the device has been added before!
>> Should the code just check for the existence of the SPI slave first, or would
>> that cause problems when just modifying an existing SPI slave node in DT?
>
> Looking at the I2C code it seems like it's using
> of_node_test_and_set_flag() to check for OF_POPULATED before
> instantiating, doing that manually in every place where it might
> instantiate a device and manually clearing when deinstantiating.

Thanks for looking into that!

> I have to say I don't entirely understand the logic behind how this
> stuff is supposed to work, it's confusing to me why we have separate
> dynamic and static instantiation paths in the first place or why this is
> open coded in the buses.  It seems like a more robust thing here is to
> always use the dynamic path even on static instantiation, or to move it
> more into the driver core.

Indeed.

> Ideally I'd like to see the I2C code factored out into the DT core but
> otherwise probably we have to cut'n'paste it.

I'll give that a try...

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
