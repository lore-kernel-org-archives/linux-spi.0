From: Christophe Ricard <christophe.ricard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: pxa2xx: Fix cs_change management
Date: Mon, 21 Mar 2016 23:12:15 +0100
Message-ID: <56F071BF.5040800@gmail.com>
References: <1458498617-11566-1-git-send-email-christophe-h.ricard@st.com>
 <CAHp75VdJ3Rgvrh5=7tCUs8it_7G=POhNiKWLcK=55=i3HRtCgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Christophe RICARD <christophe-h.ricard-qxv4g6HH51o@public.gmane.org>,
	benoit.houyere-qxv4g6HH51o@public.gmane.org, Jean-Luc Blanc <jean-luc.blanc-qxv4g6HH51o@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VdJ3Rgvrh5=7tCUs8it_7G=POhNiKWLcK=55=i3HRtCgA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Andy,

Yes i came accross this issue when working on Minnowboard Max. This is 
the easiest fix i have found.
The option you are talking about would require to convert the 
transfer_one_message to transfer_one which is pertinent in my opinion as 
well.

Would it be acceptable to take this patch as a short term solution ?

Best Regards
Christophe

On 20/03/2016 20:42, Andy Shevchenko wrote:
> On Sun, Mar 20, 2016 at 8:30 PM, Christophe Ricard
> <christophe.ricard-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> Fix cs_change management so that it is in line with other spi drivers.
>>
>> In the spi core api helpers such as spi_bus_lock/unlock and spi_sync_locked
>> or cs_change field in spi_transfer help to manage chip select from the
>> device driver.
>>
>> The driver was setting the chip select to idle if the message queue was
>> empty despite cs_change or other status field set by spi_bus_lock/unlock
>> or spi_sync_locked.
> Do you have experience the issues right now?
>
> In long term prospective I would like to see this driver converted to
> use more parts from SPI core. giveback() function will gone if that
> conversion happens.
>
>> Signed-off-by: Christophe Ricard <christophe-h.ricard-qxv4g6HH51o@public.gmane.org>
>> ---
>>   drivers/spi/spi-pxa2xx.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
>> index ab9914a..ed034ed 100644
>> --- a/drivers/spi/spi-pxa2xx.c
>> +++ b/drivers/spi/spi-pxa2xx.c
>> @@ -532,9 +532,8 @@ static void giveback(struct driver_data *drv_data)
>>                  /* see if the next and current messages point
>>                   * to the same chip
>>                   */
>> -               if (next_msg && next_msg->spi != msg->spi)
>> -                       next_msg = NULL;
>> -               if (!next_msg || msg->state == ERROR_STATE)
>> +               if ((next_msg && next_msg->spi != msg->spi) ||
>> +                   msg->state == ERROR_STATE)
>>                          cs_deassert(drv_data);
>>          }
>>
>> --
>> 2.5.0
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
