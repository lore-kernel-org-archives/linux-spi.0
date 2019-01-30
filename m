From: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH 3/9] spi: atmel-quadspi: fix naming scheme
Date: Wed, 30 Jan 2019 18:19:14 +0100
Message-ID: <20190130181904.14094418@bbrezillon>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
        <20190130150818.24902-4-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
To: <Tudor.Ambarus@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130150818.24902-4-tudor.ambarus@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 30 Jan 2019 15:08:33 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Let general names to core drivers.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/spi/atmel-quadspi.c | 52 ++++++++++++++++++++++-----------------------
>  1 file changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index 64475ad16c83..e156c345705b 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -157,14 +157,14 @@ struct atmel_qspi {
>  	struct completion	cmd_completion;
>  };
>  
> -struct qspi_mode {
> +struct atmel_qspi_mode {
>  	u8 cmd_buswidth;
>  	u8 addr_buswidth;
>  	u8 data_buswidth;
>  	u32 config;
>  };
>  
> -static const struct qspi_mode sama5d2_qspi_modes[] = {
> +static const struct atmel_qspi_mode sama5d2_qspi_modes[] = {
>  	{ 1, 1, 1, QSPI_IFR_WIDTH_SINGLE_BIT_SPI },
>  	{ 1, 1, 2, QSPI_IFR_WIDTH_DUAL_OUTPUT },
>  	{ 1, 1, 4, QSPI_IFR_WIDTH_QUAD_OUTPUT },
> @@ -175,18 +175,18 @@ static const struct qspi_mode sama5d2_qspi_modes[] = {
>  };
>  
>  /* Register access functions */
> -static inline u32 qspi_readl(struct atmel_qspi *aq, u32 reg)
> +static inline u32 atmel_qspi_readl(struct atmel_qspi *aq, u32 reg)
>  {
>  	return readl_relaxed(aq->regs + reg);
>  }
>  
> -static inline void qspi_writel(struct atmel_qspi *aq, u32 reg, u32 value)
> +static inline void atmel_qspi_writel(struct atmel_qspi *aq, u32 reg, u32 value)
>  {
>  	writel_relaxed(value, aq->regs + reg);
>  }

Can we get rid of these wrappers? I'm not a big fan of wrappers that
hide the fact that accesses are relaxed.

>  
> -static inline bool is_compatible(const struct spi_mem_op *op,
> -				 const struct qspi_mode *mode)
> +static inline bool atmel_qspi_is_compatible(const struct spi_mem_op *op,
> +					    const struct atmel_qspi_mode *mode)
>  {
>  	if (op->cmd.buswidth != mode->cmd_buswidth)
>  		return false;
> @@ -200,12 +200,12 @@ static inline bool is_compatible(const struct spi_mem_op *op,
>  	return true;
>  }
>  
> -static int find_mode(const struct spi_mem_op *op)
> +static int atmel_qspi_find_mode(const struct spi_mem_op *op)
>  {
>  	u32 i;
>  
>  	for (i = 0; i < ARRAY_SIZE(sama5d2_qspi_modes); i++)
> -		if (is_compatible(op, &sama5d2_qspi_modes[i]))
> +		if (atmel_qspi_is_compatible(op, &sama5d2_qspi_modes[i]))
>  			return i;
>  
>  	return -1;
> @@ -214,7 +214,7 @@ static int find_mode(const struct spi_mem_op *op)
>  static bool atmel_qspi_supports_op(struct spi_mem *mem,
>  				   const struct spi_mem_op *op)
>  {
> -	if (find_mode(op) < 0)
> +	if (atmel_qspi_find_mode(op) < 0)
>  		return false;
>  
>  	/* special case not supported by hardware */
> @@ -237,7 +237,7 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  	icr = QSPI_ICR_INST(op->cmd.opcode);
>  	ifr = QSPI_IFR_INSTEN;
>  
> -	mode = find_mode(op);
> +	mode = atmel_qspi_find_mode(op);
>  	if (mode < 0)
>  		return -ENOTSUPP;
>  
> @@ -293,17 +293,17 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  		ifr |= QSPI_IFR_TFRTYP_TRSFR_WRITE;
>  
>  	/* Clear pending interrupts */
> -	(void)qspi_readl(aq, QSPI_SR);
> +	(void)atmel_qspi_readl(aq, QSPI_SR);
>  
>  	/* Set QSPI Instruction Frame registers */
> -	qspi_writel(aq, QSPI_IAR, iar);
> -	qspi_writel(aq, QSPI_ICR, icr);
> -	qspi_writel(aq, QSPI_IFR, ifr);
> +	atmel_qspi_writel(aq, QSPI_IAR, iar);
> +	atmel_qspi_writel(aq, QSPI_ICR, icr);
> +	atmel_qspi_writel(aq, QSPI_IFR, ifr);
>  
>  	/* Skip to the final steps if there is no data */
>  	if (op->data.nbytes) {
>  		/* Dummy read of QSPI_IFR to synchronize APB and AHB accesses */
> -		(void)qspi_readl(aq, QSPI_IFR);
> +		(void)atmel_qspi_readl(aq, QSPI_IFR);
>  
>  		/* Send/Receive data */
>  		if (op->data.dir == SPI_MEM_DATA_IN)
> @@ -314,22 +314,22 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  				op->data.buf.out, op->data.nbytes);
>  
>  		/* Release the chip-select */
> -		qspi_writel(aq, QSPI_CR, QSPI_CR_LASTXFER);
> +		atmel_qspi_writel(aq, QSPI_CR, QSPI_CR_LASTXFER);
>  	}
>  
>  	/* Poll INSTRuction End status */
> -	sr = qspi_readl(aq, QSPI_SR);
> +	sr = atmel_qspi_readl(aq, QSPI_SR);
>  	if ((sr & QSPI_SR_CMD_COMPLETED) == QSPI_SR_CMD_COMPLETED)
>  		return err;
>  
>  	/* Wait for INSTRuction End interrupt */
>  	reinit_completion(&aq->cmd_completion);
>  	aq->pending = sr & QSPI_SR_CMD_COMPLETED;
> -	qspi_writel(aq, QSPI_IER, QSPI_SR_CMD_COMPLETED);
> +	atmel_qspi_writel(aq, QSPI_IER, QSPI_SR_CMD_COMPLETED);
>  	if (!wait_for_completion_timeout(&aq->cmd_completion,
>  					 msecs_to_jiffies(1000)))
>  		err = -ETIMEDOUT;
> -	qspi_writel(aq, QSPI_IDR, QSPI_SR_CMD_COMPLETED);
> +	atmel_qspi_writel(aq, QSPI_IDR, QSPI_SR_CMD_COMPLETED);
>  
>  	return err;
>  }
> @@ -368,7 +368,7 @@ static int atmel_qspi_setup(struct spi_device *spi)
>  		scbr--;
>  
>  	scr = QSPI_SCR_SCBR(scbr);
> -	qspi_writel(aq, QSPI_SCR, scr);
> +	atmel_qspi_writel(aq, QSPI_SCR, scr);
>  
>  	return 0;
>  }
> @@ -376,13 +376,13 @@ static int atmel_qspi_setup(struct spi_device *spi)
>  static int atmel_qspi_init(struct atmel_qspi *aq)
>  {
>  	/* Reset the QSPI controller */
> -	qspi_writel(aq, QSPI_CR, QSPI_CR_SWRST);
> +	atmel_qspi_writel(aq, QSPI_CR, QSPI_CR_SWRST);
>  
>  	/* Set the QSPI controller in Serial Memory Mode */
> -	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
> +	atmel_qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);
>  
>  	/* Enable the QSPI controller */
> -	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIEN);
> +	atmel_qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIEN);
>  
>  	return 0;
>  }
> @@ -392,8 +392,8 @@ static irqreturn_t atmel_qspi_interrupt(int irq, void *dev_id)
>  	struct atmel_qspi *aq = (struct atmel_qspi *)dev_id;
>  	u32 status, mask, pending;
>  
> -	status = qspi_readl(aq, QSPI_SR);
> -	mask = qspi_readl(aq, QSPI_IMR);
> +	status = atmel_qspi_readl(aq, QSPI_SR);
> +	mask = atmel_qspi_readl(aq, QSPI_IMR);
>  	pending = status & mask;
>  
>  	if (!pending)
> @@ -499,7 +499,7 @@ static int atmel_qspi_remove(struct platform_device *pdev)
>  	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
>  
>  	spi_unregister_controller(ctrl);
> -	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIDIS);
> +	atmel_qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIDIS);
>  	clk_disable_unprepare(aq->clk);
>  	return 0;
>  }
