From: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH v2] spi: orion: support armada extended baud rates
Date: Fri, 05 Sep 2014 10:36:10 +1000
Message-ID: <5409057A.6090900@uclinux.org>
References: <1409835268-29555-1-git-send-email-gerg@uclinux.org> <CAMuHMdWDOaPnmCzThqCo2848eDj6jmi-eaXM1YAXQLi41da34A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdWDOaPnmCzThqCo2848eDj6jmi-eaXM1YAXQLi41da34A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Geert,

On 04/09/14 23:17, Geert Uytterhoeven wrote:
> On Thu, Sep 4, 2014 at 2:54 PM,  <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org> wrote:
>> The Armada SoC family implementation of this SPI hardware module has
>> extended the configuration register to allow for a wider range of SPI
>> clock rates. Specifically the Serial Baud Rate Pre-selection bits in the
>> SPI Interface Configuration Register now also use bits 6 and 7 as well.
>>
>> Modify the baud rate calculation to handle these differences for the
>> Armada case. Potentially a baud rate can be setup using a number of
>> different pre-scalar and scalar combinations. This code tries all
>> possible pre-scalar divisors (8 in total) to try and find the most
>> accuate set.
> 
> Are the Orion rates and register bits a subset of the Armada ones?
> I.e. does the Armada work with the Orion setup?

The bits used by the orion are a subset (bits 0-4 of the SPI
configuration register) of those used by the armada (bits 0-4 and
6-7).

In practice the defined prescalar values for the orion do give
the same divisor for the same bits set on armada. The extra bits
on the armada let you get to lower SPI baudrates (which is more of
a problem on the armada with its higher core clocks).


>> This change introduces a new device tree compatible device name
>> "armada-spi". This is used in place of "orion-spi" on the Armada SoC
>> parts.
> 
>> -                               compatible = "marvell,orion-spi";
>> +                               compatible = "marvell,armada-spi";
> 
> If the answer to my above question is yes, you want to keep
> "marvell,orion-spi" as a fallback.

Do you mean like this?

  compatible = "marvell,orion-spi", "marvell,armada-spi";

Regards
Greg

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
