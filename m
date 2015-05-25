From: Mirza Krak <mirza.krak-3xdUHytR7SMQwY+2splSUA@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: fsl-dspi: Fixes warning due to devm_kzalloc on
 unbound device
Date: Mon, 25 May 2015 17:04:47 +0200
Message-ID: <CAJ=nTsvxwvvBnq3ymTnHeyeMft0H72RLOJ2mOoOoW=9hyMxxEg@mail.gmail.com>
References: <1417723755-5372-1-git-send-email-mirza.krak@hostmobility.com>
	<20150525141223.GZ21391@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150525141223.GZ21391-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2015-05-25 16:12 GMT+02:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Thu, Dec 04, 2014 at 09:09:15PM +0100, Mirza Krak wrote:
>
>> ------------[ cut here ]------------
>> WARNING: at drivers/base/dd.c:286 driver_probe_device+0x1b4/0x22c()
>> Modules linked in:
>> Backtrace:
>
> Please don't paste entire backtraces into commit messages, they're la=
rge
> and make it hard to find the content - if one  is useful please paste
> the relevant portions only.
>
>> Inspired by: 10aa5a35e34f ("SPI: fix over-eager devm_xxx()
>> conversion")
>>
>> Signed-off-by: Mirza Krak <mirza.krak-3xdUHytR7SMQwY+2splSUA@public.gmane.org>
>
> Your commit message should describe what the problem was and how it i=
s
> being fixed (ie, describe the change) rather than simply stating that=
 it
> is fixing an issue unless the change is really obvious.
>
>> @@ -342,7 +342,7 @@ static int dspi_setup_transfer(struct spi_device=
 *spi, struct spi_transfer *t)
>>       /* Only alloc on first setup */
>>       chip =3D spi_get_ctldata(spi);
>>       if (chip =3D=3D NULL) {
>> -             chip =3D devm_kzalloc(&spi->dev, sizeof(struct chip_da=
ta),
>> +             chip =3D kzalloc(sizeof(struct chip_data), GFP_KERNEL)=
;
>>                                   GFP_KERNEL);
>>               if (!chip)
>>                       return -ENOMEM;
>
> This is good.
>
>> @@ -382,6 +382,11 @@ static int dspi_setup(struct spi_device *spi)
>>       return dspi_setup_transfer(spi, NULL);
>>  }
>>
>> +static void dspi_cleanup(struct spi_device *spi)
>> +{
>> +     spi_bitbang_cleanup(spi);
>> +}
>> +
>>  static irqreturn_t dspi_interrupt(int irq, void *dev_id)
>>  {
>>       struct fsl_dspi *dspi =3D (struct fsl_dspi *)dev_id;
>> @@ -465,6 +470,7 @@ static int dspi_probe(struct platform_device *pd=
ev)
>>       dspi->bitbang.setup_transfer =3D dspi_setup_transfer;
>>       dspi->bitbang.txrx_bufs =3D dspi_txrx_transfer;
>>       dspi->bitbang.master->setup =3D dspi_setup;
>> +     dspi->bitbang.master->cleanup =3D dspi_cleanup;
>>       dspi->bitbang.master->dev.of_node =3D pdev->dev.of_node;
>
> Why not just assign spi_bitbang_cleanup() directly?

Thank you for reviewing this, but this has been fixed already [1], he
probably did not top post :). We can NAK this.

[1] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/com=
mit/drivers/spi/spi-fsl-dspi.c?id=3D973fbce69ed8e79b5fe3ad19cfecb581a7e=
f8048

--=20
Med V=C3=A4nliga H=C3=A4lsningar / Best Regards

*******************************************************************
Mirza Krak
Host Mobility AB
mirza.krak-3xdUHytR7SMQwY+2splSUA@public.gmane.org
Anders Personsgatan 12, 416 64 G=C3=B6teborg
Sweden
http://www.hostmobility.com
Direct: +46 31 31 32 704
Phone: +46 31 31 32 700
=46ax: +46 31 80 67 51
Mobile: +46 730 28 06 22
*******************************************************************
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
