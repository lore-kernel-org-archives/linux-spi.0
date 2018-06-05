From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Date: Tue, 5 Jun 2018 17:00:23 +0200
Message-ID: <20180605170023.24eeaaaa@bbrezillon>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
        <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at, miquel.raynal@bootlin.com,
        broonie@kernel.org, david.wolfe@nxp.com, fabio.estevam@nxp.com,
        prabhakar.kushwaha@nxp.com, yogeshnarayan.gaur@nxp.com,
        han.xu@nxp.com, linux-kernel@vger.kernel.org
To: Frieder Schrempf <frieder.schrempf@exceet.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 30 May 2018 15:14:32 +0200
Frieder Schrempf <frieder.schrempf@exceet.de> wrote:

> +
> +static void fsl_qspi_read_ahb(struct fsl_qspi *q, const struct spi_mem_op *op)
> +{
> +	static int seq;
> +
> +	/*
> +	 * We want to avoid needing to invalidate the cache by issueing
> +	 * a reset to the AHB and Serial Flash domain, as this needs
> +	 * time. So we change the address on each read to trigger an
> +	 * actual read operation on the flash. The actual address for
> +	 * the flash memory is set by programming the LUT.
> +	 */
> +	memcpy_fromio(op->data.buf.in,
> +		      q->ahb_addr +
> +		      (seq * q->devtype_data->ahb_buf_size),
> +		      op->data.nbytes);
> +
> +	seq = seq ? 0 : 1;

We should get rid of this hack. Yogesh, Han, do you know if there's an
easy way to invalidate the AHB buffer without resetting the IP?

> +}
