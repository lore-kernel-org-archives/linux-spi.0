From: Scott Wood <scott.wood@nxp.com>
Subject: Re: [PATCH] dspi: config dspi master regmap with right mode depend on
 BE or LE
Date: Sun, 17 Apr 2016 02:41:40 +0000
Message-ID: <DB5PR0401MB19281A317BFB1D9001F97ABB916A0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1460545402-8162-1-git-send-email-po.liu@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Po Liu <po.liu@nxp.com>, "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 04/13/2016 06:12 AM, Po Liu wrote:
> When kernel config with big endian mode, spi master need
> to config regmap data value to be little endian mode. Or else,
> the kernel boot will hang.
> 
> Signed-off-by: Po Liu <po.liu@nxp.com>
> ---
>  drivers/spi/spi-fsl-dspi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 39412c9..a1d893c 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -637,6 +637,9 @@ static const struct regmap_config dspi_regmap_config = {
>  	.val_bits = 32,
>  	.reg_stride = 4,
>  	.max_register = 0x88,
> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> +#endif

Drop this ifdef.  It's little endian regardless of what mode the CPU is in.

Are you sure this is correct on all platforms?  E.g. ls1021a?

Looking more closely, the binding has a big-endian property.  It says
the default if that property is absent is native endian, which is
insane.  Fix the binding to say that little endian is the default (this
change shouldn't break any existing trees), and make sure that's what
the code implements.  I think you need val_format_endian_default, not
val_format_endian.

-Scott
