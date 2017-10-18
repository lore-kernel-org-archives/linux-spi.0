From: Julien Thierry <julien.thierry@arm.com>
Subject: Re: [PATCH 3/4] spi: imx: Don't require platform data chipselect array
Date: Wed, 18 Oct 2017 10:02:46 +0100
Message-ID: <36d381de-ee3f-26d4-59c3-b9d361758ace@arm.com>
References: <20171013195410.30767-1-tpiepho@impinj.com>
 <20171013195410.30767-3-tpiepho@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
 Greg Ungerer <gerg@linux-m68k.org>, Sascha Hauer <kernel@pengutronix.de>
To: Trent Piepho <tpiepho@impinj.com>, linux-spi <linux-spi@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20171013195410.30767-3-tpiepho@impinj.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hi Trent,

On 13/10/17 20:54, Trent Piepho wrote:
> If the array is not present, assume all chip selects are native.  This
> is the standard behavior for SPI masters configured via the device
> tree and the behavior of this driver as well when it is configured via
> device tree.
> 
> This reduces platform data vs DT differences and allows most of the
> platform data based boards to remove their chip select arrays.
> 
> Signed-off-by: Trent Piepho <tpiepho@impinj.com>
> ---
>   drivers/spi/spi-imx.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index fea46cbf458a..3a2c34522655 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -1364,13 +1364,15 @@ static int spi_imx_probe(struct platform_device *pdev)
>   
>   	if (mxc_platform_info) {
>   		master->num_chipselect = mxc_platform_info->num_chipselect;

nit:
This is only useful when num_chipselect is non-zero (master's memory is 
zeroed on allocation). So maybe this could be simplified a bit more as:

if (mxc_platform_info && mxc_platform_info->chipselect) {
	master->num_chipselect = mxc_platform_info->num_chipselect;
	[...]
}

Reducing an indentation level for all the following statements.

Cheers,

> -		master->cs_gpios = devm_kzalloc(&master->dev,
> -			sizeof(int) * master->num_chipselect, GFP_KERNEL);
> -		if (!master->cs_gpios)
> -			return -ENOMEM;
> -
> -		for (i = 0; i < master->num_chipselect; i++)
> -			master->cs_gpios[i] = mxc_platform_info->chipselect[i];
> +		if (mxc_platform_info->chipselect) {
> +			master->cs_gpios = devm_kzalloc(&master->dev,
> +				sizeof(int) * master->num_chipselect, GFP_KERNEL);
> +			if (!master->cs_gpios)
> +				return -ENOMEM;
> +
> +			for (i = 0; i < master->num_chipselect; i++)
> +				master->cs_gpios[i] = mxc_platform_info->chipselect[i];
> +		}
>    	}
>   
>   	spi_imx->bitbang.chipselect = spi_imx_chipselect;
> 

-- 
Julien Thierry
