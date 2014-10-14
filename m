From: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH] spi: pl022: Fix incorrect dma_unmap_sg
Date: Mon, 13 Oct 2014 20:05:56 -0700
Message-ID: <543C9314.4080507@broadcom.com>
References: <rjui@broadcom.com> <1412880294-9860-1-git-send-email-rjui@broadcom.com> <20141013110851.GU27755@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141013110851.GU27755-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 10/13/2014 4:08 AM, Mark Brown wrote:
> On Thu, Oct 09, 2014 at 11:44:54AM -0700, Ray Jui wrote:
>> When mapped RX DMA entries are unmapped in an error condition when DMA
>> is firstly configured in the driver, the number of TX DMA entries was
>> passed in, which is incorrect
>
> Applied, thanks.
>
Thanks, Mark.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
