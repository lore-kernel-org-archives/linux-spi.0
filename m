From: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 4/6] spi: spi-geni-qcom: Add interconnect support
Date: Fri, 21 Feb 2020 10:55:00 -0800
Message-ID: <20200221185500.GE24720@google.com>
References: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
 <1581946205-27189-5-git-send-email-akashast@codeaurora.org>
 <20200219180950.GA24720@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
To: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200219180950.GA24720-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Feb 19, 2020 at 10:09:50AM -0800, Matthias Kaehlcke wrote:
> On Mon, Feb 17, 2020 at 07:00:03PM +0530, Akash Asthana wrote:
> > Get the interconnect paths for SPI based Serial Engine device
> > and vote according to the current bus speed of the driver.
> > 
> > Signed-off-by: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> > ---
> >  drivers/spi/spi-geni-qcom.c | 65 ++++++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 62 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> > index c397242..a066ef26 100644
> > --- a/drivers/spi/spi-geni-qcom.c
> > +++ b/drivers/spi/spi-geni-qcom.c
> > @@ -608,16 +653,25 @@ static int spi_geni_remove(struct platform_device *pdev)
> >  	spi_unregister_master(spi);
> >  
> >  	free_irq(mas->irq, spi);
> > +	geni_spi_icc_put(&mas->se);
> >  	pm_runtime_disable(&pdev->dev);
> >  	return 0;
> >  }
> >  
> >  static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
> >  {
> > +	int ret;
> >  	struct spi_master *spi = dev_get_drvdata(dev);
> >  	struct spi_geni_master *mas = spi_master_get_devdata(spi);
> >  
> > -	return geni_se_resources_off(&mas->se);
> > +	ret = geni_se_resources_off(&mas->se);
> > +	if (ret)
> > +		return ret;
> > +
> > +	icc_set_bw(mas->se.icc_path[GENI_TO_CORE], 0, 0);
> 
> This causes my SC7180 system to reset at boot time:
> 
> [    3.509652] qcom-qmp-phy 88e9000.phy-wrapper: Registered Qcom-QMP phy
> [    3.516956] qcom-qusb2-phy 88e3000.phy: Registered Qcom-QUSB2 phy
> [    3.524450] geni_se_qup 8c0000.geniqup: Adding to iommu group 4
> [    3.533896] spi_master spi0: will run message pump with realtime priority
> <reset>
> 
> The system does not reset when passing 'Bps_to_icc(1000)' (=> 1) instead of 0.

I found this is related with the use of 'earlycon'.

There is a short window where the early console and the 'real' console coexist:

[    3.858122] printk: console [ttyMSM0] enabled
[    3.875692] printk: bootconsole [qcom_geni0] disabled

The reset probably occurs when the early console tries to write, but the ICC is
effectively disabled because ttyMSM0 and the other geni ports are runtime
suspended.

In any case that's not an issue of the SPI driver, but needs to be addressed
somewhere in the console/UART code.
