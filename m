From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH 1/2] spi: Add Renesas R-Car RPC SPI controller driver
Date: Tue, 20 Nov 2018 14:09:05 +0100
Message-ID: <6b024f18-d0bc-3e65-f07c-cef913f795ab@gmail.com>
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw>
 <1542621690-10229-2-git-send-email-masonccyang@mxic.com.tw>
 <0223f43b-c6a6-eade-49af-4e7b7ef7f022@gmail.com>
 <OF4FAD10C5.F4F6D29B-ON4825834B.001FAB40-4825834B.00289635@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: boris.brezillon@bootlin.com, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, tpiepho@impinj.com,
        zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OF4FAD10C5.F4F6D29B-ON4825834B.001FAB40-4825834B.00289635@mxic.com.tw>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 11/20/2018 08:23 AM, masonccyang@mxic.com.tw wrote:
> Hi Marek,

Hi,

>> Marek Vasut <marek.vasut@gmail.com>
>> 2018/11/19 下午 10:12
>>
>> To
>>
>> > +
>> > +static int rpc_spi_set_freq(struct rpc_spi *rpc, unsigned long freq)
>> > +{
>> > +   int ret;
>> > +
>> > +   if (rpc->cur_speed_hz == freq)
>> > +      return 0;
>> > +
>> > +   clk_disable_unprepare(rpc->clk_rpc);
>> > +   ret = clk_set_rate(rpc->clk_rpc, freq);
>> > +   if (ret)
>> > +      return ret;
>> > +
>> > +   ret = clk_prepare_enable(rpc->clk_rpc);
>> > +   if (ret)
>> > +      return ret;
>>
>> Is this clock disable/update/enable really needed ? I'd think that
>> clk_set_rate() would handle the rate update correctly.
> 
> This is for run time PM mechanism in spi-mem layer and __spi_sync(),
> you may refer to another patch [1].
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?h=for-4.21&id=b942d80b0a394e8ea18fce3b032b4700439e8ca3

I think Geert commented on the clock topic, so let's move it there.
Disabling and enabling clock to change their rate looks real odd to me.

>> > +   rpc->cur_speed_hz = freq;
>> > +   return ret;
>> > +}
>> > +
>> > +static void rpc_spi_hw_init(struct rpc_spi *rpc)
>> > +{
>> > +   /*
>> > +    * NOTE: The 0x260 are undocumented bits, but they must be set.
>> > +    */
>>
>> FYI:
>>
> http://git.denx.de/?p=u-boot.git;a=blob;f=drivers/spi/renesas_rpc_spi.c#l207
>>
>> I think the STRTIM should be 6 .
>>
> 
> In my D3 Draak board, the STRTIM is 0x3 for on board qspi flash and
> mx25uw51245g.
> And this is also refer to Renesas R-Car Gen3 bare-metal code,
> mini-monitor v4.01.

The copy of minimon I have says 6 , but maybe this is flash specific ?

[...]

>> > +         writel(rpc->cmd, rpc->regs + RPC_SMCMR);
>> > +         writel(rpc->dummy, rpc->regs + RPC_SMDMCR);
>> > +         writel(rpc->addr + pos, rpc->regs + RPC_SMADR);
>> > +         writel(rpc->smenr, rpc->regs + RPC_SMENR);
>> > +         writel(rpc->smcr | RPC_SMCR_SPIE, rpc->regs + RPC_SMCR);
>> > +         ret = wait_msg_xfer_end(rpc);
>> > +         if (ret)
>> > +            goto out;
>> > +
>> > +         data = readl(rpc->regs + RPC_SMRDR0);
>> > +         memcpy_fromio(rx_buf + pos, (void *)&data, nbytes);
>> > +         pos += nbytes;
>> > +      }
>> > +   } else {
>> > +      writel(rpc->cmd, rpc->regs + RPC_SMCMR);
>> > +      writel(rpc->dummy, rpc->regs + RPC_SMDMCR);
>> > +      writel(rpc->addr + pos, rpc->regs + RPC_SMADR);
>> > +      writel(rpc->smenr, rpc->regs + RPC_SMENR);
>> > +      writel(rpc->smcr | RPC_SMCR_SPIE, rpc->regs + RPC_SMCR);
>> > +      ret = wait_msg_xfer_end(rpc);
>> > +   }
>> > +out:
>>
>> Dont you need to stop the RPC somehow in case the transmission fails ?
> 
> It seems there is no any RPC registers bit to monitor xfer fail !

What happens if wait_msg_xfer_end() returns non-zero ? I guess that
means the transfer timed out ?

[...]

>> > +static const struct of_device_id rpc_spi_of_ids[] = {
>> > +   { .compatible = "renesas,rpc-r8a77995", },
>> > +   { /* sentinel */ }
>> > +};
>> > +MODULE_DEVICE_TABLE(of, rpc_spi_of_ids);
>> > +
>> > +static struct platform_driver rpc_spi_driver = {
>> > +   .probe = rpc_spi_probe,
>> > +   .remove = rpc_spi_remove,
>> > +   .driver = {
>> > +      .name = "rpc-spi",
>> > +      .of_match_table = rpc_spi_of_ids,
>> > +      .pm = &rpc_spi_dev_pm_ops,
>> > +   },
>> > +};
>> > +module_platform_driver(rpc_spi_driver);
>> > +
>> > +MODULE_AUTHOR("Mason Yang <masonccyang@mxic.com.tw>");
>> > +MODULE_DESCRIPTION("Renesas R-Car D3 RPC SPI controller driver");
>>
>> This is not D3 specific and not SPI-only controller btw.
> 
> In R-Car Gen3, there are some registers(i.e,. RPC_PHYCNT) in different
> setting
> for R-Car H3, M3-W, V3M, V3H, D3, M3-N and E3 model.
> 
> I test this patch is based on D3 Draak board, it works fine but I am not
> sure
> if these registers setting is ok for others R-Card model.
> 
> I think this could be a reference when patch others Gen3 model is needed.
You can take a look into the U-Boot driver(s) I linked, that's used on
the other SoCs you listed (except for V3H).

-- 
Best regards,
Marek Vasut
