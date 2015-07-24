From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: bcm2835: add spi-bcm2835aux driver for the auxiliar
 spi1 and spi2
Date: Thu, 23 Jul 2015 22:09:30 -0600
Message-ID: <55B1BA7A.1090104@wwwdotorg.org>
References: <1434980408-4086-1-git-send-email-kernel@martin.sperl.org> <55A0A150.3060809@wwwdotorg.org> <ECFBB7BF-1316-4565-B1F2-FB2651131882@martin.sperl.org> <55A49662.3000706@wwwdotorg.org> <2768BFA9-7FE9-4EDC-8692-AC3F070BD874@martin.sperl.org> <55AEF828.20908@wwwdotorg.org> <0125992E-40F4-4702-8404-2943FF9A8788@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0125992E-40F4-4702-8404-2943FF9A8788-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 07/22/2015 10:28 AM, Martin Sperl wrote:
> 
> 
>> On 22.07.2015, at 03:55, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org> wrote:
>>
>> However, I'd like to see a "semantic" driver for the shared register
>> region rather than a "syscon". IIUC, "syscon" simply provides a stylized
>> way for one driver to touch some shared registers directly without any
>> semantics. I'd strongly prefer to see a real driver inside Linux rather
>> than something that just lets drivers fiddle with the shared registers
>> willy nilly. Still, this aspect is an internal implementation detail
>> inside the kernel that we can change without external impact later if we
>> need.
>>
>> More concerning: The bcm283x HW doesn't implement a "syscon" module, but
>> some semantic IP block. The DT should contain a real compatible value
>> that describes what the HW block really is, not just "syscon". We could
>> bind the syscon driver to this compatible value if we have to for
> 
> So, do I understand you correctly that if we would call the node 
> bcm2835aux_enable as syscon with only the enable bit field register in it 
> and add a enable_reg (pointing to the above) and enable_reg_mask=2 or 4
> to the spi1/2 nodes then it would be acceptable? 
> 
> Would look like this:
> spi2@7e2150c0 {
> +    compatible = "brcm,bcm2835-aux-spi";
> +    reg = <0x7e2150c0 0x40>;
> +    interrupts = <1 29>;
> +    clocks = <&clk_spi>;
> +    #address-cells = <1>;
> +    #size-cells = <0>;
> +    cs-gpios = <&gpio 43>, <&gpio 44>, <&gpio 45>;
> +    enable_reg = <&bcm2835aux_enable>;
> +    enable_reg_mask = 4;
> +};
> +
> +/* the necessary syscon config referenced above */
> +bcm2835aux_enable: bcm2835aux_enable@0x7e215004 {
> +    compatible = "syscon";
> +    reg = <0x7e215004 0x04>;
> +};
> 
> 
> The uart aux driver would use:
> +    enable_reg = <&bcm2835aux_enable>;
> +    enable_reg_mask = 1;

I think I'd expect the shared registers to be:

bcm2835aux: misc@0x7e215000 {
    compatible = "brcm,bcm2835-aux";
    reg = <0x7e215000 0x08>;
};

There are two 4-byte registers outside the UART/SPI blocks, and the
compatible value should reflect what the block is, not that Linux may
use a syscon driver to implement the driver for it.

In the client, I'd expect a more semantic naming for the reference;
something like:

	brcm,aux = <&bcm2835aux 4>;

brcm, since it's a custom/vendor-specific property. aux is the name of
the object that's referenced. Packing the phandle and data together into
a single property reduces the number of separate properties, and is a
typical thing to do in a client of a service in DT.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
