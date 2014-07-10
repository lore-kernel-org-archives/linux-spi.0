From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [RFC PATCH 1/2] spi: Add support for Zynq QSPI controller
Date: Thu, 10 Jul 2014 13:25:53 +0200
Message-ID: <CAMuHMdVcBBNQfA--vOqwsyypwdL4HGs7YuR-SkZPttxeMeRn5g@mail.gmail.com>
References: <1404982207-4707-1-git-send-email-harinik@xilinx.com>
	<1404982207-4707-2-git-send-email-harinik@xilinx.com>
	<CAMuHMdXO-PkQ+07F=aZEjvH1Kh7uhWK8i3V9w+1aHvvtg7wDoQ@mail.gmail.com>
	<CAFcVECJ93Lw1MRVU-=zLRbB6To--zmAxz8OLObu=mhV84-FTNA@mail.gmail.com>
	<CAMuHMdU2HyCwXBJTAyswyj7XqhzhHQ24MamGLLVgMwU4xi0kxQ@mail.gmail.com>
	<CAFcVEC+-bM91WmfwweDdTvJ7KwH+dxKDLkzsT82snWKhukLeYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	=?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex-ynQEQJNshbs@public.gmane.org>,
	Artem Bityutskiy <artem.bityutskiy-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>,
	"michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org" <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Punnaiah Chou
To: Harini Katakam <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFcVEC+-bM91WmfwweDdTvJ7KwH+dxKDLkzsT82snWKhukLeYQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Harini,

On Thu, Jul 10, 2014 at 12:33 PM, Harini Katakam
<harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Thu, Jul 10, 2014 at 3:12 PM, Geert Uytterhoeven
> <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
>> On Thu, Jul 10, 2014 at 11:31 AM, Harini Katakam
>> <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>>>> +       master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
>>>>> +                           SPI_TX_DUAL | SPI_TX_QUAD;
>>>>
>>>> Your driver advertises Dual/Quad SPI Transfer capabilities, but it doesn't
>>>> check spi_transfer.[tr]x_nbits? How can it determine when to enable Dual/Quad?
>>>
>>> Here the driver is just giving information that the controller support it.
>>> The MTD layer enables dual/quad based on what the flash supports; quad
>>> being the first priority
>>> I understand that the spi core reads rx, tx-bus-width property and
>>> master support flags and
>>> performs the necessary checks.
>>
>> That's correct: as long as the rx, tx-bus-width  properties do not indicate a
>> Dual or Quad wiring, it won't be used.
>>
>> However, based on schematics, someone may set the rx, tx-bus-width properties
>> to 4, which is correct, as DT describes the hardware. But this will fail to
>> work.
>> So I think it's safer not to announce Dual/Quad support in the driver until
>> the actual driver support is there.
>
> OK. Correct me if I'm wrong but announcing this support in master->flags is
> just to say the controller supports it - Like Punnaiah mentioned in the other
> mail, nothing specific needs to be done from the controller driver to enable
> dual/quad support. This is at the SOC/IP level.
> I agree it might or might not be supported at board-level.

IC. So this is not a generic SPI controller, but a controller meant for QSPI
FLASHes? I.e. if you would connect a different device, the controller may
unexpectedly use Dual or Quad mode if it sees a byte fly by that looks like
a Quad SPI FLASH read command?

> But that's based on the user's hardware. Should master->flags
> really take this into consideration?

You mean master->mode_bits?

> BTW, I dint see master->mode_bits being used anywhere at the moment.

It is used to match SPI controller and slave features, cfr. spi_setup() in
drivers/spi/spi.c.

If Dual/Quad is supported, the bits should be set. Else spi_setup() will
clear the bits in the SPI slave's mode field, disabling Dual/Quad transfers.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
