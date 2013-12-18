From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH 11/11] spi: bcm2835: Use devm_request_irq()
Date: Tue, 17 Dec 2013 19:18:08 -0700
Message-ID: <52B105E0.7080602@wwwdotorg.org>
References: <000801cef4c7$1b84a470$528ded50$%han@samsung.com> <001701cef4c8$eaa87c30$bff97490$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Chris Boot' <bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org>,
	'Laurent Navet' <laurent.navet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <001701cef4c8$eaa87c30$bff97490$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 12/09/2013 03:25 AM, Jingoo Han wrote:
> Use devm_request_irq() to make cleanup paths simpler.

Sorry for the slow response. This is likely fine, since the SPI
controller has a dedicated interrupt.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
