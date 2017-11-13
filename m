From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: spi->irq == 0 on module reload of driver using IRQF_TRIGGER_LOW
Date: Mon, 13 Nov 2017 09:35:57 +0000
Message-ID: <87k1yuttaa.fsf@on-the-bus.cambridge.arm.com>
References: <21FDD1B8-E8F6-4DCE-9D30-D82B713B0008@martin.sperl.org>
        <20171112141349.6b4b3852@why.wild-wind.fr.eu.org>
        <CD4EBEF8-DDFD-40C3-A03E-7EC964B32357@martin.sperl.org>
        <20171112154101.483d21d2@why.wild-wind.fr.eu.org>
        <6CD8E928-2143-4295-A5B3-4B95026E7261@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6CD8E928-2143-4295-A5B3-4B95026E7261-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
        (kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org's message of "Sun, 12 Nov 2017 17:49:39
        +0100")
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sun, Nov 12 2017 at  5:49:39 pm GMT, <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> wrote:
>> On 12.11.2017, at 16:41, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org> wrote:
>>> +
>>> +            can0: mcp2517fd@0 {
>>> +                reg = <0>;
>>> +                compatible = "microchip,mcp2517fd";
>>> +                pinctrl-names = "default";
>>> +                pinctrl-0 = <&can0_pins>;
>>> +                spi-max-frequency = <12500000>;
>>> +                interrupt-parent = <&gpio>;
>>> +                interrupts = <16 0x2>;
>> 
>> This indicates a falling edge. No wonder the kernel is confused (I
>> don't know why this isn't enforced the first time though, probably an
>> issue in the GPIO irqchip driver...). Replacing this 2 with a 8 should
>> allow you to make some progress.
>
> Thanks for the clarification - with that change it works!
>
> For a better understanding:
> Isn’t the interrupt type to use more of a driver decision than a
> HW implementation detail that needs to get defined in the device tree?

Absolutely *not*. The signalling of an interrupt is completely HW
dependent, and the driver *must* use abide by the HW rule. That's
because edge and level interrupts signal entirely different things:

- An edge interrupt signals a an event. Something has happened, and many
  of these events can be signalled independently without the CPU doing
  anything.

- A level interrupt indicates a change of state, and this state persist
  until the CPU has services the interrupt.

That's the difference between receiving a SMS each time you pay
something your bank card, and receiving a phone call from your bank
because your account is overdrawn.

> In my case I probably could write some more code that would allow edge
> interrupts to work (without race-conditions on spi transfers - probably
> by using spi_async to reenable interrupts on the HW device), but it
> would not be as straight-forward and a bit more complex.

And more or less wrong, given that the spec sheet calls out "active low"
interrupts.

> Summary: Essentially the driver has to match the interrupt type -
> otherwise it will fail (on second initialization).

And even that is not quite right. The driver should fail straight
away. on the first request. I don't have the HW to track it down, but
I'd appreciate it if you could have a look and enlighten me.

Thanks,

	M.
-- 
Jazz is not dead, it just smell funny.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
