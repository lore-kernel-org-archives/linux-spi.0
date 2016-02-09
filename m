From: Stefan Wahren <info-saaNCTdWVBT7BZbvpMY5sg@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: bcm2835aux: fix CPOL/CPHA setting
Date: Tue, 9 Feb 2016 21:21:15 +0100
Message-ID: <56BA4A3B.3090605@lategoodbye.de>
References: <1455041435-8015-1-git-send-email-stephanolbrich@gmx.de>
 <1455041435-8015-5-git-send-email-stephanolbrich@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: stephanolbrich-Mmb7MZpHnFY@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>,
	Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1455041435-8015-5-git-send-email-stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Stephan,

Am 09.02.2016 um 19:10 schrieb stephanolbrich-Mmb7MZpHnFY@public.gmane.org:
> From: Stephan Olbrich <stephanolbrich-Mmb7MZpHnFY@public.gmane.org>
>
> The auxiliary spi supports only CPHA=0 modes as the first bit is
> always output to the pin before the first clock cycle. In CPHA=1
> modes the first clock edge outputs the second bit hence the slave
> can never read the first bit.

in case auxiliary spi isn't able to handle all modes shouldn't we report 
this to the upper layers?

Regards
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
