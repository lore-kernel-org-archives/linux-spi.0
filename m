From: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 0/2] spi: meson: Add Amlogic GXBB compatible
Date: Thu, 08 Sep 2016 11:13:48 -0700
Message-ID: <m2wpimmf8j.fsf@baylibre.com>
References: <1473321206-32284-1-git-send-email-narmstrong@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-amlogic-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1473321206-32284-1-git-send-email-narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> (Neil
        Armstrong's message of "Thu, 8 Sep 2016 09:53:24 +0200")
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Neil Armstrong <narmstrong-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> writes:

> This patchset adds a specific compatible string in the Meson SPIFC driver for
> the Amlogic Meson GXBB SoC.
>
> This patchset is SPI-only respin from Jerome Brunet patchset at [1].
>
> [1] http://lkml.kernel.org/r/1473261223-15412-1-git-send-email-jbrunet-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
>
> Neil Armstrong (2):
>   dt-bindings: spi-meson: Add GXBB Compatible string
>   spi: meson: Add GXBB compatible

Acked-by: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>

Mark, with your ack, I could take these through the amlogic tree also.
Let me know.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
