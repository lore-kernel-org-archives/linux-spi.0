From: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: atmel: Refactor spi-atmel to use SPI framework queue
Date: Wed, 08 Jan 2014 11:25:31 +0100
Message-ID: <52CD279B.6020203@gmail.com>
References: <1389160188-4030-1-git-send-email-wenyou.yang@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389160188-4030-1-git-send-email-wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 08/01/2014 06:49, Wenyou Yang wrote:
> Replace the deprecated master->transfer with transfer_one_message()
> and allow the SPI subsystem handle all the queuing of messages.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> ---
> Hi Mark,
> 
> The patch is based on for-next branch of
> 	git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
> 
> It is tested on sama5d3xek and at91sam9m10g45ek board.

And the bug I was seeing with SPI_IOC_MESSAGE (cf https://lkml.org/lkml/2013/10/8/269 )
is now gone !

Tested on at91sam9g35-ek

Tested-by: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
