From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC][PATCH] spi: Setup the master controller driver before
 setting the chipselect
Date: Wed, 14 Oct 2015 14:08:12 +0300
Message-ID: <CAHp75VdTtZks8RA7tjiAnBUipVa5SL7YdTftzqY264G__+4yQQ@mail.gmail.com>
References: <1444683671-15570-1-git-send-email-fcooper@ti.com>
	<1444683671-15570-2-git-send-email-fcooper@ti.com>
	<32A34513-E312-40FD-9390-B080A85822B7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	"Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>, m-karicheri2-l0cyMroinI0@public.gmane.org
To: "Ivan T. Ivanov" <iivanov.xz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <32A34513-E312-40FD-9390-B080A85822B7-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

+Cc: Jarkko to see from spi-pxa2xx prospective

On Wed, Oct 14, 2015 at 12:47 PM, Ivan T. Ivanov <iivanov.xz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Adding Andy.
>
>
>> On Oct 13, 2015, at 12:01 AM, Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org> wrote:
>>
>> Some devices depend on the master controller driver setup function being
>> called before calling any chipselect functions.
>>
>> Insure that this is done otherwise uninitialized structures may be
>> accessed causing a kernel panic.

As far as I understand my concern should be about spi-dw driver.

So, I have just tested yesterday's linux-next with and without
proposed patch. Works for me:
Tested-by: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

>>
>> Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
>> ---
>> drivers/spi/spi.c | 4 ++--
>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>> index 38006cc..9374d82 100644
>> --- a/drivers/spi/spi.c
>> +++ b/drivers/spi/spi.c
>> @@ -2053,11 +2053,11 @@ int spi_setup(struct spi_device *spi)
>>       if (!spi->max_speed_hz)
>>               spi->max_speed_hz = spi->master->max_speed_hz;
>>
>> -     spi_set_cs(spi, false);
>> -
>>       if (spi->master->setup)
>>               status = spi->master->setup(spi);
>>
>> +     spi_set_cs(spi, false);
>> +
>>       dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%u bits/w, %u Hz max --> %d\n",
>>                       (int) (spi->mode & (SPI_CPOL | SPI_CPHA)),
>>                       (spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
>> --
>> 2.6.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
