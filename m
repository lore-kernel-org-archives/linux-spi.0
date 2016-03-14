From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: spi: rockchip: check requesting dma channel with EPROBE_DEFER
Date: Mon, 14 Mar 2016 14:14:46 +0300
Message-ID: <20160314111446.GM5273@mwanda>
References: <20160314094844.GA12754@mwanda> <56E6908C.3060904@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56E6908C.3060904-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
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

On Mon, Mar 14, 2016 at 06:21:00PM +0800, Shawn Lin wrote:
> On 2016/3/14 17:48, Dan Carpenter wrote:
> >Hello Shawn Lin,
> >
> >The patch 61cadcf46cfd: "spi: rockchip: check requesting dma channel
> >with EPROBE_DEFER" from Mar 9, 2016, leads to the following static
> >checker warning:
> >
> >	drivers/spi/spi-rockchip.c:742 rockchip_spi_probe()
> >	warn: passing zero to 'PTR_ERR'
> >
> >drivers/spi/spi-rockchip.c
> >    732
> >    733          rs->dma_tx.ch = dma_request_slave_channel(rs->dev, "tx");
> >    734          if (IS_ERR_OR_NULL(rs->dma_tx.ch)) {
> >    735                  /* Check tx to see if we need defer probing driver */
> >    736                  if (PTR_ERR(rs->dma_tx.ch) == -EPROBE_DEFER) {
> >    737                          ret = -EPROBE_DEFER;
> >    738                          goto err_get_fifo_len;
> >
> >What's going on here?  Are we planning to change dma_request_slave_channel()
> >to return error pointers?  Also what about other error pointers besides
> >EPROBE_DEFER it seems dangerous to leave rs->dma_tx.ch as an error
> >pointer.  We probably eventually try to free it if it's non-NULL.
> 
> yes, we are plannig to return EPROBE_DEFER/NULL for
> dma_request_slave_channel to make sure we don't decide
> the dma cap based on driver probe sequence.
> 
> No any other error pointer will be returned to the caller

It would not be terribly shocking if a couple years from now someone
else adds a new error return without auditing all the caller functions.

regards,
dan carpenter
