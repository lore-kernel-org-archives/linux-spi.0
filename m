From: Torsten Fleischer <torfl6749-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: spi-gpio: Add dt support for a single device
 with no chip select
Date: Thu, 30 Oct 2014 07:52:08 +0100
Message-ID: <CANZ4BrT8noz+zueDm2hModbduamnhSZj2F1VamckahoXUjAcGg@mail.gmail.com>
References: <1414423637-2817-1-git-send-email-torfl6749@gmail.com>
	<20141027173055.GD4971@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141027173055.GD4971@leverpostej>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2014-10-27 18:30 GMT+01:00 Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>:
> On Mon, Oct 27, 2014 at 03:27:17PM +0000, Torsten Fleischer wrote:
>> From: Torsten Fleischer <torfl6749-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> Use an empty 'cs-gpios' property if a single device is connected which
>> has no chip select.
>> This refers to the discussion at https://lkml.org/lkml/2013/11/13/62.
>>
>> Signed-off-by: Torsten Fleischer <torfl6749-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/spi/spi-gpio.txt |  6 ++++--
>>  drivers/spi/spi-gpio.c                             | 10 +++++++---
>>  2 files changed, 11 insertions(+), 5 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-gpio.txt b/Documentation/devicetree/bindings/spi/spi-gpio.txt
>> index 8a824be..ad8795f 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-gpio.txt
>> +++ b/Documentation/devicetree/bindings/spi/spi-gpio.txt
>> @@ -8,8 +8,10 @@ Required properties:
>>   - gpio-sck: GPIO spec for the SCK line to use
>>   - gpio-miso: GPIO spec for the MISO line to use
>>   - gpio-mosi: GPIO spec for the MOSI line to use
>> - - cs-gpios: GPIOs to use for chipselect lines
>> - - num-chipselects: number of chipselect lines
>> + - cs-gpios: GPIOs to use for chipselect lines. Leave this property empty if
>> +             a single device with no chip select is connected.
>> + - num-chipselects: Number of chipselect lines. Has to be "1" even if a single
>> +                    device with no chip select is connected.
>
> Why not just have num-chipselectes = <0>, and no cs-gpios property?
>
> That would match the HW, and is unambigious as the author has to state
> explicitly that there are no chipselects.

Thanks for the objection. I agree to your proposal. This is a clearer
way to describe such
a hardware. I will send an updated patch.

Torsten
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
