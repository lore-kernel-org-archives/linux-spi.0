Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B07D3B8D46;
	Wed,  4 Feb 2026 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770198707; cv=none; b=f70RtcNS290hKheYsmRZOoJjahm8deaCF1x1hxSszyJ8BkgFSJhj93wazK5Qfa3SBAtIDsdUVHKLjPteshjhd2R7G4gJ1lHPd3bb0dnTmiEojvVFt7Qh/Dn09oyazuuo3j2T5qvIRqS1ZlXvRjmcLknMjxWcSxyx/729crG/0SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770198707; c=relaxed/simple;
	bh=SOv3O413mHtdS43oewVVfmQ5gJEc8/SvynJ2iIQJ87w=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8ZNmOSx4lnaOKULLQyqUpsCLbNdjSr9nnpwIQgKMxFst0ipkSiKCfh3P8479/fiWR0ATVxPxR278k598FYgfIoIfL235VN8uX5QRbr3TMzorVK8fZEVugkUoYceLlMwAT0DtUCLt+AECOzGflj1nMDDlcUEsk7v2r14Nz64QKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f5bFp56H3zJ46cs;
	Wed,  4 Feb 2026 17:50:54 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 88AE840569;
	Wed,  4 Feb 2026 17:51:43 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Feb
 2026 09:51:42 +0000
Date: Wed, 4 Feb 2026 09:51:41 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Abdurrahman Hussain via B4 Relay
	<devnull+abdurrahman.nexthop.ai@kernel.org>
CC: <abdurrahman@nexthop.ai>, Mark Brown <broonie@kernel.org>, Michal Simek
	<michal.simek@amd.com>, <linux-spi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] spi: xilinx: use device property accessors.
Message-ID: <20260204095141.0000479a@huawei.com>
In-Reply-To: <20260203-spi-xilinx-v4-1-42f7c326061b@nexthop.ai>
References: <20260203-spi-xilinx-v4-1-42f7c326061b@nexthop.ai>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100010.china.huawei.com (7.191.174.197) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Tue, 03 Feb 2026 01:55:12 +0000
Abdurrahman Hussain via B4 Relay <devnull+abdurrahman.nexthop.ai@kernel.org> wrote:

> From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> 
> Switch to device property accessors.
> 
> Signed-off-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
> ---
> Switch to generic device property accessors.
> 
> 2.52.0
> 
> base-commit: 944aacb68baf7624ab8d277d0ebf07f025ca137c
> ---
> Changes in v4:
> - Removed patches making the irq optional.
> - Link to v3: https://lore.kernel.org/r/20260122-spi-xilinx-v3-1-8cea20e82f0b@nexthop.ai
> ---
>  drivers/spi/spi-xilinx.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
> index c86dc56f38b4..c4b70e95b695 100644
> --- a/drivers/spi/spi-xilinx.c
> +++ b/drivers/spi/spi-xilinx.c
> @@ -405,11 +405,11 @@ static int xilinx_spi_probe(struct platform_device *pdev)
>  		bits_per_word = pdata->bits_per_word;
>  		force_irq = pdata->force_irq;
>  	} else {
> -		of_property_read_u32(pdev->dev.of_node, "xlnx,num-ss-bits",
> -					  &num_cs);
> -		ret = of_property_read_u32(pdev->dev.of_node,
> -					   "xlnx,num-transfer-bits",
> -					   &bits_per_word);
> +		device_property_read_u32(&pdev->dev, "xlnx,num-ss-bits",
> +					 &num_cs);
> +		ret = device_property_read_u32(&pdev->dev,

Nothing useful is done with ret after this point, so could simplify to
the pattern of setting the default then overriding it if the property
can be successfully read.

		bits_per_word = 8;
		device_property_read_u32(&pdev->dev,
					 "xlnx,num-transfer-bits",
					 &bits_per_word);

> +					       "xlnx,num-transfer-bits",
> +					       &bits_per_word);
>  		if (ret)
>  			bits_per_word = 8;
>  	}
> 
> ---
> base-commit: 944aacb68baf7624ab8d277d0ebf07f025ca137c
> change-id: 20260118-spi-xilinx-1b884d5b6519
> 
> Best regards,

