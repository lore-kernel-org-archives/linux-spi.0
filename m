Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D9733C536
	for <linux-spi@vger.kernel.org>; Wed, 15 Apr 2026 09:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246575; cv=none; b=ZYEU/pX4IoJsK0Xz8R/1XlbF5wy+wxlD7tjz0BHH2KISgxmEL3PepeFQ3edlZN4A2t55p/+Y2FR9eQD0pHRM1WQsHSvV/rHkGaT8nma7e4juwptxuCxJkSQ2LTSuWpCqz7MUZfy+20BWpDRlW/t8ifWTpLj7fKeHb4j2GqDG6hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246575; c=relaxed/simple;
	bh=cxYpEZvQMHrSUdqMLabhc/dkvmhcRT0qC3vW9qGxMb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ej8g+5BAndVAfteq9L5t/wgoamz32fnNBehwiihSnXWKMKUEhWufzl7q2wwP8AtF9jz7a86lMx+wK8Pnx1fqlmPjndvoDK6V2/YPowDytU4Y06jzEq0erhWQ1G3mMY2/oDniJq8ugxviiki28BRydv4nFVbz+pYdyYXTgdu2rF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DSKCgCYt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e7HOOsUN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DSKCgCYt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e7HOOsUN"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F5xHqR2772654
	for <linux-spi@vger.kernel.org>; Wed, 15 Apr 2026 09:49:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UGKAhaWbgzww5lhS1vPXCnXjw4jpJVAA+m/j2lXOxow=; b=DSKCgCYtV6swTrO7
	BOS8qTKDMkjskI6iwsokkCWBuPm7oSS+g4u8AwzBl4H0cIUGW94tFo8rG98/SqrX
	hNq9Lwo95bdshxZXqGIXJm7IC1wmtdGFfjgStRP3zZdocOn/qGVnBUDHnZXGxIv/
	nFX4FQpvcfNE5PJng86B4jwuV6M/qLsPyj+AP6rJTcq+fZUw2ANsTTPMzFpjujhF
	Tg82lAf9yvpPcoDrT6DP3hhye5WU6XM1m6r7tlKNfDFv5fhUy//GLXDNloCg80NA
	NCTBYx9tnhpoD0XMGWBCWNZzyQ4/gcJSRzC4zh+8yaDOv6DDu2PL0MbzwiDpzpl6
	cK4FDA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dj50v0ub1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 15 Apr 2026 09:49:33 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50d5d076d88so14099541cf.1
        for <linux-spi@vger.kernel.org>; Wed, 15 Apr 2026 02:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776246572; x=1776851372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UGKAhaWbgzww5lhS1vPXCnXjw4jpJVAA+m/j2lXOxow=;
        b=e7HOOsUNXTXJ/4IvFM6ovxxETcZ/frFNwRwHeu1mFRXBEW97+PhSgwOV/MTBD+0X29
         T7o8ZGZKsXpfaP3dEBz4qwJO1OMp0Ht23rP3Nd6n2La0K5XG4GNNxyEAWzgC3TxE/7xS
         P9z+BoU0spQ6Nu4Yror8Y6RNTHglNdy7I1+Sry0aMUpoM+xpEArMVFQ4Y2BPqXngB5el
         b8V7aCnkviszOa5NhayvKAdTrMUf86aQZRw/71hdZgLK/Z7XGOQH2yzyI4ZkbZ8kUh7v
         ej1OpqJg29AVx7cVAdbBuAUVQRONduqI3jZHcmhWPqLvZMBLrBEIDFtdnJ2bhpso/8h+
         ukoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776246572; x=1776851372;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UGKAhaWbgzww5lhS1vPXCnXjw4jpJVAA+m/j2lXOxow=;
        b=IKFIkp4sjroAIHJuBCZLkgiIDz8aQqKcz9WtaV21w7FKgb3jKEVA3wm8Je6o7ngyX2
         UQzV/KXRo8mE/STJNEUKVo/0XyMdjlTDB2HeGA0pCLdPR586bP9mvacKwc6Cm7x+BOC4
         Kjo6Z3OlFvgl5Pv9Q5jjKm4MNZ7rZnxvNjm8Vf3UqN0W4iZ0YI5y1kbChmqHA2PKNWul
         uVGdWWDJZ/Fasb7rXQhw7a9LNlG2RIaKc7wcMLnhyj1BYLV6C/hg5lj+OphE4rqBI6T3
         p46yCgJ3zmKSbGfQ8DXIqZDMxwrjRDRa0qdjg1tgWNV2La1Asqt+wMip8m+2GG5Hzztr
         a8dA==
X-Forwarded-Encrypted: i=1; AFNElJ8guAE/9bskpjcS1h0S8cJBTzYRlHORwsLlniZAJkaa93jlBPyfrL+iQQMqTcZlceYdCwS451llaZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwm9SXMN1yFnFeqtFQPABg8GaoLes640WbsSsxY1bL9dpnTpCr
	H0D1Ua5Yq2n5zEmCgbZf0xPY0XAPz5k3xonhWiqVspo3euMB6EdEM9ciKYFV/f7wAnxW0lQ2vUQ
	c15QNK7uWJHnUOyiMu2tPahFbNVIiCcCz+aSJC3rZYFp1oipk7E0VUUBbJye3giI=
X-Gm-Gg: AeBDietuGHrUg94Sb4kCp9dOPoiu+XfKcUg10JiNYEF825b5KpZ04ufAvBTtMJ1wUiT
	BJt/+k3BH0+UPjYys9gBFIKiyAUtVP0JjD6+Q4SeWASt3HIjw722w5XWHzVYLN8vmrzOTypFJrr
	o6Ul4lGZpwI9VH+eQuEDSufygqBQUAiDePNhjCyqXuzVW5ET3sREBmrkUc9UoZlHgxvRNuqgxvt
	e+ZCvCKNtiOleM5RSpP9l6KkADqkie0TlrBQH+nLISZcGjm2pnOURhjceJvJci4W9sFFGxgb11W
	6I70vPenB1X/mp+in2SLU/QPasosJS32zZIISwl4u9S9vZXTOquFajNN5UDw5hsiNc+s+tL6OYY
	PFpRZ9HYayNyvWL2uth2bQFqkFdJYrBzknid+ZDlwI3rUvsASbLVMZTKx5tBGgxzo5CqkDJDSYI
	/D6Z/UDRdhfpIQFg==
X-Received: by 2002:ac8:5893:0:b0:509:15aa:cf03 with SMTP id d75a77b69052e-50e1a703e9dmr15482591cf.4.1776246572405;
        Wed, 15 Apr 2026 02:49:32 -0700 (PDT)
X-Received: by 2002:ac8:5893:0:b0:509:15aa:cf03 with SMTP id d75a77b69052e-50e1a703e9dmr15482401cf.4.1776246572016;
        Wed, 15 Apr 2026 02:49:32 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba1782aecf1sm38771566b.60.2026.04.15.02.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 02:49:31 -0700 (PDT)
Message-ID: <d4c7d384-316b-4d32-9161-04757ede9ffe@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 11:49:27 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: kodiak: Add QSPI memory
 interconnect path
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260414-spi-nor-v2-0-bcca40de4b5f@oss.qualcomm.com>
 <20260414-spi-nor-v2-6-bcca40de4b5f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260414-spi-nor-v2-6-bcca40de4b5f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 7xHRSyvFNpSJ870HuS-y4coAoOzk9mvR
X-Authority-Analysis: v=2.4 cv=eLMjSnp1 c=1 sm=1 tr=0 ts=69df5f2d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=ctcgHeANrx8D0WuUPGkA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA4OSBTYWx0ZWRfXy/Y6HvsY+1qg
 2Jabv5EcUDZohENx5uNkRMSdewizGmeyyejheY8X5rnU+b0Uv6ya07rvtW6DsNQqyg01YOqh49+
 I7OCGjG5XXwUAk/KIl65YK6tpNyxSP0We47iebHAWEBrhKiwSGHaUUaEgC7HJAIQFxIwwhzzh65
 NE+fzFykh+GTOG6D8BUEuVFXrPCDM750m9nHbAvpFeQArzIZML/yTaepvosk29lK0Bkt5xNpdzE
 VC/zrxqkzcZVYQvX77Vcy3uW89xc4cNZrlrNdxrhY4wDVqhFI9qpkzAg9USjCk8rQkbLOigSOGX
 DmW5EZcFkKQIAVqAZcysP/3BljAGHb+bZ9f9l+D/8kCKIfAhn3wP7zWqFSRj9w5ADhYQrdpjrtJ
 wNUWHYxS3weNmgJKxIjI72Heprt4S3/s1kLRii8vhOo4C9uSZJtYTIrDKKJN+NCg9u23EmraUTA
 dyGUhAqW5vnNw7CCQlQ==
X-Proofpoint-ORIG-GUID: 7xHRSyvFNpSJ870HuS-y4coAoOzk9mvR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150089

On 4/14/26 7:08 PM, Viken Dadhaniya wrote:
> Add the missing QSPI-to-memory interconnect path alongside the existing
> configuration path. Without it, the interconnect framework cannot vote for
> the bandwidth required by QSPI DMA data transfers.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kodiak.dtsi | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> index 6079e67ea829..105efb4b3aa4 100644
> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> @@ -4312,9 +4312,12 @@ qspi: spi@88dc000 {
>  			clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
>  				 <&gcc GCC_QSPI_CORE_CLK>;
>  			clock-names = "iface", "core";
> -			interconnects = <&gem_noc MASTER_APPSS_PROC 0
> -					&cnoc2 SLAVE_QSPI_0 0>;
> -			interconnect-names = "qspi-config";
> +			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
> +					 &cnoc2 SLAVE_QSPI_0 QCOM_ICC_TAG_ACTIVE_ONLY>,
> +					<&aggre1_noc MASTER_QSPI_0 QCOM_ICC_TAG_ACTIVE_ONLY
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;

same comments as patch 4

Konrad
