From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFT][PATCH v2] spi: clps711x: refactor to use core message parsing
Date: Tue, 18 Feb 2014 16:52:32 +0800
Message-ID: <CAFRkauCQkyDFixt-t1Oe9L8eJBdhCeAFMeEBn7KimfcFRcP_ag@mail.gmail.com>
References: <1392687089.5047.1.camel@phoenix>
	<1392712030.410354049@f297.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1392712030.410354049-ah3gxum9muhsdVUOrk1QfQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2014-02-18 16:27 GMT+08:00 Alexander Shiyan <shc_work-JGs/UdohzUI@public.gmane.org>:
> =F7=D4=CF=D2=CE=C9=CB, 18 =C6=C5=D7=D2=C1=CC=D1 2014, 9:31 +08:00 =CF=
=D4 Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>:
>> Convert to use default implementation of transfer_one_message() whic=
h provides
>> standard handling of delays and chip select management.
>>
>> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
>> ---
> ...
>>  static irqreturn_t spi_clps711x_isr(int irq, void *dev_id)
>>  {
>> -     struct spi_clps711x_data *hw =3D (struct spi_clps711x_data *)d=
ev_id;
>> +     struct spi_master *master =3D dev_id;
>> +     struct spi_clps711x_data *hw =3D spi_master_get_devdata(master=
);
>>       u8 data;
>>
>>       /* Handle RX */
>> @@ -135,7 +113,7 @@ static irqreturn_t spi_clps711x_isr(int irq, voi=
d *dev_id)
>>               clps_writel(data | SYNCIO_FRMLEN(hw->bpw) | SYNCIO_TXF=
RMEN,
>>                           SYNCIO);
>>       } else
>> -             complete(&hw->done);
>> +             complete(&master->xfer_completion);
>
> spi_finalize_current_transfer(master);

It's done by spi core. see spi_transfer_one_message() in spi.c

Regards,
Axel
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
