Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3962652B2
	for <linux-spi@vger.kernel.org>; Tue, 27 Jan 2026 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769520113; cv=none; b=S5Lt1jgtTKqcR4QEPefJtvilVNujQn2eYNCEvMAFJkl/VdcyY4UQmubMTGCGLx4eyMSihdmAQkpLlS/xiCTJX8tZiPA5mEMPhwarTwVzgQTpbE3/C1s2wGRbtP+pQfAJHHTk+VK+ICDZLwYpK4gXbjEvDfWlKIf9J7xVNDRrcLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769520113; c=relaxed/simple;
	bh=hxE8DgeXBHRE1gGLEQJUpLHZc2gKWvTHb81dLyry0kk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M4ckaaqoPxHOHk4APMaAXw8gtx5WhH0kyCRhOFybS1Z72eBNUdjxplxMeUMrep+j66gAr0u7heZpb+A1OTczY+oxWBOF/a0ebSu2tNsvFwrfy4hdIh30dgsLnl6mXr6NBjrT2VpablMi8MWrh7mAnYmImL0yRGBhZQKD+uVGap8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q8nn6Qtk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ctzc8Kln; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q8nn6Qtk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ctzc8Kln"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60RBwIRu1792658
	for <linux-spi@vger.kernel.org>; Tue, 27 Jan 2026 13:21:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AXdYhC+4OLkMnLH64qCoEJNjy817DN2szJ1t4wD7K0c=; b=Q8nn6QtkTqTxIPKP
	eXgnw1l1BeLaq5566gR6OzICQ2LMYWtYGus8/tJEqoj8BNJAywomNB3rt1VWj3/6
	nVb7aUQ96XeGNZOw3WvtaWDesCullWIUOFqgDCn7vZ2q70JZ3CDztocu/fOYqjfC
	Ql94wx1AfdHNhAkaWshHVunUFiGh2uBfaonS7Q9b2BYO0OTKrcUJWSvUtU3k0xe+
	XNhCYtn0i/gV63muq6nvekHzC4raTVSf6iNjYjHN16u4dsYsFDqavtGngcp7UP+A
	qn67p1JVPWrDbQ+jj0FqN4gF2jDbqbrAhyDDZFvMst7TFGtSv4a1EF/Lpppz4BL5
	D+kLIw==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxg93jp3f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 27 Jan 2026 13:21:51 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8c6b48c08deso172183585a.1
        for <linux-spi@vger.kernel.org>; Tue, 27 Jan 2026 05:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769520111; x=1770124911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AXdYhC+4OLkMnLH64qCoEJNjy817DN2szJ1t4wD7K0c=;
        b=ctzc8KlnP2yOyTh50cvDDBrDx9ImpR9koent64tjMpSTQvw//C8Sd1nqEjLy50sUYF
         EM65Ns7RXqjNCS7cOfyBVIYbxfbe0UQzhgXTE0JOBVhxJ0wOdS7ziLlUrViWao0YM72X
         U2hzoaiPNYkX5wMOwoA6AP7AySez4Os2MScVxoU2VDbfPxGAbGeQSRbGl++g/2mzEbWc
         KgxTAgvd4nE6Ui2pRxLQKI8Vh2w3WGPaT7cp8iFcPBegOrwiH5kjcDokCq6aprEXmuxp
         I/+MjBpiNE9gnXLh4pvmJbdxrqjoPBME4RPVGUKKuzV+Y6kiEU/vetD/emQ0ALeEOa8W
         cnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769520111; x=1770124911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AXdYhC+4OLkMnLH64qCoEJNjy817DN2szJ1t4wD7K0c=;
        b=XcOjXQ2XMd8Go4qgi4UZkeGp71lRQNEfqeSdcLEjEIX7TpCY7NWs6TUXSggnmtndOy
         VAr76UqJYfgWcISwO6MC+sytjRg4v9MQwmzxOuFJRplX9zxdGa3Ll3z6AAs4NZEMtI8A
         gWGJnN2f+8vsSdfHeO+1g3HWJzjF0R050of8/DRu5IrQL8+5c+L0160q5kkOeBPDYgUP
         2/eQbrMr1RYEEH4nm9eBhwiXPUqXmI2M9o2STEArsnrlL51NlHnGI7eVb/sn1z0fQoOj
         Wly6wdc7qUWC7EyNNYjL9mMS3ar/yG11Szvzo5pJTjJ/Z8q7EnGXDQVEKDD739fHX4gC
         mJnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+F72c86mlgWljUrsPSXLwyywjwVgEjLPZZhTuJQ22meZbu/OOASx/lvv4IhdtBN8oo45fY/e602c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwhrhsfCJswQ1MTOIJv6HH6ZPwV1o45c6AkdYv9pVffDrRMNSH
	ZZn/pjOGjUMilTYJMakG7VhxAt3TUJnKXtkxSB6AIEFWJvTZ03fvgntPiDcuX3ktTrj2NijVBBS
	rNp9ii8RNpd5mtjTYXRmeHcmGi+iRde9GbUQ5Py8YyGSdy/fBIqhkQxqwKzL2kLk=
X-Gm-Gg: AZuq6aK/nE7/W2hAMpB6I7tGNjr4dV0h8DQ9Ep8ynA7byWrUH/7zzNOaiWitetjpcFB
	rP236VMrwkxd3HqAN1ucjXV6ioYCViItKGX2C1SsfgwqbkasPMj7H9Qr0g/Pvo+VjJOisqZzbbj
	7BTmU0TE2J9r8xPQNHwPO9YZT+qcrxSnmXVyQOEn8EUE0wyn+oXGB3n4J+GXPQGzoZMDxAN0h13
	PsJsLcNp8VNdME2nS1THHtKpDhwj3R76SaAd0S3iOTDtgxI1DWolqfApI6nfqF4uc90oyXbOjn0
	yCoVQt6ZMTwThlLchX6N3NJM5EGJqa975BuEIYjjT25HrEud4garhWe1sGGbOVFY/mDUTD68fJ/
	cv1Vh25+ZNTCKg1VP04RRUULNJf1Ni1Vi27w2vQS+YsmTyYz7kF8ud8aqsYfcK9l2fWA=
X-Received: by 2002:a05:620a:2802:b0:8c7:9e6:3a4e with SMTP id af79cd13be357-8c70b73f90cmr157677485a.0.1769520110856;
        Tue, 27 Jan 2026 05:21:50 -0800 (PST)
X-Received: by 2002:a05:620a:2802:b0:8c7:9e6:3a4e with SMTP id af79cd13be357-8c70b73f90cmr157674885a.0.1769520110413;
        Tue, 27 Jan 2026 05:21:50 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b3dad3asm807868666b.12.2026.01.27.05.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 05:21:49 -0800 (PST)
Message-ID: <64961e27-e316-47d1-8ab4-c4868754adb6@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 14:21:47 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] spi: geni-qcom: Add target abort support
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        quic_vtanuku@quicinc.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260122151008.2149252-1-praveen.talari@oss.qualcomm.com>
 <20260122151008.2149252-4-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260122151008.2149252-4-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEwOSBTYWx0ZWRfXyxU7eoCc6/NK
 Gq/Mu4Fv00fLOj3aLvmZm3hZ0lmFZvbLpzPzAmV5P6AKqR80Z91YgY5K9YY8auwP1kLyKbea06X
 FYrYziL+36sHP/VsUKSlC1cCIj+thRGsuaQHQEEQnKnc+dWald0bXixmTFeBv7d2qeQpiddYANC
 TEwrDnzXGjnlW84jZX5rxiTUR3fcrIY3K74E/P9ciYWsokLYdS3v2TqiTN0gq6vCWoToOwBuDVl
 ll4DsTcDB+yy120/57IBLAAIRrbSOTNTT8VLLRn4/V61nWnUWemVgrjuB3ieIMJJL6Rcncfa/Qa
 kYbmRcUGIjTLlL2kihR4DzxxjwMm0ksuOGa8Hby2mF18ybPq112Km9GyJZgVb1MsjA7bIRWcsgl
 nJeffOMQMhlE7T0VQydkt5NyRyqWPSvNZk5MvcCFRr2L5AnCWSgVW2plPJ4OeQMqaqnvz1MJ1KF
 C1T86SMaKXpgyuXC6xg==
X-Authority-Analysis: v=2.4 cv=Uc1ciaSN c=1 sm=1 tr=0 ts=6978bbef cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KiRDxWFFE5j6wAypeYgA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: _mINDqZKC_yWNO413k_uvRiL-8nJMVS0
X-Proofpoint-GUID: _mINDqZKC_yWNO413k_uvRiL-8nJMVS0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601270109

On 1/22/26 4:10 PM, Praveen Talari wrote:
> SPI target mode currently lacks a mechanism to gracefully abort ongoing
> transfers when the client or core needs to cancel active transactions.
> 
> Implement spi_geni_target_abort() to handle aborting SPI target
> operations when the client and core want to cancel ongoing transfers.
> This provides a mechanism for graceful termination of active SPI
> transactions in target mode.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>  drivers/spi/spi-geni-qcom.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index e5320e2fb834..231fd31de048 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -1009,6 +1009,17 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +static int spi_geni_target_abort(struct spi_controller *spi)
> +{
> +	if (!spi->cur_msg)
> +		return 0;
> +
> +	handle_se_timeout(spi, spi->cur_msg);

I can't help but notice this function never even dereferences this
argument

Konrad
