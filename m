From: Mitch Bradley <wmb-D5eQfiDGL7eakBO8gow8eQ@public.gmane.org>
Subject: Re: [PATCH v2 01/12] ARM: Orion: DT support for IRQ and GPIO
 Controllers
Date: Thu, 05 Jul 2012 08:36:53 -1000
Message-ID: <4FF5DEC5.9030707@firmworks.com>
References: <1341325365-21393-1-git-send-email-andrew@lunn.ch>
 <20120705130819.GV17534@lunn.ch> <4FF5A15A.8070309@googlemail.com>
 <201207051454.24475.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>,
 devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
 linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
 linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <201207051454.24475.arnd-r2nGTMty4D4@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-spi.vger.kernel.org

On 7/5/2012 4:54 AM, Arnd Bergmann wrote:
> On Thursday 05 July 2012, Sebastian Hesselbarth wrote:
>> Andrew,
>>
>> is it possible to group all gpio banks into one DT description?
>> For mach-dove it could be something like:
>>
>> gpio: gpio-controller {
>>          compatible = "marvell, orion-gpio";
>>          ...
>>
>>          bank0@d0400 {
>>                  reg = <0xd0400 0x40>;
>>                  ngpio = <8>;
>>                  mask-offset = <0>;
>>                  interrupts = <12>;
>>          };
>>
>>          bank1@d0400 {
>>                  reg = <0xd0400 0x40>;
>>                  ngpio = <8>;
>>                  mask-offset = <8>;
>>                  interrupts = <13>;
>>          };
>
> This way you have multiple nodes with the same register
> and different names, which is not how it normally works.

The "mask-offset" property is really a "reg" in disguise.

"reg" is considerably more general than just "memory mapped
register address".  It really means "any numeric identifier
that makes sense in the context of a parent device".

Therefore, one could say:

gpio: gpio-controller {
          compatible = "marvell, orion-gpio";
          reg = <0xd0400 0x40>;
          #address-cells = <1>;
          #size-cells = <0>;
          ...

          bank0@0 {
                  reg = <0x0>;
                  ngpio = <8>;
                  mask-offset = <0>;
                  interrupts = <12>;
          };

          bank1@8 {
                  reg = <0x8>;
                  ngpio = <8>;
                  interrupts = <13>;
           };

>
>>
>> This would have the advantage that DT describes gpio-to-irq dependencies.
>> Moreover, nodes that reference gpios can do gpios = <&gpio 71 0>; instead of
>> gpios = <&gpio3 7 0>;
>
> Is that desired?
>
> The device tree representation should match what is in the data sheet
> normally. If they are in a single continuous number range, then we should
> probably have a single device node with multiple register ranges
> rather than one device node for each 32-bit register. Looking at
> arch/arm/plat-orion/gpio.c I think that is not actually the case though
> and having separate banks is more logical.
>
> Something completely different I just noticed in the original patch:
>
>> @@ -90,6 +74,27 @@ static void pmu_irq_handler(unsigned int irq, struct irq_desc *desc)
>>        }
>>   }
>>
>> +static int __initdata gpio0_irqs[4] = {
>> +     IRQ_DOVE_GPIO_0_7,
>> +     IRQ_DOVE_GPIO_8_15,
>> +     IRQ_DOVE_GPIO_16_23,
>> +     IRQ_DOVE_GPIO_24_31,
>> +};
>> +
>> +static int __initdata gpio1_irqs[4] = {
>> +     IRQ_DOVE_HIGH_GPIO,
>> +     0,
>> +     0,
>> +     0,
>> +};
>
> I think the latter one needs to be
>
> +static int __initdata gpio1_irqs[4] = {
> +     IRQ_DOVE_HIGH_GPIO,
> +     IRQ_DOVE_HIGH_GPIO,
> +     IRQ_DOVE_HIGH_GPIO,
> +     IRQ_DOVE_HIGH_GPIO,
> +};
>
> so we register all four parts to the same primary IRQ. The
> same is true for the devicetree representation.
>
> 	Arnd
>
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>
