From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 2/2] spi: Introduce new driver for Qualcomm QuadSPI
 controller
Date: Tue, 10 Jul 2018 23:19:45 +0200
Message-ID: <20180710231945.4672a18c@bbrezillon>
References: <1530827202-9997-1-git-send-email-girishm@codeaurora.org>
        <1530827202-9997-2-git-send-email-girishm@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        sdharia@codeaurora.org, kramasub@codeaurora.org
To: Girish Mahadevan <girishm@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530827202-9997-2-git-send-email-girishm@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Girish,

On Thu,  5 Jul 2018 15:46:42 -0600
Girish Mahadevan <girishm@codeaurora.org> wrote:

> +
> +static int process_data(const struct spi_mem_op *op, struct qcom_qspi *ctrl)
> +{
> +	int ret;
> +
> +	ctrl->xfer.dir = (op->data.dir == SPI_MEM_DATA_IN) ?
> +					QSPI_READ : QSPI_WRITE;
> +	ctrl->xfer.mode = op->data.buswidth;
> +	ctrl->xfer.is_last = true;
> +	ctrl->xfer.rem_bytes = op->data.nbytes;
> +
> +	if (ctrl->xfer.dir == QSPI_WRITE)
> +		ctrl->xfer.tx_buf = op->data.buf.out;
> +	else
> +		ctrl->xfer.rx_buf = op->data.buf.in;
> +	ret = qcom_qspi_pio_xfer(ctrl);
> +	if (ret)
> +		return ret;

Looks like you are converting the spi_mem_op into several regular SPI
transfers. Any good reasons for not relying on the core logic to do
that? In this case, all you'd have to do is implement ->transfer_one()
and be done with it. 

> +	ret = wait_for_xfer(ctrl);
> +	return ret;
> +}
 
Regards,

Boris
