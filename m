From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] spi/pl022: timeout on polled transfer v2
Date: Thu, 19 May 2011 10:55:31 -0600
Message-ID: <20110519165531.GF3085@ponder.secretlab.ca>
References: <1305821134-26147-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net,
	Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	Magnus Templing <magnus.templing@stericsson.com>
To: Linus Walleij <linus.walleij@stericsson.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1305821134-26147-1-git-send-email-linus.walleij@stericsson.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On Thu, May 19, 2011 at 06:05:34PM +0200, Linus Walleij wrote:
> From: Magnus Templing <magnus.templing@stericsson.com>
> 
> This adds the missing handling of polling timeouts and deletes
> our last todo.
> 
> Signed-off-by: Magnus Templing <magnus.templing@stericsson.com>
> Reviewed-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
> [Fixups from review by Wolfram Sang]
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thanks.

g.

> ---
>  drivers/spi/amba-pl022.c |   23 +++++++++++++++--------
>  1 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
> index 08de58e..18667de 100644
> --- a/drivers/spi/amba-pl022.c
> +++ b/drivers/spi/amba-pl022.c
> @@ -24,11 +24,6 @@
>   * GNU General Public License for more details.
>   */
>  
> -/*
> - * TODO:
> - * - add timeout on polled transfers
> - */
> -
>  #include <linux/init.h>
>  #include <linux/module.h>
>  #include <linux/device.h>
> @@ -287,6 +282,8 @@
>  
>  #define CLEAR_ALL_INTERRUPTS  0x3
>  
> +#define SPI_POLLING_TIMEOUT 1000
> +
>  
>  /*
>   * The type of reading going on on this chip
> @@ -1378,6 +1375,7 @@ static void do_polling_transfer(struct pl022 *pl022)
>  	struct spi_transfer *transfer = NULL;
>  	struct spi_transfer *previous = NULL;
>  	struct chip_data *chip;
> +	unsigned long time, timeout;
>  
>  	chip = pl022->cur_chip;
>  	message = pl022->cur_msg;
> @@ -1415,9 +1413,18 @@ static void do_polling_transfer(struct pl022 *pl022)
>  		       SSP_CR1(pl022->virtbase));
>  
>  		dev_dbg(&pl022->adev->dev, "polling transfer ongoing ...\n");
> -		/* FIXME: insert a timeout so we don't hang here indefinitely */
> -		while (pl022->tx < pl022->tx_end || pl022->rx < pl022->rx_end)
> +
> +		timeout = jiffies + msecs_to_jiffies(SPI_POLLING_TIMEOUT);
> +		while (pl022->tx < pl022->tx_end || pl022->rx < pl022->rx_end) {
> +			time = jiffies;
>  			readwriter(pl022);
> +			if (time_after(time, timeout)) {
> +				dev_warn(&pl022->adev->dev,
> +				"%s: timeout!\n", __func__);
> +				message->state = STATE_ERROR;
> +				goto out;
> +			}
> +		}
>  
>  		/* Update total byte transferred */
>  		message->actual_length += pl022->cur_transfer->len;
> @@ -1426,7 +1433,7 @@ static void do_polling_transfer(struct pl022 *pl022)
>  		/* Move to next transfer */
>  		message->state = next_transfer(pl022);
>  	}
> -
> +out:
>  	/* Handle end of message */
>  	if (message->state == STATE_DONE)
>  		message->status = 0;
> -- 
> 1.7.3.2
> 
