Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171F92BEFF8
	for <linux-spi@vger.kernel.org>; Tue, 27 Jan 2026 13:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769519735; cv=none; b=iISPDapUbPX1oW2M/CYLyaGz0hK6lAGymEyAeZr6W6U4BE8KMINnxCF9ic3VETqCLbJssAJADMF4Bmnzc95Y74dbn8tuUST3HUUN5oPQNUr1OQTJDzxnC1gsQuZuqOTdUjfsuWvD8/KlIg9w4d2sAWZlew2pRxyENTz4zvwAbRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769519735; c=relaxed/simple;
	bh=1cKY6BkQKnpuCf2B89RPj0zbkxZjlJBnqHRJIQ9btbk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XbLttQgJaZUHmL6jkmzT9zQH4FwcHmssC+lu+lD2/3WaMa3r5SAUSwXLw8s7j0mfL3gGy/XBi1T8Z2vMJxh4dSCJPaH6ocfdqX6bTuzUmWWPeCmFFs3/uzSrYZOBW1wVOMuWC/Hf/p+jtalHQuXdHFwkQ/Fxo2LCcGkddegUirc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zv3penNY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cN+thswu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zv3penNY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cN+thswu"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R886SX623368
	for <linux-spi@vger.kernel.org>; Tue, 27 Jan 2026 13:15:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	19/MdffilA+Flr4zp73JQSFJbwwYSsULtIZglPCfrOo=; b=Zv3penNYmKT4yXTO
	A4X5vXP1oywnyYIS9H2+npER1EU60AF5aNiQVcsFMfQsRoIbfBsWx7grch6czInv
	zuTjyprxpXdTXSpC/moCd1X57iOu+BrQBYfeSQu4ntReSS1UOZLnhMmjaKYyBhmv
	LN9hS510A0IxwVg1ccs7Voxa5ZEEZenBypAR7guHk0LSvwKPgHyYUQPjDMuIRz6T
	W3KaQmn+RGC1rFqM2hWl6KFGTchUk/RjC3v5YpCkOCSd8GkcyxzzbzuxXWeL+dsZ
	v7XaZSHqb0AQ0M88V3eWX7NksyLf0wj9TKNQTiZ+hNMcfOLlGtkM1GgF1GeUQuR/
	StRCXg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxsjegxbc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 27 Jan 2026 13:15:32 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4f77be4f283so13077311cf.2
        for <linux-spi@vger.kernel.org>; Tue, 27 Jan 2026 05:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769519732; x=1770124532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=19/MdffilA+Flr4zp73JQSFJbwwYSsULtIZglPCfrOo=;
        b=cN+thswuMaCbVJ+FNu3u335J37ZAVpexB+4IzZnBg2vyYzGCxJ2BuK3yghJdodo0oO
         ZEs5UXNhkJAVqbjz5vWcwppxEm6vspst9vQ1Fg706f1cK2TXkJUWLM7jl4h/PlZTSxJh
         PQdOwI16Iyk7M3iEsKsAHpNjDXeoh/b3bFkivod//SkvEnLeI70W3gcF5oiOH8zyyZuW
         b0yWBsjfdU9/RtR1SHfPXt4uqETSFg/V+fFjQfzoGPA2S48VCpD/hSsyB6GfPlxUa3uH
         Iw4YrAh1kryNr+9E6S4tgw9UHv6oK8qKN8EE2Y/72e2oX/OhoMg9Xyr6KTbMtR1LVbFm
         n+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769519732; x=1770124532;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=19/MdffilA+Flr4zp73JQSFJbwwYSsULtIZglPCfrOo=;
        b=XwDlqsEepLm7A4cp1SHAhNTKuFQwTQgnk+rpQyRoPGsvNv3PmsRimhF5JKSnuY+Mlo
         4KbEJRMRXLvt4BBZJINn5DApoqyYcBtnPtZWX3iD8z/dHqUom0X/yov/PI3KtzkHBi2u
         qyDuRMQzEtjT9vTMTeX1Bq5lDGys7AQO8BZAWKHNQWJy5q8D9Tma54neHEGPBFdZsShN
         DyefhYqibVkxlShNZVArnMB8lddP5ByaGhA5H7vA52GUVdy36IWnnr3pBXjKjMgtVbJY
         9QrtBJoZupCauS3X5MXMvERpuSe1LT+TN23XshC8UG1WKXYYPeXUvILxg4hDgD8il6V6
         vGRg==
X-Forwarded-Encrypted: i=1; AJvYcCW1vC+u2aW6Ra1PbPBhPmMmFEuSdCRl69sQirHtvm4UHWsf2Nh5ixbk/Ts3n4x9JlB2+EIZYhThNK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3jnYzzShsBVpMTrwG+fWTT2L2PM1mvF//B2gVQIPSvx8vaviU
	6TIIi5kJdCUtWyVBZtflqOkU+PKD4HRkH91UXlXZykBQO1F+AaKFSdfkv+ssfTsl9Xt3JoYq4de
	/p84HL5AfldnGXtztnfpWySgNzHW7sY3SkGtUUvTeZBduTUrn4fyjdB+G7wXzb5Pbheg+67U=
X-Gm-Gg: AZuq6aKA08YHeRy+6HsAIJ9zyv48h0dGoOZJQYjow1LyhafozUfiQXPXS+QdDrjewhR
	r0soBADlytJyc4MwROFrg/8/wN5eesbrFybYOFabIoYMfmQuX/wKL818UNUTlBMXH8gLyNiENrD
	Fk8XfR+UdmWEIR6zz0HRqUvql53OUSL5aMSW/cMEZa3d2/rVJ6VnL+jS45gAP8CroGT1hl7YvhW
	Q5SjeS96AMejeXw9JaL1ROhGRRbjHK9IWcc0NbQDdaXXPLgjEU41b06SP8tdxNO6LhB71Ciutix
	hjhwJN0KuitY6nDMaxcMyfjZ5tvMzgbNC8GgJLlZq2IFVo48uC5azGtV549x4aW810r1iDI4ZDP
	ErZVcimZKI1A7MdsOWZQa3xwe3sAR4A5xRGQoy7gIknYOc4PBfQZ+RLZM3MB1cqEOL/E=
X-Received: by 2002:ac8:57cf:0:b0:4ee:1db1:a61d with SMTP id d75a77b69052e-5032f76e070mr14463161cf.3.1769519731844;
        Tue, 27 Jan 2026 05:15:31 -0800 (PST)
X-Received: by 2002:ac8:57cf:0:b0:4ee:1db1:a61d with SMTP id d75a77b69052e-5032f76e070mr14462781cf.3.1769519731420;
        Tue, 27 Jan 2026 05:15:31 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6584b3e054fsm6616915a12.7.2026.01.27.05.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 05:15:30 -0800 (PST)
Message-ID: <847290c3-d5aa-45cf-a75b-ff119b608433@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 14:15:28 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] spi: geni-qcom: Improve target mode allocation by
 using proper allocation functions
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        quic_vtanuku@quicinc.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260122151008.2149252-1-praveen.talari@oss.qualcomm.com>
 <20260122151008.2149252-2-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260122151008.2149252-2-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEwOCBTYWx0ZWRfX2KTBCm259Ui/
 Y9NUbaWj828n6tsnInq0pwf713CEIcsMP0bxWCrde3T8Yi7b0j204dCgjro2BTQyRu6VF7wuSFe
 F2tjpGIGTE82QbTg9mZmw4EkObFMpLiX8w4hfVRJNvcmJnEqExUk8n241kpcViLWCepSHV5pdQN
 bUQ6E/HgxJ2rOyaQxKawDvi5fnW+/MqhSW0XS1d1MVtcoeS6hdB7mru6a0Mq/172KYLo5PNU8kd
 3/yDco8ph/kRKNJzcC44M/pt545rXGFVOFAfSXmR/1e+RmlLslxLiKJ1Nf/1hQ7moGIm8y/dKLm
 MlF9Fkkrhtm+zOmpHxKlP5FIKBmkHopnzFXDzvJSbJWliovp24iEF8hteoi3Ru5Lno2HRsoTt1i
 OPDBnblpbQSOTimdGXCR7CdEvEf9IbwJPpW3GJs1uuadUJsTRMOxo7DT7WFo7VV3jdIjEHm8jZv
 lKk1v53su34upM/66eQ==
X-Authority-Analysis: v=2.4 cv=Qelrf8bv c=1 sm=1 tr=0 ts=6978ba74 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=XHOLzdKp66iKSBlp6ecA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: YZL8zqQFOmYxtLp8hiYNUsC7kIeDajZ_
X-Proofpoint-GUID: YZL8zqQFOmYxtLp8hiYNUsC7kIeDajZ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270108

On 1/22/26 4:10 PM, Praveen Talari wrote:
> The current implementation always allocates a host controller and sets the
> target flag later when the "spi-slave" device tree property is present.
> This approach is suboptimal as it doesn't utilize the dedicated allocation
> functions designed for target mode.
> 
> Use devm_spi_alloc_target() when "spi-slave" device tree property is
> present, otherwise use devm_spi_alloc_host(). This replaces the previous
> approach of always allocating a host controller and setting target flag
> later.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>  drivers/spi/spi-geni-qcom.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 0e5fd9df1a8f..f5d05025b196 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -1017,6 +1017,14 @@ static int spi_geni_probe(struct platform_device *pdev)
>  	struct clk *clk;
>  	struct device *dev = &pdev->dev;
>  
> +	if (device_property_read_bool(dev, "spi-slave"))
> +		spi = devm_spi_alloc_target(dev, sizeof(*mas));
> +	else
> +		spi = devm_spi_alloc_host(dev, sizeof(*mas));
> +
> +	if (!spi)
> +		return -ENOMEM;
> +
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0)
>  		return irq;
> @@ -1033,10 +1041,6 @@ static int spi_geni_probe(struct platform_device *pdev)
>  	if (IS_ERR(clk))
>  		return PTR_ERR(clk);
>  
> -	spi = devm_spi_alloc_host(dev, sizeof(*mas));
> -	if (!spi)
> -		return -ENOMEM;

Is there a reason you're moving this code to the top of the function?

the "main" change looks ok

Konrad
