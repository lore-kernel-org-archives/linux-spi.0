From: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH v6 01/13] spi: atmel-quadspi: cache MR value to avoid a
 write access
Date: Wed, 6 Feb 2019 17:21:21 +0100
Message-ID: <20190206172121.78fff6c5@kernel.org>
References: <20190205173254.16388-1-tudor.ambarus@microchip.com>
 <20190205173254.16388-2-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org,
 Cyrille.Pitchen@microchip.com, robh+dt@kernel.org, linux-spi@vger.kernel.org,
 Ludovic.Desroches@microchip.com, broonie@kernel.org,
 linux-mtd@lists.infradead.org, bugalski.piotr@gmail.com,
 linux-arm-kernel@lists.infradead.org
To: <Tudor.Ambarus@microchip.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190205173254.16388-2-tudor.ambarus@microchip.com>
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

On Tue, 5 Feb 2019 17:33:06 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Set the controller by default in Serial Memory Mode (SMM) at probe.
> Cache Mode Register (MR) value to avoid write access when setting
> the controller in serial memory mode at exec_op().
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Add my R-b back

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
> v6: no change
> v5: collect R-b
> v4: s/smm/mr, init controller in serial memory mode by default
> v3: update smm value when different. rename mr/smm
> v2: cache MR value instead of moving the write access at probe
> 
>  drivers/spi/atmel-quadspi.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index ddc712410812..d6864d29f294 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -155,6 +155,7 @@ struct atmel_qspi {
>  	struct clk		*clk;
>  	struct platform_device	*pdev;
>  	u32			pending;
> +	u32			mr;
>  	struct completion	cmd_completion;
>  };
>  
> @@ -238,7 +239,14 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  	icr = QSPI_ICR_INST(op->cmd.opcode);
>  	ifr = QSPI_IFR_INSTEN;
>  
> -	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
> +	/*
> +	 * If the QSPI controller is set in regular SPI mode, set it in
> +	 * Serial Memory Mode (SMM).
> +	 */
> +	if (aq->mr != QSPI_MR_SMM) {
> +		qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
> +		aq->mr = QSPI_MR_SMM;
> +	}
>  
>  	mode = find_mode(op);
>  	if (mode < 0)
> @@ -381,6 +389,10 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
>  	/* Reset the QSPI controller */
>  	qspi_writel(aq, QSPI_CR, QSPI_CR_SWRST);
>  
> +	/* Set the QSPI controller by default in Serial Memory Mode */
> +	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
> +	aq->mr = QSPI_MR_SMM;
> +
>  	/* Enable the QSPI controller */
>  	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIEN);
>  
