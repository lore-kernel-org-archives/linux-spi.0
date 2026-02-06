Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F833ECBE3
	for <linux-spi@vger.kernel.org>; Fri,  6 Feb 2026 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770385256; cv=none; b=S/i67HcSClhF8mJxXNuCijiJtLg/VX33mG3fRKpCGDFFZ8oJbtoKjy1pCgmACDnWmbv66ZMX/0vFtMZwSsafo5Mix6JWetZTVoyI3E5ZhGn1An2WA05WZmL5eJ1ui1gPpiT2OWD9aEm31+XYIGvNB67ENoWNtO+Pb+oPMYH5czA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770385256; c=relaxed/simple;
	bh=SmbIOUbHo+snjrWyD7NJRudJRQzmv6bZIERP91BaRBg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TU3qb3u/Coyx+slUqb17raMmKoox6DW/DxjIm9hvNMgDvi7dZ3+3vhLT+a961uxkGOjbe2u+zKSnO83DO1mTP77HA3IwARXsspZ2p8Z1JrQ6Fsv2X5ouBGdnTUegv8qrMYZtQc5sca81Srw/c74zyBuKDdCljGTESneg6SMYGZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TuSuX5EW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TuSuX5EW"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-432da746749so1428481f8f.0
        for <linux-spi@vger.kernel.org>; Fri, 06 Feb 2026 05:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770385255; x=1770990055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mib8qSuKz/dqMMxLJ47BKHYisRGtocujstnMCZQJiTs=;
        b=TuSuX5EWlOTU//dJp9DwYBX4snKyqLlBu79mLbzib0GJszwM/eSaRPeUyAUUki1Buh
         5JDY+RhkJEereAowUzGtuyfLQbrq9FeN1Xkgf/5nl5sx2FyqP/I8AiXL+56rrObpsygh
         qE1sG6liQt4DgFKmNnk/PqhrfckDR3PGqiJv5so2jWUUEFu4S/OXjg9jxjeFvbP62P3I
         ahgcjMhrSpEXkfYWpM0ZB1evfBM4AlaJQ0JMcBZf9fkwq9nTfRH9jsKgl0bc8GHh7WcX
         DSCJSZLM7gXzlhWb6N+IA2AngN77fe8f5Zy/KJ0NzjJ0mZSc6VOBR7fbiGHfxeHlzzGu
         Bv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770385255; x=1770990055;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mib8qSuKz/dqMMxLJ47BKHYisRGtocujstnMCZQJiTs=;
        b=XoMCOQu+eav+PF+zIe8OLKtLrvd4u+Eb9wo/YWONCIzMgZUySxN81KWV7XH0QMv+n1
         L07BwzEuYSdhoIy7HcHPN+qRW5dLALFDe71f7iQ8+kgmBXM9j6LnOcVyXSk8FlRWaAcW
         pX0nBFiDIl8YyrZGkcMV1cCxUklk8TPAsK/pP7zPxmJ8gHV1HysmSHk2yUENLMNCzMYT
         JINhG6Qrs0+/5k+g1Q2cswO6W+T8SHi+nr/79ZLcQLyUfEM1BzMmwvfhgGblXx4n0XEN
         bWSpNnIpglASDfvO2tKc6VaKFHcQmF2hB4dDKUYFiieeu8bEjNFL/s0cCypBCyVOrXjw
         ro9A==
X-Gm-Message-State: AOJu0YwcpKfcg8FA9BixwQpVCw+hwe01lHNzQYDGqdDOtGm+2gXCBn0v
	j8hoFi6eJ1C883fBKkF8GZSmlbJw+VqnfkQfzMzYpByTlpbVjLe+HTO4KhV1slRHx/o=
X-Gm-Gg: AZuq6aKeumxhqXh99sN1VH9nBFmx9DdqCkdgueJw7UOb5xMEQnAlsi/5ZUmd7osl5jM
	3lsRLl5Lj/WmeFDcYRwFmdZnFnxBQV2MPylhjA7oHjugV4UbZ/vyzrxcsIYYb4Z85jtwRUIurWN
	j/eIn5ttgA9EAlyHTXXWT3qm5FYBSE5e3qgPdGWH5g29Kn+c3DOLuRmemAefHDg4GwmREZqpDyu
	Y8q8HsTqYjGDH2NT+NxOpUyQsqD4aVq3SihYrik10gwLgjZmYIiJKRZgrKT2f6bh54XRxS1jl68
	Dxv2zqk3hrn0rvnh+uBDpRAWKakfqoSy3nhvGCfI1GR3FPTrf05usr+i76rVLrlltyzsK33zN1A
	bWO4FEpWP2yC4amyPzHlm2q8HtNPKcjb2iQALZ6uUYV3fhblb8CEFpuzs+URUTRMYh2AE0J2Oel
	Q+a3OT5YBbN/LuCwxO
X-Received: by 2002:a5d:5e01:0:b0:432:c37c:d83b with SMTP id ffacd0b85a97d-436296590a0mr4325393f8f.20.1770385254516;
        Fri, 06 Feb 2026 05:40:54 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296b25casm6293951f8f.4.2026.02.06.05.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 05:40:54 -0800 (PST)
Date: Fri, 6 Feb 2026 16:40:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alain Volmat <alain.volmat@foss.st.com>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: [bug report] spi: stm32: properly fail on dma_request_chan error
Message-ID: <aYXvY6NH7OlZ-OAF@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>

[ Smatch checking is paused while we raise funding.  #SadFace
  https://lore.kernel.org/all/aTaiGSbWZ9DJaGo7@stanley.mountain/ -dan ]

Hello Alain Volmat,

Commit c266d19b7d4e ("spi: stm32: properly fail on dma_request_chan
error") from Dec 18, 2025 (linux-next), leads to the following Smatch
static checker warning:

	drivers/spi/spi-stm32.c:2578 stm32_spi_probe()
	error: 'spi->dma_rx' dereferencing possible ERR_PTR()

drivers/spi/spi-stm32.c
    2480         if (STM32_SPI_DEVICE_MODE(spi))
    2481                 ctrl->target_abort = stm32h7_spi_device_abort;
    2482 
    2483         spi->dma_tx = dma_request_chan(spi->dev, "tx");
    2484         if (IS_ERR(spi->dma_tx)) {
    2485                 ret = PTR_ERR(spi->dma_tx);
    2486                 if (ret == -ENODEV) {
    2487                         dev_info(&pdev->dev, "tx dma disabled\n");
    2488                         spi->dma_tx = NULL;
    2489                 } else {
    2490                         dev_err_probe(&pdev->dev, ret, "failed to request tx dma channel\n");
    2491                         goto err_clk_disable;
    2492                 }
    2493         } else {
    2494                 ctrl->dma_tx = spi->dma_tx;
    2495         }
    2496 
    2497         spi->dma_rx = dma_request_chan(spi->dev, "rx");
    2498         if (IS_ERR(spi->dma_rx)) {
    2499                 ret = PTR_ERR(spi->dma_rx);
    2500                 if (ret == -ENODEV) {
    2501                         dev_info(&pdev->dev, "rx dma disabled\n");
    2502                         spi->dma_rx = NULL;
    2503                 } else {
    2504                         dev_err_probe(&pdev->dev, ret, "failed to request rx dma channel\n");
    2505                         goto err_dma_release;

spi->dma_rx is an erorr pointer at this goto so it will crash.

    2506                 }
    2507         } else {
    2508                 ctrl->dma_rx = spi->dma_rx;
    2509         }
    2510 
    2511         if (spi->dma_tx || spi->dma_rx)
    2512                 ctrl->can_dma = stm32_spi_can_dma;
    2513 
    2514         spi->sram_pool = of_gen_pool_get(pdev->dev.of_node, "sram", 0);
    2515         if (spi->sram_pool) {
    2516                 spi->sram_rx_buf_size = gen_pool_size(spi->sram_pool);
    2517                 dev_info(&pdev->dev, "SRAM pool: %zu KiB for RX DMA/MDMA chaining\n",
    2518                          spi->sram_rx_buf_size / 1024);
    2519                 spi->sram_rx_buf = gen_pool_dma_zalloc(spi->sram_pool, spi->sram_rx_buf_size,
    2520                                                        &spi->sram_dma_rx_buf);
    2521                 if (!spi->sram_rx_buf) {
    2522                         dev_err(&pdev->dev, "failed to allocate SRAM buffer\n");
    2523                 } else {
    2524                         spi->mdma_rx = dma_request_chan(spi->dev, "rxm2m");
    2525                         if (IS_ERR(spi->mdma_rx)) {
    2526                                 ret = PTR_ERR(spi->mdma_rx);
    2527                                 spi->mdma_rx = NULL;
    2528                                 if (ret == -EPROBE_DEFER) {
    2529                                         goto err_pool_free;
    2530                                 } else {
    2531                                         gen_pool_free(spi->sram_pool,
    2532                                                       (unsigned long)spi->sram_rx_buf,
    2533                                                       spi->sram_rx_buf_size);
    2534                                         dev_warn(&pdev->dev,
    2535                                                  "failed to request rx mdma channel, DMA only\n");
    2536                                 }
    2537                         }
    2538                 }
    2539         }
    2540 
    2541         pm_runtime_set_autosuspend_delay(&pdev->dev,
    2542                                          STM32_SPI_AUTOSUSPEND_DELAY);
    2543         pm_runtime_use_autosuspend(&pdev->dev);
    2544         pm_runtime_set_active(&pdev->dev);
    2545         pm_runtime_get_noresume(&pdev->dev);
    2546         pm_runtime_enable(&pdev->dev);
    2547 
    2548         ret = spi_register_controller(ctrl);
    2549         if (ret) {
    2550                 dev_err(&pdev->dev, "spi controller registration failed: %d\n",
    2551                         ret);
    2552                 goto err_pm_disable;
    2553         }
    2554 
    2555         pm_runtime_put_autosuspend(&pdev->dev);
    2556 
    2557         dev_info(&pdev->dev, "driver initialized (%s mode)\n",
    2558                  STM32_SPI_HOST_MODE(spi) ? "host" : "device");
    2559 
    2560         return 0;
    2561 
    2562 err_pm_disable:
    2563         pm_runtime_disable(&pdev->dev);
    2564         pm_runtime_put_noidle(&pdev->dev);
    2565         pm_runtime_set_suspended(&pdev->dev);
    2566         pm_runtime_dont_use_autosuspend(&pdev->dev);
    2567 
    2568         if (spi->mdma_rx)
    2569                 dma_release_channel(spi->mdma_rx);
    2570 err_pool_free:
    2571         if (spi->sram_pool)
    2572                 gen_pool_free(spi->sram_pool, (unsigned long)spi->sram_rx_buf,
    2573                               spi->sram_rx_buf_size);
    2574 err_dma_release:
    2575         if (spi->dma_tx)
    2576                 dma_release_channel(spi->dma_tx);
    2577         if (spi->dma_rx)
--> 2578                 dma_release_channel(spi->dma_rx);
                                             ^^^^^^^^^^^
Here.

    2579 err_clk_disable:
    2580         clk_disable_unprepare(spi->clk);
    2581 
    2582         return ret;
    2583 }

regards,
dan carpenter
