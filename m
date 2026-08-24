Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277DC41DE02
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576146; cv=none; b=mPmDr/E871zOew579Nox9GlhOd9vF7s3WbzyfBbl5VKIL+9CFx60RrAgMb9UoLCezHXgxFfHd/QqlmS5KXcUhm6dZ1W0f8GeOBfW1ndrY3PXXATyk77QqCrUTbAOB3B6tA5aK4rjZ/MCTU1zOsK/weJrMfAl4zUfO6eWNjpWTKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576146; c=relaxed/simple;
	bh=pKILCIAN+R1XJIexmr3duPunuNDAf8Haawwh/AnvhFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ucT6DGE8DEQgdN2OnJBiI1fpEqCdZJ5E6stWmq7x9ISl265BXdAGWoUnN+bJ4+8ZFalqIq9w/Rm38QaWJkWcFRu/3PxQYP8L9GFmlyf4NkyJ05D2oNHd+eSFTv79uopcoFJ05JZTs5FFBHpdCN2pYqtzhS0cH0Z2cJjQqqoBa9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DcRW/Bzs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A3VCcbHO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DcRW/Bzs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A3VCcbHO"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OBMVOv2372293
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 12:55:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rOaylOn1lOxDzyU+vOEzZ5eDL2e1rhW0wfVT+oTC0xc=; b=DcRW/BzsWc8h5CCJ
	tNBRIVKUkj+vKHD6u8gZL3my4n8CVj055G5DarI4DxefZXR2pKYWIW7puazkXQ3K
	WSjwEJzgPv9/e3i0we7yu6Y6bfcIaubu2e7i5nBP2SXt+9BTewdQfS7KNr62qySQ
	RU0rtyLRu3i8fX24nogft28/zl8QnThy5iBrKiCdm2A+8pTusVxD8buJlIDE8vg+
	m3oLsMOUC7KrLvblK5Tk3ZNpPHfoO2I/1Cfab6bPQ+VmRJyFFWBkud0cauDwwj7V
	C5YeKhDfj4Vv4orUYbVpXKhjaj3ZnYpREJ6giwUqOzYK6EKjRcPac9OvNQsTNSWh
	z92obg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8gdshp60-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 12:55:42 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-73a1cf1638fso60682137.1
        for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 05:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787576142; x=1788180942; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rOaylOn1lOxDzyU+vOEzZ5eDL2e1rhW0wfVT+oTC0xc=;
        b=A3VCcbHOB03Ut+BJD6ri0oDCoK/Z4XTe+6kMUFAjL2T4p2dqMsUwoIabj2f8vJLVnF
         Lk/Wk4+V2yS8SZ55vUipdXvjGHiX0s4fyb3U8Mai+dYF/XxdTuJgts3xCBtQnYS3nRxT
         gBqiQ65K6WFHTrMaFiffrPCCaTfQOoEn5uMiY20ySBWUUcfUrKLQpRGfdVepurSeylSP
         i4MxI4PSAs/Rck7UAE7uPmHcJi6Mr1kYinxtvczTrJibYKwucEUSM1CGgPLCZGY9B+rF
         j7Bsp8OgAa8GG8QIkvYUc4d+BAFZc77W7YOZfnZVuel6+37fYg3qf1V+wvuKLDV4+W8j
         DgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576142; x=1788180942;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rOaylOn1lOxDzyU+vOEzZ5eDL2e1rhW0wfVT+oTC0xc=;
        b=PSrn8gPMc6+86RaFZPhThE42w2cznBpJnW3MjCMGPcI1UYyqWm8+S1WRCTOhZ4sL5x
         I1D/q4Vli6qa/Rwd0OyPTVjCMnndJgKBy4NLUsAZXPZP4GDaHjhrTa8cU5DJHDLZpP1B
         lPPN9d3/ePaAniwhHi3K91O5yW6EeKXnH+Ng0KuWWScsGRJiEbiOv7bBreYzQ+nbqy/S
         jAq90KYrDsBHnEBC/VJ8UnAAGe6E0H0RK8tV8m7IxbuimEgLyV8UxVhUfq+0XGPoqita
         qKUDiXGY/6U593W2x6kYyRDx9O9zkOcsoTildx6gLkAof8DjbUPEaB9xwg3SH/Spas2+
         It1A==
X-Forwarded-Encrypted: i=1; AHgh+RqstuRcbRzc6FvWv7gwIcgLe7iHnKG+WPukNu3De35cedq5hQqPCTSkrmSuA5sH8/d988kTiWKH6NM=@vger.kernel.org
X-Gm-Message-State: AFuF++mxJIo3V16AKCVkjmvWmJLc00cu5ZbOM1Md9AvGUAX8mS4F/cmQ
	KhwL7IpZjk5If55ZvlSiYMdCnWXeKPegIEwc+ksvaTLlnmMk/q9C0k20q3zHDh2p7FnAR6yGbhk
	ROkcr4fgMWwPPJsxiBgg1+ISSCcLNTT+U1xrpWDd8mUlt34ngdJYdQCtOCdt9v5WbeCGNwDc=
X-Gm-Gg: AR+sD11m4/c2jGPkYK8Mo65v/lDmLihvl6n7I0htViDbrXIVHfdELs9pH5c1jxlj3F5
	WQpPkN2TDBBAx3lyLEwtT+e7MjE8c/22SU6VsStoYIGgNa/XzAkKYev2ktBhuHtSuemq67n5Q2A
	7Ssqw1d1wMW1nxfAXVg6kmrM3xG6BI8Q6HRpZQOXxain9sz82cxwAflbrgYDg8kCHcFm3Vm9wMq
	8UheLTeeMCsyITyyo/CdNFNASG+9aNN+qm2fmIP0IKygrRvuzWCnyCvvXgn+B+PHVipOjIOtZk1
	rDTt89uYx4V4pdzr8kdQ+ueDzFeFweQTPp4H97GXnvAu5YqzIMRgMSGjzUtkGPck4BixnsvgPuf
	LcZXw5Uf96//UeQ8L/jTY804S
X-Received: by 2002:a05:6102:f90:b0:779:7d3b:1398 with SMTP id ada2fe7eead31-77a5edee8a5mr3839436137.0.1787576142288;
        Mon, 24 Aug 2026 05:55:42 -0700 (PDT)
X-Received: by 2002:a05:6102:f90:b0:779:7d3b:1398 with SMTP id ada2fe7eead31-77a5edee8a5mr3839432137.0.1787576141876;
        Mon, 24 Aug 2026 05:55:41 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59dd550bcsm9324844a12.0.2026.08.24.05.55.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 05:55:41 -0700 (PDT)
Message-ID: <9f51f316-1303-479d-932a-a688799796bf@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 14:55:39 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: qcom-geni: rename setup_fifo_params() to
 setup_spi_params() and make it void
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260824-spi-qcom-geni-cleanup-setup-fifo-params-v1-1-bdf98ae62953@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260824-spi-qcom-geni-cleanup-setup-fifo-params-v1-1-bdf98ae62953@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: E8cMXdfEoKeLWL0Qi62NPXKFhcfT-PUD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEwOCBTYWx0ZWRfXz1yfxWKqrG9o
 NCzVA7cQDWFlrAJ8U99hVeOz1kcPckjSP7HcIr8MR9xsoaxtF/CRclTZh2vjQ8fqDBFBEFOPeoh
 fiI7byCx5KUNGAtZGV4Gbj21zYh2YBTk8LJgyuXYF5m8bpier7KvdN2O7NWkrMGZDQXnsRz2Ud5
 /P1UHDfU54SKEwTJKDUHxGcuoRp5wKtfBsOn2EAjhmreRJk3fnG3+7FrjzdPwEIO5znR06wbpO1
 3cssmyGbv+OCJ288bdsyQyOw2Vx+vcZnW1HJxztTd4LJAptSEYnx3YhFES12wVK/j7Bj7Qo9iSp
 d9LB/buBICZV8gYID6w5x1AAKSLY+lhJY6OOHFWrOlXr4x2pxfgrky99ITYEo5eCoO/MixRmiOq
 u6YlL5ZL+YsqSGXqMhQqORLRZdzYRtChU/fdE73+nIpkO5iAopp/WoVv9tAepnX/l/0njz+gHSa
 YyqzL5r3UtEA//xQksg==
X-Authority-Analysis: v=2.4 cv=Fqo1OWrq c=1 sm=1 tr=0 ts=6a8c3f4e cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=pkmFLQsO-xIKxrFyL9MA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: E8cMXdfEoKeLWL0Qi62NPXKFhcfT-PUD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEwOCBTYWx0ZWRfX+wEzwK34Py6J
 r1dXW+JvXFri9p/g67keRDNgLIp9WVKAP3dSv/uldeMS7BBqF2Y3E/8KCq7fmuwcmLo7NvIhZK+
 oaUiGuYSUivPxrC8IgdoPPhE3DEB0Vo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240108

On 8/24/26 12:13 PM, Viken Dadhaniya wrote:
> The function always returned 0 and had no error paths, so change its
> return type to void. Drop the now-dead ret variable and error check
> in spi_geni_prepare_message().
> 
> setup_fifo_params() is called for both GENI_SE_FIFO and GENI_SE_DMA
> modes, so the "fifo" in the name is misleading. Rename it to
> setup_spi_params() to better reflect its purpose of configuring SPI
> mode parameters (CS, CPHA, CPOL, loopback, LSB-first).
> 
> No functional change.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
