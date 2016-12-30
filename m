From: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: s3c64xx: Don't request/release DMA channels for
 each SPI transfer
Date: Fri, 30 Dec 2016 17:39:54 +0200
Message-ID: <20161230153954.fmx3l3jvqxlwlmfq@kozik-lap>
References: <CGME20161229121937eucas1p11cd0bb98b21699b0f773ecaeb7c29d26@eucas1p1.samsung.com>
 <1483013971-26446-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
        Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1483013971-26446-1-git-send-email-m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Dec 29, 2016 at 01:19:31PM +0100, Marek Szyprowski wrote:
> Requesting a DMA channel might be a time consuming operation, so there is
> no need to acquire and release DMA channel for each SPI transfer.
> DMA channels can be requested during driver probe and kept all the time,
> also because there are no shared nor dynamically allocated channels on
> Samsung S3C/S5P/Exynos platforms.
> 
> While moving dma_requrest_slave_channel calls, lets switch to
> dma_request_slave_channel_reason(), which returns error codes on failure,
> which can be properly propagated to the caller (this for example defers
> SPI probe when DMA controller is not yet available).
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/spi/spi-s3c64xx.c | 57 ++++++++++++++++++++++++-----------------------
>  1 file changed, 29 insertions(+), 28 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Best regards,
Krzysztof

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
