Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59A939E6E0
	for <linux-spi@vger.kernel.org>; Sat,  7 Mar 2026 13:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772888902; cv=none; b=cnp/FTIMcAMJ8tAUOF/kpHl4t4jL45cnLmMXoXsbwAMK6UsiZCNDVlN0KAECLd7WzrmMOAzGr4VKIIb04DxEZw/nwT5oQqU89lyFlwSaQjIqFnICq7W+xu3JAKQxiw/H/YH1LvbWo2G5UC4E9DNl6FVGN7r139fSAcTlQcHyRMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772888902; c=relaxed/simple;
	bh=6ZueMwC5TQvpvKLpbqMnKp8v4IHcY2ATl0BWBsjdG24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uAFBlvpb9/T5yR5jCtvk+OQGwBZ1d9R7Ee+FO53Z7+LBWQ9imISpsKpYB8ni7a1JmkEtCzNv9gfR1xNIWsWHWOvfgJgyJaptQoWFBHvPGoVkw3T8OVSm6ck+rESQsOqQP42XhXrbxQyo1ybHrdG64j9yl7BNbpASBC0RRgxZkkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=uDEWI0PM; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="uDEWI0PM"
Received: from eig-obgw-5004b.ext.cloudfilter.net ([10.0.29.208])
	by cmsmtp with ESMTPS
	id yqKEvZbtLKjfoyrOGv5Hmn; Sat, 07 Mar 2026 13:08:20 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id yrO9vUcS8qfpWyrO9vOrpQ; Sat, 07 Mar 2026 13:08:13 +0000
X-Authority-Analysis: v=2.4 cv=A55sP7WG c=1 sm=1 tr=0 ts=69ac2344
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=7vwVE5O1G3EA:10 a=VwQbUJbxAAAA:8
 a=HaFmDPmJAAAA:8 a=4SagQa6AY7hvVoN6pvcA:9 a=QEXdDO2ut3YA:10
 a=nmWuMzfKamIsx3l42hEX:22 a=L5EjiQpGQaFGZdqT14z7:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ARXowE8k1fH/dnVCY7yvpHlIGYpIl/GW5K2hyx6Xi8c=; b=uDEWI0PMvf0ZPhN9BX1BAk92to
	0Jz+fJEHMZtTwbZ5GYjxot6hjqRQL4nDJX0/TA4pZ4NVAoo38jow57mBfJ/W79ymJUIYS2IY8Oxsd
	aFaHqrqia8AqvW1DD3kNWOFvDJ5PoQ4jcjItQy1Eq6ZMeytubvtQFn64LnYgypYbsRKonUKL8AEss
	Z9Yjq83Pd2L5NDcr3xjyNIp67S+v8EjXqIChtfAf4/OS/4t4RE4XO/w90nhBaRe2Joc/NBVEyX9ey
	wR8UUeNNVc2IK6lvp24EpcbnHbGEtC3bVovj6a0AfJbx0myhT7iBgPCn3eeoc15ZhV3JXq3UQBoTr
	/wrgkPSQ==;
Received: from c-73-162-206-103.hsd1.ca.comcast.net ([73.162.206.103]:33810 helo=[10.0.1.180])
	by box5620.bluehost.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <re@w6rz.net>)
	id 1vyrO8-00000000Zji-0t9k;
	Sat, 07 Mar 2026 06:08:12 -0700
Message-ID: <a2cc3687-7814-4f63-83d8-6ca731eb5e4d@w6rz.net>
Date: Sat, 7 Mar 2026 05:08:10 -0800
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: cadence-qspi: Fix requesting of APB and AHB clocks
 on JH7110
To: Mark Brown <broonie@kernel.org>,
 "Miquel Raynal (Schneider Electric)" <miquel.raynal@bootlin.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260307-spi-cadence-qspi-fix-jh7110-v1-1-c9f37b8c58b1@kernel.org>
Content-Language: en-US
From: Ron Economos <re@w6rz.net>
In-Reply-To: <20260307-spi-cadence-qspi-fix-jh7110-v1-1-c9f37b8c58b1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 73.162.206.103
X-Source-L: No
X-Exim-ID: 1vyrO8-00000000Zji-0t9k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-73-162-206-103.hsd1.ca.comcast.net ([10.0.1.180]) [73.162.206.103]:33810
X-Source-Auth: re@w6rz.net
X-Email-Count: 2
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfM3uhHotm5zHgbfsIkiBmVHHkh9KuwgqeLGu/SlxRCn6bpmj/ueaFgL8koFcxTSlTCMMncjAdyrzzv8XhLBNnPfW1aaphX0e7Z07euoMlNyOarGfc3L1
 d+68uo6HGOx261PZBQyTObQT9eB5nqjIB+VFWoPyewQ4onHac6CauhpIn58u+DleEIWm6JBnWjsyQWdt3EXgFLCcJ5F46tDgIc4=

On 3/7/26 01:50, Mark Brown wrote:
> The move of the AHB and APB clocks from a JH7110 specific quirk to the
> main clock init dropped the specification of the clock names to request
> for the AHB and APB clocks, resulting in the clock framework requesting
> a clock with a NULL name three times.  On most platforms where the
> clocks are physically the same or some are always on this makes no
> difference but the reason we had the specific quirk for JH7110 is that
> it does actually have separate, controllable clocks.  Update the new
> code to request the AHB and APB clocks by name to restore the original
> behaviour on JH7110.
>
> Fixes: 324ecc7788c2 ("spi: cadence-qspi: Kill cqspi_jh7110_clk_init")
> Reported-by: Ron Economos <re@w6rz.net>
> Closes: https://lore.kernel.org/r/a3ca5e9b-7446-497e-8df2-7ef2b42a02e9@w6rz.net
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   drivers/spi/spi-cadence-quadspi.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
> index 649ff55333f0..5fb0cb07c110 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -76,6 +76,11 @@ struct cqspi_flash_pdata {
>   	u8		cs;
>   };
>   
> +static const struct clk_bulk_data cqspi_clks[CLK_QSPI_NUM] = {
> +	[CLK_QSPI_APB] = { .id = "apb" },
> +	[CLK_QSPI_AHB] = { .id = "ahb" },
> +};
> +
>   struct cqspi_st {
>   	struct platform_device	*pdev;
>   	struct spi_controller	*host;
> @@ -1823,6 +1828,7 @@ static int cqspi_probe(struct platform_device *pdev)
>   	}
>   
>   	/* Obtain QSPI clocks. */
> +	memcpy(&cqspi->clks, &cqspi_clks, sizeof(cqspi->clks));
>   	ret = devm_clk_bulk_get_optional(dev, CLK_QSPI_NUM, cqspi->clks);
>   	if (ret)
>   		return dev_err_probe(dev, ret, "Failed to get clocks\n");
>
> ---
> base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
> change-id: 20260306-spi-cadence-qspi-fix-jh7110-608e79a09d15
>
> Best regards,
> --
> Mark Brown <broonie@kernel.org>

Tested-by: Ron Economos <re@w6rz.net>

