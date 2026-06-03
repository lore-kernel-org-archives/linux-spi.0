Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF91034404A
	for <linux-spi@vger.kernel.org>; Wed,  3 Jun 2026 11:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780485577; cv=none; b=VV410Abib8ESPxpjWt4xMmhNvhS6uePtaJhmnPhmHnGy95YFWCvWiJsvDIJE7iCkrzVisLKiIOhaGZc5tM8yXBWl+86vk7ZvQcD4awuuLi1rha/kbtPEnVz1rKE1STwRy9Ggp1o5l/TAnoDOTYRQ9iRoDj9jMuR4U1jKd8XSYB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780485577; c=relaxed/simple;
	bh=kZoUTfsDT+RfT9JubWcPrDJcSQyFYJpzaANhbfZqFts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pA+DZYZDWfBi9hvgdeeEzPeguLBfW2WMAasSqLtuID8ot5/riJRu6owIRtoQQWe63tbqVyksqsXHOYdQKh/2WpwYGA4mCnhQF3AkNlMaclz0qkOwYP/XAHsZAdJa5U4QggDhlk0G+QjXilXML2an3iWLjhH/rr8f+KnpGUNEeEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P4+I5Msv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dE633e0M; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P4+I5Msv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dE633e0M"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6536RJNW380273
	for <linux-spi@vger.kernel.org>; Wed, 3 Jun 2026 11:19:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vCOLHvwV3YQ3YkFnuUfmclvlWehtJAlfoI/KL/kihbE=; b=P4+I5Msv3LWbf+y3
	KtTjVVbUB0Ud1TC8oaSnUQaLwrQVemJZL6Viq1WS9y176RAqyeoG9rPuZuX0zMqd
	CyN7VNWt7sl57aPK5H6ZVUQjL5eyF9qJtZi3RqkXdbmRzj5lhGyUU1y4FJnHriq4
	c4IhzNSlUwOOUTspkM9yn4kpZAmVHY/aKSJ3/W3At9kgADxfT6E2Y5m7EEGe9HAV
	rrGSr4mUIXQidUBRlGpWFBapLq8aZVew7z1ig/HHdZYe3hTQbNSY+5YiiXQaWRYU
	eCec/DIAIHY0n7n+IP6ITLhfo391i81UzrNL/qMOUD5Ki2Wc7tZPF7OHxM+6kwrV
	vWBiPQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejewhs7dv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 03 Jun 2026 11:19:35 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2bd04e4fe3dso199766965ad.3
        for <linux-spi@vger.kernel.org>; Wed, 03 Jun 2026 04:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780485574; x=1781090374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vCOLHvwV3YQ3YkFnuUfmclvlWehtJAlfoI/KL/kihbE=;
        b=dE633e0MV3xtxjpmUj4hNMLVDM76fUQR/rZiPlULemoaapmjzGqxKD243MfusbaXGY
         zodAxHT0pn3v2n0zlqPy/eNHTkk629ZkWUosJwJE1HeeW4XJUhA1ruttXmlsU2bKD0UP
         6GQ1hP2A26RepJ5tK0gAn1dQZlX6JWQBnewN92GUfNi37dDJxJj9Qpl6LiXS/VJvQH/V
         ARHBSxXZI5t97UOO43e3pMWEY5UrB49llGJxfopoMXG1SObDhPnp47h8OLOxyIfJ/VyP
         k8wEVnl8XFkEq7RGD0jbvSOoIXq3ezb2LcS2cAY9VEh+E3daCDfgEOuA67oGGdbAaOfr
         FllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780485574; x=1781090374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vCOLHvwV3YQ3YkFnuUfmclvlWehtJAlfoI/KL/kihbE=;
        b=FukeQJxgQ8bO1DWevnTigmVSwlulxOMc9e+r2N7z1/YMN/91KwMbPVKOCRqAh/ZEPj
         t3mwCXnqBCXJDN+OuLqe5C0A4C1H/NuPLGh/E8VqwZtfjAy8VHQygTnbBcGGQkkjFAb/
         AMt6lv4yRv2lSlSMa0HkTvsvPwbSgdYF+mCGkeo3enRBX+E0I8EmWWmL+QYsg6aE4EEY
         JtFecFhhncjihFmgWshG9jTbFfVAwQvHaIEKB8ZbOz0MCWc2NAJLGcZsrTAe0aCBuj96
         Ohqj7NRTnOmGFS7B1GfDfklDrQWX65eexD8mRGGcN+XvctiQlrZg+ZbN8OGzRTWcrf8n
         xMfg==
X-Forwarded-Encrypted: i=1; AFNElJ92833UylKptNTAq7J3CTtoDclXj2Mda75eMK+74a/rkToC+gQq3KyLkf+z9aI/PHQ62hhoUAlXcYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8QdE5Yuc9sh2gSmtfg7q9WHC7Qhn1vnJGLrnqJ51naG5CaWXt
	LshXNRkfDmVeYlL9VPaoNLkW3pGKL3hKte5HAV8IhB8e9u6zcjTeWKfRFohuNL2ijBLnCBHC23l
	kB6lzjkES2Z5PLWTGoUrB3JrBZq+0+zxT+7eNksVHCjLRUsWeCHYIdk5NU1eP558=
X-Gm-Gg: Acq92OEPDKhjoX7/5yWjrHuJrb9UI7blsoAun/LRl1dnDn8rt4F2K0uNFRgg1PG8Shr
	cTufy0lCG5DiUT1ZFA1TvZebBpFoAroWeb7pA7vPcuAevSu2OzNfTcXd9W93a6NN0ekcgVjLNo6
	ZK2K4KgZUi3MJrd0o+rUm+hdbRhFj+pZc8z/6nSs9lkM8xglAE9tiGuXTBAS6aipN9eKuv82q12
	kplA7rfoyGbXdkUX82v7Dav9/hCDgnkgvGBFtXaUgllAU40miq8GRCpmy7oqMbu24+k2AUR+nES
	uBU+98nxFqmolOjvnhX3GIjTrmW2lALmZWnxwvBhH+zrxv2/cRteb6Fx7Ttl1RzN6iX0g0N/nmx
	oGhfOWQOQ/hjRlNmcN0LxL2+VK0rpSn7/9yFbfT8nJkd7dWEIeW9e8g+rxMyQbXZew5M=
X-Received: by 2002:a05:6a21:7a97:b0:3b4:82bb:cb67 with SMTP id adf61e73a8af0-3b4978d6511mr3387440637.39.1780485574263;
        Wed, 03 Jun 2026 04:19:34 -0700 (PDT)
X-Received: by 2002:a05:6a21:7a97:b0:3b4:82bb:cb67 with SMTP id adf61e73a8af0-3b4978d6511mr3387408637.39.1780485573657;
        Wed, 03 Jun 2026 04:19:33 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df0b315esm1916840a12.26.2026.06.03.04.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2026 04:19:33 -0700 (PDT)
Message-ID: <ac86f985-7252-41f5-a08a-1a6f7385e25f@oss.qualcomm.com>
Date: Wed, 3 Jun 2026 16:49:28 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] spi: qcom-geni: Fix cs_change handling on the last
 transfer
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, Jonathan Marek <jonathan@marek.ca>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260529-fix-spi-fragmentation-bit-logic-v1-1-3b30f1a3dd7d@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260529-fix-spi-fragmentation-bit-logic-v1-1-3b30f1a3dd7d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDEwOCBTYWx0ZWRfXwQd6sSbNQlok
 HeQU9fAJo1Ieph1uknePRfid5BRCDZxSTcZkssgD7XIPSgLFP+egvjQJwarVjnfJg1INXKKpqts
 NnIRD2cun2sq4mW8G/67MDAfFnYLCp0nlIIuC9Uikkk4kJMBeOtIB1hB7dgRLIM+3D/gr0vq5dA
 6NIUz8EiVJrDy8NsFlEe693qB8QRr1C7ubQb2QPaXh3ii0enU4lK+5RUFQ7wuRBrfCt1w27/NEy
 LhvxAIV9V9wCgQ/Lt25c87jZaOMqejDL6OrXIo1oWczzLPKhj/0N68HGVNEIaqTuw4uOVQkvxzC
 judwwktuLxcitaWna5ngxCQoK9sHKKJVavWejMPHoh6ZBR5CK4/KvCj5dw/TbIu4e0z2JIs0Suk
 CoO8Pw0EOPxONW8pYTbh8lvPNR3bp64IbwRa9VHBCSNwBGl9KvdZ3WgXMkBUzGqSxo4t4d3QSSf
 tory1kq4xE2/aVEVzkQ==
X-Authority-Analysis: v=2.4 cv=Zewt8MVA c=1 sm=1 tr=0 ts=6a200dc7 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SmtWm-_bhN_d2ojGWe4A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 03t5fEaDHYn1Zw985mS2-WuPoZpuFx_w
X-Proofpoint-ORIG-GUID: 03t5fEaDHYn1Zw985mS2-WuPoZpuFx_w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030108



On 5/29/2026 12:33 AM, Viken Dadhaniya wrote:
> Commit b99181cdf9fa ("spi-geni-qcom: remove manual CS control") introduced
> automatic CS control via the FRAGMENTATION bit, but missed the case where
> cs_change is set on the last transfer in a message.
> 
> For the last transfer, cs_change means that CS should remain asserted after
Please make it clear if cs_change = 1 or true ? for CS assertion ?
This is to make it understandable for anyone.

> the message completes. Since GENI SPI controls CS through FRAGMENTATION,
Please provide FRAGMENTION bit information to know what it does when set 
to 1 and 0 ? Same for better clarity.
> set FRAGMENTATION for this case as well as for non-last transfers where
> cs_change is not set.
> 
> Additionally, setup_gsi_xfer() was storing FRAGMENTATION (BIT(2) = 4) in
> peripheral.fragmentation, which is a boolean field consumed by
> gpi_create_spi_tre() via u32_encode_bits(..., TRE_SPI_GO_FRAG). Storing 4
Writing 4 ?
> causes u32_encode_bits to mask it to 0, silently disabling the FRAG bit in
> the GPI TRE regardless of the cs_change logic. Store 1 instead.
> 
confusing  to understand.
> Without these fixes, TPM TIS SPI transfers deassert CS between
> single-transfer messages that use cs_change to keep CS asserted across the
> header, wait-state, and data phases, breaking TCG SPI flow control:
> 
can we also mention scenario like TPM client controls the CS separately 
on its own. so it becomes clear to understand requirement also.
>    tpm_tis_spi: probe of spi11.0 failed with error -110
> 
> Update both setup_se_xfer() and setup_gsi_xfer() to handle this condition.
> 
> Fixes: b99181cdf9fa ("spi-geni-qcom: remove manual CS control")
> Cc: stable@vger.kernel.org
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>   drivers/spi/spi-geni-qcom.c | 27 +++++++++++++++++++--------
>   1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index a04cdc1e5ad4..0618f6bd7878 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -449,10 +449,15 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
>   		return ret;
>   	}
>   
> -	if (!xfer->cs_change) {
> -		if (!list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers))
> -			peripheral.fragmentation = FRAGMENTATION;
> -	}
> +	/*
> +	 * Set fragmentation to keep CS asserted after this transfer when:
> +	 *  - non-last transfer with cs_change=0: keep CS between chained transfers
Seems typo, should be keep CS de-deasserted between....
> +	 *  - last transfer with cs_change=1: keep CS asserted after the message
> +	 *    (e.g. TPM TIS SPI uses cs_change=1 on single-transfer messages to
> +	 *     keep CS asserted across header, wait-state and data phases)
> +	 */
> +	peripheral.fragmentation = list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers) ?
> +				   xfer->cs_change : !xfer->cs_change;
>   
>   	if (peripheral.cmd & SPI_RX) {
>   		dmaengine_slave_config(mas->rx, &config);
> @@ -858,10 +863,16 @@ static int setup_se_xfer(struct spi_transfer *xfer,
>   		mas->cur_xfer_mode = GENI_SE_DMA;
>   	geni_se_select_mode(se, mas->cur_xfer_mode);
>   
> -	if (!xfer->cs_change) {
> -		if (!list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers))
> -			m_params = FRAGMENTATION;
> -	}
> +	/*
> +	 * Set FRAGMENTATION to keep CS asserted after this transfer when:
> +	 *  - non-last transfer with cs_change=0: keep CS between chained transfers
> +	 *  - last transfer with cs_change=1: keep CS asserted after the message
> +	 *    (e.g. TPM TIS SPI uses cs_change=1 on single-transfer messages to
> +	 *     keep CS asserted across header, wait-state and data phases)
> +	 */
> +	if (list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers) ?
> +	    xfer->cs_change : !xfer->cs_change)
> +		m_params = FRAGMENTATION;
m_params |= FRAGMENTATION ?
>   
>   	/*
>   	 * Lock around right before we start the transfer since our
> 
> ---
> base-commit: e7d700e14934e68f86338c5610cf2ae76798b663
> change-id: 20260528-fix-spi-fragmentation-bit-logic-880394337ff9
> 
> Best regards,
> --
> Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> 
> 

