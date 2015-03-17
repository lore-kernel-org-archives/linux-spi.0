From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 2/2] dt/bindings: control CS via standard GPIO operations
 instead of SPI-HW
Date: Mon, 16 Mar 2015 21:18:09 -0600
Message-ID: <55079CF1.4000102@wwwdotorg.org>
References: <1425487205-5477-1-git-send-email-kernel@martin.sperl.org> <1425487205-5477-2-git-send-email-kernel@martin.sperl.org> <54FA9109.6080102@wwwdotorg.org> <A8477522-2A97-4D1B-89EC-A70B5A28489F@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <A8477522-2A97-4D1B-89EC-A70B5A28489F-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 03/11/2015 09:21 AM, Martin Sperl wrote:
>> On 07.03.2015, at 06:47, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>>
>> These pins aren't used by anything on the board, but are rather part of
>> the expansion header. I wonder if we wouldn't be better off removing any
>> configuration of the pins from the DT. After all, we can't guarantee how
>> the user has connected them. The "default" usage, a/k/a the expansion
>> header signal naming, isn't any guarantee.
>>
>> Rather, the user should specify what they want to use the pin as; as a
>> GPIO input, GPIO output, or an SPI chip-select.
> ...
>> While the existing DT already has this issue, note that this forces
>> these pins to be driven as outputs. What if the user has hooked up an
>> external device that drives these signals, and wants to use the pins as
>> GPIO inputs?
> 
> Actually if you look at the Documentation on page 102 you will find that
> those pins are pulled high by default (if it is HW or firmware I am not
> sure) - so a hat designer needs to take this into consideration anyway.
> The only difference is that it is pulled high and not driven high/low.

Assuming that table shows HW defaults as opposed to the pin's
capabilities for pull-up-vs-down, then yes. Still, there is typically
quite a difference in strength between a pull-up and a drive-up.

> Also with the "new" models there is the Firmware that will read those 
> "hat-descriptors" from the eeprom and configure the GPIO "modes" and
> pullups based on this information.

Yes, my thinking is we should probably rely on that, or an explicit user
modification of the DT, to configure the pinmux, rather than making
assumptions.

> But then it means in principle that this is a more general issue
> that just became apparent now.

Yes.

>> This shouldn't be in the SoC .dtsi file. It's quite possible for someone
>> to use other GPIOs as SPI CS. It's board or even use-case specific
>> whether those are the correct values.
>>
>> I would argue that we should not put any cs-gpios into any in-kernel DT
>> file, since there's no on-board usage of SPI on the RPi boards.
> 
> but then: why not just make it optional and NOT configuring it at all
> and keep it "outside".

Sorry, I don't quite understand that comment; outside what?

>> For SPI to be useful, the user has to add a DT node to represent the SPI
>> device itself anyway, so adding some properties to the controller to
>> define which GPIOs to use for SPI CS can be done then too.
> 
> From what I have seen (and I am not an expert) is that with the 
> foundation device trees each "device" (spi/i2c/...) has a separate
> Gpio section, which gets referenced inside the spi/i2c/... block.
> 
> As far as I understood with this setup the GPIOs ALT only gets set
> up when the driver itself loads (probably while parsing the DT
> for the device)

Yes, that is certainly possible.

> So this is maybe the way forward for the whole default-dt?
> 
> For SPI it would look like this:
> &gpio {
>         spi0_pins: spi0_pins {
>                 brcm,pins = <7 8 9 10 11>;
>                 brcm,function = <4>; /* alt0 */
>         };
> 	...
> }
> 
> &spi0 {
> 	...
>         pinctrl-0 = <&spi0_pins>;
> 	...
> }
> 
> And if you keep spi0 disabled in the dtsi files then the ALT
> modes should not be set.

Yes, so long as it's disabled by default that would be OK. However, I
wonder why we don't just rely on the firmware to set up the pinmux,
since as you mentioned it does it now?

> Obviously we could also split the gpio-block into 
> "normal SPI" and "CS" pins, which would allow changing the
> "defaults" also in the dts that gets build.
> 
> So how should we proceed?

If we do put any default CS GPIO setup in the kernel DT, we should
indeed put it into a separate node (pinctrl state) so that the user can
override it easily without any interactions with any other pins/...
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
