From: Thor Thayer <tthayer@opensource.altera.com>
Subject: Re: [PATCHv2 1/2] Documentation: dt: spi: Add GPIO Slave Select
 Parameter
Date: Fri, 7 Oct 2016 15:01:26 -0500
Message-ID: <f22a7978-f47a-3fbc-925f-9e7c85ed2bd3@opensource.altera.com>
References: <1475852194-27690-1-git-send-email-tthayer@opensource.altera.com>
 <CAMuHMdXuJbc+smiY8DNMYHiCuOxtt44o2N0eJvzq+FKUoZm+Rg@mail.gmail.com>
Reply-To: <tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        <jszhang@marvell.com>, <michael@smart-africa.com>,
        <kernel@mseidel.net>, linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXuJbc+smiY8DNMYHiCuOxtt44o2N0eJvzq+FKUoZm+Rg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On 10/07/2016 02:33 PM, Geert Uytterhoeven wrote:
> On Fri, Oct 7, 2016 at 4:56 PM,  <tthayer@opensource.altera.com> wrote:
>> From: Thor Thayer <tthayer@opensource.altera.com>
>>
>> Some SPI masters require the slave to be selected before a
>> transaction can occur - even in the case of GPIO chip select.
>>
>> This patch adds a GPIO slave select parameter to indicate
>> the slave needs to be selected in the GPIO CS case.
>>
>> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
>> ---
>> v2  Add to SPI framework - add bindings.
>> ---
>>  Documentation/devicetree/bindings/spi/spi-bus.txt |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
>> index 4b1d6e7..3a006bc 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
>> +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
>> @@ -24,6 +24,7 @@ support describing the chip select layout.
>>  Optional properties:
>>  - cs-gpios       - gpios chip select.
>>  - num-cs         - total number of chipselects.
>> +- gpio-ss        - use internal slave select with gpio chip select.
>>
>>  If cs-gpios is used the number of chip selects will be increased automatically
>>  with max(cs-gpios > hw cs).
>
> To me, this looks more like a new flag the SPI controller driver should
> set in spi_master.flags, instead of a DT property.
>
Yes, I see your point since this is SPI master specific. I'll respin as 
you suggest.

Thanks for reviewing!

> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
>
