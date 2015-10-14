From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [RFC][PATCH] spi: Setup the master controller driver before
 setting the chipselect
Date: Wed, 14 Oct 2015 13:45:20 +0200
Message-ID: <CAFSsGVtXP_Jd+CxvxfWCLXT_f+Tgv5SSZAbnBciqfr_BQMEZhA@mail.gmail.com>
References: <1444683671-15570-1-git-send-email-fcooper@ti.com>
	<1444683671-15570-2-git-send-email-fcooper@ti.com>
	<32A34513-E312-40FD-9390-B080A85822B7@gmail.com>
	<CAHp75VdTtZks8RA7tjiAnBUipVa5SL7YdTftzqY264G__+4yQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Ivan T. Ivanov" <iivanov.xz@gmail.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Franklin S Cooper Jr <fcooper@ti.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
	ssantosh@kernel.org, "Ivan T. Ivanov" <iivanov@mm-sol.com>,
	m-karicheri2@ti.com
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VdTtZks8RA7tjiAnBUipVa5SL7YdTftzqY264G__+4yQQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Oct 14, 2015 at 1:08 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> +Cc: Jarkko to see from spi-pxa2xx prospective
>
> On Wed, Oct 14, 2015 at 12:47 PM, Ivan T. Ivanov <iivanov.xz@gmail.com> wrote:
>> Adding Andy.
>>
>>
>>> On Oct 13, 2015, at 12:01 AM, Franklin S Cooper Jr <fcooper@ti.com> wrote:
>>>
>>> Some devices depend on the master controller driver setup function being
>>> called before calling any chipselect functions.
>>>
>>> Insure that this is done otherwise uninitialized structures may be
>>> accessed causing a kernel panic.
>
> As far as I understand my concern should be about spi-dw driver.
>
> So, I have just tested yesterday's linux-next with and without
> proposed patch. Works for me:
> Tested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
>>>
>>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>>> ---
>>> drivers/spi/spi.c | 4 ++--
>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>>> index 38006cc..9374d82 100644
>>> --- a/drivers/spi/spi.c
>>> +++ b/drivers/spi/spi.c
>>> @@ -2053,11 +2053,11 @@ int spi_setup(struct spi_device *spi)
>>>       if (!spi->max_speed_hz)
>>>               spi->max_speed_hz = spi->master->max_speed_hz;
>>>
>>> -     spi_set_cs(spi, false);
>>> -
>>>       if (spi->master->setup)
>>>               status = spi->master->setup(spi);
>>>
>>> +     spi_set_cs(spi, false);
>>> +
>>>       dev_dbg(&spi->dev, "setup mode %d, %s%s%s%s%u bits/w, %u Hz max --> %d\n",
>>>                       (int) (spi->mode & (SPI_CPOL | SPI_CPHA)),
>>>                       (spi->mode & SPI_CS_HIGH) ? "cs_high, " : "",
>>> --
>>> 2.6.1
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
>
> --
> With Best Regards,
> Andy Shevchenko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
The recent change to the bitbang driver leads to the the set_cs hook
of spi_master being set
now for all drivers using the bitbang layer. This hook is called also
from spi_setup and therefore
one possible side effect is issues with bitbang drivers implementing
the chipselect hook of
spi_bitbang with a dependency on the master being set up before.
The proposed patch looks good to me.
There should be no impact on drivers not using bitbang.
