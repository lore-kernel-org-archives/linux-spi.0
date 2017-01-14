From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 14/17] spi/topcliff-pch: Adjust six checks for null
 pointers
Date: Sat, 14 Jan 2017 09:36:08 +0300
Message-ID: <20170114063608.GD15314@mwanda>
References: <1413e173-dbac-7a6e-09cb-2287300a335e@users.sourceforge.net>
 <676a6351-ec06-9744-9f6f-753feb65f8fb@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <676a6351-ec06-9744-9f6f-753feb65f8fb@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jan 13, 2017 at 06:24:22PM +0100, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 13 Jan 2017 16:16:05 +0100
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> The script "checkpatch.pl" pointed information out like the following.
> 
> Comparison to NULL could be written …
> 
> Thus fix the affected source code places.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/spi/spi-topcliff-pch.c | 15 ++++++---------
>  1 file changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
> index 0a876311b67b..e4f1f66b751b 100644
> --- a/drivers/spi/spi-topcliff-pch.c
> +++ b/drivers/spi/spi-topcliff-pch.c
> @@ -531,12 +531,11 @@ static int pch_spi_transfer(struct spi_device *pspi, struct spi_message *pmsg)
>  static inline void pch_spi_select_chip(struct pch_spi_data *data,
>  				       struct spi_device *pspi)
>  {
> -	if (data->current_chip != NULL) {
> +	if (data->current_chip)


Put the curly braces back.  Multi-line indents get curly braces for
readability.

>  		if (pspi->chip_select != data->n_curnt_chip) {
>  			dev_dbg(&pspi->dev, "%s : different slave\n", __func__);
>  			data->current_chip = NULL;
>  		}
> -	}

regards,
dan carpenter
