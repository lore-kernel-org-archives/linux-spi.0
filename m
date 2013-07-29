From: yuhang wang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2] SPI: DUAL and QUAD support
Date: Mon, 29 Jul 2013 10:44:43 +0800
Message-ID: <CAHSAbzNTUpsftZ1-fpv7UefuSdUvUidg9-SLOUXCTmSBhM0ZJQ@mail.gmail.com>
References: <1374917973-7083-1-git-send-email-wangyuhang2014@gmail.com>
	<CA+7tXihU+JODQec-h2joUYiVY=otuSOu8BwADn+mtgELCFHPng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>
To: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CA+7tXihU+JODQec-h2joUYiVY=otuSOu8BwADn+mtgELCFHPng-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi


2013/7/29 Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> On Sat, Jul 27, 2013 at 2:39 AM, wangyuhang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> 2:To spidev, in order to backward compatible, still use
>>  SPI_IOC_RD_MODE to deal with user who use <u8 mode>. Add
>>  SPI_IOC_EXTRD_MODE to fix the <u16 mode>. And SPI_IOC_RD_LSB_FIRST
>>  seems a little redundant, so del it.
>
> Your changes to spidev are not backward compatible at all.  You can
> not change the data types in the ioctl and maintain backward
> compatibility.  You can also not delete ioctls!
>
well, please give me some details or specific situations. Why ioctl
can not be changed. The operation that SPI_IOC_RD_LSB_FIRST do can be
done in SPI_IOC_RD_MODE, so I dont think there is any necessary using
SPI_IOC_RD_LSB_FIRST. What you worry about is the user already used
SPI_IOC_RD_LSB_FIRST?

>> @@ -1316,6 +1324,12 @@ int spi_setup(struct spi_device *spi)
>>         /* help drivers fail *cleanly* when they need options
>>          * that aren't supported with their current master
>>          */
>> +       if (((spi->mode >> 8) & 0x03) == 0x03 ||
>> +               ((spi->mode >> 10) & 0x03) == 0x03) {
>> +               dev_err(&spi->dev,
>> +               "setup: can not select dual and quad at the same time\n");
>> +               return -EINVAL;
>> +       }
>
> This code won't work if the constants you added for mode flags change
> value.  More importantly, anyone searching the code for SPI_TX_DUAL,
> etc. won't find this code.
agree, thanks.

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
