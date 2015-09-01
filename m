From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] spi: spi-pxa2xx: Check status register to determine if
 SSSR_TINT is disabled
Date: Tue, 01 Sep 2015 10:41:50 +0300
Message-ID: <55E556BE.1020705@linux.intel.com>
References: <1441074171-23265-1-git-send-email-jui.nee.tan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: Tan Jui Nee <jui.nee.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441074171-23265-1-git-send-email-jui.nee.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 09/01/2015 05:22 AM, Tan Jui Nee wrote:
> From: "Tan, Jui Nee" <jui.nee.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>
> On Intel Baytrail, there is case when interrupt handler get called, no SPI
> message is captured. The RX FIFO is indeed empty when RX timeout pending
> interrupt (SSSR_TINT) happens.
>
> Use the BIOS version where both HSUART and SPI are on the same IRQ. Both
> drivers are using IRQF_SHARED when calling the request_irq function. When
> running two separate and independent SPI and HSUART application that
> generate data traffic on both components, user will see messages like
> below on the console:
>
>    pxa2xx-spi pxa2xx-spi.0: bad message state in interrupt handler
>
> This commit will fix this by first checking Receiver Time-out Interrupt,
> if it is disabled, ignore the request and return without servicing.
>
> Signed-off-by: Tan, Jui Nee <jui.nee.tan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>   drivers/spi/spi-pxa2xx.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
Acked-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
