From: lei liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [spi:topic/mtk 2/2] drivers/spi/spi-mt65xx.c:362:24: sparse:
 incorrect type in argument 1 (different base types)
Date: Tue, 11 Aug 2015 10:44:55 +0800
Message-ID: <1439261095.21454.6.camel@mhfsdcap03>
References: <201508072245.3TStW9QR%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: <kbuild-all-JC7UmRfGjtg@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201508072245.3TStW9QR%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Mark,

On Fri, 2015-08-07 at 22:33 +0800, kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi topic/mtk
> head:   a568231f463225eb31593f71446a267a03ae0528
> commit: a568231f463225eb31593f71446a267a03ae0528 [2/2] spi: mediatek: Add spi bus for Mediatek MT8173
> reproduce:
>   # apt-get install sparse
>   git checkout a568231f463225eb31593f71446a267a03ae0528
>   make ARCH=x86_64 allmodconfig
>   make C=1 CF=-D__CHECK_ENDIAN__
> 
> 

I use these commands and also find another waring:

../drivers/spi/spi-mt65xx.c:589:25: warning: incorrect type in argument
1 (different address spaces)
../drivers/spi/spi-mt65xx.c:589:25: expected void const *ptr
../drivers/spi/spi-mt65xx.c:589:25: got void [noderef] <asn:2>*base
../drivers/spi/spi-mt65xx.c:590:36: warning: incorrect type in argument
1 (different address spaces)
../drivers/spi/spi-mt65xx.c:590:36: expected void const *ptr
../drivers/spi/spi-mt65xx.c:590:36: got void [noderef] <asn:2>*base

vi drivers/spi/spi-mt65xx.c +589

588         mdata->base = devm_ioremap_resource(&pdev->dev, res);
589         if (IS_ERR(mdata->base)) {
590                 ret = PTR_ERR(mdata->base);
591                 goto err_put_master;
592         }

should I also fix them?

> sparse warnings: (new ones prefixed by >>)
> 
> >> drivers/spi/spi-mt65xx.c:362:24: sparse: incorrect type in argument 1 (different base types)
>    drivers/spi/spi-mt65xx.c:362:24:    expected unsigned int [unsigned] val
>    drivers/spi/spi-mt65xx.c:362:24:    got restricted __le32 [usertype] <noident>
>    drivers/spi/spi-mt65xx.c:364:24: sparse: incorrect type in argument 1 (different base types)
>    drivers/spi/spi-mt65xx.c:364:24:    expected unsigned int [unsigned] val
>    drivers/spi/spi-mt65xx.c:364:24:    got restricted __le32 [usertype] <noident>
> >> drivers/spi/spi-mt65xx.c:734:24: sparse: symbol 'mtk_spi_driver' was not declared. Should it be static?
> 
> Please review and possibly fold the followup patch.
> 
> vim +362 drivers/spi/spi-mt65xx.c
> 
>    346			mult_delta = mtk_spi_get_mult_delta(mdata->tx_sgl_len);
>    347			mdata->xfer_len = mdata->tx_sgl_len - mult_delta;
>    348			mdata->tx_sgl_len = mult_delta;
>    349		} else if (mdata->rx_sgl_len) {
>    350			mult_delta = mtk_spi_get_mult_delta(mdata->rx_sgl_len);
>    351			mdata->xfer_len = mdata->rx_sgl_len - mult_delta;
>    352			mdata->rx_sgl_len = mult_delta;
>    353		}
>    354	}
>    355	
>    356	static void mtk_spi_setup_dma_addr(struct spi_master *master,
>    357					   struct spi_transfer *xfer)
>    358	{
>    359		struct mtk_spi *mdata = spi_master_get_devdata(master);
>    360	
>    361		if (mdata->tx_sgl)
>  > 362			writel(cpu_to_le32(xfer->tx_dma), mdata->base + SPI_TX_SRC_REG);
>    363		if (mdata->rx_sgl)
>    364			writel(cpu_to_le32(xfer->rx_dma), mdata->base + SPI_RX_DST_REG);
>    365	}
>    366	
>    367	static int mtk_spi_fifo_transfer(struct spi_master *master,
>    368					 struct spi_device *spi,
>    369					 struct spi_transfer *xfer)
>    370	{
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
