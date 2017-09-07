From: =?UTF-8?Q?L=c3=a9o_Serre?= <leo-fx4xgHRsvDuU6xZXA0faPpqQE7yCjDx5@public.gmane.org>
Subject: Re: Single SPI Protocol Driver with multiple SPI Slaves
Date: Thu, 7 Sep 2017 09:03:59 +0200
Message-ID: <6a5ddbb9-3203-48aa-a4d9-7bd100224592@naio-technologies.com>
References: <faa18de5-545a-4be1-eaf0-a0374a75d7e2@naio-technologies.com>
 <af912d1d-a036-ebc3-5439-09a44e98f437@metafoo.de>
 <20170906130950.q5acowbqa65h3zrz@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170906130950.q5acowbqa65h3zrz-7j8lgAiuQgnQXOPxS62xeg@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Thanks for your answers,

It appears that the solution is to bind the driver to a unique SPI slave 
in the device-tree using a fake CS pin.

Then in the probe function, assign two GPIO pins to the control the two 
CS of the device.

I'm sure that solution will work but:
  * The driver will be written specifically to a configuration (GPIO pin 
number hard-coded)
  * Requires a unused pin (the fake CS pin, except if it is possible to 
setup the SPI bus as "no-cs" in the device-tree).
  * Requires do find the GPIO pin number, that could be quite difficult 
in iMX6 for example.

Léo

Le 06/09/2017 à 15:09, Mark Brown a écrit :
> On Wed, Sep 06, 2017 at 01:49:25PM +0200, Lars-Peter Clausen wrote:
> 
>> There are currently no facilities in the kernel to do this. I've have had a
>> similar problem with a different driver and given this some thought.
> 
> The kernel really can't cope with this at all, it's got a fairly clear
> idea that a device will only have one control bus.
> 
>> Conceptually I think the best approach is to have something like
>> i2c_new_dummy() that creates a second slave device with a different address
>> for an existing device.
> 
>> The main issue with implementing this is the global spi_add_lock mutex which
>> prevents a SPI device from being created from within the probe() callback of
>> another SPI device.
> 
> There's also the devices that want to use multiple buses simultaneously
> that cause problems here, it's not just SPI vs SPI - there's one audio
> CODEC upstream that's got mixed I2C and SPI control.
> 
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
