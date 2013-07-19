From: yuhang wang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: support DUAL and QUAD[patch v1]
Date: Fri, 19 Jul 2013 10:24:56 +0800
Message-ID: <CAHSAbzNNLbfot_j1rBUsd+1NUJcWeGkCReD+iTMsV-CoprOb=w@mail.gmail.com>
References: <CAHSAbzP0Nc1ahf_ra6yDuMvV998_+EGcUOGDv5ifKaagYf+NOg@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9E84D2@DBDE04.ent.ti.com>
	<CAHSAbzMDOWo5oBqUHqMxybuDwUjFbczYwN+85gH+rxZ9z8u2Pw@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9E851E@DBDE04.ent.ti.com>
	<593AEF6C47F46446852B067021A273D6D93B49E1@MUCSE039.lantiq.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9E85D0@DBDE04.ent.ti.com>
	<CAHSAbzP5jqHwCm0qhu=DiNzpP0swqWHsQ0=MnF+EKaSN22E5hg@mail.gmail.com>
	<CA+7tXihoZZhpoyvxj58c+Zi-Zy631kK5s-kDoSxPKq=ej0qyvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org" <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>,
	"broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>, "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, "Poddar,
	Sourav" <sourav.poddar-l0cyMroinI0@public.gmane.org>
To: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CA+7tXihoZZhpoyvxj58c+Zi-Zy631kK5s-kDoSxPKq=ej0qyvA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Trent,

2013/7/18 Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> On Wed, Jul 17, 2013 at 6:58 PM, yuhang wang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> >> > >
>> >> > > > [Pekon]: Instead of adding new fields you can use existing 'mode'
>> >> > > > field
>> >> to
>> >> > > > pass on the platform specific configurations. And if 'u8 mode'
>> >> > > > does not
>> >> > > > suffice you can increase it to 'u32'.
>
> But what about spidev?
>
>> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
>> index 004b10f..36d2451 100644
>> --- a/drivers/spi/spi.c
>> +++ b/drivers/spi/spi.c
>> @@ -868,6 +868,14 @@ static void of_register_spi_devices(struct
>> spi_master *master)
>>   spi->mode |= SPI_CS_HIGH;
>>   if (of_find_property(nc, "spi-3wire", NULL))
>>   spi->mode |= SPI_3WIRE;
>> + if (of_find_property(nc, "spi-tx-dual", NULL))
>> + spi->mode |= SPI_TX_DUAL;
>> + if (of_find_property(nc, "spi-tx-quad", NULL))
>> + spi->mode |= SPI_TX_QUAD;
>> + if (of_find_property(nc, "spi-rx-dual", NULL))
>> + spi->mode |= SPI_RX_DUAL;
>> + if (of_find_property(nc, "spi-rx-quad", NULL))
>> + spi->mode |= SPI_RX_QUAD;
>>
>>   /* Device speed */
>>   prop = of_get_property(nc, "spi-max-frequency", &len);
>> @@ -1316,6 +1324,12 @@ int spi_setup(struct spi_device *spi)
>>   /* help drivers fail *cleanly* when they need options
>>   * that aren't supported with their current master
>>   */
>> + if (((spi->mode >> 8) & 0x03) == 0x03 ||
>> + ((spi->mode >> 10) & 0x03) == 0x03) {
>> + dev_err(&spi->dev,
>> + "setup: can not select dual and quad at the same time\n");
>> + return -EINVAL;
>> + }
>
> Maybe it would make more sense to have a spi-rx-width and spi-tx-width
> than can be set to 1, 2, 4, etc. bits instead of a bunch of properties
> that are mutually exclusive?  Sooner or later someone is going to want
> 8 bits.
>
>> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
>> index 38c2b92..e9ba1cf 100644
>> --- a/include/linux/spi/spi.h
>> +++ b/include/linux/spi/spi.h
>> @@ -74,7 +74,7 @@ struct spi_device {
>>   struct spi_master *master;
>>   u32 max_speed_hz;
>>   u8 chip_select;
>> - u8 mode;
>> + u16 mode;
>
> What about this, from include/uapi/linux/spi/spidev.h:
>
> /* Read / Write of SPI mode (SPI_MODE_0..SPI_MODE_3) */
> #define SPI_IOC_RD_MODE                 _IOR(SPI_IOC_MAGIC, 1, __u8)
> #define SPI_IOC_WR_MODE                 _IOW(SPI_IOC_MAGIC, 1, __u8)
>
> Note that you can't just change the type in the ioctl define, as it
> won't be backward compatible.
well, got it.Still need to be considered. Thanks

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
