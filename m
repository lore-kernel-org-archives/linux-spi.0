From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: add spi controller master driver for Blackfin 6xx
	processor
Date: Mon, 4 Jun 2012 15:03:58 +0530
Message-ID: <CAM=Q2ctr6+LeP9YQDVzeOeVQ_-X_S7NoWeZtuR6dARbqyUWW6w@mail.gmail.com>
References: <1338837689-19114-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1338837689-19114-1-git-send-email-scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Scott,
Some minor comments?

On Tue, Jun 5, 2012 at 12:51 AM, Scott Jiang
<scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> New spi controller is integrated into Blackfin 6xx processor.
> Comparing to bf5xx spi controller, we support 32 bits word size
> and independent receive and transmit DMA channels now.
> Also mode 0 and 2 (CPHA =3D 0) can get fully supported
> becasue cs line may be controlled by the software.
<Snip>

how about using spi core queuing?
> +
> + =A0 =A0 =A0 status =3D bfin_spi_start_queue(drv_data);
> + =A0 =A0 =A0 if (status !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "problem starting queue\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_destroy_queue;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 bfin_write(&drv_data->regs->control, SPI_CTL_MSTR | SPI_CTL=
_CPHA);
> + =A0 =A0 =A0 bfin_write(&drv_data->regs->ssel, 0x0000FE00);
> + =A0 =A0 =A0 bfin_write(&drv_data->regs->delay, 0x0);
> +
> + =A0 =A0 =A0 /* Register with the SPI framework */
> + =A0 =A0 =A0 platform_set_drvdata(pdev, drv_data);
> + =A0 =A0 =A0 status =3D spi_register_master(master);
> + =A0 =A0 =A0 if (status !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "problem registering spi maste=
r\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_free_peripheral;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 dev_info(dev, "bfin-spi probe success\n");
> + =A0 =A0 =A0 return status;
> +
> +err_destroy_queue:
> + =A0 =A0 =A0 bfin_spi_destroy_queue(drv_data);
> +err_free_peripheral:
> + =A0 =A0 =A0 peripheral_free_list(drv_data->pin_req);
> +err_free_rx_dma:
> + =A0 =A0 =A0 free_dma(drv_data->rx_dma);
> +err_free_tx_dma:
> + =A0 =A0 =A0 free_dma(drv_data->tx_dma);
> +err_iounmap:
> + =A0 =A0 =A0 iounmap(drv_data->regs);
> +err_put_master:
> + =A0 =A0 =A0 spi_master_put(master);
> +
> + =A0 =A0 =A0 return status;
> +}
> +
> +/* stop hardware and remove the driver */
> +static int __devexit bfin_spi_remove(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct bfin_spi_master_data *drv_data =3D platform_get_drvd=
ata(pdev);
> +
> + =A0 =A0 =A0 if (!drv_data)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 /* Remove the queue */
> + =A0 =A0 =A0 bfin_spi_destroy_queue(drv_data);
> +
> + =A0 =A0 =A0 /* Disable the SSP at the peripheral and SOC level */
> + =A0 =A0 =A0 bfin_spi_disable(drv_data);
> +
> + =A0 =A0 =A0 peripheral_free_list(drv_data->pin_req);
> + =A0 =A0 =A0 free_dma(drv_data->rx_dma);
> + =A0 =A0 =A0 free_dma(drv_data->tx_dma);
> + =A0 =A0 =A0 iounmap(drv_data->regs);
> +
> + =A0 =A0 =A0 /* Disconnect from the SPI framework */
> + =A0 =A0 =A0 spi_unregister_master(drv_data->master);
> + =A0 =A0 =A0 spi_master_put(drv_data->master);
> + =A0 =A0 =A0 /* Prevent double remove */
> + =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int bfin_spi_suspend(struct platform_device *pdev, pm_message_t s=
tate)
> +{
> + =A0 =A0 =A0 struct bfin_spi_master_data *drv_data =3D platform_get_drvd=
ata(pdev);
> + =A0 =A0 =A0 int status =3D 0;
> +
> + =A0 =A0 =A0 status =3D bfin_spi_stop_queue(drv_data);
> + =A0 =A0 =A0 if (status !=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return status;
> +
> + =A0 =A0 =A0 drv_data->control =3D bfin_read(&drv_data->regs->control);
> + =A0 =A0 =A0 drv_data->ssel =3D bfin_read(&drv_data->regs->ssel);
> +
> + =A0 =A0 =A0 bfin_write(&drv_data->regs->control, SPI_CTL_MSTR | SPI_CTL=
_CPHA);
> + =A0 =A0 =A0 bfin_write(&drv_data->regs->ssel, 0x0000FE00);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int bfin_spi_resume(struct platform_device *pdev)
> +{
> + =A0 =A0 =A0 struct bfin_spi_master_data *drv_data =3D platform_get_drvd=
ata(pdev);
> + =A0 =A0 =A0 int status =3D 0;
> +
> + =A0 =A0 =A0 bfin_write(&drv_data->regs->control, drv_data->control);
> + =A0 =A0 =A0 bfin_write(&drv_data->regs->ssel, drv_data->ssel);
> +
> + =A0 =A0 =A0 /* Start the queue running */
> + =A0 =A0 =A0 status =3D bfin_spi_start_queue(drv_data);
> + =A0 =A0 =A0 if (status !=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "problem starting queue=
 (%d)\n", status);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return status;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +#else
> +#define bfin_spi_suspend NULL
> +#define bfin_spi_resume NULL
> +#endif /* CONFIG_PM */
> +
> +MODULE_ALIAS("platform:bfin-spi");
> +static struct platform_driver bfin_spi_driver =3D {
> + =A0 =A0 =A0 .driver =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =A0 =3D "bfin-spi",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =A0=3D THIS_MODULE,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .suspend =A0 =A0 =A0 =A0=3D bfin_spi_suspend,
> + =A0 =A0 =A0 .resume =A0 =A0 =A0 =A0 =3D bfin_spi_resume,

Can we move to dev pm ops instead?

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
