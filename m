From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 1/2] spi: Add MXIC controller driver
Date: Fri, 28 Sep 2018 10:29:35 +0200
Message-ID: <20180928102935.4c3811b4@bbrezillon>
References: <1537168579-31593-1-git-send-email-masonccyang@mxic.com.tw>
        <1537168579-31593-2-git-send-email-masonccyang@mxic.com.tw>
        <20180917140922.3132ab99@bbrezillon>
        <OF74F67ECA.BEFB2D2A-ON48258316.002C2CD6-48258316.002DE896@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: broonie@kernel.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        tpiepho@impinj.com, zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OF74F67ECA.BEFB2D2A-ON48258316.002C2CD6-48258316.002DE896@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mason,

On Fri, 28 Sep 2018 16:21:27 +0800
masonccyang@mxic.com.tw wrote:

> > > +static int mxic_spi_mem_exec_op(struct spi_mem *mem,
> > > +            const struct spi_mem_op *op)
> > > +{
> > > +   struct mxic_spi *mxic = spi_master_get_devdata(mem->spi->master);
> > > +   int nio = 1, i, ret;
> > > +   u32 ss_ctrl;
> > > +   u8 addr[8];
> > > +
> > > +   ret = mxic_spi_clk_setup(mem->spi);
> > > +   if (ret)
> > > +      return ret;  
> > 
> > Hm, can we change the rate when the clk/PLL is enabled? If not then
> > you'll have to first call pm_runtime_get_sync() to start from a know
> > state, then inside mxic_spi_clk_setup(), call mxic_spi_clk_disable(),
> > change the rate and call mxic_spi_clk_enable().
> >   
> 
> I have removed this clk_setup() in patch v3, 
> I think spi clock frequence changed should be modified from User space
> by something like sys-fs, right ?

No, it shouldn't. It should be changed when the driver detects it needs
to be changed (access to a different spi device using a different freq).
My point was: make sure the clk is disable when you change the rate.


> 
> 
> > > +
> > > +static int mxic_spi_probe(struct platform_device *pdev)
> > > +{
> > > +   ret = clk_prepare_enable(mxic->ps_clk);
> > > +   if (ret)
> > > +      return ret;
> > > +
> > > +   pm_runtime_use_autosuspend(&pdev->dev);
> > > +   pm_runtime_set_autosuspend_delay(&pdev->dev,   
> SPI_AUTOSUSPEND_TIMEOUT);
> > > +   pm_runtime_set_active(&pdev->dev);
> > > +   pm_runtime_enable(&pdev->dev);
> > > +   master->auto_runtime_pm = true;
> > > +
> > > +   master->num_chipselect = 1;
> > > +   master->setup = mxic_spi_setup;
> > > +   master->mem_ops = &mxic_spi_mem_ops;
> > > +
> > > +   master->set_cs = mxic_spi_set_cs;
> > > +   master->transfer_one = mxic_spi_transfer_one;
> > > +   master->bits_per_word_mask = SPI_BPW_MASK(8);
> > > +   master->mode_bits = SPI_CPOL | SPI_CPHA |
> > > +         SPI_RX_DUAL | SPI_TX_DUAL |
> > > +         SPI_RX_QUAD | SPI_TX_QUAD;
> > > +
> > > +   mxic_spi_hw_init(mxic);
> > > +
> > > +   pm_runtime_mark_last_busy(&pdev->dev);
> > > +   pm_runtime_put_autosuspend(&pdev->dev);  
> > 
> > Okay, I'll let others review the runtime PM init/cleanup bits, because
> > I'm not an expert, but I don't remember seeing this
> > pm_runtime_set_active()+pm_runtime_mark_last_busy()
> > +pm_runtime_put_autosuspend()
> > dance in the drivers I worked on. Most probably because they were not
> > using autosuspend.
> > 
> > [1]https://elixir.bootlin.com/linux/v4.19-rc4/source/drivers/spi/
> > spi-mem.c#L210
> > [2]  
> https://elixir.bootlin.com/linux/v4.19-rc4/source/drivers/spi/spi.c#L1214
> 
> In patch v2, the spi-mxic controller will auto enter suspend mode after 2 
> sec,
> and resume again if spi device read/write is needed.
> 
> In patch v3, removed it due to run time PM functions are enabled by the 
> core [1][2].

Okay. It seems you didn't patch spi-mem.c to call
pm_runtime_put_autosuspend() instead of pm_runtime_put(). Do you plan
to send a patch for that?

Regards,

Boris
