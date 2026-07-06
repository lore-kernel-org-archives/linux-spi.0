Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A4A372ED5;
	Mon,  6 Jul 2026 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783336012; cv=none; b=CiZy/w7u8c0FSg/vIhyeNy/FLDvK/EFe0yAN/K2fDy/9VfGps54jvWB2tDgwS/zPQfLqlVh4sQiIn87gvXxGSreLM39BJvltR+FHmVqB5aoFO1xlzliXgdKdfZOdV6GqAXSXUpfbPSLGL2TmaF3YzMu3AN2S94A9f73vrulicKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783336012; c=relaxed/simple;
	bh=MMaoKzXp//v1HK4HDldEtFfaYwNaCGZ7imUlYkjBr6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L9K9R1YYVayFCojIKqy85Rf3vCx8p2u/E97Q3qnWWVfW7eVKNWwOkIsAMyrtptpp2qBXIIsCLb18al6AvOLUS01TumG8fo10F/tRc3+NTV7tLCjPtNULMYjHjrvdc5veljmbA29PwTEYtJsL311OCj83hhllL+7MI0oAR09Q0kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=Iy5YxAKw; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="Iy5YxAKw"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B349148CF67;
	Mon,  6 Jul 2026 12:58:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1783335520; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=WAhivCzCc5imdzAsAJR6CIv8LmWf45kJCVdZMw3xeVg=;
	b=Iy5YxAKwatmbE0VSdGw3rI0EtsFCJN+rdqhnBjbwinLR8bwcc8fnTBoisLY8SVhFC47ZNr
	l6Pq4OHnpGCX02+D4Q/N9LBo2Xz/K337Rjcj+x5Ti+E+wnDbq2VX4aTawC6BXLa7/Ox3xN
	PnN3zYCzmYQzR+p5br8wmNiv0+1HDtK5S5WpeTFSYDmkY9HXDFMC5cW5fBHgnt2CgIoNQk
	HED0hk6ZwU3qkTgIUV+oK/PcZAWx61Zuz+n9Zsocff7IGV3f1tvfzE1WvzEr24DXKt/4oc
	IaAFxblx6Rov+7c8eO0LRWVEPXyKiwjkXYqk6GBrtgQeGlVW4IWz02q0mJLWhg==
Date: Mon, 6 Jul 2026 12:58:31 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: atmel-quadspi: Simplify probe() with local
 'dev' variable
Message-ID: <20260706-plunder-fencing-b9ca15ef05ae@thorsis.com>
Mail-Followup-To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
References: <20260705172737.120095-4-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705172737.120095-4-krzysztof.kozlowski@oss.qualcomm.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Last-TLS-Session-Version: TLSv1.3

Hello Krzysztof,

I think you missed some.  At least the two outlined below, but maybe
more which are not part of the lines covered by the patch?

Am Sun, Jul 05, 2026 at 07:27:38PM +0200 schrieb Krzysztof Kozlowski:
> Instead of multiple '&pdev->dev' dereferences, just use a local 'dev'
> variable which makes multiple function calls shorter thus easier to
> follow.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/spi/atmel-quadspi.c | 37 +++++++++++++++++++------------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index aaf7f4c46b22..8d9c77f5de43 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -1347,20 +1347,21 @@ static const struct atmel_qspi_ops atmel_qspi_sama7g5_ops = {
>  
>  static int atmel_qspi_probe(struct platform_device *pdev)
>  {
> +	struct device *dev = &pdev->dev;
>  	struct spi_controller *ctrl;
>  	struct atmel_qspi *aq;
>  	struct resource *res;
>  	int irq, err = 0;
>  
> -	ctrl = devm_spi_alloc_host(&pdev->dev, sizeof(*aq));
> +	ctrl = devm_spi_alloc_host(dev, sizeof(*aq));
>  	if (!ctrl)
>  		return -ENOMEM;
>  
>  	aq = spi_controller_get_devdata(ctrl);
>  
> -	aq->caps = of_device_get_match_data(&pdev->dev);
> +	aq->caps = of_device_get_match_data(dev);
>  	if (!aq->caps) {
> -		dev_err(&pdev->dev, "Could not retrieve QSPI caps\n");
> +		dev_err(dev, "Could not retrieve QSPI caps\n");
>  		return -EINVAL;
>  	}
>  
> @@ -1387,31 +1388,31 @@ static int atmel_qspi_probe(struct platform_device *pdev)
>  	/* Map the registers */
>  	aq->regs = devm_platform_ioremap_resource_byname(pdev, "qspi_base");
>  	if (IS_ERR(aq->regs))
> -		return dev_err_probe(&pdev->dev, PTR_ERR(aq->regs),
> +		return dev_err_probe(dev, PTR_ERR(aq->regs),
>  				     "missing registers\n");
>  
>  	/* Map the AHB memory */
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_mmap");
> -	aq->mem = devm_ioremap_resource(&pdev->dev, res);
> +	aq->mem = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(aq->mem))
> -		return dev_err_probe(&pdev->dev, PTR_ERR(aq->mem),
> +		return dev_err_probe(dev, PTR_ERR(aq->mem),
>  				     "missing AHB memory\n");
>  
>  	aq->mmap_size = resource_size(res);
>  	aq->mmap_phys_base = (dma_addr_t)res->start;
>  
>  	/* Get the peripheral clock */
> -	aq->pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
> +	aq->pclk = devm_clk_get_enabled(dev, "pclk");
>  	if (IS_ERR(aq->pclk))
> -		aq->pclk = devm_clk_get_enabled(&pdev->dev, NULL);
> +		aq->pclk = devm_clk_get_enabled(dev, NULL);
>  
>  	if (IS_ERR(aq->pclk))
> -		return dev_err_probe(&pdev->dev, PTR_ERR(aq->pclk),
> +		return dev_err_probe(dev, PTR_ERR(aq->pclk),
>  				     "missing peripheral clock\n");
>  
>  	if (aq->caps->has_qspick) {
>  		/* Get the QSPI system clock */
> -		aq->qspick = devm_clk_get_enabled(&pdev->dev, "qspick");
> +		aq->qspick = devm_clk_get_enabled(dev, "qspick");
>  		if (IS_ERR(aq->qspick)) {
>  			dev_err(&pdev->dev, "missing system clock\n");

Here.

>  			err = PTR_ERR(aq->qspick);
> @@ -1420,7 +1421,7 @@ static int atmel_qspi_probe(struct platform_device *pdev)
>  
>  	} else if (aq->caps->has_gclk) {
>  		/* Get the QSPI generic clock */
> -		aq->gclk = devm_clk_get(&pdev->dev, "gclk");
> +		aq->gclk = devm_clk_get(dev, "gclk");
>  		if (IS_ERR(aq->gclk)) {
>  			dev_err(&pdev->dev, "missing Generic clock\n");

Here.

>  			err = PTR_ERR(aq->gclk);
> @@ -1439,15 +1440,15 @@ static int atmel_qspi_probe(struct platform_device *pdev)
>  	if (irq < 0)
>  		return irq;
>  
> -	err = devm_request_irq(&pdev->dev, irq, atmel_qspi_interrupt,
> -			       0, dev_name(&pdev->dev), aq);
> +	err = devm_request_irq(dev, irq, atmel_qspi_interrupt,
> +			       0, dev_name(dev), aq);
>  	if (err)
>  		return err;
>  
> -	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
> -	pm_runtime_use_autosuspend(&pdev->dev);
> -	devm_pm_runtime_set_active_enabled(&pdev->dev);
> -	devm_pm_runtime_get_noresume(&pdev->dev);
> +	pm_runtime_set_autosuspend_delay(dev, 500);
> +	pm_runtime_use_autosuspend(dev);
> +	devm_pm_runtime_set_active_enabled(dev);
> +	devm_pm_runtime_get_noresume(dev);
>  
>  	err = atmel_qspi_init(aq);
>  	if (err)
> @@ -1457,7 +1458,7 @@ static int atmel_qspi_probe(struct platform_device *pdev)
>  	if (err)
>  		return err;
>  
> -	pm_runtime_put_autosuspend(&pdev->dev);
> +	pm_runtime_put_autosuspend(dev);
>  
>  	return 0;
>  }

Greets
Alex

