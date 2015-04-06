From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: bcm-mspi: Make BCMA optional to support non-BCMA chips
Date: Mon, 6 Apr 2015 12:26:55 +0200
Message-ID: <CACna6rx6ogbK=0rbmNCOYUyyP2rC+Tb5xpMeb45kcNS8eCRfsw@mail.gmail.com>
References: <1428002603-21892-1-git-send-email-jonathar@broadcom.com>
	<1428002603-21892-4-git-send-email-jonathar@broadcom.com>
	<CAHp75VcMg-8X8DtHbQrmugzWG5VzzHXcpWNiyrTT=qmuCvA95w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VcMg-8X8DtHbQrmugzWG5VzzHXcpWNiyrTT=qmuCvA95w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 3 April 2015 at 15:38, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> w=
rote:
> On Thu, Apr 2, 2015 at 10:23 PM, Jonathan Richardson
> <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> wrote:
>> The Broadcom MSPI controller is used on various chips. The driver on=
ly
>> supported BCM53xx chips with BCMA (an AMBA bus variant). The driver =
is
>> refactored to make BCMA optional and provides a new config for non B=
CMA
>> systems.
>
>>  struct bcm_mspi {
>> +       #ifdef CONFIG_SPI_BCMA_MSPI
>>         struct bcma_device *core;
>> -       struct spi_master *master;
>> +       #endif
>>
>> +       void __iomem *base;
>> +       struct spi_master *master;
>>         size_t read_offset;
>
>> +       void (*mspi_write)(struct bcm_mspi *mspi, u16 offset, u32 va=
lue);
>> +       u32 (*mspi_read)(struct bcm_mspi *mspi, u16 offset);
>> +};
>
> To avoid ugly ifdefs I think better to split driver to core part and
> the actual driver part, at the end you will have something like
> mspi-core.c mspi-53xx.c mspi-whatever.c. Check for example spi-dw*.c

I also believe we usually (always?) don't align any #if-s (no indent/ta=
bs).

--=20
Rafa=C5=82
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
