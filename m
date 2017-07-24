From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: pxa2xx: Only claim CS GPIOs when the slave device is created
Date: Mon, 24 Jul 2017 14:02:57 +0300
Message-ID: <CAHp75Vf0NuOAvsJDxeB=5uqhMFpQ54vZzegJe=EYZDd3Bd6erw@mail.gmail.com>
References: <90b3e14d-0077-9a25-9d90-ab340577af57@web.de> <CAHp75VfpJzOdhMyZoMGnC4CQc5kGxq1k-__dpmVAOaxaD04w6Q@mail.gmail.com>
 <59066818-a284-4da0-d05f-d2503aeee44b@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Jan Kiszka <jan.kiszka-S0/GAf8tV78@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <59066818-a284-4da0-d05f-d2503aeee44b-S0/GAf8tV78@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Jul 24, 2017 at 1:53 PM, Jan Kiszka <jan.kiszka-S0/GAf8tV78@public.gmane.org> wrote:
> On 2017-07-24 12:44, Andy Shevchenko wrote:
>> +Cc: Mika
>>
>> On Sat, Jul 8, 2017 at 11:41 AM, Jan Kiszka <jan.kiszka-S0/GAf8tV78@public.gmane.org> wrote:
>>> From: Jan Kiszka <jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org>
>>>
>>> Avoid hogging chip select GPIOs just because they are listed for the
>>> master. They might be mulitplexed and, if no slave device is attached,
>>> used for different purposes. Moreover, this strategy avoids having to
>>> allocate a cs_gpiods structure.
>>>
>>> Tested on the IOT2000 where the second SPI bus is connected to an
>>> Arduino-compatible connector and multiplexed between SPI, GPIO and PWM
>>> usage.

>> This breaks all systems which are using _DSD.
>
> Err, can you elaborate? Worked fine here with _DSD on the IOT2000.

Sure, the setup() function can be called several times for the same
chip (as written in the comment inside the function).
Definitely your code doesn't follow this, since gpiod_get_index() is
returning -EBUSY when called 2+ time, that's what I got on all my
tests.

>> While I'm looking for fix, I get feeling that the approach itself is not right,
>>
>> So, for now I would vote for immediate revert and then rethink what we
>> can do here.
>
> I'm fine with reverting because the patch wasn't clean anyway (mixed old
> and new GPIO API) - aside from whatever you found in addition.

> I had an
> update pending but, as you are looking into this anyway, I'm sure your
> patches will be more holistic.

Please, send it as RFC, because it might have something we can use/re-use.

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
