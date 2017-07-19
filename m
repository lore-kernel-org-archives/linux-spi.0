From: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv3 2/2] spi: imx: document use of native chip-selects in
 devicetree
Date: Wed, 19 Jul 2017 03:39:04 +0300
Message-ID: <42e1aad1-ca53-ba70-2922-25e2b083d971@mleia.com>
References: <1499746932-14850-1-git-send-email-gerg@linux-m68k.org>
 <1499746932-14850-3-git-send-email-gerg@linux-m68k.org>
 <CAOMZO5A6CZAQUh3mBpH3AdEtcTH-=tdMdqL-SV+4=zcstVQEaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOMZO5A6CZAQUh3mBpH3AdEtcTH-=tdMdqL-SV+4=zcstVQEaQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Fabio,

On 07/19/2017 03:37 AM, Fabio Estevam wrote:
> Hi Greg,
> 
> On Tue, Jul 11, 2017 at 1:22 AM, Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
>> Document the "<0>" notation for specifying use of a native chip-select
>> in the "cs-gpios" tag of an SPI device in devicetree. This isn't unique
>> to the spi-imx driver, but this clearly spells out that you can use it
>> with this driver.
>>
>> Signed-off-by: Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
> 
> Whic SoC did you use to test the native chip-select?
> 
> I remember that some old SoCs (mx27/mx31) used to have issues with
> native chip-select.

FWIW I tested on DT-only i.MX31, the change works acceptable.

--
With best wishes,
Vladimir
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
