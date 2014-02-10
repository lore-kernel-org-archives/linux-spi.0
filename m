From: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH RFT] spi: ep93xx: Convert to let spi core handle checking
 transfer speed
Date: Mon, 10 Feb 2014 13:11:20 +0200
Message-ID: <CALp=xyNt+1T64XZQac9Rva+JVXrkgG+xbV6JMWrOBOUNmFRhXA@mail.gmail.com>
References: <1391874746.24507.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1391874746.24507.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sat, Feb 8, 2014 at 5:52 PM, Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org> wrote:
>
> By setting master->max_speed_hz and master->min_speed_hz, spi core will handle
> checking transfer speed. So we can remove the same checking in this driver.
>
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>

I don't have the hardware to test this anymore but the patch looks good to me.

Acked-by: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>

Adding Hartley to the loop in case he has some comments.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
