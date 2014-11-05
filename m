From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: Re: [PATCH] spi: dw: Fix dynamic speed change
Date: Wed, 5 Nov 2014 14:25:59 -0600
Message-ID: <545A87D7.3010705@opensource.altera.com>
References: <1415140617-2028-1-git-send-email-tthayer@opensource.altera.com> <20141105105452.GS3729@sirena.org.uk> <545A1308.4080106@vsis.cz> <20141105132442.GT3729@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	<tthayer-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>, <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	=?UTF-8?B?Vmxhc3RpbWlsIMWgZXRrYQ==?= <setka-3PjVBYxTQDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141105132442.GT3729-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


On 11/05/2014 07:24 AM, Mark Brown wrote:
> On Wed, Nov 05, 2014 at 01:07:36PM +0100, Vlastimil =C5=A0etka wrote:
>> 5.11.2014 11:54, Mark Brown:
>>> On Tue, Nov 04, 2014 at 04:36:56PM -0600, tthayer-yzvPICuk2ABMcg4IHK0kFvd9D2ou9A/h@public.gmane.org=
=2Ecom wrote:
>>>> When speed_hz is not declared in a SPI transfer, the transfer spee=
d is
>>>> not updated for the next read/write on /dev/spidevX.Y. The element
>>> Why is the behaviour of spidev relevant here, if there is a problem=
 with
>>> spidev why is it being addressed in a specific driver?
>> You can do a transfer at SPI using SPI_IOC_MESSAGE ioctl. In this ca=
se you
>> can declare speed_hz per transfer, and everything is OK in spi-dw.
> You can declare a speed per transfer for *any* client, this is totall=
y
> generic behaviour.  What is the specific relevance of spidev here?
spidev was just the vehicle that the issue was observed on and is usefu=
l=20
for debugging.
>> If you do not declare speed_hz (default is 0) when using SPI_IOC_MES=
SAGE, or
>> when you do just read/write on /dev/spidevX.Y, the spi_transfer->spe=
ed_hz is
>> filled by spi->max_speed_hz (which is the value previously set by
>> SPI_IOC_WR_MAX_SPEED_HZ). This triggers a problem in spi-dw.
> Again, this is something that any client could do...
>
>> The reason is buggy condition which encloses chip->clk_div recalcula=
tion:
>>       if (transfer->speed_hz) {
>>           speed =3D chip->speed_hz;
>>           if (transfer->speed_hz !=3D speed) {
>> because transfer->speed_hz is filled by spi->max_speed_hz, which is =
equal to
>> chip->speed_hz -- because SPI_IOC_WR_MAX_SPEED_HZ do this (in dw_spi=
_setup):
> To repeat again: please talk about driver problems in terms of the
> driver not in terms of a particular driver.  Glancing at the code her=
e
> it looks like spidev is buggy here, it's just blindly allowing usersp=
ace
> to overwrite the maximum speed configured for the device which seems
> like a bad idea, drivers should have no reason to expect that somethi=
ng
> called max_speed is actually variable.  It looks like spidev is abusi=
ng
> this as a default speed.
spidev is calling the case condition SPI_IOC_WR_MAX_SPEED_HZ in=20
spidev_ioctl() to overwrite the maximum speed. From the code and the=20
name, it seems like overwriting the maximum speed was the intended use=20
and not a side effect.
>>      chip->speed_hz =3D spi->max_speed_hz =3D new_spi_speed
> So the driver is overriding its idea of the current speed without
> actually updatng the hardware.  Why is the fix here not to just delet=
e
> the assignment here, it seems fairly obviously buggy?
Yes, removing line 591 of the spi-dw.c (chip->speed_hz =3D=20
spi->max_speed_hz;) will solve the problem and seems like a clean fix.=20
In this case the chip->speed_hz will persist the last transfer speed=20
setting.

The chip->speed_hz parameter won't be updated as part of the spi-dw=20
driver initialization. This may not matter since it will get updated on=
=20
the first transfer in the (transfer->speed !=3D speed) test shown above=
=2E
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
