Received: from smtp153-171.sina.com.cn (smtp153-171.sina.com.cn [61.135.153.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4703F39FD4
	for <linux-spi@vger.kernel.org>; Thu,  5 Mar 2026 04:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772684290; cv=none; b=JONew8JKmfWy9EY6Ow7GioIWuHMBGYBx6Hcy+eEX3O1F9dhyjf86YFNfqEecFZ2yHL/7Kwz104R5gyryZkNOaYpfILT1roYagRV5+H29o7hd9s29pKfZzXR4sFgYB7biUAKatAGCn4gKN4HDBwbco31Gk0uCOoEVmYUJI5Glw0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772684290; c=relaxed/simple;
	bh=favTZIXJG2CWfU8yJO7xDQZzhjWmYDKLlH8+aO6MbrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mHbUwYAcShR+xskKV6KKS+E4A7Rn6712piZ7PGNiuBajF7i18gkKjXAil1m9w3O/YnSv+gA2/6GR/hX52H0Jesrv2tY+LaX5ErnGuzVgZls5biT5YE+T3fRLuwzcGtrG2Fj4vXc8hjF5dvveFUQAXpl4kEpX7nFBZ0dJz0q2NB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=CCI8oIzs; arc=none smtp.client-ip=61.135.153.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="CCI8oIzs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1772684284;
	bh=Npl5WUvYNLpW63TPWsVH+5F7JvbCkleBCD6qiZ+HkMQ=;
	h=From:Subject:Date:Message-ID;
	b=CCI8oIzs5zxwCvA4XN4QE1EJRRRnme4+PNtvYfewUiuqTwPy3jesCnK4S+TD9oBfe
	 FHptUIOAtOzO2P2DKihAeo0rB6xytFwZ+5am2gSbc6uYdHEN9HslrSuFU1wdM2k+ok
	 eCTy89eZY8c1LsAeS7ZjbGpi57VhWJJjNWFeefMg=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.34) with ESMTP
	id 69A903F100004C36; Thu, 5 Mar 2026 12:17:55 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 1762856292029
X-SMAIL-UIID: CC3245C390534F6C92739127E4A831DF-20260305-121755-1
From: Hillf Danton <hdanton@sina.com>
To: Felix Gu <ustc.gu@gmail.com>
Cc: Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] spi: nxp-fspi: Use reinit_completion() for repeated operations
Date: Thu,  5 Mar 2026 12:17:45 +0800
Message-ID: <20260305041746.657-1-hdanton@sina.com>
In-Reply-To: <20260304-spi-nxp-v2-2-cd7d7726a27e@gmail.com>
References: <20260304-spi-nxp-v2-0-cd7d7726a27e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 04 Mar 2026 20:47:20 +0800 Felix Gu wrote:
> The driver currently calls init_completion() during every spi_mem_op.
> Tchnically it may work, but it's not the recommended pattern.
> 
> According to the kernel documentation: Calling init_completion() on
> the same completion object twice is most likely a bug as it
> re-initializes the queue to an empty queue and enqueued tasks
> could get "lost" - use reinit_completion() in that case, but be
> aware of other races.
> 
> So moves the initial initialization to probe function and uses
> reinit_completion() for subsequent operations.
> 
> Fixes: a5356aef6a90 ("spi: spi-mem: Add driver for NXP FlexSPI controller")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>  drivers/spi/spi-nxp-fspi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
> index 320b3d93df57..1e36ae084dd8 100644
> --- a/drivers/spi/spi-nxp-fspi.c
> +++ b/drivers/spi/spi-nxp-fspi.c
> @@ -996,7 +996,7 @@ static int nxp_fspi_do_op(struct nxp_fspi *f, const struct spi_mem_op *op)
>  	reg = reg | FSPI_IPRXFCR_CLR;
>  	fspi_writel(f, reg, base + FSPI_IPRXFCR);
>  
> -	init_completion(&f->c);
> +	reinit_completion(&f->c);
>  
>  	fspi_writel(f, op->addr.val, base + FSPI_IPCR0);
>  	/*
> @@ -1365,6 +1365,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "Failed to disable clock");
>  
> +	init_completion(&f->c);
>  	ret = devm_request_irq(dev, irq,
>  			nxp_fspi_irq_handler, 0, pdev->name, f);
>  	if (ret)
> 
> -- 
> 2.43.0
> 
After this work relevant code in nxp_fspi_exec_op() looks like

	guard(mutex)(&f->lock);
	nxp_fspi_do_op()
	  reinit_completion(&f->c);
	  /* Wait for the interrupt. */
	  if (!wait_for_completion_timeout(&f->c, msecs_to_jiffies(1000)))
		err = -ETIMEDOUT;

and if __no__ interrupt could fire after the 1000ms timeout, no reinit is
needed at all. Otherwise reinit alone fails to work.

Important is -- show the evidence that no chance is left for the timeout.

BTW the same applies to other patches in this series?
