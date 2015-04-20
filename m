From: Cao Minh Hiep <cm-hiep@jinso.co.jp>
Subject: Re: [PATCH v3 1/1] spi: Using Trigger number to transmit/receive
 data
Date: Mon, 20 Apr 2015 16:04:42 +0900
Message-ID: <5534A50A.8000109@jinso.co.jp>
References: <1414034053-14750-1-git-send-email-cm-hiep@jinso.co.jp>	<1414034053-14750-2-git-send-email-cm-hiep@jinso.co.jp> <CAMuHMdWcfij=gFwT9c5wT1+mBT7Q-Fc5_qzqSjLk4RvOEsUGgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Mark Brown <broonie@kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Ryusuke Sakato <ryusuke.sakato.bx@renesas.com>,
	Linux-sh list <linux-sh@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWcfij=gFwT9c5wT1+mBT7Q-Fc5_qzqSjLk4RvOEsUGgA@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Geert-san
I am sorry for late replying.

On 2015=E5=B9=B404=E6=9C=8808=E6=97=A5 03:51, Geert Uytterhoeven wrote:
> Hi Hiep-san,
>
> On Thu, Oct 23, 2014 at 5:14 AM, Cao Minh Hiep <cm-hiep@jinso.co.jp> =
wrote:
>> From: Hiep Cao Minh <cm-hiep@jinso.co.jp>
>>
>> In order to transmit and receive data when have 32 bytes of data tha=
t
>> ready has prepared on Transmit/Receive Buffer to transmit or receive=
=2E
>> Instead transmits/receives a byte data using Transmit/Receive Buffer
>> Data Triggering Number will improve the speed of transfer data.
> Please accept my apologies for these late review comments.
> I had completely forgotten about your patch, until I noticed Mark had
> applied it.
  No problems. Thanks,
>> --- a/drivers/spi/spi-rspi.c
>> +++ b/drivers/spi/spi-rspi.c
>> @@ -614,19 +667,29 @@ static bool rspi_can_dma(struct spi_master *ma=
ster, struct spi_device *spi,
>>          return __rspi_can_dma(rspi, xfer);
>>   }
>>
>> -static int rspi_common_transfer(struct rspi_data *rspi,
>> -                               struct spi_transfer *xfer)
>> +static int rspi_dma_check_then_transfer(struct rspi_data *rspi,
>> +                                        struct spi_transfer *xfer)
>>   {
>> -       int ret;
>> -
>>          if (rspi->master->can_dma && __rspi_can_dma(rspi, xfer)) {
>>                  /* rx_buf can be NULL on RSPI on SH in TX-only Mode=
 */
>> -               ret =3D rspi_dma_transfer(rspi, &xfer->tx_sg,
>> +               int ret =3D rspi_dma_transfer(rspi, &xfer->tx_sg,
>>                                          xfer->rx_buf ? &xfer->rx_sg=
 : NULL);
>>                  if (ret !=3D -EAGAIN)
>> -                       return ret;
>> +                       return 0;
> Shouldn't you propagate "ret" here, instead of returning zero?
> Else you will turn a failure into a success below (see "here").
Thanks, I will keep the "ret" here.
>>          }
>>
>> +       return -EAGAIN;
>> +}
>> +
>> +static int rspi_common_transfer(struct rspi_data *rspi,
>> +                               struct spi_transfer *xfer)
>> +{
>> +       int ret;
>> +
>> +       ret =3D rspi_dma_check_then_transfer(rspi, xfer);
>> +       if (ret !=3D -EAGAIN)
>> +               return ret;
> ... here.
>
>> +
>>          ret =3D rspi_pio_transfer(rspi, xfer->tx_buf, xfer->rx_buf,=
 xfer->len);
>>          if (ret < 0)
>>                  return ret;
>> @@ -666,12 +729,59 @@ static int rspi_rz_transfer_one(struct spi_mas=
ter *master,
>>          return rspi_common_transfer(rspi, xfer);
>>   }
>>
>> +static int qspi_trigger_transfer_out_int(struct rspi_data *rspi, co=
nst u8 *tx,
> I guess this should be called "qspi_trigger_transfer_out_in" (without=
 "t")?
>
thanks, I will re-do that.

>> +                                       u8 *rx, unsigned int len)
>>   static int qspi_transfer_out_in(struct rspi_data *rspi,
>>                                  struct spi_transfer *xfer)
>>   {
>> +       int ret;
>> +
>>          qspi_receive_init(rspi);
>>
>> -       return rspi_common_transfer(rspi, xfer);
>> +       ret =3D rspi_dma_check_then_transfer(rspi, xfer);
>> +       if (ret !=3D -EAGAIN)
>> +               return ret;
>> +
>> +       ret =3D qspi_trigger_transfer_out_int(rspi, xfer->tx_buf,
>> +                                           xfer->rx_buf, xfer->len)=
;
>> +       if (ret < 0)
>> +               return ret;
>> +
>> +       return 0;
> You could just write
>
>        return qspi_trigger_transfer_out_int(rspi, xfer->tx_buf,
>                                             xfer->rx_buf, xfer->len);
ok. Thanks,

I will update your comments in other patch, then sending them to you an=
d=20
Mark-san.

Best Regards,
Hiep.


