From: Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH 4/6] spi: spi-geni-qcom: Add interconnect support
Date: Wed, 19 Feb 2020 10:09:50 -0800
Message-ID: <20200219180950.GA24720@google.com>
References: <1581946205-27189-1-git-send-email-akashast@codeaurora.org>
 <1581946205-27189-5-git-send-email-akashast@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: gregkh@linuxfoundation.org, agross@kernel.org,
        bjorn.andersson@linaro.org, wsa@the-dreams.de, broonie@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org,
        linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, swboyd@chromium.org,
        mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, dianders@chromium.org
To: Akash Asthana <akashast@codeaurora.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1581946205-27189-5-git-send-email-akashast@codeaurora.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Feb 17, 2020 at 07:00:03PM +0530, Akash Asthana wrote:
> Get the interconnect paths for SPI based Serial Engine device
> and vote according to the current bus speed of the driver.
> 
> Signed-off-by: Akash Asthana <akashast@codeaurora.org>
> ---
>  drivers/spi/spi-geni-qcom.c | 65 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 62 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index c397242..a066ef26 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -608,16 +653,25 @@ static int spi_geni_remove(struct platform_device *pdev)
>  	spi_unregister_master(spi);
>  
>  	free_irq(mas->irq, spi);
> +	geni_spi_icc_put(&mas->se);
>  	pm_runtime_disable(&pdev->dev);
>  	return 0;
>  }
>  
>  static int __maybe_unused spi_geni_runtime_suspend(struct device *dev)
>  {
> +	int ret;
>  	struct spi_master *spi = dev_get_drvdata(dev);
>  	struct spi_geni_master *mas = spi_master_get_devdata(spi);
>  
> -	return geni_se_resources_off(&mas->se);
> +	ret = geni_se_resources_off(&mas->se);
> +	if (ret)
> +		return ret;
> +
> +	icc_set_bw(mas->se.icc_path[GENI_TO_CORE], 0, 0);

This causes my SC7180 system to reset at boot time:

[    3.509652] qcom-qmp-phy 88e9000.phy-wrapper: Registered Qcom-QMP phy
[    3.516956] qcom-qusb2-phy 88e3000.phy: Registered Qcom-QUSB2 phy
[    3.524450] geni_se_qup 8c0000.geniqup: Adding to iommu group 4
[    3.533896] spi_master spi0: will run message pump with realtime priority
<reset>

The system does not reset when passing 'Bps_to_icc(1000)' (=> 1) instead of 0.
