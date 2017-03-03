From: Shubhrajyoti Datta <shubhrajyoti.datta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: zynqmp: Add runtime support
Date: Fri, 3 Mar 2017 10:43:12 +0530
Message-ID: <CAKfKVtHRXTnOt1SQpiL+RdLAbBcHBSSN8R5U52AGKZ8EyezQVQ@mail.gmail.com>
References: <1488446552-15689-1-git-send-email-shubhrajyoti.datta@xilinx.com> <20170302150956.ogsvx7nrpkwbu33k@xsjsorenbubuntu.xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
To: =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170302150956.ogsvx7nrpkwbu33k-W+a29BXK3HMBNn8Usd2qwIIxRWo/Wh1X0E9HWUfgJXw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Soren,

On Thu, Mar 2, 2017 at 8:39 PM, S=C3=B6ren Brinkmann
<soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org> wrote:
> On Thu, 2017-03-02 at 14:52:32 +0530, Shubhrajyoti Datta wrote:
>> Add runtime support for the zynqmp qspi driver.
>
> runtime PM
>
> A little more detail about why, what and how things are changed would be
> nice.

Yes updated in v2.

>
>>
>> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/spi/spi-zynqmp-gqspi.c | 90 ++++++++++++++++++++++++++++++++++-=
-------
>>  1 file changed, 74 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqs=
pi.c
>> index 0b3ba7a..980877a 100644
>> --- a/drivers/spi/spi-zynqmp-gqspi.c
>> +++ b/drivers/spi/spi-zynqmp-gqspi.c
>> @@ -20,6 +20,7 @@
>>  #include <linux/of_irq.h>
>>  #include <linux/of_address.h>
>>  #include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>>  #include <linux/spi/spi.h>
>>  #include <linux/spinlock.h>
>>  #include <linux/workqueue.h>
>> @@ -156,6 +157,7 @@
>>  #define GQSPI_FREQ_150MHZ    150000000
>>  #define IOU_TAPDLY_BYPASS_MASK       0x7
>>
>> +#define SPI_AUTOSUSPEND_TIMEOUT              3000
>>  enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
>>
>>  /**
>> @@ -424,21 +426,9 @@ static void zynqmp_qspi_copy_read_data(struct zynqm=
p_qspi *xqspi,
>>  static int zynqmp_prepare_transfer_hardware(struct spi_master *master)
>>  {
>>       struct zynqmp_qspi *xqspi =3D spi_master_get_devdata(master);
>> -     int ret;
>> -
>> -     ret =3D clk_enable(xqspi->refclk);
>> -     if (ret)
>> -             return ret;
>> -
>> -     ret =3D clk_enable(xqspi->pclk);
>> -     if (ret)
>> -             goto clk_err;
>
> Isn't there a pm_runtime_get_sync() needed now? Or how is the
> clk_enable/resume triggered now?

We are registering to the auto_runtime_pm and the spi core will do it for u=
s.

>
>>
>>       zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, GQSPI_EN_MASK);
>>       return 0;
>> -clk_err:
>> -     clk_disable(xqspi->refclk);
>> -     return ret;
>>  }
>>
>>  /**
>> @@ -455,8 +445,6 @@ static int zynqmp_unprepare_transfer_hardware(struct=
 spi_master *master)
>>       struct zynqmp_qspi *xqspi =3D spi_master_get_devdata(master);
>>
>>       zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
>> -     clk_disable(xqspi->refclk);
>> -     clk_disable(xqspi->pclk);
>
> Similar here, shouldn't the device be pm_runtime_put() here?

The spi core will now do it for us.

>
>         S=C3=B6ren
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
