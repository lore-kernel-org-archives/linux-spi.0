From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [RFC 23/42] drivers/spi: don't check resource with devm_ioremap_resource
Date: Fri, 10 May 2013 10:37:44 -0600
Message-ID: <518D2258.2090403@wwwdotorg.org>
References: <1368173847-5661-1-git-send-email-wsa@the-dreams.de> <1368173847-5661-24-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Ben Dooks <ben-linux@fluff.org>,
	Kukjin Kim <kgene.kim@samsung.com>,
	Barry Song <baohua.song@csr.com>,
	spi-devel-general@lists.sourceforge.net,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1368173847-5661-24-git-send-email-wsa@the-dreams.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 05/10/2013 02:17 AM, Wolfram Sang wrote:
> devm_ioremap_resource does sanity checks on the given resource. No need to
> duplicate this in the driver.

> diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c

> -	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!r) {
> -		dev_err(&pdev->dev, "No IO memory resource\n");
> -		ret = -ENODEV;
> -		goto exit_free_master;
> -	}
>  	tspi->phys = r->start;
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);

The tspi->phy assignment is broken there now.

> diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c

> -	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!r) {
> -		dev_err(&pdev->dev, "No IO memory resource\n");
> -		ret = -ENODEV;
> -		goto exit_free_master;
> -	}
>  	tspi->phys = r->start;
> +	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);

Same here.
