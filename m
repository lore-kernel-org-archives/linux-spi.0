Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357E8C433B4
	for <linux-spi@archiver.kernel.org>; Tue, 18 May 2021 14:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 086DC611CC
	for <linux-spi@archiver.kernel.org>; Tue, 18 May 2021 14:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhEROia (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 18 May 2021 10:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbhEROia (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 18 May 2021 10:38:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17104C061573;
        Tue, 18 May 2021 07:37:12 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 8815F1F42F11;
        Tue, 18 May 2021 15:37:10 +0100 (BST)
Date:   Tue, 18 May 2021 16:37:07 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     <patrice.chotard@foss.st.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <christophe.kerello@foss.st.com>
Subject: Re: [PATCH v4 3/3] spi: stm32-qspi: add automatic poll status
 feature
Message-ID: <20210518163707.0e6bd120@collabora.com>
In-Reply-To: <20210518134332.17826-4-patrice.chotard@foss.st.com>
References: <20210518134332.17826-1-patrice.chotard@foss.st.com>
        <20210518134332.17826-4-patrice.chotard@foss.st.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, 18 May 2021 15:43:32 +0200
<patrice.chotard@foss.st.com> wrote:

> +static int stm32_qspi_poll_status(struct spi_mem *mem, const struct spi_mem_op *op,
> +				  u16 mask, u16 match,
> +				  unsigned long initial_delay_us,
> +				  unsigned long polling_rate_us,
> +				  unsigned long timeout_ms)
> +{
> +	struct stm32_qspi *qspi = spi_controller_get_devdata(mem->spi->master);
> +	int ret;
> +

The spi_mem_supports_op() call is still missing.

> +	ret = pm_runtime_get_sync(qspi->dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(qspi->dev);
> +		return ret;
> +	}
> +
> +	mutex_lock(&qspi->lock);
> +
> +	writel_relaxed(mask, qspi->io_base + QSPI_PSMKR);
> +	writel_relaxed(match, qspi->io_base + QSPI_PSMAR);
> +	qspi->fmode = CCR_FMODE_APM;
> +	qspi->status_timeout = timeout_ms;
> +
> +	ret = stm32_qspi_send(mem, op);
> +	mutex_unlock(&qspi->lock);
> +
> +	pm_runtime_mark_last_busy(qspi->dev);
> +	pm_runtime_put_autosuspend(qspi->dev);
> +
> +	return ret;
> +}
