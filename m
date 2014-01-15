From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: FW: [PATCH] spi: sirf: Avoid duplicate code in various
 bits_per_word cases
Date: Wed, 15 Jan 2014 16:42:22 +0800
Message-ID: <CAGsJ_4y-5PuKA0y7JicDsH5AY159MPnA+qHU5BxnBrGC6WsT=g@mail.gmail.com>
References: <1389772636.13585.1.camel@phoenix> <5EB3BFCD089AD643B9BB63439F5FD5E9012BC102FB@SHAASIEXM01.ASIA.ROOT.PRI>
 <CAGsJ_4xu2g3K7D-QumwJBCxTvwc06GLE_Mz8uLyAKpHOLgq2Sw@mail.gmail.com> <CAFRkauB7DrFy-v0+14PcKjan4YxFiTzC5OruiaHC7mFdDmOXoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, Zhiwu Song <zhiwu.song-kQvG35nSl+M@public.gmane.org>,
	DL-SHA-WorkGroupLinux <workgroup.linux-kQvG35nSl+M@public.gmane.org>
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAFRkauB7DrFy-v0+14PcKjan4YxFiTzC5OruiaHC7mFdDmOXoA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2014/1/15 Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>:
> 2014/1/15 Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
>> 2014/1/15 Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Axel Lin [mailto:axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org]
>>>> Sent: Wednesday, January 15, 2014 3:57 PM
>>>> To: Mark Brown
>>>> Cc: Zhiwu Song; Barry Song; Qipan Li; linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>>>> Subject: [PATCH] spi: sirf: Avoid duplicate code in various bits_per_word
>>>> cases
>>>>
>>>> Trivial cleanup to avoid duplicate code in various bits_per_word cases.
>>>>
>>>> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
>>>> ---
>>>>  drivers/spi/spi-sirf.c | 21 ++++++---------------
>>>>  1 file changed, 6 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c index
>>>> ed5e501..787683d 100644
>>>> --- a/drivers/spi/spi-sirf.c
>>>> +++ b/drivers/spi/spi-sirf.c
>>>> @@ -459,11 +459,6 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi,
>>>> struct spi_transfer *t)
>>>>               regval |= SIRFSOC_SPI_TRAN_DAT_FORMAT_8;
>>>>               sspi->rx_word = spi_sirfsoc_rx_word_u8;
>>>>               sspi->tx_word = spi_sirfsoc_tx_word_u8;
>>>> -             txfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE
>>>> / 2) |
>>>> -                                     SIRFSOC_SPI_FIFO_WIDTH_BYTE;
>>>> -             rxfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE
>>>> / 2) |
>>>> -                                     SIRFSOC_SPI_FIFO_WIDTH_BYTE;
>>>> -             sspi->word_width = 1;
>>>>               break;
>>>>       case 12:
>>>>       case 16:
>>>> @@ -471,26 +466,22 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi,
>>>> struct spi_transfer *t)
>>>>                       SIRFSOC_SPI_TRAN_DAT_FORMAT_16;
>>>>               sspi->rx_word = spi_sirfsoc_rx_word_u16;
>>>>               sspi->tx_word = spi_sirfsoc_tx_word_u16;
>>>> -             txfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE
>>>> / 2) |
>>>> -                                     SIRFSOC_SPI_FIFO_WIDTH_WORD;
>>>> -             rxfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE
>>>> / 2) |
>>>> -                                     SIRFSOC_SPI_FIFO_WIDTH_WORD;
>>>> -             sspi->word_width = 2;
>>>>               break;
>>>>       case 32:
>>>>               regval |= SIRFSOC_SPI_TRAN_DAT_FORMAT_32;
>>>>               sspi->rx_word = spi_sirfsoc_rx_word_u32;
>>>>               sspi->tx_word = spi_sirfsoc_tx_word_u32;
>>>> -             txfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE
>>>> / 2) |
>>>> -                                     SIRFSOC_SPI_FIFO_WIDTH_DWORD;
>>>> -             rxfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE
>>>> / 2) |
>>>> -                                     SIRFSOC_SPI_FIFO_WIDTH_DWORD;
>>>> -             sspi->word_width = 4;
>>>>               break;
>>>>       default:
>>>>               BUG();
>>>>       }
>>>>
>>>> +     txfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE / 2) |
>>>> +                                        SIRFSOC_SPI_FIFO_WIDTH_WORD;
>>>> +     rxfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE / 2) |
>>>> +                                        SIRFSOC_SPI_FIFO_WIDTH_WORD;
>>>> +     sspi->word_width = DIV_ROUND_UP(bits_per_word, 8);
>>>> +
>>
>> Axel, thanks.
>> it is a good cleanup, but it seems it is not right for txfifo_ctrl and
>> rxfifo_ctrl?
>
> I don't get it.
> I thought there is no functional change with this patch.

you might want to change

 txfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE / 2) |
                                        SIRFSOC_SPI_FIFO_WIDTH_WORD;
 rxfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE / 2) |
                                       SIRFSOC_SPI_FIFO_WIDTH_WORD;

to "SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE / 2)  I sspi->word_width" ?

>
> Regards,
> Axel

-barry
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
