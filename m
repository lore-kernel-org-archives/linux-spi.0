From: Mirza Krak <mirza.krak-3xdUHytR7SMQwY+2splSUA@public.gmane.org>
Subject: Re: [PATCH 1/1] spi: fsl-dspi: Fixes warning due to devm_kzalloc on
 unbound device
Date: Tue, 23 Dec 2014 09:57:03 +0100
Message-ID: <20141223095703.4221b9a1@mirza-hm>
References: <1417723755-5372-1-git-send-email-mirza.krak@hostmobility.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1417723755-5372-1-git-send-email-mirza.krak-3xdUHytR7SMQwY+2splSUA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi!

Any feedback on this?

Best Regards / Mirza

On Thu,  4 Dec 2014 21:09:15 +0100
Mirza Krak <mirza.krak-3xdUHytR7SMQwY+2splSUA@public.gmane.org> wrote:

> ------------[ cut here ]------------
> WARNING: at drivers/base/dd.c:286 driver_probe_device+0x1b4/0x22c()
> Modules linked in:
> Backtrace:
> [<80011644>] (dump_backtrace) from [<800117e0>] (show_stack+0x18/0x1c)
> r6:0000011e r5:00000009 r4:00000000 r3:00000000
> [<800117c8>] (show_stack) from [<805961e8>] (dump_stack+0x20/0x28)
> [<805961c8>] (dump_stack) from [<80020e48>]
> (warn_slowpath_common+0x6c/0x8c)
> [<80020ddc>] (warn_slowpath_common) from [<80020e8c>]
> (warn_slowpath_null+0x24/0x2c) r8:00000006 r7:7f005b94 r6:8ea1ae34
> r5:8ea1ae00 r4:80837290
> [<80020e68>] (warn_slowpath_null) from [<802d9078>]
> (driver_probe_device+0x1b4/0x22c)
> [<802d8ec4>] (driver_probe_device) from [<802d9184>]
> (__driver_attach+0x94/0x98) r8:7f00b000 r7:00000000 r6:8ea1ae34
> r5:7f005b94 r4:8ea1ae00 r3:00000000
> [<802d90f0>] (__driver_attach) from [<802d778c>]
> (bus_for_each_dev+0x5c/0x90) r6:802d90f0 r5:7f005b94 r4:00000000
> r3:8ea120bc
> [<802d7730>] (bus_for_each_dev) from [<802d8acc>]
> (driver_attach+0x24/0x28) r6:807c8428 r5:8e335e80 r4:7f005b94
> [<802d8aa8>] (driver_attach) from [<802d874c>]
> (bus_add_driver+0xdc/0x1d8)
> [<802d8670>] (bus_add_driver) from [<802d9814>]
> (driver_register+0x80/0xfc) r7:8e307d00 r6:8e307e00 r5:807a93d8
> r4:7f005b94
> [<802d9794>] (driver_register) from [<8034f410>]
> (spi_register_driver+0x4c/0x60) r5:807a93d8 r4:807a93d8
> [<8034f3c4>] (spi_register_driver) from [<7f00b01c>]
> (mx4_io_init+0x1c/0x28 [spi_pic])
> [<7f00b000>] (mx4_io_init [spi_pic]) from [<8000874c>]
> (do_one_initcall+0x88/0x1cc)
> [<800086c4>] (do_one_initcall) from [<800638ac>]
> (load_module+0x1634/0x1d10) r10:800611c0 r9:7f006174 r8:00000001
> r7:8e307d00 r6:00000001 r5:7f006180 r4:8e12bf48
> [<80062278>] (load_module) from [<80064068>]
> (SyS_init_module+0xe0/0xf4) r10:00000000 r9:8e12a000 r8:8000e9e4
> r7:00000080 r6:00884008 r5:00884018 r4:0000cb5d
> [<80063f88>] (SyS_init_module) from [<8000e840>]
> (ret_fast_syscall+0x0/0x30) r6:7eee4e53 r5:7eee4e53 r4:0000cb5d
> ---[ end trace 9c516d4cef36cef3 ]---
> 
> Inspired by: 10aa5a35e34f ("SPI: fix over-eager devm_xxx()
> conversion")
> 
> Signed-off-by: Mirza Krak <mirza.krak-3xdUHytR7SMQwY+2splSUA@public.gmane.org>
> ---
>  drivers/spi/spi-fsl-dspi.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 831ceb4..78509d6 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -342,7 +342,7 @@ static int dspi_setup_transfer(struct spi_device
> *spi, struct spi_transfer *t) /* Only alloc on first setup */
>  	chip = spi_get_ctldata(spi);
>  	if (chip == NULL) {
> -		chip = devm_kzalloc(&spi->dev, sizeof(struct
> chip_data),
> +		chip = kzalloc(sizeof(struct chip_data), GFP_KERNEL);
>  				    GFP_KERNEL);
>  		if (!chip)
>  			return -ENOMEM;
> @@ -382,6 +382,11 @@ static int dspi_setup(struct spi_device *spi)
>  	return dspi_setup_transfer(spi, NULL);
>  }
>  
> +static void dspi_cleanup(struct spi_device *spi)
> +{
> +	spi_bitbang_cleanup(spi);
> +}
> +
>  static irqreturn_t dspi_interrupt(int irq, void *dev_id)
>  {
>  	struct fsl_dspi *dspi = (struct fsl_dspi *)dev_id;
> @@ -465,6 +470,7 @@ static int dspi_probe(struct platform_device
> *pdev) dspi->bitbang.setup_transfer = dspi_setup_transfer;
>  	dspi->bitbang.txrx_bufs = dspi_txrx_transfer;
>  	dspi->bitbang.master->setup = dspi_setup;
> +	dspi->bitbang.master->cleanup = dspi_cleanup;
>  	dspi->bitbang.master->dev.of_node = pdev->dev.of_node;
>  
>  	master->mode_bits = SPI_CPOL | SPI_CPHA;

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
