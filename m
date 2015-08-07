From: kbuild test robot <fengguang.wu@intel.com>
Subject: [spi:topic/mtk 2/2] drivers/spi/spi-mt65xx.c:362:24: sparse:
 incorrect type in argument 1 (different base types)
Date: Fri, 7 Aug 2015 22:33:11 +0800
Message-ID: <201508072245.3TStW9QR%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kbuild-all@01.org, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Leilk Liu <leilk.liu@mediatek.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi topic/mtk
head:   a568231f463225eb31593f71446a267a03ae0528
commit: a568231f463225eb31593f71446a267a03ae0528 [2/2] spi: mediatek: Add spi bus for Mediatek MT8173
reproduce:
  # apt-get install sparse
  git checkout a568231f463225eb31593f71446a267a03ae0528
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/spi/spi-mt65xx.c:362:24: sparse: incorrect type in argument 1 (different base types)
   drivers/spi/spi-mt65xx.c:362:24:    expected unsigned int [unsigned] val
   drivers/spi/spi-mt65xx.c:362:24:    got restricted __le32 [usertype] <noident>
   drivers/spi/spi-mt65xx.c:364:24: sparse: incorrect type in argument 1 (different base types)
   drivers/spi/spi-mt65xx.c:364:24:    expected unsigned int [unsigned] val
   drivers/spi/spi-mt65xx.c:364:24:    got restricted __le32 [usertype] <noident>
>> drivers/spi/spi-mt65xx.c:734:24: sparse: symbol 'mtk_spi_driver' was not declared. Should it be static?

Please review and possibly fold the followup patch.

vim +362 drivers/spi/spi-mt65xx.c

   346			mult_delta = mtk_spi_get_mult_delta(mdata->tx_sgl_len);
   347			mdata->xfer_len = mdata->tx_sgl_len - mult_delta;
   348			mdata->tx_sgl_len = mult_delta;
   349		} else if (mdata->rx_sgl_len) {
   350			mult_delta = mtk_spi_get_mult_delta(mdata->rx_sgl_len);
   351			mdata->xfer_len = mdata->rx_sgl_len - mult_delta;
   352			mdata->rx_sgl_len = mult_delta;
   353		}
   354	}
   355	
   356	static void mtk_spi_setup_dma_addr(struct spi_master *master,
   357					   struct spi_transfer *xfer)
   358	{
   359		struct mtk_spi *mdata = spi_master_get_devdata(master);
   360	
   361		if (mdata->tx_sgl)
 > 362			writel(cpu_to_le32(xfer->tx_dma), mdata->base + SPI_TX_SRC_REG);
   363		if (mdata->rx_sgl)
   364			writel(cpu_to_le32(xfer->rx_dma), mdata->base + SPI_RX_DST_REG);
   365	}
   366	
   367	static int mtk_spi_fifo_transfer(struct spi_master *master,
   368					 struct spi_device *spi,
   369					 struct spi_transfer *xfer)
   370	{

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
