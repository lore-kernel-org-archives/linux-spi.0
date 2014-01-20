From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH] spi: sc18is602: Remove sc18is602_setup() because it is
 done by spi core
Date: Mon, 20 Jan 2014 08:24:55 -0800
Message-ID: <52DD4DD7.3030605@roeck-us.net>
References: <1390231125.11756.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1390231125.11756.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 01/20/2014 07:18 AM, Axel Lin wrote:
> The checking for spi->mode is done in the implementation of spi_setup().
> Calling sc18is602_check_transfer(spi, NULL, 0) is pointless because
> the code is equivent to checking if spi->max_speed_hz is 0.
> Note, sc18is602_check_transfer actually allows spi->max_speed_hz is 0
> if t->speed_hz is set. So return error in sc18is602_setup() when
> spi->max_speed_hz is 0 does not make sense.
>
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>

Acked-by: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
