From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: Re: spi->irq == 0 on module reload of driver using IRQF_TRIGGER_LOW
Date: Sun, 12 Nov 2017 17:49:39 +0100
Message-ID: <6CD8E928-2143-4295-A5B3-4B95026E7261@martin.sperl.org>
References: <21FDD1B8-E8F6-4DCE-9D30-D82B713B0008@martin.sperl.org> <20171112141349.6b4b3852@why.wild-wind.fr.eu.org> <CD4EBEF8-DDFD-40C3-A03E-7EC964B32357@martin.sperl.org> <20171112154101.483d21d2@why.wild-wind.fr.eu.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171112154101.483d21d2-Fmn/x+r+pSA9//JtdbceeD8Kkb2uy4ct@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 12.11.2017, at 16:41, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org> wrote:
>> +
>> +            can0: mcp2517fd@0 {
>> +                reg = <0>;
>> +                compatible = "microchip,mcp2517fd";
>> +                pinctrl-names = "default";
>> +                pinctrl-0 = <&can0_pins>;
>> +                spi-max-frequency = <12500000>;
>> +                interrupt-parent = <&gpio>;
>> +                interrupts = <16 0x2>;
> 
> This indicates a falling edge. No wonder the kernel is confused (I
> don't know why this isn't enforced the first time though, probably an
> issue in the GPIO irqchip driver...). Replacing this 2 with a 8 should
> allow you to make some progress.

Thanks for the clarification - with that change it works!

For a better understanding:
Isn’t the interrupt type to use more of a driver decision than a
HW implementation detail that needs to get defined in the device tree?

In my case I probably could write some more code that would allow edge
interrupts to work (without race-conditions on spi transfers - probably
by using spi_async to reenable interrupts on the HW device), but it
would not be as straight-forward and a bit more complex.

Summary: Essentially the driver has to match the interrupt type - 
otherwise it will fail (on second initialization).

Thanks,
	Martin






--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
