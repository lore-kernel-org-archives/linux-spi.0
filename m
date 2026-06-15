Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677652F8EB0
	for <linux-spi@vger.kernel.org>; Mon, 15 Jun 2026 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781523769; cv=none; b=lU+UuaNsIbCb14hPml3Z6yloq53O+XzbDr+CyfjUP0iTmresChUvkjdA5TuCfb6d/6c3QSecOQ2qFu+V2OOIYCiloOVgSHZREZ2zC+Lxfp7zUe5ldMvkebnq0dlak+iRDrhBbs893/D6qh4NgsopWR7o/5+Ixxf2t13uiMggaUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781523769; c=relaxed/simple;
	bh=d2A3H56c96ogqtKRqXPGR2WiKdZUuGpqLGk0A19DUtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t6FQ5K+MlgvkIhlmH04c7OZCuryamRE7XMko6ECjmoVpmCHBB9OHEDdcgezUmEg5gI/v0IP0Ct3pg1Htx5uqD0X+AxuSA/tnL661wwNdS9rFNUyY9Q+Rl4HM2dUYB3cyGMZWwjTpjKgwLxOLcmabIdeKf2jHkgfsZhnAmC04LwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JBluL/h5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IJTW8ZiZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JBluL/h5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IJTW8ZiZ"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FApRnT298290
	for <linux-spi@vger.kernel.org>; Mon, 15 Jun 2026 11:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hi8mNl/OuPgOWOdFW7792tQtaj6OLx58c3c/es7HvJM=; b=JBluL/h5Dzur9H74
	OAV3nxcc3wgep6MY2a7T4L6amzfzUo53eY727Q4xZWbljJnBnbGtuYgIfA+kfqq6
	z46QrRn3Pi3A5TffwnVXCNrXiHkA/XGjfCrt4+fR/u6QHpXhSas70ebw/SV8nW0S
	SnBIcX0InfPecNTX9Yng9r7EQi/pLMrQ8yaeDayj/OCO187IAGFw+uUXstaemn48
	NJQwIdn+G+NZRPrsYGc9lATBL0Tn1IXs6M/9yjR/cvbKYLGrarQ8Bm06HFjG2Rbn
	iJrkweRIEu4Jw3cAUtTppQ+SjFYDu74OAIMOnEwhLJ2QYvl3kuoeoVDneYG0sT+I
	YWs3bg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eter20gsc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 15 Jun 2026 11:42:47 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8ccd1c3b9caso12739716d6.3
        for <linux-spi@vger.kernel.org>; Mon, 15 Jun 2026 04:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781523767; x=1782128567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hi8mNl/OuPgOWOdFW7792tQtaj6OLx58c3c/es7HvJM=;
        b=IJTW8ZiZ7speyW1R7e2ZReOeZkl4xRbGHat7qGMYTSJtEru0g1Xt2qbqfEu74VoSzY
         3SWyFjeS7iOXQvxGuEEH/L1QoZP0p7yhgBbwFmqtQBSt08HKrh9bUKRucDb5x/ZiUobE
         okE0tTgAOEkk8Xo9jzk3JnBGv1671vDc1fyGsfb+l5z21etPS6fBfd1ICVF7aT5d1JEc
         k67GSuAoafB4a3GAA1vtN19X/5onHxPwt+RVPyTyMfM5WD4ldKhG8O4fM+Lr2YMjCTrC
         19VCo3Q5qZhiECtkTVr6SDWWnMJ4PRLcx7w9zc9yrrNurfK/IlhZ0qJ1/cqxrh1JYXv6
         e0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781523767; x=1782128567;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hi8mNl/OuPgOWOdFW7792tQtaj6OLx58c3c/es7HvJM=;
        b=IrZFpd3rmSuNsu1AbyOOeLAFA8xyqRzJ2/ihZs2C4buM32/oQ3ttTVqjaCMIWlqZBn
         NSu1T1iQPqcegD5gSA+rWFl0OlQ2UMPtdCzLmuSAJYSY5dtapvzb2T+tuy3SNzXLup2F
         BxqSfqIFpZkaFKT5ucfDGInRJhuVbzaZGh0DQbkQnZciXx10Pprvorz25C6MxBW7jhNL
         6vT65kBMvBc/VkTYFVp6L5dvJiykz42vo/sXnL6PUuX8mfpJjbpMR4hEixGZu75k0Dg9
         sPT6BXaGM7ovkpgtnfWJzF18UivTRtuiT1E4296eKvysuI4Sn04IcnlMh2Jqh4DQjc49
         I4uw==
X-Forwarded-Encrypted: i=1; AFNElJ91zgrcHWNb5QQO5vZNsBY70+ymJbP7PGbzC2efThUNNQafUXvFy/l2lSJ5HCvC2itBwMZqWS5OmzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyj8/BjkWA1pyxP1qOJGQ/g8G8LUITCS90QD4cVbga3Ynn9eRc
	E7eASW2Op0bzBA6CPxK57SuI5MHkPKNM3nk+VJQ6BCQgL9uokqcrUdH/PGOkmRJn1gdDFgCcQDP
	TbnSjbdiM3cEZ58Hefn0Vd0vRnVHs/dpYh3uQq3HaY36OP/OD02OE17QhxOqoXEk=
X-Gm-Gg: Acq92OG6PHviUXvhgJhIt51A5iUnOhjZbDPJBMJsOQRCuV5H1ncSFLSMogSKexmeOZ/
	A7S445jf4G1r+akZxweLrhrVF1sB8hJpZiq2gwaB363u1Mj0EnK2DfaglveqfXkMQjeaEgROpcJ
	3kTEO7GBNzQVovuo0XzTGPWPTFJghNl+7mqcWiiglvD8lAHV5retT4PN493aouUEuGIUEZ87uS3
	6MVkgmleN+cUvrIyJ+L9xfRkLTPL54/IZ2nSdyXk6P/oakpJjvikTQTDDDU4QZmbMJJH/uFYq3k
	oR4aqrhc1MpVL/zDXNAyIsnklz/qmGHTji1NxJB9ONblQa+lasF8RMRlI5XkwkNxrXsUwip2qoQ
	2LUWvwEIokxrS94yQ0RVsgc+YaF9VMsImaBH4OvEmkWJcJQ==
X-Received: by 2002:a05:620a:2714:b0:90f:7ce2:3019 with SMTP id af79cd13be357-9161bd622a1mr1230197385a.7.1781523766784;
        Mon, 15 Jun 2026 04:42:46 -0700 (PDT)
X-Received: by 2002:a05:620a:2714:b0:90f:7ce2:3019 with SMTP id af79cd13be357-9161bd622a1mr1230195585a.7.1781523766398;
        Mon, 15 Jun 2026 04:42:46 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb9013575sm459444566b.59.2026.06.15.04.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 04:42:45 -0700 (PDT)
Message-ID: <3451facc-4a2e-43bf-ba13-944488bce437@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 13:42:42 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] spi: qcom-geni: Add property to force GSI mode
To: Pengyu Luo <mitltlatltl@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260614083424.464132-1-mitltlatltl@gmail.com>
 <20260614083424.464132-2-mitltlatltl@gmail.com>
 <qwbda435on6rhsbf5o4jqijakanjmnmswnc6g6qsubuqbyvbok@fuoclv6u7tq5>
 <CAH2e8h5Swn2mWoz+t_nrSw1=hQttwi1Hx=dg=cd9S3QRnHjpSQ@mail.gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <CAH2e8h5Swn2mWoz+t_nrSw1=hQttwi1Hx=dg=cd9S3QRnHjpSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEyMyBTYWx0ZWRfX21w2qZE31Q/h
 mGX9cgzai4I0edev3o2j6+WMBLtv+v5EWLAP4dA4bxS7KHvqIS3atD47XOjAcLKJ+sGNR6CgHS+
 5uVEXegOWIWMK5OJ4BQeicccYobeW+s=
X-Proofpoint-GUID: UvakY7bI_CfLYQBPgFOkZPmmDj_r17CZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEyMyBTYWx0ZWRfX8z7Ur22NiILo
 bHsfabS0jUROww++IzE44m+dFXvOkSgH38hZ7liPU7FiXd0jWNxUiR+YzAfz7erZX+lAcBiXS3u
 Lf4ZcdrLUKKm/pEALtZl/Vmp1lvzrU9nfmA3q29HoRkHifsUw8BMZyDNfEKm+/QSHAipAYqT4z6
 PS6GV6+gBnF1u7k4Vjl9PSyam4m3azzmpbv2aR6/XlLL0U1UcwhAj9OX4zhvWM0XhJKYNz7F5AQ
 bJ9MnOOYNOfZE2gq0Hg7yz19q/VzeievUVYKM+oV3D26sR0k3DMCfKeKeLsibein/Mh4YWykJGB
 3PLP7Y3yzxlVC92uSKdQZ5ewMAGBFX7OrJEo3X/RYJ+WIbhxIjpNvvF9W9M6vGt3h1oBfSGY6XD
 lQgLVsqE1DYM2ZK7WABke/E3xvFJh4kFNcZ982QEm/Mp0VouyYdnJbFQcFsfknEeXdGs10sO3aQ
 PVdQLVX3fTTOLogw9DA==
X-Authority-Analysis: v=2.4 cv=F4tnsKhN c=1 sm=1 tr=0 ts=6a2fe537 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=yIUj8aQuGlWjW2UBUNMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: UvakY7bI_CfLYQBPgFOkZPmmDj_r17CZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150123

On 6/15/26 6:25 AM, Pengyu Luo wrote:
> On Mon, Jun 15, 2026 at 5:18 AM Dmitry Baryshkov
> <dmitry.baryshkov@oss.qualcomm.com> wrote:
>>
>> On Sun, Jun 14, 2026 at 04:34:24PM +0800, Pengyu Luo wrote:
>>> Some devices (such as gaokun3) do not disable FIFO mode, causing the
>>> driver to fallback to FIFO mode by default. However, these platforms
>>> also support GSI mode, which is highly preferred for certain
>>> peripherals like SPI touchscreens to improve performance.
>>>
>>> Introduce the "qcom,force-gsi-mode" device property to hint and force
>>> the controller into GSI mode during initialization.
>>
>> Ideally, this should be decided by the SPI controller based on the
>> requirements. Another option would be to prefer GSI for all transfers if
>> it is available, ignoring the FIFO even if it is not disabled.
>>
> 
> I have read reviews. Can we check if the compatible
> "qcom,sm6350-gpi-dma" is in DT? If the gpi dma controller is
> presented, then we enable GSI mode.


This hunk is very odd:

/*
 * in case of failure to get gpi dma channel, we can still do the
 * FIFO mode, so fallthrough
 */
dev_warn(mas->dev, "FIFO mode disabled, but couldn't get DMA, fall back to FIFO mode\n");

In my understanding, GSI DMA mode is always preferable. +Mukesh, do
you have any insights?

Konrad
