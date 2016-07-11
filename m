From: Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] spi: spi-ti-qspi: clear wlen field while setting word
 length.
Date: Mon, 11 Jul 2016 14:45:01 +0530
Message-ID: <57836395.3030602@ti.com>
References: <1468094753-8327-1-git-send-email-prahlad.eee@gmail.com>
 <5783297C.7080702@ti.com>
 <CAFbo-qWbjXJQDY+Rq5kX-e77hPExr64o8wm4o-w0bvAFyM3LcA@mail.gmail.com>
 <57835C62.7030704@ti.com>
 <CAFbo-qWayTXErQa4YQw32-TCA5H6qTAr6WA2Xx7diePFLo5T6w@mail.gmail.com>
 <CAFbo-qW1pK5RJOCY0b0Gz7JR+9170sjiZb90UEvqySLheZst3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: prahlad venkata <prahlad.eee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFbo-qW1pK5RJOCY0b0Gz7JR+9170sjiZb90UEvqySLheZst3A-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On Monday 11 July 2016 02:39 PM, prahlad venkata wrote:
> On Mon, Jul 11, 2016 at 2:36 PM, prahlad venkata <prahlad.eee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> On Mon, Jul 11, 2016 at 2:14 PM, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> wrote:
>>>
>>>
>>> On Monday 11 July 2016 01:34 PM, prahlad venkata wrote:
>>>> On Mon, Jul 11, 2016 at 10:37 AM, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org> wrote:
>>>>> Hi Prahlad,
>>>>>
>>>>> On Sunday 10 July 2016 01:35 AM, Prahlad V wrote:
>>>>>> When a word length of 1 byte is selected and writing data of length
>>>>>> more than QSPI_WLEN_MAX_BYTES, first MAX_BYTES will be transfered
>>>>>> and remaining will be transfered byte by byte. In that case wlen
>>>>>> field should be cleared before setting.
>>>>>>
>>>>>> Signed-off-by: Prahlad V <prahlad.eee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>>>>> ---
>>>>>>  drivers/spi/spi-ti-qspi.c | 4 ++--
>>>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
>>>>>> index 29ea8d2..6c61f54 100644
>>>>>> --- a/drivers/spi/spi-ti-qspi.c
>>>>>> +++ b/drivers/spi/spi-ti-qspi.c
>>>>>> @@ -276,9 +276,9 @@ static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t,
>>>>>>                               cmd |= QSPI_WLEN(QSPI_WLEN_MAX_BITS);
>>>>>>                       } else {
>>>>>>                               writeb(*txbuf, qspi->base + QSPI_SPI_DATA_REG);
>>>>>> -                             cmd = qspi->cmd | QSPI_WR_SNGL;
>>>
>>> This is wrong. Deleting this line means QSPI_WR_SNGL is not set and no
>>> data is sent out on the wire.
>> QSPI_WR_SNGL is already set as soon as we enter the function.
>>>
>>>>>
>>>>> qspi->cmd always has WLEN field cleared and set to WLEN = 1 byte (see
>>>>> ti_qspi_start_transfer_one()). And hence variable 'cmd' will also have
>>>>> WLEN set to 1 byte.
>>>> Even though WLEN=1 is set in the ti_qspi_transfer_one, if we ask for a
>>>> transfer of large data,
>>>> say 300 bytes in length, for attaining faster data rate WLEN 128 is
>>>> selected for the first two
>>>> transactions and remaining 44 bytes will be transmitted with WLEN 1.
>>>> During that case,
>>>> WLEN will be changed inside qspi_write_msg function itself and the
>>>> field should be cleared
>>>> first while doing that.
>>>
>>> In qspi_write_msg(), qspi->cmd will always have WLEN set to
>>> QSPI_WLEN(t->bits_per_word) and qspi->cmd is never changed within this
>>> function.
>>> It is the value of local variable 'cmd' that is changed to appropriate
>>> WLEN (128bit or 8bit) as necessary.

> 'cmd' is written back to qspi->cmd for every transaction.

You mean qspi->cmd = cmd ?
I don't see this happening anywhere in the driver. Can you point me to
that line of code?

-- 
Regards
Vignesh
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
