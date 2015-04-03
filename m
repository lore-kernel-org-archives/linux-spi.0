From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/4] spi: bcm-mspi: Make BCMA optional to support non-BCMA
 chips
Date: Fri, 03 Apr 2015 10:52:05 -0700
Message-ID: <551ED345.1000702@gmail.com>
References: <1428002603-21892-1-git-send-email-jonathar@broadcom.com>	<1428002603-21892-4-git-send-email-jonathar@broadcom.com> <CAHp75VcMg-8X8DtHbQrmugzWG5VzzHXcpWNiyrTT=qmuCvA95w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Rafal Milecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VcMg-8X8DtHbQrmugzWG5VzzHXcpWNiyrTT=qmuCvA95w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 03/04/15 06:38, Andy Shevchenko wrote:
> On Thu, Apr 2, 2015 at 10:23 PM, Jonathan Richardson
> <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org> wrote:
>> The Broadcom MSPI controller is used on various chips. The driver only
>> supported BCM53xx chips with BCMA (an AMBA bus variant). The driver is
>> refactored to make BCMA optional and provides a new config for non BCMA
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
>> +       void (*mspi_write)(struct bcm_mspi *mspi, u16 offset, u32 value);
>> +       u32 (*mspi_read)(struct bcm_mspi *mspi, u16 offset);
>> +};
> 
> To avoid ugly ifdefs I think better to split driver to core part and
> the actual driver part, at the end you will have something like
> mspi-core.c mspi-53xx.c mspi-whatever.c. Check for example spi-dw*.c
> 

Actually, I am really curious whether we need the special BCMA I/O
accessors in the first place, cannot we just access the MSPI core on
BCM53xx chips using regular MMIO? That would probably solve the
"problem" entirely. Rafal, did you try this before?

As for splitting the driver into a "library" driver which is mostly
independent from the bus and a bus-specific wrapper, I think BCMA is
really the only special case here, which is why I suggested earlier to
Jonathan that we might just prefer ifdefing things out instead of
creating a separate layer just for BCMA.
-- 
Florian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
