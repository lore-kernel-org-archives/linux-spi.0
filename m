From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] spi: sc18is602: Don't be that restrictive with the maximum
 transfer speed
Date: Mon, 17 Mar 2014 06:25:37 -0700
Message-ID: <5326F7D1.2050800@roeck-us.net>
References: <1395020870-18107-1-git-send-email-linux@roeck-us.net> <20140317115256.GC11706@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140317115256.GC11706-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 03/17/2014 04:52 AM, Mark Brown wrote:
> On Sun, Mar 16, 2014 at 06:47:50PM -0700, Guenter Roeck wrote:
>> Commit 09e99bca8 (spi: sc18is602: Convert to let spi core validate
>> transfer speed) made the maximum transfer speed much more restrictive
>> than before. The transfer speed used to be adjusted to 1/4 of the chip
>> clock rate if a higher transfer speed was requested. Now such transfers are
>> simply rejected. With default settings, this causes, for example, a transfer
>> request at 2 mbps to be rejected because the maximum speed with the default
>> chip clock is 1.843 mbps.
>
>> This is unnecessarily restrictive and causes unnecessary failures. Loosen
>> the limit to accept transfers up to 50% of the clock rate and adjust
>> the speed as needed when setting up the actualt transfer.
>
> Given this description I'd expect to see a change in the core not a
> driver - like the other fork of the thread said I'd expect to deal with
> the issue by improving the constraint handling code.
>
Agreed.

>>   	master->transfer_one_message = sc18is602_transfer_one;
>>   	master->dev.of_node = np;
>>   	master->min_speed_hz = hw->freq / 128;
>> -	master->max_speed_hz = hw->freq / 4;
>> +	master->max_speed_hz = hw->freq / 2;
>
> That said, if this is something that the hardware can support it makes
> sense to do it anyway - is there an actual spec constraint available?
>

No, the technical fastest transfer speed is hz / 4, so this would be just an
arbitrary limit to be less restrictive. Axel's patch for the spi core works
perfectly, so I would suggest to go with it if that is acceptable for you.

Thanks,
Guenter

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
