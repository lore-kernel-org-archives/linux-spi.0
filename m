From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH RFT] spi: bcm2835: Remove unnecessary workaround to call gpio_set_value
Date: Sat, 13 Feb 2016 18:08:25 +0100
Message-ID: <67B70D1B-7FA5-48A6-8719-490FA484BFF6@martin.sperl.org>
References: <1455380347.25581.1.camel@ingics.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455380347.25581.1.camel-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 13.02.2016, at 17:19, Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org> wrote:
> 
> This should be fixed by commit 4c02cba18cc9
> ("pinctrl: bcm2835: Fix initial value for direction_output")
> 
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>

Actually this also solves the situation when the DT is configured
badly - and it is likely that old DTs are configured badly,
because it did not matter before (it was always wrong anyway).

This change would break those old DTs in this respect and can
result in unexpected behavior and undetected devices.

In this case it would be better to add a warning that the
GPIO is not configured in the DT correctly, so that it is
clear that the DT needs to change.

But then maybe a more generalized approach implemented
in the framework would be better...

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
