From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 2/2] dt/bindings: control CS via standard GPIO operations instead of SPI-HW
Date: Tue, 17 Mar 2015 08:12:26 +0100
Message-ID: <1B96F4D4-E072-4021-95F3-B985D1103BFF@martin.sperl.org>
References: <1425487205-5477-1-git-send-email-kernel@martin.sperl.org> <1425487205-5477-2-git-send-email-kernel@martin.sperl.org> <54FA9109.6080102@wwwdotorg.org> <A8477522-2A97-4D1B-89EC-A70B5A28489F@martin.sperl.org> <55079CF1.4000102@wwwdotorg.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55079CF1.4000102-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 17.03.2015, at 04:18, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>> But then it means in principle that this is a more general issue
>> that just became apparent now.
> 
> Yes.
> 
...
>> So this is maybe the way forward for the whole default-dt?
>> 
>> For SPI it would look like this:
>> &gpio {
>>        spi0_pins: spi0_pins {
>>                brcm,pins = <7 8 9 10 11>;
>>                brcm,function = <4>; /* alt0 */
>>        };
>> 	...
>> }
>> 
>> &spi0 {
>> 	...
>>        pinctrl-0 = <&spi0_pins>;
>> 	...
>> }
>> 
>> And if you keep spi0 disabled in the dtsi files then the ALT
>> modes should not be set.
> 
> Yes, so long as it's disabled by default that would be OK. However, I
> wonder why we don't just rely on the firmware to set up the pinmux,
> since as you mentioned it does it now?
...
>> Obviously we could also split the gpio-block into 
>> "normal SPI" and "CS" pins, which would allow changing the
>> "defaults" also in the dts that gets build.
>> 
>> So how should we proceed?
> 
> If we do put any default CS GPIO setup in the kernel DT, we should
> indeed put it into a separate node (pinctrl state) so that the user can
> override it easily without any interactions with any other pins/...
So I will create a patch to separate the spi portions out as 
mentioned above.

I will actually create 2 gpio-sections:
one for the SPI transfer pins (GPIO 9, 10, 11) 
and one for the chipselects (8, 7), which can get overridden
either as output or as ALT0 in a customized device tree.

SPI by default shall be disabled.

Martin
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
