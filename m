From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v5 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
Date: Wed, 9 Jan 2019 09:12:33 +0100
Message-ID: <CAMuHMdWg+X+R3_i6=tfK5PKxNcrVjb3T_dKRn8ZFV7EqKUvCwQ@mail.gmail.com>
References: <1546921020-20436-1-git-send-email-masonccyang@mxic.com.tw> <1546921020-20436-2-git-send-email-masonccyang@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546921020-20436-2-git-send-email-masonccyang@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mason,

On Tue, Jan 8, 2019 at 5:17 AM Mason Yang <masonccyang@mxic.com.tw> wrote:
> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
>
> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/spi/spi-renesas-rpc.c

> +static void rpc_spi_mem_set_prep_op_cfg(struct spi_device *spi,
> +                                       const struct spi_mem_op *op,
> +                                       u64 *offs, size_t *len)
> +{
> +       struct rpc_spi *rpc = spi_master_get_devdata(spi->master);

spi_controller_get_devdata(), for new code.


> +static ssize_t rpc_spi_mem_dirmap_read(struct spi_mem_dirmap_desc *desc,
> +                                      u64 offs, size_t len, void *buf)
> +{
> +       struct rpc_spi *rpc = spi_master_get_devdata(desc->mem->spi->master);
> +       int ret;
> +
> +       if (WARN_ON(offs + desc->info.offset + len > U32_MAX))
> +               return -EINVAL;

Why do you need a WARN_ON()?

> +
> +       if (WARN_ON(len > 0x4000000))
> +               len = 0x4000000;

Please drop the WARN_ON(), as this is normal behavior, cfr.:

 * @dirmap_write: write data to the memory device using the direct mapping
 *                created by ->dirmap_create(). The function can return less
 *                data than requested (for example when the request is crossing
 *                the currently mapped area), and the caller of
 *                spi_mem_dirmap_write() is responsible for calling it again in
 *                this case.


> +static ssize_t rpc_spi_mem_dirmap_write(struct spi_mem_dirmap_desc *desc,
> +                                       u64 offs, size_t len, const void *buf)
> +{
> +       struct rpc_spi *rpc = spi_master_get_devdata(desc->mem->spi->master);
> +       int ret;
> +
> +       if (WARN_ON(offs + desc->info.offset + len > U32_MAX))
> +               return -EINVAL;

Why do you need a WARN_ON()?

> +
> +       if (WARN_ON(len > RPC_WBUF_SIZE))
> +               len = RPC_WBUF_SIZE;

Please drop the WARN_ON().


> +static int rpc_spi_transfer_one_message(struct spi_master *master,
> +                                       struct spi_message *msg)
> +{
> +       struct rpc_spi *rpc = spi_master_get_devdata(master);
> +       struct spi_transfer *t;
> +       int ret;
> +
> +       rpc_spi_transfer_setup(rpc, msg);
> +
> +       list_for_each_entry(t, &msg->transfers, transfer_list) {
> +               if (!list_is_last(&t->transfer_list, &msg->transfers))
> +                       continue;

Can't you use list_last_entry(), to avoid having to loop over the whole list?

> +               ret = rpc_spi_xfer_message(rpc, t);
> +               if (ret)
> +                       goto out;
> +       }
> +
> +       msg->status = 0;
> +       msg->actual_length = rpc->totalxferlen;
> +out:
> +       spi_finalize_current_message(master);
> +       return 0;
> +}

> +static int rpc_spi_probe(struct platform_device *pdev)
> +{
> +       struct spi_master *master;

struct spi_controller, for new code.

> +       struct resource *res;
> +       struct rpc_spi *rpc;
> +       const struct regmap_config *regmap_config;
> +       const char *mode;
> +       int ret;
> +
> +       ret = of_property_read_string(pdev->dev.of_node,
> +                                     "renesas,rpc-mode", &mode);
> +       if (ret < 0)
> +               return ret;
> +
> +       if (strcasecmp(mode, "spi"))
> +               return -ENODEV;
> +
> +       master = spi_alloc_master(&pdev->dev, sizeof(*rpc));
> +       if (!master)
> +               return -ENOMEM;
> +
> +       platform_set_drvdata(pdev, master);
> +
> +       rpc = spi_master_get_devdata(master);
> +
> +       master->dev.of_node = pdev->dev.of_node;
> +
> +       rpc->clk_rpc = devm_clk_get(&pdev->dev, "rpc");
> +       if (IS_ERR(rpc->clk_rpc))
> +               return PTR_ERR(rpc->clk_rpc);
> +
> +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
> +       rpc->base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(rpc->base))
> +               return PTR_ERR(rpc->base);
> +
> +       regmap_config = &rpc_spi_regmap_config;
> +       rpc->regmap = devm_regmap_init_mmio(&pdev->dev, rpc->base,
> +                                           regmap_config);
> +       if (IS_ERR(rpc->regmap)) {
> +               dev_err(&pdev->dev, "failed to init regmap %ld for rpc-spi\n",
> +                       PTR_ERR(rpc->regmap));
> +               return PTR_ERR(rpc->regmap);
> +       }
> +
> +       res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dirmap");
> +       rpc->dirmap = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(rpc->dirmap))
> +               rpc->dirmap = NULL;
> +
> +       rpc->rstc = devm_reset_control_get_exclusive(&pdev->dev, NULL);
> +       if (IS_ERR(rpc->rstc))
> +               return PTR_ERR(rpc->rstc);
> +
> +       pm_runtime_enable(&pdev->dev);
> +       master->auto_runtime_pm = true;
> +
> +       master->num_chipselect = 1;
> +       master->mem_ops = &rpc_spi_mem_ops;
> +       master->transfer_one_message = rpc_spi_transfer_one_message;
> +
> +       master->bits_per_word_mask = SPI_BPW_MASK(8);
> +       master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_TX_QUAD | SPI_RX_QUAD;
> +
> +       rpc_spi_hw_init(rpc);
> +
> +       ret = spi_register_master(master);
> +       if (ret) {
> +               dev_err(&pdev->dev, "spi_register_master failed\n");
> +               goto err_put_master;
> +       }
> +       return 0;
> +
> +err_put_master:
> +       spi_master_put(master);

spi_controller_put(), for new code

> +       pm_runtime_disable(&pdev->dev);
> +
> +       return ret;
> +}
> +
> +static int rpc_spi_remove(struct platform_device *pdev)
> +{
> +       struct spi_master *master = platform_get_drvdata(pdev);

struct spi_controller

> +
> +       pm_runtime_disable(&pdev->dev);
> +       spi_unregister_master(master);

spi_unregister_controller()

> +
> +       return 0;
> +}
> +
> +static const struct of_device_id rpc_spi_of_ids[] = {
> +       { .compatible = "renesas,r8a77995-rpc", },
> +       { /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, rpc_spi_of_ids);
> +
> +#ifdef CONFIG_PM_SLEEP
> +static int rpc_spi_suspend(struct device *dev)
> +{
> +       struct spi_master *master = dev_get_drvdata(dev);
> +
> +       return spi_master_suspend(master);

spi_controller_suspend()

> +}
> +
> +static int rpc_spi_resume(struct device *dev)
> +{
> +       struct spi_master *master = dev_get_drvdata(dev);
> +
> +       return spi_master_resume(master);

spi_controller_resume()

> +}

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
