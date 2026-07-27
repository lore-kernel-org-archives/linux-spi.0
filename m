Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7640537DEBC;
	Mon, 27 Jul 2026 06:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785132589; cv=none; b=c+wGR2J+0tK2uc19Fm5vKl5w0QAOkF3EI4ConUEJBsB4LWvtqflo4j0QMOy2Lam5soQ3F21EzPSXzoVpZlAqj7DtsWyI/nG2iQaxu/1qA0ttSXyvLRDtkR8IpiBQ7xhw/VinukHwTQ5ykuxLI82hnW0J/eOzABBSulOTlTfOAbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785132589; c=relaxed/simple;
	bh=hzjTysOwMf9WSqZ7u4gmSkdBdhONZEo7O4je3BPbIXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZVUcxhxwNa34MQ/ZEJ0xVobYNwr2VdDOOJ2C1hWVbwt71ViyhKnG4ibU3HUi4VNnNI9VN84Lb4Qledq1mnqOAoxbjNJ3pnOB/EQOxSvzSpiV8OyXSqeK5xUzfZFjcaREybye7LUbm/YNWbqbdxuGMrajNbW4uSz6L1aIzmTI+Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=v4PWOlNq; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="v4PWOlNq"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785132576; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BZ3FVnxTZf60992ChwBb5YGnWOioAt2Y8n8O1GL9p7M=;
	b=v4PWOlNqB3xTsZmUR71u8jAuvKR7sKiEFR/644yA5LiGl8hyC+tqaAHXt1BcBGHx8K29e1ESr0/CWQYJLEyPG8scHnL7ZQvtyiYRUtAYRXUK8f0LSX/bA+4n+MmmpPwZnGwPoBca0YHG93/kxjrVroQpmw4MK2BYewDG8bvEsag=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X7qPkgI_1785132575;
Received: from 30.74.144.127(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X7qPkgI_1785132575 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 27 Jul 2026 14:09:36 +0800
Message-ID: <7792d078-f80e-42f4-9217-190ef5fb8573@linux.alibaba.com>
Date: Mon, 27 Jul 2026 14:09:35 +0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: sprd-adi: Fix probe succeeding without registering
 the controller
To: Babanpreet Singh <bbnpreetsingh@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260726072221.7-1-bbnpreetsingh@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260726072221.7-1-bbnpreetsingh@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/26/26 3:22 PM, Babanpreet Singh wrote:
> With CONFIG_HWSPINLOCK=n the of_hwspin_lock_get_id() stub returns 0
> unconditionally. In sprd_adi_probe() the guard
> 
> 	if (ret > 0 || (IS_ENABLED(CONFIG_HWSPINLOCK) && ret == 0))
> 
> is false for that 0, so it takes the else branch, where the switch has no
> case for 0 and lands in
> 
> 	default:
> 		return dev_err_probe(&pdev->dev, ret, "failed to find hwlock id\n");
> 
> dev_err_probe() returns its err argument unchanged, so probe logs
> "failed to find hwlock id" and then returns 0, reporting success.
> sprd_adi_hw_init(), the restart handler and devm_spi_register_controller()
> are all skipped: the device binds but no SPI controller is ever
> registered. Since the stub is a constant-returning static inline, the
> compiler folds the whole remainder of probe away as dead code - an
> object built in that configuration contains no reference to
> devm_spi_register_controller() at all.
> 
> The hardware spinlock is optional for this controller and the -ENOENT arm
> already covers "no hardware spinlock supplied". Treat the stub's 0 the
> same way and continue without a lock; all four users of sadi->hwlock
> already test it for NULL.
> 
> This is not reachable on production kernels. Kconfig has
> 
> 	depends on HWSPINLOCK || (COMPILE_TEST && !HWSPINLOCK)
> 
> so the affected configuration exists only under COMPILE_TEST, where no
> real hardware is present. Object code for CONFIG_HWSPINLOCK=y builds is
> byte-identical before and after this change.
> 
> Found by smatch:
> drivers/spi/spi-sprd-adi.c:560 sprd_adi_probe() warn: passing zero to 'dev_err_probe'
> 
> Fixes: f9adf61e983f ("spi: sprd: adi: Change hwlock to be optional")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
> ---
>   drivers/spi/spi-sprd-adi.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
> index e7d83c16b46c..7c29115c5b8b 100644
> --- a/drivers/spi/spi-sprd-adi.c
> +++ b/drivers/spi/spi-sprd-adi.c
> @@ -553,6 +553,11 @@ static int sprd_adi_probe(struct platform_device *pdev)
>   			return -ENXIO;
>   	} else {
>   		switch (ret) {
> +		case 0:
> +			/*
> +			 * Only reachable with CONFIG_HWSPINLOCK=n, where the
> +			 * of_hwspin_lock_get_id() stub returns 0.
> +			 */

Please add a 'fallthrough' here. With that, you can add:

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

>   		case -ENOENT:
>   			dev_info(&pdev->dev, "no hardware spinlock supplied\n");
>   			break;

