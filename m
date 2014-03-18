From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 2/2] spi/fsl-lib: Get the SPI controller bus number from DTS
Date: Tue, 18 Mar 2014 09:55:58 +0100
Message-ID: <CAMuHMdWHSVPDZ9q9rw0FZqNrR+E0q9pQcYLRiseopoM-K-5svg@mail.gmail.com>
References: <1394789757-40732-1-git-send-email-B48286@freescale.com>
	<1394789757-40732-2-git-send-email-B48286@freescale.com>
	<20140314191922.GA366@sirena.org.uk>
	<c4b28b01b2f544ca9d264eaee2542257@DM2PR03MB301.namprd03.prod.outlook.com>
	<20140317130109.GE11706@sirena.org.uk>
	<9186860716f446f9a5773e7e47d39114@DM2PR03MB301.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	"pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	"mark.rutland-5wv7dgnIgG8@public.gmane.org" <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	"ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org" <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	"galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org" <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org" <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	"Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Mingkai.Hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: "B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <9186860716f446f9a5773e7e47d39114-ufbTtyGzTTTk7ZsBhlipOOO6mTEJWrR4XA4E9RH9d+qIuWR1G4zioA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Mar 18, 2014 at 8:40 AM, B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org
<B48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
>> > > The DT already has support for specifying flash layouts, can't those
>> > > be used (for example via chosen if they're not fixed for the board)?
>> > > Or if it's just picking the correct filesystem then UUIDs and labels
>> > > are the standard way to do things.
>>
>> > The DT specifying flash layouts is ok. There is another way to make
>> > the flash layouts using command line, but it is not safe because of
>> > the dynamic bus_num. It is not the reason that the way of DT is
>> > supported flash layouts, to live the other way unsafe, right?
>>
>> This sounds to me like we need a better way of talking about flash device
>> names on the Linux command line rather than a way to fix the bus number -
>> for example, being able to refer to them using a fixed property like the
>> physical address.  Being able to refer to devices via an alias assigned
>> in the DT would also be useful (and more readable), I think there may
>> already be a mechanism for doing that which would need to be plumbed in
>> but I'm not 100% sure.
>
> The bus number is the variable designed to distinguish one spi controller
> from others. Why spi controller's physical address must be use instead of
> bus number?

Because the bus number is dynamic, while the physical address doesn't
change, so it can be used to uniqely identify the device before booting the
kernel.
Cfr. "spi1" vs. "e6e20000.spi".

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
