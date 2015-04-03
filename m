From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 0/2] spi: fsl-dspi: better approximation for baudrate
Date: Fri, 3 Apr 2015 23:59:08 +0300
Message-ID: <CAHp75Vfa9b0s6rXMbUERbbGRowGp4bidKH1UZ4a8HAx23oSrLw@mail.gmail.com>
References: <1427965907-28125-1-git-send-email-andy.shevchenko@gmail.com>
	<551ED2F6.8020701@datasoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Aaron Brice <aaron.brice-vSOi0k5x9wFWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <551ED2F6.8020701-vSOi0k5x9wFWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Apr 3, 2015 at 8:50 PM, Aaron Brice <aaron.brice-vSOi0k5x9wFWk0Htik3J/w@public.gmane.org> wrote:
> On 04/02/2015 02:11 AM, Andy Shevchenko wrote:
>>
>> This series makes better approximation when baud rate divisor parameters
>> are
>> calculated.
>>
>> The algorithm is represent as Python script here [1]. First parameter is
>> algorithm (0 - original, 1 - after patch 1/2, 2 - after patch 2/2, 3 -
>> memory
>> vs. performance: use precalculated scales).
>>
>> I played with let's say standard baud rates (which I used for Quark) and
>> separately run algorithms 0 and 1 for range 100-5000 baud. Input frequency
>> is
>> 64MHz. It seems my algo shows better results in all cases. Here is a diff
>> for
>> 'standard' baud rates
>> (speed_hz, DBR, i, BR, j, PBR, real baud rate, difference):

[]

>>   3140500  0 1  4     2 5 3200000 59500
>>   3125000  0 1  4     2 5 3200000 75000
>>   3109500  0 1  4     2 5 3200000 90500
>> -2500000  0 1  4     3 7 2285714 214286
>> +2500000  0 3  8     1 3 2666666 166666
>
> The rest of these I'm not sure about.  The property is called
> "spi-max-frequency" and the description in the bindings document is:
>
> - spi-max-frequency - (required) Maximum SPI clocking speed of device in Hz

I think we are talking about real world and real hardware. As far as I
understand the problem with SPI (or any other) clocking is a
consistent error.

If you have that error is a big enough the data might be corrupted.
How big? Each difference between clocking is for hardware the shifted
phase.  When phase is deviated your consumer might missed change of
the signal and inverted a bit.

Thus, if the delta for clocking is small the hardware will still catch
the change of the signal.

So, in practice it is quite unlikely to happen since usual devices
have enough frequency margin.

> In the rest of the examples you've gotten a closer baud rate by exceeding
> the "Maximum" value.  I don't think you want best approximation, I think you
> want closest without going over..

Can you test on real hardware? I'm pretty sure it's quite hard to find
something that will not work.

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
