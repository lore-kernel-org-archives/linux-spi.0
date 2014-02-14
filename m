From: "Li.Xiubo@freescale.com" <Li.Xiubo@freescale.com>
Subject: RE: [PATCH v4 1/2] spi:fsl-dspi:convert to use regmap and
 big-endian supports
Date: Fri, 14 Feb 2014 07:33:17 +0000
Message-ID: <065acacc2f4f461cbd310eb54737a32e@DM2PR03MB509.namprd03.prod.outlook.com>
References: <1392190146-18852-1-git-send-email-b44548@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Chao Fu <B44548@freescale.com>
To: Chao Fu <B44548@freescale.com>, "linux-spi@vger.kernel.org"
 <linux-spi@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "broonie@kernel.org"
 <broonie@kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1392190146-18852-1-git-send-email-b44548@freescale.com>
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



> @@ -435,12 +441,20 @@ static const struct dev_pm_ops dspi_pm = {
>  	SET_SYSTEM_SLEEP_PM_OPS(dspi_suspend, dspi_resume)
>  };
> 
> +static struct regmap_config dspi_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = 0x88,
> +};
> +


If needed, you should add the callbacks like:
	.readable_reg,
	.writeable_reg,
	.volatile_reg,

Otherwise, it looks fine to me, for both patches:
Reviewed-by: Xiubo Li <Li.Xiubo@freescale.com>
