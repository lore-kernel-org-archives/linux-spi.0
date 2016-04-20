From: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC 1/2] spi: spidev: Use 'new_id' sysfs file for enabling
 spidev
Date: Wed, 20 Apr 2016 18:41:11 +0530
Message-ID: <57177FEF.8080906@toradex.com>
References: <1460978308-8062-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1460978308-8062-2-git-send-email-bhuvanchandra.dv@toradex.com>
 <20160418130126.GC3217@sirena.org.uk> <5717726C.2090302@toradex.com>
 <20160420121704.GI3217@sirena.org.uk>
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
In-Reply-To: <20160420121704.GI3217-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 04/20/2016 05:47 PM, Mark Brown wrote:
> On Wed, Apr 20, 2016 at 05:43:32PM +0530, Bhuvanchandra DV wrote:
>
>> SPI drivers bind to the device as configured in DT, but in case of
>> spidev(non DT approach) the device is not available in hand to bind the
>> driver. So tried this approach of creating the device and then bind spidev.
>> I agree this is not a standard way we bind SPI devices. With out a device
>> available, seems it is not possible to bind spidev in non DT approach.
>> Please correct me if i'm wrong.
>
> The DT should describe the hardware so the DT should describe whatever
> device is connected to the spidev, what you're trying to do is have
> spidev bind to these new compatible strings.

The device which i was pointing earlier is the SPI master device(spiB.C) 
not the external h/w device interfaced to it. Yes, DT will describe the 
h/w interfaced on SPI master device(spiB.C). In case of spidev we are 
not supposed to describe in DT as it is not a real h/w. The intention of 
this patchset is to completely avoid spidev in DT and load it via sysfs 
new_id file for selected SPI master device(spiB.C).

>

-- 
Best regards,
Bhuvan
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
