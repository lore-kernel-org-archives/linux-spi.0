From: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH v3 03/13] spi: atmel-quadspi: drop wrappers for iomem
 accesses
Date: Sat, 2 Feb 2019 08:11:11 +0100
Message-ID: <20190202081111.0bbc4443@bbrezillon>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
        <20190202040653.1217-4-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <Cyrille.Pitchen@microchip.com>,
        <bugalski.piotr@gmail.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
To: <Tudor.Ambarus@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190202040653.1217-4-tudor.ambarus@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, 2 Feb 2019 04:07:19 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> The wrappers hid that the accesses are relaxed. Drop them.
> 
> Suggested-by: Boris Brezillon <bbrezillon@kernel.org>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
> v3: no change
> v2: new patch
> 
>  drivers/spi/atmel-quadspi.c | 47 +++++++++++++++++++--------------------------
>  1 file changed, 20 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index feeddcb25e1f..131374db0db4 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -175,17 +175,6 @@ static const struct qspi_mode sama5d2_qspi_modes[] = {
>  	{ 4, 4, 4, QSPI_IFR_WIDTH_QUAD_CMD },
>  };
>  
> -/* Register access functions */
> -static inline u32 qspi_readl(struct atmel_qspi *aq, u32 reg)
> -{
> -	return readl_relaxed(aq->regs + reg);
> -}
> -
> -static inline void qspi_writel(struct atmel_qspi *aq, u32 reg, u32 value)
> -{
> -	writel_relaxed(value, aq->regs + reg);
> -}
> -
>  static inline bool is_compatible(const struct spi_mem_op *op,
>  				 const struct qspi_mode *mode)
>  {
> @@ -229,6 +218,7 @@ static bool atmel_qspi_supports_op(struct spi_mem *mem,
>  static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  {
>  	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->master);
> +	void __iomem *base = aq->regs;

Can we name this variable regs instead of base or even get rid of it
and dereference aq->regs in the xxx_relaxed() calls (doesn't look like
the lines would be over 80 chars even when doing that). With this
addressed, you can add:

Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>

>  	int mode;
>  	u32 dummy_cycles = 0;
>  	u32 iar, icr, ifr, sr;
> @@ -240,7 +230,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  
>  	/* Set the QSPI controller in Serial Memory Mode */
>  	if (aq->smm != QSPI_MR_SMM) {
> -		qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
> +		writel_relaxed(QSPI_MR_SMM, base + QSPI_MR);
>  		aq->smm = QSPI_MR_SMM;
>  	}
>  
> @@ -300,17 +290,17 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  		ifr |= QSPI_IFR_TFRTYP_TRSFR_WRITE;
>  
>  	/* Clear pending interrupts */
> -	(void)qspi_readl(aq, QSPI_SR);
> +	(void)readl_relaxed(base + QSPI_SR);
>  
>  	/* Set QSPI Instruction Frame registers */
> -	qspi_writel(aq, QSPI_IAR, iar);
> -	qspi_writel(aq, QSPI_ICR, icr);
> -	qspi_writel(aq, QSPI_IFR, ifr);
> +	writel_relaxed(iar, base + QSPI_IAR);
> +	writel_relaxed(icr, base + QSPI_ICR);
> +	writel_relaxed(ifr, base + QSPI_IFR);
>  
>  	/* Skip to the final steps if there is no data */
>  	if (op->data.nbytes) {
>  		/* Dummy read of QSPI_IFR to synchronize APB and AHB accesses */
> -		(void)qspi_readl(aq, QSPI_IFR);
> +		(void)readl_relaxed(base + QSPI_IFR);
>  
>  		/* Send/Receive data */
>  		if (op->data.dir == SPI_MEM_DATA_IN)
> @@ -321,22 +311,22 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  				op->data.buf.out, op->data.nbytes);
>  
>  		/* Release the chip-select */
> -		qspi_writel(aq, QSPI_CR, QSPI_CR_LASTXFER);
> +		writel_relaxed(QSPI_CR_LASTXFER, base + QSPI_CR);
>  	}
>  
>  	/* Poll INSTRuction End status */
> -	sr = qspi_readl(aq, QSPI_SR);
> +	sr = readl_relaxed(base + QSPI_SR);
>  	if ((sr & QSPI_SR_CMD_COMPLETED) == QSPI_SR_CMD_COMPLETED)
>  		return err;
>  
>  	/* Wait for INSTRuction End interrupt */
>  	reinit_completion(&aq->cmd_completion);
>  	aq->pending = sr & QSPI_SR_CMD_COMPLETED;
> -	qspi_writel(aq, QSPI_IER, QSPI_SR_CMD_COMPLETED);
> +	writel_relaxed(QSPI_SR_CMD_COMPLETED, base + QSPI_IER);
>  	if (!wait_for_completion_timeout(&aq->cmd_completion,
>  					 msecs_to_jiffies(1000)))
>  		err = -ETIMEDOUT;
> -	qspi_writel(aq, QSPI_IDR, QSPI_SR_CMD_COMPLETED);
> +	writel_relaxed(QSPI_SR_CMD_COMPLETED, base + QSPI_IDR);
>  
>  	return err;
>  }
> @@ -375,18 +365,20 @@ static int atmel_qspi_setup(struct spi_device *spi)
>  		scbr--;
>  
>  	scr = QSPI_SCR_SCBR(scbr);
> -	qspi_writel(aq, QSPI_SCR, scr);
> +	writel_relaxed(scr, aq->regs + QSPI_SCR);
>  
>  	return 0;
>  }
>  
>  static int atmel_qspi_init(struct atmel_qspi *aq)
>  {
> +	void __iomem *base = aq->regs;
> +
>  	/* Reset the QSPI controller */
> -	qspi_writel(aq, QSPI_CR, QSPI_CR_SWRST);
> +	writel_relaxed(QSPI_CR_SWRST, base + QSPI_CR);
>  
>  	/* Enable the QSPI controller */
> -	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIEN);
> +	writel_relaxed(QSPI_CR_QSPIEN, base + QSPI_CR);
>  
>  	return 0;
>  }
> @@ -394,10 +386,11 @@ static int atmel_qspi_init(struct atmel_qspi *aq)
>  static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
>  {
>  	struct atmel_qspi *aq = (struct atmel_qspi *)dev_id;
> +	void __iomem *base = aq->regs;
>  	u32 status, mask, pending;
>  
> -	status = qspi_readl(aq, QSPI_SR);
> -	mask = qspi_readl(aq, QSPI_IMR);
> +	status = readl_relaxed(base + QSPI_SR);
> +	mask = readl_relaxed(base + QSPI_IMR);
>  	pending = status & mask;
>  
>  	if (!pending)
> @@ -503,7 +496,7 @@ static int atmel_qspi_remove(struct platform_device *pdev)
>  	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
>  
>  	spi_unregister_controller(ctrl);
> -	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIDIS);
> +	writel_relaxed(QSPI_CR_QSPIDIS, aq->regs + QSPI_CR);
>  	clk_disable_unprepare(aq->clk);
>  	return 0;
>  }
