From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: rockchip: check requesting dma channel with
 EPROBE_DEFER
Date: Tue, 22 Mar 2016 14:59:56 +0300
Message-ID: <20160322115956.GY5273@mwanda>
References: <1457511043-2058-1-git-send-email-shawn.lin@rock-chips.com>
 <1457511092-2216-1-git-send-email-shawn.lin@rock-chips.com>
 <CAD=FV=Wi9SEtM+o4AEPW6kpuGU+NH1uhW9hk5OQ5U8inyr1y1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
 Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
 "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=Wi9SEtM+o4AEPW6kpuGU+NH1uhW9hk5OQ5U8inyr1y1w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Mar 21, 2016 at 04:33:32PM -0700, Doug Anderson wrote:
> Presumably Dan would be happy if you just add this right after the dev_warn():
>   rs->dma_tx.ch = NULL;
> 

Yes.  Thanks.

> Presumably from Dan's email it would also be wise to make sure you
> don't pass NULL to PTR_ERR, which you could probably do by just using
> ERR_PTR instead of PTR_ERR.  I think you could structure like this:
> 
>         rs->dma_tx.ch = dma_request_slave_channel(rs->dev, "tx");
> -       if (!rs->dma_tx.ch)
> +       if (IS_ERR_OR_NULL(rs->dma_tx.ch)) {
> +               /* Check tx to see if we need defer probing driver */
> +               if (rs->dma_tx.ch == ERR_PTR(-EPROBE_DEFER)) {
> +                       ret = -EPROBE_DEFER;
> +                       goto err_get_fifo_len;
> +               }
>                 dev_warn(rs->dev, "Failed to request TX DMA channel\n");
> +               rs->dma_tx.ch = NULL;
> +       }

My check doesn't care if you pass something to PTR_ERR() that might be
NULL, it complains when PTR_ERR() can only be zero.  And it's ok to have
the warning for a while and silence it in another patch when we update
dma_request_slave_channel().

But this also works well.

regards,
dan carpenter
