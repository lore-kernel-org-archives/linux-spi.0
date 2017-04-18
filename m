From: <Nicolas.Ferre@microchip.com>
Subject: RE: [PATCH 2/2] spi: atmel: add deepest PM support to SAMA5D2
Date: Tue, 18 Apr 2017 08:50:36 +0000
Message-ID: <56448E9475A7CD4F97A754616F76B45780A3A0@CHN-SV-EXMX07.mchp-main.com>
References: <20170414082243.23002-1-quentin.schulz@free-electrons.com>
 <20170414082243.23002-2-quentin.schulz@free-electrons.com>,<20170414103549.szcy5ev26psnuu4i@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <thomas.petazzoni@free-electrons.com>
To: <alexandre.belloni@free-electrons.com>,
        <quentin.schulz@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170414103549.szcy5ev26psnuu4i@piout.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

(sorry for malformed email but I didn't want to hold this patch longer)

On 14/04/2017 at 10:22:43 +0200, Quentin Schulz wrote:
> This adds deepest (Backup+Self-Refresh) PM support to the ATMEL SAMA5D2
> SoC's SPI controller.
>
> When resuming from deepest state, it is required to restore MR register
> as the registers are lost since VDD core has been shut down when
> entering deepest state on the SAMA5D2.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

> ---
>
> v2:
>   - fix commit log explanation on why restoring the registers is required
>   after resuming from deepest state,
>
>  drivers/spi/spi-atmel.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 247d920..1eb83c9 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -1702,8 +1702,17 @@ static int atmel_spi_suspend(struct device *dev)
>  static int atmel_spi_resume(struct device *dev)
>  {
>       struct spi_master *master = dev_get_drvdata(dev);
> +     struct atmel_spi *as = spi_master_get_devdata(master);
>       int ret;
>
> +     ret = clk_prepare_enable(as->clk);
> +     if (ret)
> +             return ret;
> +
> +     atmel_spi_init(as);
> +
> +     clk_disable_unprepare(as->clk);
> +
>       if (!pm_runtime_suspended(dev)) {
>               ret = atmel_spi_runtime_resume(dev);
>               if (ret)
> --
> 2.9.3
>

--
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
