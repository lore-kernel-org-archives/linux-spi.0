From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH v2] spi: qup: Add DMA capabilities
Date: Tue, 24 Feb 2015 19:11:56 +0200
Message-ID: <1424797916.2340.19.camel@mm-sol.com>
References: <1424782803-13103-1-git-send-email-stanimir.varbanov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kumar Gala <galak@codeaurora.org>,
	Andy Gross <agross@codeaurora.org>,
	Sagar Dharia <sdharia@codeaurora.org>,
	Daniel Sneddon <dsneddon@codeaurora.org>
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1424782803-13103-1-git-send-email-stanimir.varbanov@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


Hi Stan, 

Sorry I didn't saw this first look.

On Tue, 2015-02-24 at 15:00 +0200, Stanimir Varbanov wrote:

<snip>

> 
> +static bool spi_qup_can_dma(struct spi_master *master, struct spi_device *spi,
> +                                                       struct spi_transfer *xfer)
> +{
> +       struct spi_qup *qup = spi_master_get_devdata(master);
> +       size_t dma_align = dma_get_cache_alignment();
> +       int n_words, w_size;
> +
> +       qup->dma_available = 0;
> +
> +       if (xfer->rx_buf && xfer->len % qup->in_blk_sz)
> +               return false;
> +
> +       if (xfer->tx_buf && xfer->len % qup->out_blk_sz)
> +               return false;
> +

Actually we can end up here with tx_buf or rx_buf to be NULL.
Which voids my previous comments about these pointers.

It will be simpler if you just check transfer length.

And better return false if both are NULL.

> +       if (IS_ERR_OR_NULL(master->dma_rx) || IS_ERR_OR_NULL(master->dma_tx))
> +               return false;
> +
> +       if (!IS_ALIGNED((size_t)xfer->tx_buf, dma_align) ||
> +                                       !IS_ALIGNED((size_t)xfer->rx_buf, dma_align))
> +               return false;

Testing NULL for alignment is fine, right?

> +       w_size = spi_qup_get_word_sz(xfer);
> +       n_words = xfer->len / w_size;
> +
> +       /* will use fifo mode */
> +       if (n_words <= (qup->in_fifo_sz / sizeof(u32)))
> +               return false;
> +
> +       qup->dma_available = 1;
> +
> +       return true;
> +}
> +

Regards,
Ivan
