From: Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv3 2/2] spi: imx: document use of native chip-selects in
 devicetree
Date: Wed, 19 Jul 2017 04:07:00 +0300
Message-ID: <63f017b2-3cf3-d219-5935-8543bd5af32b@mleia.com>
References: <1499746932-14850-1-git-send-email-gerg@linux-m68k.org>
 <1499746932-14850-3-git-send-email-gerg@linux-m68k.org>
 <CAOMZO5A6CZAQUh3mBpH3AdEtcTH-=tdMdqL-SV+4=zcstVQEaQ@mail.gmail.com>
 <42e1aad1-ca53-ba70-2922-25e2b083d971@mleia.com>
 <CAOMZO5B55NzBpZscqQECt=2nUQatnU7s2Oc8YLkxFa-dbaB=bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAOMZO5B55NzBpZscqQECt=2nUQatnU7s2Oc8YLkxFa-dbaB=bA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 07/19/2017 03:42 AM, Fabio Estevam wrote:
> Hi Vladimir,
> 
> On Tue, Jul 18, 2017 at 9:39 PM, Vladimir Zapolskiy <vz-ChpfBGZJDbMAvxtiuMwx3w@public.gmane.org> wrote:
> 
>> FWIW I tested on DT-only i.MX31, the change works acceptable.
> 
> MX31 has an issue with native chip select as far as I remember. Please
> check DSPhl22960 from the chip errata:
> http://www.nxp.com/docs/en/errata/MCIMX31CE.pdf

Oh, it's unpleasant, I didn't know or experience the issue, thank you
for information.

I can definitely tell that

a) my hardware (Logitech i.MX31 Litekit) does not allow to use GPIOs
instead of native chip selects for two SPI devices on board:
  Atmel AT93C66A EEPROM on CSPI1 pads selected by CS2,
  Freescale MC13783 PMIC on CSPI2 pads selected by CS0.

There is no option to mux CSPI1_SS2 or CSPI2_SS0 pad to GPIOs, so some
kind of native chip select support is needed for legacy hardware, even
if it is exposed to the errata item,

b) MC13783 PMIC on CS0 works fine with Greg's change,

c) actually there is no AT93C66A driver for better testing, but I do
experience issues with the native CS2, however as I said in another
email it is not related to Greg's change.

By the way I'm going to unrestrict DMA support on i.MX31, due to my
loose tests (only to/from MC13783) DMA transfers seem to work properly.

--
With best wishes,
Vladimir
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
