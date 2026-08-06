Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F187048C8BB
	for <linux-spi@vger.kernel.org>; Thu,  6 Aug 2026 18:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786040699; cv=none; b=Ui6ZOwYUZI2n8q7xR5lY6vlDGx9VHSQsEEJiEmAA2I4MsicwA0lIFIX26hhzmDZwU4/7fDuvaNT8M4s8MjDqcox2mAI/D6fO3T9SkrJ4Pi9hJCsWu4Wc1tOyjiTpNprn+sMhB5p6GUMc9MNJ6IIDPe+rYaOpo25J3ZGzwCNy8TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786040699; c=relaxed/simple;
	bh=y0dQYGiQOYwW/eAOTG5GOZGj8VDF399Xgl/hPfbAQZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZIGCW0/w6bcPTZC/Tan1OJ5rmADwWj9IL2LMMIMuRUfs64bvKwxfK0M+zDhPd5g6ak0wOlTgMARK5NdhQRvdNSvwuoYi92ySXpNzdu9MNR84e1tF/VurW+6LD1kS54o9SPd/lhbBqU9Wq/PuzA+l5q74wrczttJkWok/TZvIwaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TnvEHapi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=atfpRlPn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TnvEHapi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="atfpRlPn"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676IHf1s2757755
	for <linux-spi@vger.kernel.org>; Thu, 6 Aug 2026 18:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bGV75NTkpHIAnldHndd4H4dBMpSpkx9GuGpjcJKUYaI=; b=TnvEHapiinUk1mxR
	Yrs/ponipl7UEDeDg3cY7/nW/4GHECGEorOuVuxUGR1msGUbCaMiK+LkYv0pAuWv
	OE2QLovdGFYHc/BBb8cm+1KXbVcKmwAf+BS4i28/Hir5RS8JpX48LnJhlqx7TJ/u
	lDxbGJR7GMeQRl3orpHvE3lxbeWXqr+rkzWSA+mkUng95Kuxxs6cEMk1tmNpWP4B
	9x7a1DZBqfK+0Qhw2Ey6TISRZoxld81Zg0sBRVoJyZf4Qq+CiIsRmy64MSx5avx7
	sAECZsLcOpesWXDdcXEQEa4GBgDEZDWqWo645MEc6Qbz4AJsmdPbus7FadZYkc88
	rWJ+zQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6fr435-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 06 Aug 2026 18:24:56 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e1118e4abso3618714a91.0
        for <linux-spi@vger.kernel.org>; Thu, 06 Aug 2026 11:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786040696; x=1786645496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bGV75NTkpHIAnldHndd4H4dBMpSpkx9GuGpjcJKUYaI=;
        b=atfpRlPn0239JoOGXx1phOR5Je8N7twyjTNkDSS0uC9kT/CY5XaLHh+uTZgupekYKI
         kPsZUR2F835R2xi6GlAQaKbxo6MpKKovDa66C4GrTPLmQltCvz1+tfup9PltKuars5b8
         w7SKrCemlj4GXOsXFWpfEAq/4A8ymFJFmL5rggt9RnR2r0uHNZ/YI+RAD+xtGerM7ygC
         2CaALVx52FRzxYAk+V6dIeYEY21VNSiTR7982t7Wao9sE46Hn2RiCi5BC8q5NYl0FOlA
         v9QAghGBMQ/U+1zB5hFWz1dlHa5O3tOTNDapAS/Ut2YLgxg7YUFpLnNTjH4mG4LF29NX
         sjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786040696; x=1786645496;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bGV75NTkpHIAnldHndd4H4dBMpSpkx9GuGpjcJKUYaI=;
        b=EIMyM2Q72sCQJzm14kIWdJPKB9cUTBl4kwbAYxcn5j/fJqDj85kYY4Q2RybnMJsLgV
         t3nMkn+PN5/uOULqr3us6Si+Fu5xlryQ8s4xM5XylcWRye19onVPirZNlc6epX3v37BO
         2wUg9XmMdOCf4ZoXby8VrPZwB0ZE9/iQr4rdJyKa/NcS6NIm/9t4wQgsFUUd6YxbXZPK
         mXoOXVMEk+7vx1LKRKAuu7FCiXR1b3fFwEBgoZMWx/cH8vYm+KizzMYPhVZEp7sJuFXn
         WyUn6llEDsXb5E4du+t39yCZdP+DtjClv0GFCUt+yjJaHOIFkQV+j9U18ht8kQSTDUKf
         7BfQ==
X-Forwarded-Encrypted: i=1; AHgh+RrT6VcqNLN0o301LrNvtiUp0SDW/wHbZLkq2wQh3k4U9a+iPu0ypyaWnjZMnpxqgVFWpj3k1nOah7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz26Aez1dZvjMgQgDPST1Gz5IMz/hJhYEYvYzPqBxIGDf92VFiY
	Eny2QhfNQQLKJrGWyU8hzB8Q+Gq7WuZM5FhmON8rP0Ox8mrhi8T+noBQA5VwEBSa17gS/CzXq/4
	E2uZ7gf9KWMp/5dNcBi76+Uuf/MLr+gmrKkDjEXX3tKEq7feVILPOUtecQyybZYY=
X-Gm-Gg: AR+sD11Mws8iSuBLnc3ANwLvMlqIeqAmbjy2pOWNTqd5kAETAwLwdCpsOitYGjn9WMV
	/HbeN0oqlESNJQOFmquA39lzjyumEypPmg3B6UPvURVMRN4Wt/rLVVHBOG6qLRpQU9u1KK5e4Rz
	KHGFqp3a5bcfGAz8A+CdnjqaMeHoQ+1+Uollkbg8WLvDmQQkYZq/QBSey1zNxQNb8zaKB9XJmsW
	qsEnkTmmTKfuSWWdL5TOa8/8Q390xSnU1GqQNuceuRTAaScZY1FuLBmUHQIdl6GbQwxUE4XRUmh
	gYHI8KJqGb5MfH2LoLnSY8B6oGylmCWehcBVr3f/iMjcbqAQbZm3E6yVzkixVbvHmMOoHgGIWZV
	2VwlTatbMomz/KJY3FQgH3/FImzKOJXN55w==
X-Received: by 2002:a17:90b:2245:b0:36b:bec8:94c5 with SMTP id 98e67ed59e1d1-3903c5a6abbmr12183099a91.10.1786040694743;
        Thu, 06 Aug 2026 11:24:54 -0700 (PDT)
X-Received: by 2002:a17:90b:2245:b0:36b:bec8:94c5 with SMTP id 98e67ed59e1d1-3903c5a6abbmr12183053a91.10.1786040694175;
        Thu, 06 Aug 2026 11:24:54 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.231.86])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141009923a5sm460846c88.4.2026.08.06.11.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 11:24:53 -0700 (PDT)
Message-ID: <3c39da7f-ef15-4219-8126-dc5255c10318@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 23:54:47 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] spi: qcom-geni: Use GPIO to notify master of SPI
 target activity
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com,
        Krzysztof Kozlowski
 <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260806-use_gpio_to_notify_master_of_spi_target_activity-v1-0-c363a9b5df69@oss.qualcomm.com>
 <20260806-use_gpio_to_notify_master_of_spi_target_activity-v1-2-c363a9b5df69@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260806-use_gpio_to_notify_master_of_spi_target_activity-v1-2-c363a9b5df69@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE0NCBTYWx0ZWRfX1FYJD6tfHgZ6
 DYWAmG75GsEGeMk2T5Z8oSX37JR8d6AosrlyM7sy8flRGRe/vlaynZwRZeXeskjrCakhC46kfq+
 Al9081PAXBngcB7iEvtz5vUbctSZJnUmfT2fHLqFU4SWBcRD0Icvxcx/biA/Q4XaNX5su/Nf3gK
 Kmb+crlBZfRjuijIXCvNjwwigaaOoZKbyycKxCiUTUGjm7HJqKljbgqXG1lkGuu64cYdWa4reBX
 rtC1Atz8V7yOFuIiUbeFdTY/kH5x8xaxjh1uHv2bM9ORgmZ9I27FGXC0KFrJTY7GJGVMk1na+tR
 JJd8GV68w5jeduJ4RRP0+Q4H+vzbHEvntTMvhlco+Zf89c2UdlZHsKVfF2iYfiquL1zXv0cCYx+
 MjAvRhRMOs8E/kLZllPtE7bKVmfo4rWfPpXSjl1Gu7CrMiFzhQlFCPhs5s1FAIV1IUT0X6yzmlo
 a1mBm5Q7SZBYpw43bng==
X-Authority-Analysis: v=2.4 cv=DvhmPm/+ c=1 sm=1 tr=0 ts=6a74d178 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=uB10XSru4U0CyR2DWkO06w==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=qmjqkF4nJp0v-fA0mrIA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: gy7V_xYjKN4qRxKBGea1_myuo93YJ4RT
X-Proofpoint-GUID: gy7V_xYjKN4qRxKBGea1_myuo93YJ4RT
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE0NCBTYWx0ZWRfX9cXrxzZv9Pan
 S2tA51hQhOe+aZifxrDoHFAgsnj1cZhrmCWR0pdmvjT1Jcg2IEDhqYmhpdlZTjsaMqKlCSyMSH1
 GiQy7efAk1elOvQj/ACCdX+hKSXBVIc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060144



On 8/6/2026 3:43 PM, Praveen Talari wrote:
> When operating in SPI target mode, the GENI controller relies on an
> external GPIO to notify the SPI master about the target's active state.
> 
> Add support for an optional device GPIO that is asserted when a target
> transfer begins and deasserted when the transfer completes, is aborted,
> or hits a timeout. This allows the target to explicitly signal its
> availability to the master and ensures the GPIO is released in all error
> and completion paths, preventing the master from observing a stale or
> incorrect target-ready indication.
> 
> The GPIO is optional and requested only when target mode is enabled,
> using devm_gpiod_get_index_optional() so targets without this signal
> continue to work unchanged.

if this is an optional for something like showing target readiness,
why it's required ? if not defined, what mechanism makes it work properly ?

Like does it depend on any timing or sync mechanism if not the GPIO way?

> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>   drivers/spi/spi-geni-qcom.c | 25 +++++++++++++++++++++++--
>   1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c

[...]

> @@ -1116,8 +1129,16 @@ static int spi_geni_probe(struct platform_device *pdev)
>   	init_completion(&mas->rx_reset_done);
>   	spin_lock_init(&mas->lock);
>   
> -	if (spi->target)
> +	if (spi->target) {
>   		spi->target_abort = spi_geni_target_abort;
> +		mas->target_gpio = devm_gpiod_get_index_optional(dev, "device", 0,
> +								 GPIOD_OUT_LOW);
> +		if (IS_ERR(mas->target_gpio)) {
> +			dev_err(dev, "Failed to request GPIO: %ld\n",
> +				PTR_ERR(mas->target_gpio));
> +			mas->target_gpio = NULL;
IIUC, this GPIO is an optional one. if so, please add a comment to let 
go ahead with an error.

Else need to return an error.
> +		}
> +	}
>   
>   	pm_runtime_use_autosuspend(&pdev->dev);
>   	pm_runtime_set_autosuspend_delay(&pdev->dev, 250);
> 

