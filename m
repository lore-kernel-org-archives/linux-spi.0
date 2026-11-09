Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794234820;
	b=Jkn/EtIfAXPN4QhrhEXHnhbJhZakCR4vyQ5AUuosiBG8gnCaWHK5egpd1nndDJscLKdL
	 J/wAh8Sh6viezpRgYuozEyUAD974MQHaZTkef8f803znRWKja17n68xlUBhLCOy/sb8Eu
	 EZWfBWw69E7P/Xnl8mnCYLRSYJ2l9A992lhelTn+Wd2ChqjcDP4EdFpT8FKTv95EcHls0
	 kyYFep3SBOCowwwJ1UjHBMAGpm2+PT8jokv+hU+rfeatidi8AwUR3hcLYSmyKwZ18QLgo
	 SAO3WL4AcfMp7SXPwpt4xagvLTdpURmew/1t4gtl4fo18JMxPNzdY+tj/fFzYep/3qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794234820;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=LzdcUGnHa1JcIxlDEp+JQ+iXSi5nkLn3zmwF0wQSnvc=;
	b=yq4rQitgowtqsxbgTaj7EIZFXh0UdhWNbph+/5pSvWKMZfIe6kupq0fXtw0C8ZUCeEPV
	 63WgmVUloOWesE2BBV2DJ7xYntUZRdrLF8XymA8desdDNkD2vPT/yqg/aqwYnO135whhB
	 DtvmltJCszTgf3UZCaUKAsCXD7b+I4RovfXg7Mfg9Vj8uCvHRskf3m55uVsmZh0hTkO7m
	 mNbLLJvSmUnKVf5WC8cl+VeWPl/1UsSzWrsIQ1qlIA1RPfhRi+H52Txb/TdZoeKj0TYIq
	 T2An4Vm0JO5iXRsGcB/5uiIyZdOAv8fQfwr8M9aYg6xCBN1V1U6LRpYAZujQQuJxmUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LA+1xtTA;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bz6eHkuD;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5607606D801
	for <linux-spi@vger.kernel.org>; Mon,  9 Nov 2026 14:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5607606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LA+1xtTA;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Bz6eHkuD
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DFLNq971519
	for <linux-spi@vger.kernel.org>; Mon, 9 Nov 2026 14:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LzdcUGnHa1JcIxlDEp+JQ+iXSi5nkLn3zmwF0wQSnvc=; b=LA+1xtTAJJxIVMht
	l/U6UzdQc712+X62A61o2OXNbrxt9nseabB8UoVTwbxmp2DMA+narMHLKqgv21S3
	H+GcaS+du0uQSGd8cprO9d+g/ncMNIl00x6a/XuBgWAZUKFNBB+HOeMuHJ7l0vQm
	FIr5Ow9i+7mPHkze15zhbAlB8QX9ayArzdnIvv74RZXkGSuPi1cVA2vI6woR8Et2
	jC7ZcbY4VR5TfD0Kx6obAkKlNWa15YSvRHVOHS8HSNLcTMctoNhtiL4jK38usNQo
	VRJIkytT3TCG5ndGKreTXgrY7CzyBubG/EUeRN9lH9RpYfhYaOYRiI0XiVdWHKf6
	j6oppQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4htuqm3jjq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 09 Nov 2026 14:33:38 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd65070d3feso484198a12.0
        for <linux-spi@vger.kernel.org>; Mon, 09 Nov 2026 06:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794234818; x=1794839618; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LzdcUGnHa1JcIxlDEp+JQ+iXSi5nkLn3zmwF0wQSnvc=;
        b=Bz6eHkuDq8tGabsrhSqRKUJIkC1XDtE7VUpdoBYKg4bt2LPTn2/WAl2pKXYa5GGYsZ
         GHEZg8ue4J+Zd1m3kmvi1b4Sb1jzz6x08U/ayifSZ/5z0KdfHF/Mkzb6q7DmMsZkP0mr
         zrQ1JWMNRWQVWprnkiZ/4UgXlbOUrNzMH6p+RlQ4qBfgS1gGc/YVZup9HNB+NvYL2XHE
         9oCNrTBsCwilrN1l6jXMQIxkb3D0mkp5OwBDfKKuqKjO51O9+uIzGIscX0fy2ct4RbVc
         l78b2NfYZjStk+QUJ/Ai0bZxF6fhO/ISEqi/MDhKDVSBhKcOdZ0p0U19rKwSHYxkIWPn
         1nUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794234818; x=1794839618;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LzdcUGnHa1JcIxlDEp+JQ+iXSi5nkLn3zmwF0wQSnvc=;
        b=Ka6i7KkPOTWJ7RNebkJwLMauGfuwFDB40hE8PsRgCw+7fBsAjXsMKLY/NzVU/uhHoi
         ElOiIZ4/5RgRwoMfnJl5DnrmHNhZjWMrGNrZfhGwGMyiPpcsxpknbyqbyz+HA5cCDni5
         v5oXqex4WpBK6Ui+fNKBPyZNPM6rl11wq6b1cycl73TLgngPDAkA7nYhaKU22zdou8Ih
         rU/AaXD3pSH2fHLOm3eTy9cWgCdYGka66PEb3clPfZfbb1NsSrEwMdDLBMvfVl5cwA8i
         sXc11QVws2w1veRn4VlInQFsBS7bRIvjPL9ZJV1Zfwus1tRClatRgCS5C9zfGKdSlNZ0
         l8Ew==
X-Forwarded-Encrypted: i=1; AL+hErGRosmNt9y4eH5Dmv/yrppzodRjPH+jSLKkA0GmgEPSwDpfXKSftCLV12LWm3yfeJPGec7lpUTJBnY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8/i1aC245ZRyZ1P2v0dSb9RjgkwKEao8UDLccOhDfdJl1sqTEc
	OS7zM+qtAatslcOeptey+AAQn8ihHaUDO32Pq0grdORqM1jfgoDXL+1EG4aWk3yJAwJeCkAlva1
	KonO63zkS8ufXhbGmnR0YJM7qrvbM8f4s+Lbn9GKdcb8ZZZJD19BVaGA2KJjH6Bw=
X-Gm-Gg: AYBFou0j1gBYe56oZC1a3KLMUDk2kCinN36xDlhLeqHrpCDwZf+lr44AWm3sNseg9Z8
	Ov1W+Et0ceWTcZkXCYiJ2xxXZ2LPaYEmDSzFdJmewk/3ee64zoftm5XcDxGLjEL9gwqN4SdC+wS
	nV8IPKzyGgPHFKF3UjeqQ5DvlocESZ+pSF9orwi+biCTQ9owidNHftaCgS/YqFcFg47WfKUz/9J
	SwZC9GCLjgOtm9qmWsNYanIKtMzQTg+f43Ve+Um/MtQX0Eh1KEoNoZevi4YiEyL6yMqkHrW2rbg
	n4TMsFGX6dyw++PDMhr7m+paH+FO5OvNCRgCrbm9D4sjTqOiShHzt/oQ3EqXHPIAE9dd4jNSarS
	ayJqaoTOcA/SUyzawu1NQf96AzrArve37wHrClY+QO5ZwCDcUUMyVIUy0k5j0KfB9nVKM1HJAfH
	zTlw==
X-Received: by 2002:a05:6a21:71cb:b0:3eb:b2fc:bed7 with SMTP id adf61e73a8af0-3eed2024dbemr2536997637.16.1794234817643;
        Mon, 09 Nov 2026 06:33:37 -0800 (PST)
X-Received: by 2002:a05:6a21:71cb:b0:3eb:b2fc:bed7 with SMTP id adf61e73a8af0-3eed2024dbemr2536968637.16.1794234817107;
        Mon, 09 Nov 2026 06:33:37 -0800 (PST)
Received: from [10.218.50.86] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b648e54de9sm1408883b3a.14.2026.11.09.06.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 06:33:36 -0800 (PST)
Message-ID: <2fc8f7ea-651e-466e-9346-c47e0a38c5bb@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 20:03:29 +0530
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] dt-bindings: dma: qcom-gpi: Add QSPI protocol
 identifier
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org
References: <20261106-qspi_upstream_series-v1-0-21f43042dd60@oss.qualcomm.com>
 <20261106-qspi_upstream_series-v1-2-21f43042dd60@oss.qualcomm.com>
 <20261109-wandering-miraculous-mamba-0cf21a@quoll>
Content-Language: en-US
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
In-Reply-To: <20261109-wandering-miraculous-mamba-0cf21a@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfX+ZITiU38FQuU
 CaZYHcap6kY/FaPYPEm2277kM5aGqY8fFuz3jbdsY/RmFAn06pMHHPZFwDk6gHe+akJ2QcbBEV7
 E1vdCm4e6gEh72YOQCzvaRu6uv/zTTc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfX7jj0t2q+SlaX
 FyHL+IVxu86CtREakuzWn+G6X3xhIYGou5kSLW0Lm+4+ROGFFbk+RxDhgmimpkh6Ado6qaJXyAw
 wBjpQtWaP1PDeLsC2Vx6vefRjJH6Ef/BNKr1X0lawpvg8CPt6/i++NqV8YBLNyOJ0yK9WhfZklf
 W8f4SGb3owVQc+ZcdqjO65X3Q2jaBg8r9KwOT7UtWmJiRbo6ACTsBZAMP9hu8PFBUJf2p1tnzKA
 vYDhnLRpNd62rJFEdMqcVVYcZl/gxRDibaVxtW4KpQnAbkd1mtzhj/lP++XTbgzcAkxfKKDpouq
 KJ5vHzK5Pe7Ge2X+97bMXArvFBXXMmig7y/ue2IcNEmoSwgSsVoTe3ysMUfExjQxD9SGAhSeOMf
 azCIY4sv4wdU0zqLv42U47XrLgYcs6wj4YNC4DQzC5/AlM55UybkCTIxjT9Od6SNXQIBJN5KJ40
 6XYQoNMKupfOKqCoAdA==
X-Authority-Analysis: v=2.4 cv=JLquIMKb c=1 sm=1 tr=0 ts=6af1d9c2 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=lXLgDm0nUj_2s8HzTMgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: sTDBjWxVWtrJByyb--sSah11Aenx-pzZ
X-Proofpoint-ORIG-GUID: sTDBjWxVWtrJByyb--sSah11Aenx-pzZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090057



On 11/9/2026 7:12 PM, Krzysztof Kozlowski wrote:
> On Fri, Nov 06, 2026 at 08:31:20PM +0530, Jyothi Kumar Seerapu wrote:
>> Add QCOM_GPI_QSPI to identify QSPI (Quad SPI) channels in GPI DMA
>> specifiers. Its value, 9, matches the GENI serial engine firmware
>> protocol ID for QSPI.
> 
> What is GENI serial engine firmware? How does the Linux rely on it that
> we add bindings for it?

Hi Krzysztof,
GENI firmware runs on the serial engine’s programmable sequencers and 
implements protocols such as SPI and QSPI. Linux configures the engine 
and submits transfers to it.
The existing GPI DMA specifier includes a client protocol ID. Linux 
programs this ID into the DMA channel and selects the corresponding 
descriptor format. QCOM_GPI_QSPI adds the QSPI protocol encoding 9 to 
that interface.
I will clarify this in the commit description in V2.

Thanks,
JyothiKumar>
> Best regards,
> Krzysztof

