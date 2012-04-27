From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 5/6] spi: spi-bfin5xx: reverse if condition in interrupt
	mode
Date: Fri, 27 Apr 2012 12:21:59 -0600
Message-ID: <20120427182159.1F6E43E171B@localhost>
References: <1335219493-24184-1-git-send-email-scott.jiang.linux@gmail.com>
	<1335219493-24184-5-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1335219493-24184-5-git-send-email-scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, 23 Apr 2012 18:18:12 -0400, Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> This condition is used to determine 8 bits or 16 and 32 bits transfer. Obviously it is reversed.
> 
> Signed-off-by: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Applied, thanks.

g.

> ---
>  drivers/spi/spi-bfin5xx.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi-bfin5xx.c b/drivers/spi/spi-bfin5xx.c
> index c0cdcb7..432d019 100644
> --- a/drivers/spi/spi-bfin5xx.c
> +++ b/drivers/spi/spi-bfin5xx.c
> @@ -396,7 +396,7 @@ static irqreturn_t bfin_spi_pio_irq_handler(int irq, void *dev_id)
>  		/* last read */
>  		if (drv_data->rx) {
>  			dev_dbg(&drv_data->pdev->dev, "last read\n");
> -			if (n_bytes % 2) {
> +			if (!(n_bytes % 2)) {
>  				u16 *buf = (u16 *)drv_data->rx;
>  				for (loop = 0; loop < n_bytes / 2; loop++)
>  					*buf++ = bfin_read(&drv_data->regs->rdbr);
> @@ -424,7 +424,7 @@ static irqreturn_t bfin_spi_pio_irq_handler(int irq, void *dev_id)
>  	if (drv_data->rx && drv_data->tx) {
>  		/* duplex */
>  		dev_dbg(&drv_data->pdev->dev, "duplex: write_TDBR\n");
> -		if (n_bytes % 2) {
> +		if (!(n_bytes % 2)) {
>  			u16 *buf = (u16 *)drv_data->rx;
>  			u16 *buf2 = (u16 *)drv_data->tx;
>  			for (loop = 0; loop < n_bytes / 2; loop++) {
> @@ -442,7 +442,7 @@ static irqreturn_t bfin_spi_pio_irq_handler(int irq, void *dev_id)
>  	} else if (drv_data->rx) {
>  		/* read */
>  		dev_dbg(&drv_data->pdev->dev, "read: write_TDBR\n");
> -		if (n_bytes % 2) {
> +		if (!(n_bytes % 2)) {
>  			u16 *buf = (u16 *)drv_data->rx;
>  			for (loop = 0; loop < n_bytes / 2; loop++) {
>  				*buf++ = bfin_read(&drv_data->regs->rdbr);
> @@ -458,7 +458,7 @@ static irqreturn_t bfin_spi_pio_irq_handler(int irq, void *dev_id)
>  	} else if (drv_data->tx) {
>  		/* write */
>  		dev_dbg(&drv_data->pdev->dev, "write: write_TDBR\n");
> -		if (n_bytes % 2) {
> +		if (!(n_bytes % 2)) {
>  			u16 *buf = (u16 *)drv_data->tx;
>  			for (loop = 0; loop < n_bytes / 2; loop++) {
>  				bfin_read(&drv_data->regs->rdbr);
> -- 
> 1.7.0.4
> 
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
