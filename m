From: Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH spi-next] spi: add Broadcom BCM63xx SPI controller driver
Date: Wed, 23 Nov 2011 20:41:18 +0100
Message-ID: <201111232041.18477.florian@openwrt.org>
References: <1321906615-11392-1-git-send-email-florian@openwrt.org>
	<CAM=Q2cudxgW-B_TEDgBrdk4CFB9LgZqE9db6vDH+MJEgJeCQcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Tanguy Bouzeloc <tanguy.bouzeloc-HH44TBFINEIAvxtiuMwx3w@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org,
	ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAM=Q2cudxgW-B_TEDgBrdk4CFB9LgZqE9db6vDH+MJEgJeCQcg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi  Shubhrajyoti

Le mardi 22 novembre 2011 09:26:07, Shubhrajyoti Datta a =E9crit :
> Hi Florian,
> =

> On Tue, Nov 22, 2011 at 1:46 AM, Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org> =

wrote:
[snip]
> > +       bs->irq =3D irq;
> > +       bs->clk =3D clk;
> > +       bs->fifo_size =3D pdata->fifo_size;
> > +
> > +       ret =3D request_irq(irq, bcm63xx_spi_interrupt, 0, pdev->name,
> > master); +       if (ret) {
> > +               dev_err(dev, "unable to request irq\n");
> > +               goto out_unmap;
> > +       }
> =

> Could this be a threaded irq ?

I see no reasons why it could not. Is this a requirement for accepting new =

drivers? I see no drivers doing this in Grant's spi/next branch.

> =

> > +
> > +       master->bus_num =3D pdata->bus_num;
> > +       master->num_chipselect =3D pdata->num_chipselect;
> > +       master->setup =3D bcm63xx_spi_setup;
> > +       master->transfer =3D bcm63xx_transfer;
> > +       bs->speed_hz =3D pdata->speed_hz;
> > +       bs->stopping =3D 0;
> > +       bs->tx_io =3D (u8 *)(bs->regs + bcm63xx_spireg(SPI_MSG_DATA));
> > +       bs->rx_io =3D (const u8 *)(bs->regs + bcm63xx_spireg(SPI_RX_DAT=
A));
> > +       spin_lock_init(&bs->lock);
> > +
> > +       /* Initialize hardware */
> > +       clk_enable(bs->clk);
> > +       bcm_spi_writeb(bs, SPI_INTR_CLEAR_ALL, SPI_INT_STATUS);
> > +
> > +       /* register and we are done */
> > +       ret =3D spi_register_master(master);
> > +       if (ret) {
> > +               dev_err(dev, "spi register failed\n");
> > +               goto out_reset_hw;
> > +       }
> > +
> > +       dev_info(dev, "at 0x%08x (irq %d, FIFOs size %d) v%s\n",
> > +                r->start, irq, bs->fifo_size, DRV_VER);
> > +
> > +       return 0;
> > +
> > +out_reset_hw:
> > +       clk_disable(clk);
> > +       free_irq(irq, master);
> > +out_unmap:
> > +       iounmap(bs->regs);
> > +out_put_master:
> > +       spi_master_put(master);
> > +out_free:
> > +       clk_put(clk);
> > +out:
> > +       return ret;
> > +}
> > +
> > +static int __exit bcm63xx_spi_remove(struct platform_device *pdev)
> > +{
> > +       struct spi_master *master =3D platform_get_drvdata(pdev);
> > +       struct bcm63xx_spi *bs =3D spi_master_get_devdata(master);
> > +       struct resource *r =3D platform_get_resource(pdev, IORESOURCE_M=
EM,
> > 0); +
> > +       /* reset spi block */
> > +       bcm_spi_writeb(bs, 0, SPI_INT_MASK);
> > +       spin_lock(&bs->lock);
> > +       bs->stopping =3D 1;
> > +
> > +       /* HW shutdown */
> > +       clk_disable(bs->clk);
> > +       clk_put(bs->clk);
> > +
> > +       spin_unlock(&bs->lock);
> > +
> > +       free_irq(bs->irq, master);
> > +       iounmap(bs->regs);
> > +       release_mem_region(r->start, r->end - r->start);
> > +       platform_set_drvdata(pdev, 0);
> > +       spi_unregister_master(master);
> > +
> > +       return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM
> > +static int bcm63xx_spi_suspend(struct platform_device *pdev,
> > pm_message_t mesg) +{
> > +       struct spi_master *master =3D platform_get_drvdata(pdev);
> > +       struct bcm63xx_spi *bs =3D spi_master_get_devdata(master);
> > +
> > +       clk_disable(bs->clk);
> > +
> > +       return 0;
> > +}
> > +
> > +static int bcm63xx_spi_resume(struct platform_device *pdev)
> > +{
> > +       struct spi_master *master =3D platform_get_drvdata(pdev);
> > +       struct bcm63xx_spi *bs =3D spi_master_get_devdata(master);
> > +
> > +       clk_enable(bs->clk);
> > +
> > +       return 0;
> > +}
> > +#else
> > +#define bcm63xx_spi_suspend    NULL
> > +#define bcm63xx_spi_resume     NULL
> > +#endif
> > +
> > +static struct platform_driver bcm63xx_spi_driver =3D {
> > +       .driver =3D {
> > +               .name   =3D "bcm63xx-spi",
> > +               .owner  =3D THIS_MODULE,
> > +       },
> > +       .probe          =3D bcm63xx_spi_probe,
> > +       .remove         =3D __exit_p(bcm63xx_spi_remove),
> > +       .suspend        =3D bcm63xx_spi_suspend,
> > +       .resume         =3D bcm63xx_spi_resume,
> =

> Could we move to dev pm ops?

Sure, I have fixed that in version 2 of the patch.

-- =

Florian

---------------------------------------------------------------------------=
---
All the data continuously generated in your IT infrastructure =

contains a definitive record of customers, application performance, =

security threats, fraudulent activity, and more. Splunk takes this =

data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
