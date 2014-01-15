From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] spi: sirf: Avoid duplicate code in various
 bits_per_word cases
Date: Wed, 15 Jan 2014 17:35:18 +0800
Message-ID: <CAGsJ_4wAT41tUf-yVcot=nSm5iqHq5ThCQyL=DRgAhW308-zpg@mail.gmail.com>
References: <1389776863.28509.0.camel@phoenix> <5EB3BFCD089AD643B9BB63439F5FD5E9012BC1048F@SHAASIEXM01.ASIA.ROOT.PRI>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: DL-SHA-WorkGroupLinux <workgroup.linux-kQvG35nSl+M@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
To: Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>, Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5EB3BFCD089AD643B9BB63439F5FD5E9012BC1048F-W2enlP78h2wYZnBWG7VmBdnKn0HB1kRyVQQcQy+6Uvc@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2014/1/15 Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>:
>> -----Original Message-----
>> From: Axel Lin [mailto:axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org]
>> Sent: Wednesday, January 15, 2014 5:08 PM
>> To: Mark Brown
>> Cc: Zhiwu Song; Barry Song; Qipan Li; linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Subject: [PATCH v2] spi: sirf: Avoid duplicate code in various bits_per_word
>> cases
>>
>> Trivial cleanup to avoid duplicate code in various bits_per_word cases.
>>
>> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>

looks good to me. Thank, Axel.
Reviewed-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>

>> ---
>>  drivers/spi/spi-sirf.c | 21 ++++++---------------
>>  1 file changed, 6 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c index
>> ed5e501..4b43310 100644
>> --- a/drivers/spi/spi-sirf.c
>> +++ b/drivers/spi/spi-sirf.c
>> @@ -459,11 +459,6 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi,
>> struct spi_transfer *t)
>>               regval |= SIRFSOC_SPI_TRAN_DAT_FORMAT_8;
>>               sspi->rx_word = spi_sirfsoc_rx_word_u8;
>>               sspi->tx_word = spi_sirfsoc_tx_word_u8;
>> -             txfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE
>> / 2) |
>> -                                     SIRFSOC_SPI_FIFO_WIDTH_BYTE;
>> -             rxfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE
>> / 2) |
>> -                                     SIRFSOC_SPI_FIFO_WIDTH_BYTE;
>> -             sspi->word_width = 1;
>>               break;
>>       case 12:
>>       case 16:
>> @@ -471,26 +466,22 @@ spi_sirfsoc_setup_transfer(struct spi_device *spi,
>> struct spi_transfer *t)
>>                       SIRFSOC_SPI_TRAN_DAT_FORMAT_16;
>>               sspi->rx_word = spi_sirfsoc_rx_word_u16;
>>               sspi->tx_word = spi_sirfsoc_tx_word_u16;
>> -             txfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE
>> / 2) |
>> -                                     SIRFSOC_SPI_FIFO_WIDTH_WORD;
>> -             rxfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE
>> / 2) |
>> -                                     SIRFSOC_SPI_FIFO_WIDTH_WORD;
>> -             sspi->word_width = 2;
>>               break;
>>       case 32:
>>               regval |= SIRFSOC_SPI_TRAN_DAT_FORMAT_32;
>>               sspi->rx_word = spi_sirfsoc_rx_word_u32;
>>               sspi->tx_word = spi_sirfsoc_tx_word_u32;
>> -             txfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE
>> / 2) |
>> -                                     SIRFSOC_SPI_FIFO_WIDTH_DWORD;
>> -             rxfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE
>> / 2) |
>> -                                     SIRFSOC_SPI_FIFO_WIDTH_DWORD;
>> -             sspi->word_width = 4;
>>               break;
>>       default:
>>               BUG();
>>       }
>>
>> +     sspi->word_width = DIV_ROUND_UP(bits_per_word, 8);
>> +     txfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE / 2) |
>> +                                        sspi->word_width;
>> +     rxfifo_ctrl = SIRFSOC_SPI_FIFO_THD(SIRFSOC_SPI_FIFO_SIZE / 2) |
>> +                                        sspi->word_width;
>> +
>>       if (!(spi->mode & SPI_CS_HIGH))
>>               regval |= SIRFSOC_SPI_CS_IDLE_STAT;
>>       if (!(spi->mode & SPI_LSB_FIRST))
>> --
>> 1.8.1.2

-barry
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
