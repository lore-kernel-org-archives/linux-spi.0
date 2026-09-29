Received: from mail-m12777.qiye.163.com (mail-m12777.qiye.163.com [115.236.127.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49F8EECB;
	Tue, 29 Sep 2026 02:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.236.127.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790650637; cv=none; b=YHMjDt8l0ootpj4m+Le+To6CyodmTer3EKg5SxF2VSP2IAH4Sz+Cm3i4B6V5RcIDnw/nLBh2fRh6rLND96v0af7SfA9iNzRfeeouYIpMlADuWuMQlqbelR/50WHYITvv56N3a/K2fY3uxFcs0mn5YbYb5SvocUbNZOGFqBLRSJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790650637; c=relaxed/simple;
	bh=dX5g2A8dNRLCfKqimnnMsqEhqM1vaEuZCIlZar6YfAY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ebLPrZ36hTG4QL5ufV8zR5aqUC8WTPOUDnYQ7XLn6KEbXUrbJBdjbd9RWxQdkNDY/NadAXq4lWVFjMLBcpnlY2Yx81aZrjqYukCxqg5bfwZbxgDY7Dk4YxQILGAuAFtqXg+zrqSG0sxLJYxFYjgiTLNQZC1+SjAO+Y6IRE7PoTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=b0Nmn4A2; arc=none smtp.client-ip=115.236.127.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="b0Nmn4A2"
Received: from [172.16.12.48] (unknown [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f6d2dccf;
	Tue, 29 Sep 2026 10:21:32 +0800 (GMT+08:00)
Message-ID: <23589ca5-7b7e-4f0a-8da7-1cd8ca8cdc6e@rock-chips.com>
Date: Tue, 29 Sep 2026 10:21:31 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linusw@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 jon.lin@rock-chips.com, bcm-kernel-feedback-list@broadcom.com,
 noltari@gmail.com
Subject: Re: [PATCH 2/3] spi: rockchip-sfc: Clean up runtime PM on remove
To: Guangshuo Li <lgs201920130244@gmail.com>, broonie@kernel.org,
 heiko@sntech.de, william.zhang@broadcom.com, kursad.oney@broadcom.com,
 jonas.gorski@gmail.com
References: <20260924112329.1566051-1-lgs201920130244@gmail.com>
 <20260924112329.1566051-3-lgs201920130244@gmail.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <20260924112329.1566051-3-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0eaf7a0ba03a4kunm3f316cb87f1ea3
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSk9CVh9NQk1NGk8fHx1OTFYVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
	9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=b0Nmn4A2L3sB7JXXDYNJoZwkmkRNQshPXshO1PivLsRYoBKNfmCpAX4c41WhmHiA0V3vSIAX9UViYpiGG1X/sPsl25P7DD6NNfhtT2G05ZEkmQX+3/LTlPQGKQ4gWt5eINnmjHlEtJlDI4xXqGRHli26/2zelrE9jjcj0uhCTt4=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=608TxoAcsSFja39GdQX5iExTG94VTDqd7cjXZfeJR4s=;
	h=date:mime-version:subject:message-id:from;

Hi Guangshuo

在 2026/09/24 星期四 19:23, Guangshuo Li 写道:
> rockchip_sfc_probe() enables runtime PM and autosuspend before registering
> the controller. After a successful probe, rockchip_sfc_remove() tears down
> the controller and clocks without undoing that runtime PM setup.
> 
> The probe error path resumes the device, drops the temporary usage count,
> disables runtime PM, marks the device suspended, and stops using
> autosuspend before disabling the clocks. The remove path lacks this
> matching cleanup.
> 
> Mirror the existing error-path sequence in rockchip_sfc_remove() before
> disabling the clocks.
> 

Thanks for this patch. However, it was fixed, see:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=34e32e9ade58e32daf933974c9b697d066fc5aaa

> Fixes: 8011709906d0 ("spi: rockchip-sfc: Support pm ops")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>   drivers/spi/spi-rockchip-sfc.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/spi/spi-rockchip-sfc.c b/drivers/spi/spi-rockchip-sfc.c
> index 662a994da60b..6e1c7d6318bb 100644
> --- a/drivers/spi/spi-rockchip-sfc.c
> +++ b/drivers/spi/spi-rockchip-sfc.c
> @@ -747,6 +747,12 @@ static void rockchip_sfc_remove(struct platform_device *pdev)
>   			 DMA_BIDIRECTIONAL);
>   	free_pages((unsigned long)sfc->buffer, get_order(sfc->max_iosize));
>   
> +	pm_runtime_get_sync(&pdev->dev);
> +	pm_runtime_put_noidle(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +	pm_runtime_set_suspended(&pdev->dev);
> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
> +
>   	clk_disable_unprepare(sfc->clk);
>   	clk_disable_unprepare(sfc->hclk);
>   }

