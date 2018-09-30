From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v2 1/4] spi: spi-mem: Add the spi_set_xfer_bpw function
Date: Sun, 30 Sep 2018 12:04:25 +0200
Message-ID: <20180930120425.7715cb29@bbrezillon>
References: <20180930092535.24544-1-chuanhua.han@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, eha@deif.com
To: Chuanhua Han <chuanhua.han@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180930092535.24544-1-chuanhua.han@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Chuanhua,

On Sun, 30 Sep 2018 17:25:32 +0800
Chuanhua Han <chuanhua.han@nxp.com> wrote:

> Before we add this spi_transfer to the spi_message chain table, we need
> bits_per_word_mask based on spi_control to set the bits_per_word of
> this spi_transfer.

Let's make it clearer: this is wrong. The spi-mem protocol is just
using bytes, not custom size words. Fix the fsl-dspi driver if needed,
but don't try to adjust xfer->bits_per_word in spi-mem.c, because this
is inappropriate.

Regards,

Boris

> 
> Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
> ---
> Changes in v2:
>  -The original patch is divided into multiple patches(the original
> patch theme is "spi: spi-fsl-dspi: Fix support for XSPI transport
> mode"),one of which is segmented.
> 
>  drivers/spi/spi-mem.c | 39 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
> index eb72dba71d83..717e711c0952 100644
> --- a/drivers/spi/spi-mem.c
> +++ b/drivers/spi/spi-mem.c
> @@ -175,6 +175,41 @@ bool spi_mem_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  }
>  EXPORT_SYMBOL_GPL(spi_mem_supports_op);
>  
> +/**
> + * spi_set_xfer_bpw() - Set the bits_per_word for each transfer based on
> + *			the bits_per_word_mask of the spi controller
> + * @ctrl: the spi controller
> + * @xfer: the spi transfer
> + *
> + * This function sets the bits_per_word for each transfer based on the spi
> + * controller's bits_per_word_mask to improve the efficiency of spi transport.
> + *
> + * Return: 0 in case of success, a negative error code otherwise.
> + */
> +int spi_set_xfer_bpw(struct spi_controller *ctlr, struct spi_transfer *xfer)
> +{
> +	if (!ctlr || !xfer) {
> +		dev_err(&ctlr->dev,
> +			"Fail to set bits_per_word for spi transfer\n");
> +		return -EINVAL;
> +	}
> +
> +	if (ctlr->bits_per_word_mask) {
> +		if (!(xfer->len % 4)) {
> +			if (ctlr->bits_per_word_mask & SPI_BPW_MASK(32))
> +				xfer->bits_per_word = 32;
> +		} else if (!(xfer->len % 2)) {
> +			if (ctlr->bits_per_word_mask & SPI_BPW_MASK(16))
> +				xfer->bits_per_word = 16;
> +		} else {
> +			xfer->bits_per_word = 8;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(spi_set_xfer_bpw);
> +
>  /**
>   * spi_mem_exec_op() - Execute a memory operation
>   * @mem: the SPI memory
> @@ -252,6 +287,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  	xfers[xferpos].tx_buf = tmpbuf;
>  	xfers[xferpos].len = sizeof(op->cmd.opcode);
>  	xfers[xferpos].tx_nbits = op->cmd.buswidth;
> +	spi_set_xfer_bpw(ctlr, &xfers[xferpos]);
>  	spi_message_add_tail(&xfers[xferpos], &msg);
>  	xferpos++;
>  	totalxferlen++;
> @@ -266,6 +302,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  		xfers[xferpos].tx_buf = tmpbuf + 1;
>  		xfers[xferpos].len = op->addr.nbytes;
>  		xfers[xferpos].tx_nbits = op->addr.buswidth;
> +		spi_set_xfer_bpw(ctlr, &xfers[xferpos]);
>  		spi_message_add_tail(&xfers[xferpos], &msg);
>  		xferpos++;
>  		totalxferlen += op->addr.nbytes;
> @@ -276,6 +313,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  		xfers[xferpos].tx_buf = tmpbuf + op->addr.nbytes + 1;
>  		xfers[xferpos].len = op->dummy.nbytes;
>  		xfers[xferpos].tx_nbits = op->dummy.buswidth;
> +		spi_set_xfer_bpw(ctlr, &xfers[xferpos]);
>  		spi_message_add_tail(&xfers[xferpos], &msg);
>  		xferpos++;
>  		totalxferlen += op->dummy.nbytes;
> @@ -291,6 +329,7 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  		}
>  
>  		xfers[xferpos].len = op->data.nbytes;
> +		spi_set_xfer_bpw(ctlr, &xfers[xferpos]);
>  		spi_message_add_tail(&xfers[xferpos], &msg);
>  		xferpos++;
>  		totalxferlen += op->data.nbytes;
