From: "Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 0/2] Remove .owner from spi_drivers
Date: Wed, 28 Oct 2015 12:51:17 -0500
Message-ID: <56310B15.3000103@ti.com>
References: <1445608751-8432-1-git-send-email-afd@ti.com>
 <20151023182911.GA14674@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Sebastian Reichel <sre-GFxCN5SEZAc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20151023182911.GA14674@earth>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 10/23/2015 01:29 PM, Sebastian Reichel wrote:
> Hi,
>
> On Fri, Oct 23, 2015 at 08:59:09AM -0500, Andrew F. Davis wrote:
>> This series adds a helper macro to the SPI core that assigns the owner
>> in spi_drivers so individual drivers do not have to do this, this is
>> similar to other subsystems like platform_driver and i2c_driver that
>> have made this change.
>
> Probably it makes sense to also update the related coccinelle
> script: scripts/coccinelle/api/platform_no_drv_owner.cocci
>
> -- Sebastian
>

Makes sense, patch submitted.

Thanks,
Andrew
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
