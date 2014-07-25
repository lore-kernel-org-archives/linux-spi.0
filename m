From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 1/2] dmaengine: Clarify device parameter for
 dma_sync_*_for_*()
Date: Fri, 25 Jul 2014 14:21:48 +0530
Message-ID: <20140725085148.GN8181@intel.com>
References: <1405094182-13962-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1405094182-13962-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Jul 11, 2014 at 05:56:21PM +0200, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
> ---
> v2:
>   - New
> ---
>  Documentation/dmaengine.txt | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/dmaengine.txt b/Documentation/dmaengine.txt
> index 879b6e31e2da..87d3f192e160 100644
> --- a/Documentation/dmaengine.txt
> +++ b/Documentation/dmaengine.txt
> @@ -100,8 +100,10 @@ The slave DMA usage consists of following steps:
>     The peripheral driver is expected to have mapped the scatterlist for
>     the DMA operation prior to calling device_prep_slave_sg, and must
>     keep the scatterlist mapped until the DMA operation has completed.
> -   The scatterlist must be mapped using the DMA struct device.  So,
> -   normal setup should look like this:
> +   The scatterlist must be mapped using the DMA struct device.
> +   If a mapping needs to be synchronized later, dma_sync_*_for_*() must be
> +   called using the DMA struct device, too.
> +   So, normal setup should look like this:
>  
>  	nr_sg = dma_map_sg(chan->device->dev, sgl, sg_len);
>  	if (nr_sg == 0)
> -- 
> 1.9.1
> 
Applied, thanks

-- 
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
