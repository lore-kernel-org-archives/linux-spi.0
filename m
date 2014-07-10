From: Harini Katakam <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: cadence: Configure SPI clock in the
 prepare_message() callback
Date: Thu, 10 Jul 2014 16:13:46 +0530
Message-ID: <CAFcVEC+yX7Zm2rq=XU0V8cs-vgxeLX5HsM=NySXwe9iEazC5eA@mail.gmail.com>
References: <1404984389-12802-1-git-send-email-lars@metafoo.de>
	<1404984389-12802-2-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1404984389-12802-2-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

On Thu, Jul 10, 2014 at 2:56 PM, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org> wrote:
> Currently the cadence SPI driver does the SPI clock configuration (setup CPOL
> and CPHA) in the prepare_transfer_hardware() callback. The
> prepare_transfer_hardware() callback is only called though when the controller
> transitions from a idle state to a non-idle state. Such a transitions happens
> when the message queue goes from empty to non-empty. If multiple messages from
> different SPI slaves with different clock settings are in the message queue the
> clock settings will not be properly updated when switching from one slave device
> to another. Instead do the updating of the clock configuration in the
> prepare_message() callback which will be called for each individual message.
>

Yes, the requirement from the controller is that CPOL/CPHA setting changes
will not take effect when SPI is enabled. CPOL/CPHA setting is done in
prepare_hardware
before SPI is enabled. So this works.
According to your patches I understand that you might change CPOL/CPHA for
each message. Is this possible? Is this a requirement?

Regards,
Harini
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
