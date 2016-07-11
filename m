From: Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] spi: spi-ti-qspi: clear wlen field while setting word
 length.
Date: Mon, 11 Jul 2016 15:53:42 +0530
Message-ID: <578373AE.5060803@ti.com>
References: <1468094753-8327-1-git-send-email-prahlad.eee@gmail.com>
 <5783297C.7080702@ti.com>
 <CAFbo-qWbjXJQDY+Rq5kX-e77hPExr64o8wm4o-w0bvAFyM3LcA@mail.gmail.com>
 <57835C62.7030704@ti.com>
 <CAFbo-qWayTXErQa4YQw32-TCA5H6qTAr6WA2Xx7diePFLo5T6w@mail.gmail.com>
 <CAFbo-qW1pK5RJOCY0b0Gz7JR+9170sjiZb90UEvqySLheZst3A@mail.gmail.com>
 <57836395.3030602@ti.com>
 <CAFbo-qWV1727RgKf8xQbJzaTDHVGnLYM+Qi4AmetN62p-hqDUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "broonie@kernel.org" <broonie@kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: prahlad venkata <prahlad.eee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFbo-qWV1727RgKf8xQbJzaTDHVGnLYM+Qi4AmetN62p-hqDUw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



On Monday 11 July 2016 02:49 PM, prahlad venkata wrote:
> On Mon, Jul 11, 2016 at 2:45 PM, Vignesh R <vigneshr@ti.com> wrote:
[...]
>>>>>>>> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
>>>>>>>> index 29ea8d2..6c61f54 100644
>>>>>>>> --- a/drivers/spi/spi-ti-qspi.c
>>>>>>>> +++ b/drivers/spi/spi-ti-qspi.c
>>>>>>>> @@ -276,9 +276,9 @@ static int qspi_write_msg(struct ti_qspi *qspi, struct spi_transfer *t,
>>>>>>>>                               cmd |= QSPI_WLEN(QSPI_WLEN_MAX_BITS);
>>>>>>>>                       } else {
>>>>>>>>                               writeb(*txbuf, qspi->base + QSPI_SPI_DATA_REG);
>>>>>>>> -                             cmd = qspi->cmd | QSPI_WR_SNGL;
>>>>>
>>>>> This is wrong. Deleting this line means QSPI_WR_SNGL is not set and no
>>>>> data is sent out on the wire.
>>>> QSPI_WR_SNGL is already set as soon as we enter the function.
>>>>>
>>>>>>>
>>>>>>> qspi->cmd always has WLEN field cleared and set to WLEN = 1 byte (see
>>>>>>> ti_qspi_start_transfer_one()). And hence variable 'cmd' will also have
>>>>>>> WLEN set to 1 byte.
>>>>>> Even though WLEN=1 is set in the ti_qspi_transfer_one, if we ask for a
>>>>>> transfer of large data,
>>>>>> say 300 bytes in length, for attaining faster data rate WLEN 128 is
>>>>>> selected for the first two
>>>>>> transactions and remaining 44 bytes will be transmitted with WLEN 1.
>>>>>> During that case,
>>>>>> WLEN will be changed inside qspi_write_msg function itself and the
>>>>>> field should be cleared
>>>>>> first while doing that.
>>>>>
>>>>> In qspi_write_msg(), qspi->cmd will always have WLEN set to
>>>>> QSPI_WLEN(t->bits_per_word) and qspi->cmd is never changed within this
>>>>> function.
>>>>> It is the value of local variable 'cmd' that is changed to appropriate
>>>>> WLEN (128bit or 8bit) as necessary.
>>
>>> 'cmd' is written back to qspi->cmd for every transaction.
>>
>> You mean qspi->cmd = cmd ?
>> I don't see this happening anywhere in the driver. Can you point me to
>> that line of code?
> line 296:
> ti_qspi_write(qspi, cmd, QSPI_SPI_CMD_REG);

Sorry, I don't understand. QSPI_SPI_CMD_REG and qspi->cmd are different.
qspi->cmd does not represent the QSPI_SPI_CMD_REG register. qspi->cmd is
just local driver data for book-keeping.

Please add some prints in driver to see how 'cmd' (and qspi->cmd)
variable changes in case of 128bit mode and 8bit mode.

Regards
Vignesh


-- 
Regards
Vignesh
