From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] spi: spi-geni-qcom: Speculative fix of "nobody cared"
 about interrupt
Date: Mon, 23 Mar 2020 14:08:21 +0300
Message-ID: <20200323110756.GD26299@kadam>
References: <20200317133653.v2.1.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kbuild-all-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Alok Chauhan <alokc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, skakit-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
        Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        Andy Gross <agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
        Girish Mahadevan <girishm-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
        Stephen Boyd <swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kbuild-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200317133653.v2.1.I752ebdcfd5e8bf0de06d66e767b8974932b3620e@changeid>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Douglas,

url:    https://github.com/0day-ci/linux/commits/Douglas-Anderson/spi-spi-geni-qcom-Speculative-fix-of-nobody-cared-about-interrupt/20200318-043933
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Reported-by: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>

smatch warnings:
drivers/spi/spi-geni-qcom.c:385 setup_fifo_xfer() warn: inconsistent returns 'irq'.
drivers/spi/spi-geni-qcom.c:385 setup_fifo_xfer() warn: inconsistent returns 'mas->lock'.

# https://github.com/0day-ci/linux/commit/365ef891fdac5e58b1f621b0b0d57608ffafeb2b
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 365ef891fdac5e58b1f621b0b0d57608ffafeb2b
vim +/irq +385 drivers/spi/spi-geni-qcom.c

561de45f72bd5f Girish Mahadevan 2018-10-03  305  static void setup_fifo_xfer(struct spi_transfer *xfer,
561de45f72bd5f Girish Mahadevan 2018-10-03  306  				struct spi_geni_master *mas,
561de45f72bd5f Girish Mahadevan 2018-10-03  307  				u16 mode, struct spi_master *spi)
561de45f72bd5f Girish Mahadevan 2018-10-03  308  {
561de45f72bd5f Girish Mahadevan 2018-10-03  309  	u32 m_cmd = 0;
561de45f72bd5f Girish Mahadevan 2018-10-03  310  	u32 spi_tx_cfg, len;
561de45f72bd5f Girish Mahadevan 2018-10-03  311  	struct geni_se *se = &mas->se;
561de45f72bd5f Girish Mahadevan 2018-10-03  312  
365ef891fdac5e Douglas Anderson 2020-03-17  313  	spin_lock_irq(&mas->lock);
365ef891fdac5e Douglas Anderson 2020-03-17  314  
561de45f72bd5f Girish Mahadevan 2018-10-03  315  	spi_tx_cfg = readl(se->base + SE_SPI_TRANS_CFG);
561de45f72bd5f Girish Mahadevan 2018-10-03  316  	if (xfer->bits_per_word != mas->cur_bits_per_word) {
561de45f72bd5f Girish Mahadevan 2018-10-03  317  		spi_setup_word_len(mas, mode, xfer->bits_per_word);
561de45f72bd5f Girish Mahadevan 2018-10-03  318  		mas->cur_bits_per_word = xfer->bits_per_word;
561de45f72bd5f Girish Mahadevan 2018-10-03  319  	}
561de45f72bd5f Girish Mahadevan 2018-10-03  320  
561de45f72bd5f Girish Mahadevan 2018-10-03  321  	/* Speed and bits per word can be overridden per transfer */
561de45f72bd5f Girish Mahadevan 2018-10-03  322  	if (xfer->speed_hz != mas->cur_speed_hz) {
561de45f72bd5f Girish Mahadevan 2018-10-03  323  		int ret;
561de45f72bd5f Girish Mahadevan 2018-10-03  324  		u32 clk_sel, m_clk_cfg;
561de45f72bd5f Girish Mahadevan 2018-10-03  325  		unsigned int idx, div;
561de45f72bd5f Girish Mahadevan 2018-10-03  326  
561de45f72bd5f Girish Mahadevan 2018-10-03  327  		ret = get_spi_clk_cfg(xfer->speed_hz, mas, &idx, &div);
561de45f72bd5f Girish Mahadevan 2018-10-03  328  		if (ret) {
561de45f72bd5f Girish Mahadevan 2018-10-03  329  			dev_err(mas->dev, "Err setting clks:%d\n", ret);
561de45f72bd5f Girish Mahadevan 2018-10-03  330  			return;

Needs to drop the lock before returning.

561de45f72bd5f Girish Mahadevan 2018-10-03  331  		}
561de45f72bd5f Girish Mahadevan 2018-10-03  332  		/*
561de45f72bd5f Girish Mahadevan 2018-10-03  333  		 * SPI core clock gets configured with the requested frequency
561de45f72bd5f Girish Mahadevan 2018-10-03  334  		 * or the frequency closer to the requested frequency.
561de45f72bd5f Girish Mahadevan 2018-10-03  335  		 * For that reason requested frequency is stored in the
561de45f72bd5f Girish Mahadevan 2018-10-03  336  		 * cur_speed_hz and referred in the consecutive transfer instead
561de45f72bd5f Girish Mahadevan 2018-10-03  337  		 * of calling clk_get_rate() API.
561de45f72bd5f Girish Mahadevan 2018-10-03  338  		 */
561de45f72bd5f Girish Mahadevan 2018-10-03  339  		mas->cur_speed_hz = xfer->speed_hz;
561de45f72bd5f Girish Mahadevan 2018-10-03  340  		clk_sel = idx & CLK_SEL_MSK;
561de45f72bd5f Girish Mahadevan 2018-10-03  341  		m_clk_cfg = (div << CLK_DIV_SHFT) | SER_CLK_EN;
561de45f72bd5f Girish Mahadevan 2018-10-03  342  		writel(clk_sel, se->base + SE_GENI_CLK_SEL);
561de45f72bd5f Girish Mahadevan 2018-10-03  343  		writel(m_clk_cfg, se->base + GENI_SER_M_CLK_CFG);
561de45f72bd5f Girish Mahadevan 2018-10-03  344  	}
561de45f72bd5f Girish Mahadevan 2018-10-03  345  
561de45f72bd5f Girish Mahadevan 2018-10-03  346  	mas->tx_rem_bytes = 0;
561de45f72bd5f Girish Mahadevan 2018-10-03  347  	mas->rx_rem_bytes = 0;
561de45f72bd5f Girish Mahadevan 2018-10-03  348  	if (xfer->tx_buf && xfer->rx_buf)
561de45f72bd5f Girish Mahadevan 2018-10-03  349  		m_cmd = SPI_FULL_DUPLEX;
561de45f72bd5f Girish Mahadevan 2018-10-03  350  	else if (xfer->tx_buf)
561de45f72bd5f Girish Mahadevan 2018-10-03  351  		m_cmd = SPI_TX_ONLY;
561de45f72bd5f Girish Mahadevan 2018-10-03  352  	else if (xfer->rx_buf)
561de45f72bd5f Girish Mahadevan 2018-10-03  353  		m_cmd = SPI_RX_ONLY;
561de45f72bd5f Girish Mahadevan 2018-10-03  354  
561de45f72bd5f Girish Mahadevan 2018-10-03  355  	spi_tx_cfg &= ~CS_TOGGLE;
561de45f72bd5f Girish Mahadevan 2018-10-03  356  
561de45f72bd5f Girish Mahadevan 2018-10-03  357  	if (!(mas->cur_bits_per_word % MIN_WORD_LEN))
561de45f72bd5f Girish Mahadevan 2018-10-03  358  		len = xfer->len * BITS_PER_BYTE / mas->cur_bits_per_word;
561de45f72bd5f Girish Mahadevan 2018-10-03  359  	else
561de45f72bd5f Girish Mahadevan 2018-10-03  360  		len = xfer->len / (mas->cur_bits_per_word / BITS_PER_BYTE + 1);
561de45f72bd5f Girish Mahadevan 2018-10-03  361  	len &= TRANS_LEN_MSK;
561de45f72bd5f Girish Mahadevan 2018-10-03  362  
561de45f72bd5f Girish Mahadevan 2018-10-03  363  	mas->cur_xfer = xfer;
561de45f72bd5f Girish Mahadevan 2018-10-03  364  	if (m_cmd & SPI_TX_ONLY) {
561de45f72bd5f Girish Mahadevan 2018-10-03  365  		mas->tx_rem_bytes = xfer->len;
561de45f72bd5f Girish Mahadevan 2018-10-03  366  		writel(len, se->base + SE_SPI_TX_TRANS_LEN);
561de45f72bd5f Girish Mahadevan 2018-10-03  367  	}
561de45f72bd5f Girish Mahadevan 2018-10-03  368  
561de45f72bd5f Girish Mahadevan 2018-10-03  369  	if (m_cmd & SPI_RX_ONLY) {
561de45f72bd5f Girish Mahadevan 2018-10-03  370  		writel(len, se->base + SE_SPI_RX_TRANS_LEN);
561de45f72bd5f Girish Mahadevan 2018-10-03  371  		mas->rx_rem_bytes = xfer->len;
561de45f72bd5f Girish Mahadevan 2018-10-03  372  	}
561de45f72bd5f Girish Mahadevan 2018-10-03  373  	writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
561de45f72bd5f Girish Mahadevan 2018-10-03  374  	mas->cur_mcmd = CMD_XFER;
561de45f72bd5f Girish Mahadevan 2018-10-03  375  	geni_se_setup_m_cmd(se, m_cmd, FRAGMENTATION);
561de45f72bd5f Girish Mahadevan 2018-10-03  376  
561de45f72bd5f Girish Mahadevan 2018-10-03  377  	/*
561de45f72bd5f Girish Mahadevan 2018-10-03  378  	 * TX_WATERMARK_REG should be set after SPI configuration and
561de45f72bd5f Girish Mahadevan 2018-10-03  379  	 * setting up GENI SE engine, as driver starts data transfer
561de45f72bd5f Girish Mahadevan 2018-10-03  380  	 * for the watermark interrupt.
561de45f72bd5f Girish Mahadevan 2018-10-03  381  	 */
561de45f72bd5f Girish Mahadevan 2018-10-03  382  	if (m_cmd & SPI_TX_ONLY)
561de45f72bd5f Girish Mahadevan 2018-10-03  383  		writel(mas->tx_wm, se->base + SE_GENI_TX_WATERMARK_REG);
365ef891fdac5e Douglas Anderson 2020-03-17  384  
365ef891fdac5e Douglas Anderson 2020-03-17 @385  	spin_unlock_irq(&mas->lock);
561de45f72bd5f Girish Mahadevan 2018-10-03  386  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
