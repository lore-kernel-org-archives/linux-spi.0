Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E034A40B389
	for <linux-spi@vger.kernel.org>; Tue, 30 Jun 2026 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782822570; cv=none; b=TtgdYvaGoDQTr1qIgv0mu+UQHsnKB43VVrLl0RD4Gi5oC7QINAO4EC8j7zO+AXq0yYGV35wPhvwu1qwdFcZNtOGJN8P0vtNiajLG7DBfXOE9OUgs4lU6tpsygTCckpSPEOiKWCT2490rhvFV4t1I1VFDzyH5cwsGjFRYXYlik28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782822570; c=relaxed/simple;
	bh=gl0lDm4wynurmveioyR1l2Y5g2edwHFBtqEE6jb4mBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OaYxSoQgAzuCvZGDaibLp5H/pi0qVLBsXaJFBznlnHyjpCJdBu1tjeKmuIVs0DQe3An93K1PNr9SLNM53Vw6rYwqCP1cgjYly13aAYE8YnHLabKCtZhWs+2lLTSYawnFoNz4Gt6oypOyJFkVe+Y6vH3BNi8BZG00FI1AvePW09Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Tyw3gH/T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wj2ddysx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Tyw3gH/T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wj2ddysx"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9muTu1604531
	for <linux-spi@vger.kernel.org>; Tue, 30 Jun 2026 12:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GtTspHsbGkjYzDUUdoD9USWBMPNjPNk/lGT+v+UlaRM=; b=Tyw3gH/TTSBgvzYn
	CTDF1wxMcnv74fhvk3IQ+KTC+kIcRKKbecYHSHw5W3Ijh78lb7r5Vo6eefToGkKb
	RG2k7f319WAv2t1vukHnvTcoYNJfMmXu8qaPa/7c3G8xW9RMoDGFnY/bdoAATjCU
	P3HVlZJyHNBxR6DBCTwhGj+SAdHCis+tHm9F3fZ0e9X20NLWTX1dz5MjSsG7wqLj
	UZzIVUl3cyF+FQ3UD8rPfRqSRf6wJ6nxSINb5cGrg4SWOergjYPo6lX8z2QjgB74
	L4ScsZ/5LQ2x/3wMP4rdY0gGjU0xceG4tF9mLK5jG9uzdKJ+/0y+4u8bv04hrR5x
	QRUeKw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f462fj6kn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 30 Jun 2026 12:29:27 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c8e14ebb2aso8286795ad.0
        for <linux-spi@vger.kernel.org>; Tue, 30 Jun 2026 05:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782822567; x=1783427367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GtTspHsbGkjYzDUUdoD9USWBMPNjPNk/lGT+v+UlaRM=;
        b=Wj2ddysxTfwAYc1XH7KOPx+uLd372goh4s4FNN3Klz99QdA3LD79xnDtycwKxAuLDJ
         eTMS2EcqHkRM+dk5hxNDTRwmvL3/g7tAVUbP38ukIpAFz5j73oTih4GJPboNU6M9XA6g
         rfR79qJuiS6+6MEE7G0/jp8zwtDuvPG1dlqapViF+jjiDpLGm3F/GWSgtG3cSwcZyJh8
         m6lqkcJccdk9y0uLT6M1t8383RJEi0OcDC7S+sZZhu9AhnMVrAJ4VMruf2xKVyDdya9K
         wodrzu1K1OcOVZPhLgQhKB0kc0A6t4+8sDeS5dw5FBCZyGWEYJeujITZLoIKDwWbCzpX
         1e9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782822567; x=1783427367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GtTspHsbGkjYzDUUdoD9USWBMPNjPNk/lGT+v+UlaRM=;
        b=Atg+pCjQGTqWu2+Wn4h6sACP9pWfyRdFHeJdCLjE88UudL3I/C0GzqQ5Y5voC4vXSd
         K80B+OVjbzHUbp07ufM2CpL5u1qlXBh3hrBk6v51dlqSW3PGRSgLhLj4/glAwCgfnFTc
         xAW6K0Q1UuU77XiPP5ja1EXqeZWslLqlaLpsTuaJTB+s67M76WyOMgNfv+pSr7GotD1P
         psBdvqRztnvNGZ7Pf4zZEKFi1t8eFag4cM1EDznNFoZd8RNOKaNEvEkpbnECqAJyERS2
         wdSX6zNRtLWjhWmUO91f3x8bbyOAUpgSy+PzSl2JOWY6e4SB4M8++ZVtnpsk0QOrfF6a
         LydA==
X-Forwarded-Encrypted: i=1; AHgh+RqZwYM7lVSkZSNvx7gA+GhcxKvs6nCnNfzmcxUjk8KZI2jfuJLn7I27OZhnny5V17qMMdJTFeB1DSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqvS3Kjb8kJyOoXhaYhBwxTGLtR/TLzEbhsR6oNFldh15jLC1/
	Sfq4n/F7pFG06FMmV5/a8fqYQy04KBRa4vrb4y92N4X5Ibih0CX+g4nVI/szeuthToB5ZkQdxs2
	zwmbMTIMKuEx2Dft+h5UQ5i7L18FOad7GN0SNeAOWdsuF3gfGoXS23StaLYaCQTU=
X-Gm-Gg: AfdE7cmJvpAGGIgZ1THFyzP7vOtgOndQeg0stvfUkabQczgSAIsJPFJp3oyngNzNIBp
	+WPgB73BWJKUOGMqaWLFxdlJk7KSfDiFjPtTFZngf0RZAf5eWYLnBneshps0MytefW1yx80k0v+
	f9pAyhkwJV3azMSZ+Vp3Baldd+NKW96v8H6+hgAeaXiO3XHqtvh79xnCeLGboJM0g28Tu81/dUP
	u5R0toay1uNjwh5mz/+5nvYuIrcEUW98B17hzbZ2ke+SHyEnR5E6ve+eUF8sQER7JMB9fJ1V5Jj
	50u1/YaevjFu/rbPtGlzvYm+Y3ID1oUhx5p6CIt5Qg5Nl5J3qVgLgj1vYPj8vEkFtdFsIQtvLth
	xETD/+fm5/I/GsM+emULoeGplJepX2wV65+Al3miaxVdR
X-Received: by 2002:a17:902:d4d1:b0:2c6:8d95:fd7e with SMTP id d9443c01a7336-2ca4487f4c0mr11769025ad.6.1782822567268;
        Tue, 30 Jun 2026 05:29:27 -0700 (PDT)
X-Received: by 2002:a17:902:d4d1:b0:2c6:8d95:fd7e with SMTP id d9443c01a7336-2ca4487f4c0mr11768685ad.6.1782822566664;
        Tue, 30 Jun 2026 05:29:26 -0700 (PDT)
Received: from [10.217.219.87] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca37c71e77sm13054905ad.18.2026.06.30.05.29.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 05:29:26 -0700 (PDT)
Message-ID: <1098f5ca-2273-484b-9e0b-26bbe9644c2c@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 17:59:21 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] spi: qcom-geni: Add property to force GSI mode
To: Pengyu Luo <mitltlatltl@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260614083424.464132-1-mitltlatltl@gmail.com>
 <20260614083424.464132-2-mitltlatltl@gmail.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260614083424.464132-2-mitltlatltl@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDExNSBTYWx0ZWRfX0k5xzRP+ATb1
 dQp/KtN+7BPkISgA7YDKXZ9R9A8ploPFqr72Mpk9SyE/HiU4YXE6x3Y+UWIW6TdjITW2KhMdnov
 Cq9OYyignQgM2KyWDkQYDrxL+ujFOS4IEs69HCjH5APSl6q4zf1U2aBW6nFpgq8rTHLb7G6Xpcc
 lbt4fDgqHC+Ls3nwaDYDKVpYZ103XIutiNYo6sE8GHifIiWUiTDZZiU2YdHxCJDJW+cGWc9R62p
 2PQKZb49kTSkpbwx1FXp0cosR1NnhaWzsCgdFSH2Wh09HTCThXKIJY+GXGUtJWbYXnqg1JzbNBk
 d/Fx3hCKAEOI4xXsNV/pGm7onJb1BSef8bGpceP1vKQw3ErJ+4ycoRJwnvqdleeEGlyX0wCfR4C
 uRfXLFhn4xB1j18uDyLs2edQatlqZDckhSRlptx9xFoKVcK1iyvd1DGL9FTV/FX3QxF3PTg++qC
 tr9ZMMkGHwazHsFgIVg==
X-Proofpoint-ORIG-GUID: fPbLQ4Tga8Eskh8M2ZjxFjsIxp6SketS
X-Authority-Analysis: v=2.4 cv=JqbBas4C c=1 sm=1 tr=0 ts=6a43b6a7 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=eJ7jpIcogiy-yz44Dk8A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: fPbLQ4Tga8Eskh8M2ZjxFjsIxp6SketS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDExNSBTYWx0ZWRfX8moPS+yNf2m6
 yy3YwKnZOjfsZzvu+cBWi3Gz5OWvli+pUw50i1TQu05cGsG+TkGlkdEG7t90W2Mh4e0ga/CbYFC
 4W/lHz4O8LjUeci3brqydV+Nig3pius=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300115



On 6/14/2026 2:04 PM, Pengyu Luo wrote:
> Some devices (such as gaokun3) do not disable FIFO mode, causing the
> driver to fallback to FIFO mode by default. However, these platforms
> also support GSI mode, which is highly preferred for certain
> peripherals like SPI touchscreens to improve performance.
> 
> Introduce the "qcom,force-gsi-mode" device property to hint and force
> the controller into GSI mode during initialization.
> 
> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
> ---
>   drivers/spi/spi-geni-qcom.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 26e723cfea61..eece7312f780 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -102,6 +102,7 @@ struct spi_geni_master {
>   	int irq;
>   	bool cs_flag;
>   	bool abort_failed;
> +	bool force_gsi_mode;
>   	struct dma_chan *tx;
>   	struct dma_chan *rx;
>   	int cur_xfer_mode;
> @@ -655,6 +656,9 @@ static int spi_geni_init(struct spi_geni_master *mas)
>   		mas->oversampling = 1;
>   
>   	fifo_disable = readl(se->base + GENI_IF_DISABLE_RO) & FIFO_IF_DISABLE;
> +	if (mas->force_gsi_mode)
> +		fifo_disable = 1;
> +
>   	switch (fifo_disable) {
>   	case 1:
>   		ret = spi_geni_grab_gpi_chan(mas);
> @@ -1133,6 +1137,9 @@ static int spi_geni_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> +	if (device_property_read_bool(&pdev->dev, "qcom,force-gsi-mode"))
> +		mas->force_gsi_mode = true;
> +
I don't think this is a HW bit, it's an internal selection based on FW 
programming. This is inherently decided by GENI_IF_DISABLE_RO, No 
exposure to the user/DT.
>   	ret = spi_geni_init(mas);
>   	if (ret)
>   		return ret;

