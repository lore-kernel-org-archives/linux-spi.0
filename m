From: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/3] dt-bindings: spi: document bcm63xx HS SPI devicetree bindings
Date: Tue, 28 Feb 2017 14:11:04 +0100
Message-ID: <CAOiHx==wHRDqiWFkupmcj0iw8u6w36j8Lb-V_gq8oqKLei6Aww@mail.gmail.com>
References: <20170222131940.31085-1-jonas.gorski@gmail.com>
 <20170222131940.31085-2-jonas.gorski@gmail.com> <c21aadc6-cbcf-4948-0e40-b8aae0304430@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c21aadc6-cbcf-4948-0e40-b8aae0304430-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi,

On 27 February 2017 at 23:49, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On 02/22/2017 05:19 AM, Jonas Gorski wrote:
>> Add documentation for the bindings of the high speed SPI controller found
>> on newer bcm63xx SoCs.
>>
>> Signed-off-by: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  .../devicetree/bindings/spi/spi-bcm63xx-hsspi.txt  | 35 ++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt b/Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt
>> new file mode 100644
>> index 000000000000..3b0a2220b896
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/spi-bcm63xx-hsspi.txt
>> @@ -0,0 +1,35 @@
>> +Binding for Broadcom BCM6328 SPI controller

I missed a "High Speed" here.

>> +
>> +Required properties:
>> +- compatible: must contain of "brcm,bcm6328-hsspi".
>> +- reg: Base address and size of the controllers memory area.
>> +- interrupts: Interrupt for the SPI block.
>> +- clocks: phandle of the SPI clock.
>> +- clock-names: must be "hsspi".
>> +- #address-cells: <1>, as required by generic SPI binding.
>> +- #size-cells: <0>, also as required by generic SPI binding.
>> +
>> +Optional properties:
>> +- num-cs: some controllers have less than 8 cs signals. Defaults to 8
>> +  if absent.
>> +- clocks: a second handle for the PLL clock.
>> +- clock-names: must be named "pll", if present.
>
> I have not found chips where the PLL may be optional, but there may be
> ways to have the same PLL and UBUS clocks feeding into the HSSPI block.

Indeed, I guess I make it just non-optional. Having it as an optional
clock was (not intentionally) more describing the driver, not the
hardware. If there is ever only one clock, one could just pass it
twice. I'll update and send a V2.


Jonas
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
