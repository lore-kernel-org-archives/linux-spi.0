From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/3] omap2_spi: fix compilation warning.
Date: Fri, 3 Jun 2011 14:59:54 -0600
Message-ID: <20110603205954.GJ17972@ponder.secretlab.ca>
References: <1306908084-28959-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general@lists.sourceforge.net, stable@kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Return-path: <stable-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <1306908084-28959-1-git-send-email-govindraj.raja@ti.com>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/stable>,
	<mailto:stable-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/mailman/private/stable/>
List-Post: <mailto:stable@linux.kernel.org>
List-Help: <mailto:stable-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/stable>,
	<mailto:stable-request@linux.kernel.org?subject=subscribe>
Sender: stable-bounces@linux.kernel.org
Errors-To: stable-bounces@linux.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jun 01, 2011 at 11:31:24AM +0530, Govindraj.R wrote:
> fix below compilation warning.
> 
> drivers/spi/omap2_mcspi.c: In function 'omap2_mcspi_txrx_dma':
> drivers/spi/omap2_mcspi.c:301: warning: 'elements' may be used uninitialized in this function
> 
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>

Applied, thanks.

Should got to stable too.

g.

> ---
>  drivers/spi/omap2_mcspi.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
> index 6f86ba0..969cdd2 100644
> --- a/drivers/spi/omap2_mcspi.c
> +++ b/drivers/spi/omap2_mcspi.c
> @@ -298,7 +298,7 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
>  	unsigned int		count, c;
>  	unsigned long		base, tx_reg, rx_reg;
>  	int			word_len, data_type, element_count;
> -	int			elements;
> +	int			elements = 0;
>  	u32			l;
>  	u8			* rx;
>  	const u8		* tx;
> -- 
> 1.7.0.4
> 

_______________________________________________
stable mailing list
stable@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/stable
