From: =?windows-1252?Q?Vlastimil_=8Aetka?= <setka-3PjVBYxTQDg@public.gmane.org>
Subject: Re: [PATCH] spi: dw: Fix dynamic speed change
Date: Wed, 05 Nov 2014 13:07:36 +0100
Message-ID: <545A1308.4080106@vsis.cz>
References: <1415140617-2028-1-git-send-email-tthayer@opensource.altera.com> <20141105105452.GS3729@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, tthayer-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org,
	andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141105105452.GS3729-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

5.11.2014 11:54, Mark Brown:
> On Tue, Nov 04, 2014 at 04:36:56PM -0600, tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org wrote:
>
>> When speed_hz is not declared in a SPI transfer, the transfer speed is
>> not updated for the next read/write on /dev/spidevX.Y. The element
> Why is the behaviour of spidev relevant here, if there is a problem with
> spidev why is it being addressed in a specific driver?
You can do a transfer at SPI using SPI_IOC_MESSAGE ioctl. In this case 
you can declare speed_hz per transfer, and everything is OK in spi-dw.

If you do not declare speed_hz (default is 0) when using 
SPI_IOC_MESSAGE, or when you do just read/write on /dev/spidevX.Y, the 
spi_transfer->speed_hz is filled by spi->max_speed_hz (which is the 
value previously set by SPI_IOC_WR_MAX_SPEED_HZ). This triggers a 
problem in spi-dw.

>> spi_transfer->speed_hz is filled with spi->max_speed_hz. The test of
>> if (transfer->speed_hz != speed) doesn't work because the chip->speed_hz
>> matches transfer->speed_hz and the clock divider is not updated.
> In what way does the test "not work"?  What should the test be doing and
> what is it actually doing?

Test:
- set SPI clock to 100 000 Hz by SPI_IOC_WR_MAX_SPEED_HZ ioctl
- write something to /dev/spidevX.Y (or use SPI_IOC_MESSAGE with zero 
speed_hz)
- set SPI clock to 200 000 Hz by SPI_IOC_WR_MAX_SPEED_HZ ioctl
- write something to /dev/spidevX.Y (or use SPI_IOC_MESSAGE with zero 
speed_hz)

In last step, the clock should be 200 000 Hz, but actually it's 100 000 Hz.

The reason is buggy condition which encloses chip->clk_div recalculation:

      if (transfer->speed_hz) {
          speed = chip->speed_hz;
          if (transfer->speed_hz != speed) {

because transfer->speed_hz is filled by spi->max_speed_hz, which is 
equal to chip->speed_hz -- because SPI_IOC_WR_MAX_SPEED_HZ do this (in 
dw_spi_setup):

     chip->speed_hz = spi->max_speed_hz = new_spi_speed

>
>> +	/* Always calculate the desired clock divider */
>> +	speed = transfer->speed_hz ? transfer->speed_hz : chip->speed_hz;
> Please avoid using the ternery operator standalone, write a normal if to
> help people read the code.  Though in this case the core should always
> ensure that there is a speed set on each transfer so I'm not clear when
> this test would ever use anything other than transfer->speed_hz anyway.
Yes, as I can catch from code, the transfer->speed_hz should never be 0. 
But in current spi-dw.c version there is a `if (transfer->speed_hz)` 
condition, so I kept it in the patch.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
