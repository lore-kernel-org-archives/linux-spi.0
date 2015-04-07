From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH] spi: bcm2835: transform native-cs to gpio-cs on first
 spi_setup
Date: Tue, 07 Apr 2015 14:15:26 +0200
Message-ID: <5523CA5E.3020200@martin.sperl.org>
References: <1428340592-3196-2-git-send-email-kernel@martin.sperl.org> <20150406172913.GW6023@sirena.org.uk> <12F93D4D-EDCB-4F48-B42B-049ECAD7F5E8@martin.sperl.org> <20150406174552.GY6023@sirena.org.uk> <F4571783-619C-4664-B14F-207E2D3F60C3@martin.sperl.org> <20150406181033.GB6023@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150406181033.GB6023-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 2015-04-06 20:10, Mark Brown wrote:
> People adding things to the standard kernel (presumably people push
> their board support in there) would still have to work out which
> chip select corresponds to which GPIO and write that mapping into
> their DT with the corresponding loss of legibility there, and of
> course there's the cost of modifying existing users.
>
> It *would* be nice if the mapping to which pin has which function
> were pushed into the pinctrl driver (and then possibly into the DT
> for it) but generally this seems like something we should be doing
> more of not less of.
>
The foundation gets to a point of using device-tree overlays to minimize
this kind of manual changes - the default still would include CS0=GPIO8
and CS1=GPIO7. If someone needs more CS, then the extra CS needs to get
configured in an overlay overriding those pins - so not a huge
difference

If we add "cs_gpios = <&gpio 8 0> <&gpio 7 0>" to the dtsi or assume it
is native, where this code essentially does what is needed to translate
it to the above.

Just tell me if we need spi_bus_lock on the "change" path to avoid
unpleasant behavior and I will create a patch incorporating that.
Spi_setup can sleep, so we can wait for the bus to become idle before
such a change...

Alternatively we could also add something like:
     int initial_chip_select_setup(int cs, int cspol);
as a method in spi_master that the framework would call prior to
registering all spi_devices with spi_device_register.

In the code for the spi-bcm2835 we can run the native-CS to GPIO
translation.

I could create a patch that handles this.

If you like it as is, merge it.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
