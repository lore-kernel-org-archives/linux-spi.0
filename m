Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2F5C4167B
	for <linux-spi@archiver.kernel.org>; Sat, 12 Dec 2020 12:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 816E8230F9
	for <linux-spi@archiver.kernel.org>; Sat, 12 Dec 2020 12:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438835AbgLLMGw (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Sat, 12 Dec 2020 07:06:52 -0500
Received: from bmailout2.hostsharing.net ([83.223.78.240]:52445 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390904AbgLLMGv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sat, 12 Dec 2020 07:06:51 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id A8B682800A287;
        Sat, 12 Dec 2020 13:05:48 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 2758D110C0; Sat, 12 Dec 2020 13:06:08 +0100 (CET)
Date:   Sat, 12 Dec 2020 13:06:08 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, broonie@kernel.org,
        bbrezillon@kernel.org, p.yadav@ti.com, tudor.ambarus@microchip.com,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/9] spi: tegra210-quad: Add support for Tegra210 QSPI
 controller
Message-ID: <20201212120608.GA24303@wunner.de>
References: <1607721363-8879-1-git-send-email-skomatineni@nvidia.com>
 <1607721363-8879-5-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607721363-8879-5-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Dec 11, 2020 at 01:15:58PM -0800, Sowjanya Komatineni wrote:
> Tegra SoC has a Quad SPI controller starting from Tegra210.

The probe/remove hooks LGTM now.  Just two tiny nits that caught my eye:


> +	master = devm_spi_alloc_master(&pdev->dev, sizeof(*tqspi));
> +	if (!master) {
> +		dev_err(&pdev->dev, "failed to allocate spi_master\n");
> +		return -ENOMEM;
> +	}

The memory allocater already emits an error message if it can't satisfy
a request.  Emitting an additional message here isn't really necessary.


> +exit_free_irq:
> +	free_irq(qspi_irq, tqspi);
> +exit_pm_disable:
> +	pm_runtime_disable(&pdev->dev);
> +	tegra_qspi_deinit_dma(tqspi);
> +	return ret;
> +}
> +
> +static int tegra_qspi_remove(struct platform_device *pdev)
> +{
> +	struct spi_master *master = platform_get_drvdata(pdev);
> +	struct tegra_qspi *tqspi = spi_master_get_devdata(master);
> +
> +	spi_unregister_master(master);
> +	free_irq(tqspi->irq, tqspi);
> +	tegra_qspi_deinit_dma(tqspi);
> +	pm_runtime_disable(&pdev->dev);

The order of tegra_qspi_deinit_dma() and pm_runtime_disable() is
reversed in the remove hook vis-a-vis the probe error path.
It's nicer to use the same order as in the probe error path.

Thanks,

Lukas
