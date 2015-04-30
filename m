From: Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: Re-do the returning value of rspi_dma_check_then_transfer
Date: Thu, 30 Apr 2015 09:26:46 +0900
Message-ID: <554176C6.8040402@jinso.co.jp>
References: <1430200551-20708-1-git-send-email-cm-hiep@jinso.co.jp>	<1430200551-20708-2-git-send-email-cm-hiep@jinso.co.jp> <CAMuHMdU8fHW9SCHPTpjwQMfsQc7Qn3F29-P2tsi_j-4Pjp_QCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Ryusuke Sakato <ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdU8fHW9SCHPTpjwQMfsQc7Qn3F29-P2tsi_j-4Pjp_QCg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Geert-san,

On 2015=E5=B9=B404=E6=9C=8828=E6=97=A5 18:02, Geert Uytterhoeven wrote:
> Hi Hiep-san,
>
> On Tue, Apr 28, 2015 at 7:55 AM, Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org> =
wrote:
>> To reduce indentation and complex of code, insteeds of returning zer=
o,
>> the function rspi_dma_check_then_transfer should be returned
>> rspi_dma_transfer directly after checking error.
> Thanks for the update!
>
> Unfortunately it doesn't compile...
Sorry to bother you again.
>> --- a/drivers/spi/spi-rspi.c
>> +++ b/drivers/spi/spi-rspi.c
>> @@ -665,15 +665,12 @@ static bool rspi_can_dma(struct spi_master *ma=
ster, struct spi_device *spi,
>>   static int rspi_dma_check_then_transfer(struct rspi_data *rspi,
>>                                           struct spi_transfer *xfer)
>>   {
>> -       if (rspi->master->can_dma && __rspi_can_dma(rspi, xfer)) {
>> -               /* rx_buf can be NULL on RSPI on SH in TX-only Mode =
*/
>> -               int ret =3D rspi_dma_transfer(rspi, &xfer->tx_sg,
>> -                                       xfer->rx_buf ? &xfer->rx_sg =
: NULL);
>> -               if (ret !=3D -EAGAIN)
>> -                       return 0;
>> -       }
>> +       if (!rspi->master->can_dma || !__rspi_can_dma(rspi, xfer)) {
> Superfluous opening curly brace.
> Please compile and run test your patches.
> Thanks!

Thanks, I'll fix it and send you at a moment.

>> +               return -EAGAIN;
>>
>> -       return -EAGAIN;
>> +       /* rx_buf can be NULL on RSPI on SH in TX-only Mode */
>> +       return rspi_dma_transfer(rspi, &xfer->tx_sg,
>> +                                       xfer->rx_buf ? &xfer->rx_sg =
: NULL);
>>   }
>>
>>   static int rspi_common_transfer(struct rspi_data *rspi,
>
>
>

Hiep.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
