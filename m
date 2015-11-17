From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: Re: spi: OF module autoloading is still broken
Date: Tue, 17 Nov 2015 10:14:27 -0300
Message-ID: <564B2833.8030100@osg.samsung.com>
References: <20151113194031.GI8456@google.com>
 <20151113221228.GT12392@sirena.org.uk> <20151113225113.GJ8456@google.com>
 <20151113231410.GV12392@sirena.org.uk> <20151113234857.GK8456@google.com>
 <564A101F.9090807@osg.samsung.com> <20151116192434.GO8456@google.com>
 <564A35EB.5080008@osg.samsung.com> <20151116204702.GP8456@google.com>
 <564A4B66.6090107@osg.samsung.com> <20151116215144.GQ8456@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151116215144.GQ8456-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Brian,

On 11/16/2015 06:51 PM, Brian Norris wrote:
> On Mon, Nov 16, 2015 at 06:32:22PM -0300, Javier Martinez Canillas wrote:

[snip]

>>
>> Let's suppose you have 3 different IP's blocks (i.e: pmics) from the same
>> vendor. The IP's are quite similar but only differ in that use a different
>> bus to communicate with the SoC.
> 
> Ah, I thought that's what you might have meant, but then I reread enough
> times that I confused myself. I think my first understanding was correct
> :)
>

:)
 
>> So you could have a core driver and transport drivers for SPI and I2C.
>>
>> So currently you could use the not too creative compatible strings compatible
>> string "acme,my-pmic" in all the drivers and is not a problem because the SPI
>> and I2C subsystem will always report the MODALIAS uevent as:
>>
>> MODALIAS=i2c:my-pmic and MODALIAS=spi:my-pmic
>>
>> so as far as there is a "my-pmic" entry in the SPI and I2C id tables, module
>> autoload will work and the match will also work since that happens per bus_type.
>>
>> But if SPI and I2C are migrated to OF modalias reporting, then both I2C and SPI
>> will report (assuming the device node is called pmic in both cases):
>>
>> MODALIAS=of:NpmicT<NULL>Cacme,my-pmic
>>
>> That's what I meant when said that the modalias namespace is flat in the case of
>> OF but is separated in the case of board files and the current implementation.
> 
> Thanks for the additional explanation.
> 

You are welcome.

>> What currently the drivers are doing is to name the model my-pmic-{i2c,spi,etc}
>> but I think that the subsystem information should be explicitly present in the
>> OF modalias information as it is for legacy device registration.
> 
> Lest someone else wonder whether this is theoretical or not, I'll save
> them the work in pointing at an example: "st,st33zp24". See:
> 
> Documentation/devicetree/bindings/security/tpm/st33zp24-*.txt
> 
> and the code is in drivers/char/tpm/st33zp24/, sharing the same core
> library, suggesting that the devices really are the same except simply
> the bus.
> 

Thanks for pointing out that example although for that specific case,
the drivers' compatible are "st,st33zp24-i2c" and "st,st33zp24-spi" to
avoid the issue explained before.

Another example is Documentation/devicetree/bindings/mfd/cros-ec.txt
and code in drivers/mfd/cros_ec* where the EC is the same and all the
logic is in the core but only the transport bus changes for each driver.

Compatible strings again are using IP + bus:

"google,cros-ec-i2c"
"google,cros-ec-spi"

I still didn't find an example where the same compatible string is
used for different drivers (i.e: "st,st33zp24" or "google,cros-ec")
but the fact that is possible for legacy and not for OF is worrisome.

> In my limited opinion, then, it seems like a good idea to still try to
> separate the bus namespaces when reporting module-loading information.
>

Yes, I'll add it to my TODO list since this is orthogonal to the SPI
discussion, for example this could also be a problem for platform
drivers (i.e: MODALIAS=platform:bar vs of:N*T*Cfoo,bar).
 
> Brian
> 

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
