From: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC 1/2] spi: spidev: Use 'new_id' sysfs file for enabling
 spidev
Date: Wed, 20 Apr 2016 17:43:32 +0530
Message-ID: <5717726C.2090302@toradex.com>
References: <1460978308-8062-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1460978308-8062-2-git-send-email-bhuvanchandra.dv@toradex.com>
 <20160418130126.GC3217@sirena.org.uk>
Reply-To: <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, <stefan-XLVq0VzYD2Y@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Stefan Agner <stefan.agner-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>,
	Bhuvanchandra <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160418130126.GC3217-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 04/18/2016 06:31 PM, Mark Brown wrote:
> On Mon, Apr 18, 2016 at 04:48:27PM +0530, Bhuvanchandra DV wrote:
>
>> +++ b/Documentation/ABI/testing/sysfs-bus-spi-spidev
>> @@ -0,0 +1,8 @@
>> +What:		/sys/bus/spi/drivers/spidev/new_id
>> +Date:		March 2016
>> +Description:
>> +		This allows to load spidev at runtime. new_id file accepts bus
>> +		number and chip select in 'B.C' format.
>> +		e.g.
>> +		To load spidev1.1 at runtime:
>> +		$ echo 1.1 > /sys/bus/spi/drivers/spidev/new_id
>
> I would expect a new_id file to allow a new device identifier to be
> added to a driver at runtime but this isn't doing that, it's specifying
> by bus and chip select instead which is totally different to how we
> normally bind SPI devices.  That seems likely to cause confusion down
> the line.  I'd expect to be able to supply a DT compatible string or a
> Linux SPI ID.

SPI drivers bind to the device as configured in DT, but in case of 
spidev(non DT approach) the device is not available in hand to bind the 
driver. So tried this approach of creating the device and then bind 
spidev. I agree this is not a standard way we bind SPI devices. With out 
a device available, seems it is not possible to bind spidev in non DT 
approach. Please correct me if i'm wrong.

>

-- 
Best regards,
Bhuvan
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
