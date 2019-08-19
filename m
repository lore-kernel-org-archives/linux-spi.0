From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] spi: zynq-qspi: Fix missing spi_unregister_controller
 when unload module
Date: Mon, 19 Aug 2019 08:54:30 +0200
Message-ID: <21496235-7fcc-d2bb-407a-5770b11b87d7@xilinx.com>
References: <20190818095113.2397-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Michal Simek <michal.simek@xilinx.com>,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190818095113.2397-1-axel.lin@ingics.com>
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

On 18. 08. 19 11:51, Axel Lin wrote:
> Use devm_spi_register_controller to fix missing spi_unregister_controller
> when unload module.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/spi/spi-zynq-qspi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-zynq-qspi.c b/drivers/spi/spi-zynq-qspi.c
> index 3155e2cabb1e..4a5326ccf65a 100644
> --- a/drivers/spi/spi-zynq-qspi.c
> +++ b/drivers/spi/spi-zynq-qspi.c
> @@ -694,7 +694,7 @@ static int zynq_qspi_probe(struct platform_device *pdev)
>  	ctlr->setup = zynq_qspi_setup_op;
>  	ctlr->max_speed_hz = clk_get_rate(xqspi->refclk) / 2;
>  	ctlr->dev.of_node = np;
> -	ret = spi_register_controller(ctlr);
> +	ret = devm_spi_register_controller(&pdev->dev, ctlr);
>  	if (ret) {
>  		dev_err(&pdev->dev, "spi_register_master failed\n");
>  		goto clk_dis_all;
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
