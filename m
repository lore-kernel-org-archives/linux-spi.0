From: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH v4 13/13] spi: atmel-quadspi: add support for sam9x60
 qspi controller
Date: Mon, 4 Feb 2019 15:16:43 +0100
Message-ID: <20190204151643.0354180d@bbrezillon>
References: <20190204100910.26701-1-tudor.ambarus@microchip.com>
 <20190204100910.26701-14-tudor.ambarus@microchip.com>
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
In-Reply-To: <20190204100910.26701-14-tudor.ambarus@microchip.com>
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

On Mon, 4 Feb 2019 10:10:21 +0000
<Tudor.Ambarus@microchip.com> wrote:

> +
> +static void atmel_qspi_sam9x60_write_regs(const struct atmel_qspi *aq,
> +					  const struct spi_mem_op *op,
> +					  const struct atmel_qspi_cfg *cfg)
> +{
> +	/* Clear pending interrupts */
> +	(void)readl_relaxed(aq->regs + QSPI_SR);
> +
> +	/* Set QSPI Instruction Frame registers */
> +	writel_relaxed(cfg->iar, aq->regs + QSPI_IAR);
> +	if (op->data.dir == SPI_MEM_DATA_IN)
> +		writel_relaxed(cfg->icr, aq->regs + QSPI_RICR);
> +	else
> +		writel_relaxed(cfg->icr, aq->regs + QSPI_ICR);

Can you use WICR here (even if ICR == WICR)?

> +	writel_relaxed(cfg->ifr, aq->regs + QSPI_IFR);
> +}

Hm, so the only difference we have is the RICR vs ICR reg and the
APBTFRTYP_READ vs SAMA5D2_WRITE_TRSFR bit. Not sure it deserves
creating 2 hooks for that. Can we have something like ->has_ricr in
the caps and then have an if/else block directly in
atmel_qspi_set_cfg()?
