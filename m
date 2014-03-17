From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] spi: sc18is602: Don't be that restrictive with the maximum
 transfer speed
Date: Sun, 16 Mar 2014 20:53:09 -0700
Message-ID: <532671A5.5070302@roeck-us.net>
References: <1395020870-18107-1-git-send-email-linux@roeck-us.net> <CAFRkauDEBe+XStLJSiMzvNOxpFZ2iBGD36-Brq9oHN2RRa+rog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFRkauDEBe+XStLJSiMzvNOxpFZ2iBGD36-Brq9oHN2RRa+rog-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 03/16/2014 07:07 PM, Axel Lin wrote:
> 2014-03-17 9:47 GMT+08:00 Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>:
>> Commit 09e99bca8 (spi: sc18is602: Convert to let spi core validate
>> transfer speed) made the maximum transfer speed much more restrictive
>> than before. The transfer speed used to be adjusted to 1/4 of the chip
>> clock rate if a higher transfer speed was requested. Now such transfers are
>> simply rejected. With default settings, this causes, for example, a transfer
>> request at 2 mbps to be rejected because the maximum speed with the default
>> chip clock is 1.843 mbps.
>>
>> This is unnecessarily restrictive and causes unnecessary failures. Loosen
>> the limit to accept transfers up to 50% of the clock rate and adjust
>> the speed as needed when setting up the actualt transfer.
>
> I suppose this controller can only set to SC18IS602_MODE_CLOCK_DIV_4 for the
> highest transfer speed. If this is the case, master->max_speed_hz should be
> hw->freq / 4.
>

That really depends on one's point of view. The chip does not support a transfer
speed of, say, hw->freq / 5 or hw->freq / 6 either, but adjusts it to the next
available speed. Following your logic, every non-exact speed should be rejected,
which would make it a pain for a user to find a working speed.

> Now I'm thinking if it is ok to use master->max_speed_hz as transfer speed when
> xfer->speed_hz > master->max_speed_hz. And it should be handled in spi core.
> I'm sending a RFC patch now.
>
That is an acceptable alternate solution for me.

Guenter

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
