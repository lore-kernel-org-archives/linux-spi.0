From: Andi Shyti <andi.shyti@samsung.com>
Subject: Re: [PATCH] spi: s3c64xx: Don't request/release DMA channels for each
 SPI transfer
Date: Fri, 30 Dec 2016 10:31:30 +0900
Message-ID: <20161230013130.dxs45jtc7fyidx5g@gangnam.samsung>
References: <CGME20161229121937eucas1p11cd0bb98b21699b0f773ecaeb7c29d26@eucas1p1.samsung.com>
 <1483013971-26446-1-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Javier Martinez Canillas <javier@osg.samsung.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-disposition: inline
In-reply-to: <1483013971-26446-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Marek,

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
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

Thanks!

Reviewed-by: Andi Shyti <andi.shyti@samsung.com>
Tested-by: Andi Shyti <andi.shyti@samsung.com>

Andi
