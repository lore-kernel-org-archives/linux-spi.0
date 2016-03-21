From: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: rockchip: check requesting dma channel with EPROBE_DEFER
Date: Mon, 21 Mar 2016 16:33:32 -0700
Message-ID: <CAD=FV=Wi9SEtM+o4AEPW6kpuGU+NH1uhW9hk5OQ5U8inyr1y1w@mail.gmail.com>
References: <1457511043-2058-1-git-send-email-shawn.lin@rock-chips.com>
	<1457511092-2216-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>,
	"open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1457511092-2216-1-git-send-email-shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Shawn,

On Wed, Mar 9, 2016 at 12:11 AM, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
> Let's defer probing the driver if the return value of
> dma_request_slave_channel is ERR_PTR(-EPROBE_DEFER) instead
> of disabling dma capability directly.
>
> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
>
>  drivers/spi/spi-rockchip.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index ca4f4e0..75fa990 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -737,8 +737,14 @@ static int rockchip_spi_probe(struct platform_device *pdev)
>         master->handle_err = rockchip_spi_handle_err;
>
>         rs->dma_tx.ch = dma_request_slave_channel(rs->dev, "tx");
> -       if (!rs->dma_tx.ch)
> +       if (IS_ERR_OR_NULL(rs->dma_tx.ch)) {
> +               /* Check tx to see if we need defer probing driver */
> +               if (PTR_ERR(rs->dma_tx.ch) == -EPROBE_DEFER) {
> +                       ret = -EPROBE_DEFER;
> +                       goto err_get_fifo_len;
> +               }
>                 dev_warn(rs->dev, "Failed to request TX DMA channel\n");

Presumably Dan would be happy if you just add this right after the dev_warn():
  rs->dma_tx.ch = NULL;

Presumably from Dan's email it would also be wise to make sure you
don't pass NULL to PTR_ERR, which you could probably do by just using
ERR_PTR instead of PTR_ERR.  I think you could structure like this:

        rs->dma_tx.ch = dma_request_slave_channel(rs->dev, "tx");
-       if (!rs->dma_tx.ch)
+       if (IS_ERR_OR_NULL(rs->dma_tx.ch)) {
+               /* Check tx to see if we need defer probing driver */
+               if (rs->dma_tx.ch == ERR_PTR(-EPROBE_DEFER)) {
+                       ret = -EPROBE_DEFER;
+                       goto err_get_fifo_len;
+               }
                dev_warn(rs->dev, "Failed to request TX DMA channel\n");
+               rs->dma_tx.ch = NULL;
+       }


With that change your patch should be happy, I think.  If some new
unknown error return gets added to dma_request_slave_channel() then
your code will continue to work properly.  Such a change is simple and
safe, so presumably you could just spin your patch with that fix.
Although unlikely, it's probably good to check for IS_ERR_OR_NULL()
when requesting the "rx" channel too.

...but, looking at this, presumably before landing any patch that made
dma_request_slave_channel() return -EPROBE_DEFER you'd need to modify
_all_ users of dma_request_slave_channel to handle error pointers
being returned.  Right now dma_request_slave_channel() says it returns
a pointer to a channel or NULL and the function explicitly avoids
returning any errors.  That might be possible, but it's a big
change...


-Doug
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
