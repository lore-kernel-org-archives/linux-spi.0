Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119101;
	b=szrKBm+fSUN5/H0R6cdJsL0YUlxhogLYsMkxKBMyp8Mdfgpmb3pYhRe+BvSN3AxCfIH9
	 LgqFMXMdL+v9Z1xpAVARZgM+BKPVscbMdjU0M7Cc/PGjvvT1ygWD+zPakb67B6YqPrZT+
	 XNFjIs+qZkJdauuA+6Tu4BdbFSWxs0Pdxdn7mOU9FV/+SKJwfg3xhP9Pcj3uVAlRTDHZ7
	 5/Le6FOYLblkRPaPBH6AAsxpm8tNy+lEDapxC/qZK9/EDRO7Ow5jXUmDvMJWQBBSIv5lw
	 OvOCWv9+d7qSImyrAS0OTHxGFvyC8GTeH3vDC5I/yR8hePDKCROjGID+63M8ft218NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119101;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=8B2Th1R9Lqn9RKkMsnmyDng7k5mr5JEyT4PL6ub6m0k=;
	b=vLTJIgY65Av7afZHDOMkG9Basn+a22sJ/+Em/jxO3qs8KWptqOoRKW5e32GMe1zXzU/K
	 Fs0gViNqFQ5u3UrjbCB/RiQmh0v8enzUZ/zK0c9OXyxX5cbnxrBa8/ozatMVb1iKhvEpq
	 xPL6/Lxd8wEKRkz+3+W53+Tr7dxe6WXaNtge8ggsRi/SjLL4SSiwew5VTpFXTlzeDW/op
	 ucskcQhv7vm3oxDo6G39v2hqd2rynZyAt1+vcFp6Po/FCnKnrmYx5jUDCefmKw+sogPUz
	 Ef1w1qytP/716VuIPFOhOPTF3pB9WqE8us1b19nUNl0HzNvkhtAs30GhSfRve/ZvmdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V2cHMTPC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE79960A2600;
	Thu, 19 Nov 2026 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V2cHMTPC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46881F000CF;
	Thu, 19 Nov 2026 20:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795119101;
	bh=8B2Th1R9Lqn9RKkMsnmyDng7k5mr5JEyT4PL6ub6m0k=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=V2cHMTPChoAT52knBYXe+EHytjbn7YLQFG/EY8buiTa60qkU+092oEKs6vv9LVKEq
	 a4yNWrA8zlWXUID+xYSD1zxvnlNyiUhXBjB/PBlECWMtVvIasqOZDJVUnJ2iqWVLaO
	 pzOop72mFX/QwxEPzFpVL597KfDI3Xv/Zg1/aa47lnxu+0uwAIRRS+mwkOWIXP+gK0
	 Q23nkplWV634Ysj+sa87gZ1U4RpWeikkeDdbw/PlfdqhCpm2yFqB/SeeXoSraRBPZ3
	 hAhcPoFAJkmvsb1p3y+prpzMvbY22hm4hDCzpAlYkuK6sM/Ticj4d8mZekpAB+1Bvo
	 xNwBntIECX6XA==
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 2/6] spi: dw-g2: Add Synopsys DWC SSI v2.02a driver
From: Mark Brown <broonie@kernel.org>
To: Prakriti Sharma <Prakriti.Sharma@synopsys.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org, 
 Siddhant Kumar <Siddhant.Kumar@synopsys.com>
In-Reply-To: <20261119100513.433044-3-prakriti@synopsys.com>
References: <20261119100513.433044-1-prakriti@synopsys.com>
 <20261119100513.433044-3-prakriti@synopsys.com>
Date: Thu, 19 Nov 2026 20:11:34 +0000
Message-Id: <179511909433.116416.9010484552833951379.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7706; i=broonie@kernel.org;
 h=from:subject:message-id; bh=eAgOHUioN/yeAtismp7cX02GMn69rORdcDrDtQbplVA=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLL+h3/XuvxxY135zbVPN/JxbDiYZfyyPJH56y6pSROEj
 e5qJKSwdZSyMIhxMciKKbLEZXG/rC95vYbv4MI2mDmsTCBDGLg4BWAiG48x/E8U5Lt5b5ap9n31
 TD+LE3+6fjVdEn3mpKi6cbPmPvvtfTcYGa6s7Jp7weLmvt+JZ68tam8O9Lpg85fLqFW45rzhs6M
 GKswA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> Add a driver for the Synopsys DesignWare SSI Gen2 (DWC_ssi v2.02a)
> controller. Support probe, the MMIO glue, command-only transfers, and
> short register operations.
> 
> Transfers are polled. The IRQ is claimed, including the optional
> per-source rxf, txe, txaf, and wsf lines.

> +F:	drivers/spi/spi-dw-g2-*.[ch]

There's drivers/spi/spi-dw-g2.h too.

> +/*
> + * ========================================================================
> + * DebugFS support - exposes controller registers for debugging
> + * ========================================================================
> + */

If you wanrelatively heavyweight stuff like this consider using regmap;
I'd suggest dropping it from the initial submission in any casse.

> +	/*
> +	 * Clamp speed to achievable range. If requested speed is below
> +	 * hardware minimum, clamp to min_speed
> +	 */
> +	if (speed < min_speed) {
> +		dev_warn(&spi->dev, "speed %u Hz below minimum %u Hz, clamping\n",
> +			 speed, min_speed);
> +		speed = min_speed;
> +	}

dev_warn_once(), this might happen a lot.

> +/**
> + * dw_spi_g2_xfer_fifo - Low-level FIFO transfer using polling
> + * @dws: Driver state
> + * @tx_buf: TX buffer (or NULL if no TX)
> + * @tx_len: Number of bytes to transmit
> + * @rx_buf: RX buffer (or NULL if no RX expected)
> + * @rx_len: Number of bytes to receive
> + *
> + * Performs a polled FIFO transfer. Writes tx_len bytes from tx_buf to DR0,
> + * checking SR.TFNF (TX FIFO not full) before each write. For RX, waits for
> + * RXFLR to indicate data availability, then reads rx_len bytes from DR0.
> + *
> + * Return: 0 on success, -ETIMEDOUT on timeout
> + */
> +static int dw_spi_g2_xfer_fifo(struct dw_spi_g2 *dws,
> +			       const u8 *tx_buf, u32 tx_len,
> +			       u8 *rx_buf, u32 rx_len)
> +{
> +	u32 tx_sent = 0;
> +	u32 rx_got = 0;
> +	u32 sr;
> +	unsigned long timeout;
> +
> +	/* TX phase: push bytes checking TFNF */
> +	timeout = jiffies + msecs_to_jiffies(1000);

We usually scale our timeouts based on the length and speed of the
transfer.

> +	while (tx_sent < tx_len) {
> +		sr = dw_spi_g2_readl(dws->regs, DW_SPI_G2_SR);
> +		if (sr & DW_SPI_G2_SR_TFNF) {
> +			dw_spi_g2_writel(dws->regs, DW_SPI_G2_DR0,
> +					 tx_buf[tx_sent]);
> +			tx_sent++;
> +			timeout = jiffies + msecs_to_jiffies(1000);

If this timeout is being applied per word written then a second feels
like an extravagant timeout.

> +	/* RX phase */
> +	timeout = jiffies + msecs_to_jiffies(1000);
> +	while (rx_got < rx_len) {
> +		sr = dw_spi_g2_readl(dws->regs, DW_SPI_G2_SR);
> +		if (sr & DW_SPI_G2_SR_RFNE) {
> +			rx_buf[rx_got++] = dw_spi_g2_readl(dws->regs,
> +							   DW_SPI_G2_DR0) &
> +			    0xff;
> +			timeout = jiffies + msecs_to_jiffies(1000);
> +		} else if (time_after(jiffies, timeout)) {
> +			dev_err(dws->dev,
> +				"xfer_fifo: RX timeout after %u/%u bytes (SR=0x%08x RXFLR=%u)\n",
> +				rx_got, rx_len,
> +				dw_spi_g2_readl(dws->regs, DW_SPI_G2_SR),
> +				dw_spi_g2_readl(dws->regs, DW_SPI_G2_RXFLR));
> +			return -ETIMEDOUT;
> +		}
> +		cpu_relax();
> +	}

This looks like it supports only half duplex transfers, is that a
hardware limitation or a software one?  I'd really expect this to be a
transfer_one() callback.

> +/**
> + * dw_spi_g2_fill_tx_buf - Serialize command/address/data into TX buffer
> + * @buf: Destination buffer
> + * @op: SPI memory operation
> + * @include_data: true to include data bytes, false for command+address only
> + *
> + * Builds a byte stream from a spi_mem_op structure:
> + *   [opcode bytes MSB..LSB] [address bytes MSB..LSB] [data bytes (optional)].
> + *
> + * Return: Total number of bytes written to buf
> + */
> +static u32 dw_spi_g2_fill_tx_buf(u8 *buf, const struct spi_mem_op *op,
> +				 bool include_data)
> +{

This looks like the driver is trying to open code the support for
running unaccelerated ops that spi_mem_exec_op() has?

> +	dev_info(dws->dev, "DW SSI G2 core init\n");

Drop this, it's just noise.

> +/*
> + * ========================================================================
> + * Legacy SPI transfer_one interface (not actively used with spi-mem)
> + * ========================================================================
> + */

It should be, if only so you can avoid the open coding above.

> +int dw_spi_g2_transfer_one(struct spi_controller *ctlr, struct spi_device *spi,
> +			   struct spi_transfer *xfer)
> +{

> +	local_irq_disable();
> +	/* Polling-based full-duplex transfer */
> +	while (dws->tx_len || dws->rx_len) {

This needs a *really* good reason to run with interrupts disabled,
that's very rude to the rest of the system.  Especially to run with
interrupts disabled for the whole length of the transfer.

> +irqreturn_t dw_spi_g2_irq(int irq, void *dev_id)
> +{
> +	struct dw_spi_g2 *dws = dev_id;
> +	u32 isr;
> +
> +	isr = dw_spi_g2_readl(dws->regs, DW_SPI_G2_ISR);
> +	if (!isr)
> +		return IRQ_NONE;
> +
> +	/* Check for error conditions */
> +	if (isr & (DW_SPI_G2_ISR_RXOI | DW_SPI_G2_ISR_RXUI |
> +		   DW_SPI_G2_ISR_TXOI | DW_SPI_G2_ISR_TXUI)) {
> +		dev_warn(dws->dev, "Error interrupt: ISR=0x%x\n", isr);
> +		dws->error = -EIO;
> +	}
> +
> +	/* Clear all interrupts by writing 1s to defined ICR bits */
> +	dw_spi_g2_writel(dws->regs, DW_SPI_G2_ICR, DW_SPI_G2_ICR_ALL);

It would be better to only clear interrupts that the driver handled,
this allows the genirq handling for things like stuck interrupts to do
the right thing.

> +	dws->irq = platform_get_irq_byname_optional(pdev, "rxf");
> +	if (dws->irq < 0)
> +		dws->irq = platform_get_irq(pdev, 0);

The DT binding said that the interrupt line was optional and the driver
is polling based so the software seems to support that but this won't
handle a missing interrupt gracefully.  Either update the binding or the
driver.  TBH I'd make the interrupt mandatory, this seems to be a
relatively high end IP and I'm not sure anyone is going to implement it
without interrupts and I'd imagine at least the spi-mem stuff will work
more efficiently with interrupts.

> +	ret = device_property_read_u32(&pdev->dev, "num-cs", &num_cs);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to read 'num-cs' property: %d\n", ret);
> +		goto err_reset;
> +	}
> +	ctlr->num_chipselect = num_cs;

You should validate num_cs.

> +static void dw_spi_g2_mmio_remove(struct platform_device *pdev)
> +{
> +	struct spi_controller *ctlr = platform_get_drvdata(pdev);
> +	struct dw_spi_g2_mmio *dwsmmio = spi_controller_get_devdata(ctlr);
> +
> +	spi_unregister_controller(ctlr);
> +	dw_spi_g2_deinit(&dwsmmio->dws);
> +	pm_runtime_disable(&pdev->dev);
> +	reset_control_assert(dwsmmio->rstc);
> +}

You're mixing devm and non-devm things here so for example the
controller will be deregistered prior to the interrupt handler which
will go badly if the interrupt fires in the interim.  Also note that the
devdata is allocated along with the controller so when you free the
controller you should no longer dereference dwsmmio.

> +/*
> + * Transfer control: enable CS register block, assert CS line, enable SSI.
> + * Starts the SPI transfer — controller begins clocking data.
> + */
> +static inline void dw_spi_g2_transfer_begin(struct dw_spi_g2 *dws)
> +{
> +	dw_spi_g2_target_enable(dws, dws->cs);
> +	dw_spi_g2_cs_assert(dws, dws->cs);
> +	dw_spi_g2_enable(dws, true);
> +}

The chip select should be controlled at the start/end of a message, not
a transfer (and should just be a set_cs() operation).

-- 
Mark Brown <broonie@kernel.org>
