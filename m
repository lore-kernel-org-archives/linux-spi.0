From: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: pxa2xx: Set the max_speed_hz of the master
Date: Sat, 26 Sep 2015 11:23:26 +0200
Message-ID: <877fndo7ox.fsf@belgarion.home>
References: <1443166038-31658-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1443166038-31658-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
	(Jarkko Nikula's message of "Fri, 25 Sep 2015 10:27:17 +0300")
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> writes:

> Carry input clock of the controller in max_speed_hz of struct spi_master
> instead of in own driver data. They mean the same thing and more over now
> the max_speed_hz is not even set here.
>
> As an added bonus this allows SPI core to validate that transfer speed is
> not beyond the maximum input clock. This is not a problem in spi-pxa2xx as
> the driver doesn't use transfer speed parameter directly but via input
> clock divider calculation which will top at divide by one. However it's
> better to validate speed before passing it here.
>
> Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Acked-by: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>

Cheers.

--
Robert
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
