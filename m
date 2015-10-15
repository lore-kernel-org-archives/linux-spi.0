From: "Franklin S Cooper Jr." <fcooper-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC][PATCH] spi: Setup the master controller driver before
 setting the chipselect
Date: Thu, 15 Oct 2015 15:50:55 -0500
Message-ID: <562011AF.5040306@ti.com>
References: <1444683671-15570-1-git-send-email-fcooper@ti.com>
 <1444683671-15570-2-git-send-email-fcooper@ti.com>
 <32A34513-E312-40FD-9390-B080A85822B7@gmail.com>
 <CAHp75VdTtZks8RA7tjiAnBUipVa5SL7YdTftzqY264G__+4yQQ@mail.gmail.com>
 <CAFSsGVtXP_Jd+CxvxfWCLXT_f+Tgv5SSZAbnBciqfr_BQMEZhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "Ivan T. Ivanov" <iivanov.xz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>,
	<ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>,
	<m-karicheri2-l0cyMroinI0@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFSsGVtXP_Jd+CxvxfWCLXT_f+Tgv5SSZAbnBciqfr_BQMEZhA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>




On 10/14/2015 06:45 AM, Heiner Kallweit wrote:
> On Wed, Oct 14, 2015 at 1:08 PM, Andy Shevchenko
> <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> +Cc: Jarkko to see from spi-pxa2xx prospective
>>
>> On Wed, Oct 14, 2015 at 12:47 PM, Ivan T. Ivanov <iivanov.xz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>> Adding Andy.
>>>
>>>
>>>> On Oct 13, 2015, at 12:01 AM, Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org> wrote:
>>>>
>>>> Some devices depend on the master controller driver setup function being
>>>> called before calling any chipselect functions.
>>>>
>>>> Insure that this is done otherwise uninitialized structures may be
>>>> accessed causing a kernel panic.
>> As far as I understand my concern should be about spi-dw driver.
>>
>> So, I have just tested yesterday's linux-next with and without
>> proposed patch. Works for me:
>> Tested-by: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>>>> Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
>>>> ---
>>>> drivers/spi/spi.c | 4 ++--
>>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>>>> index 38006cc..9374d82 100644
>>>> --- a/drivers/spi/spi.c
>>>> +++ b/drivers/spi/spi.c
>>>> @@ -2053,11 +2053,11 @@ int spi_setup(struct spi_device *spi)
>>>>       if (!spi->max_speed_hz)
>>>>               spi->max_speed_hz = spi->master->max_speed_hz;
>>>>
>>>> -     spi_set_cs(spi, false);
>>>> -
>>>>       if (spi->master->setup)
>>>>               status = spi->master->setup(spi);
>>>>
>>>> +     spi_set_cs(spi, false);
>>>> +
>>>>       dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%u bits/w, %u Hz max --> %d\n",
>>>>                       (int) (spi->mode & (SPI_CPOL | SPI_CPHA)),
>>>>                       (spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
>>>> --
>>>> 2.6.1
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
>>>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> The recent change to the bitbang driver leads to the the set_cs hook
> of spi_master being set
> now for all drivers using the bitbang layer. This hook is called also
> from spi_setup and therefore
> one possible side effect is issues with bitbang drivers implementing
> the chipselect hook of
> spi_bitbang with a dependency on the master being set up before.
> The proposed patch looks good to me.
> There should be no impact on drivers not using bitbang.
Thank all. Since nothing obvious seems wrong with this patch I will resend this patch without the RFC.


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
