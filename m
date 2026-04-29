Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF973537FD
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777477985; cv=none; b=AuOD2bgevQjabCHNWj/KK9EB45JH3+D54yT/hWwfGrGXIkZh/k5CUhQ2CRLrUfL9nCCfNUV75i/TGfra4nIO/13sjQvVOnKwsMBbuhDn+IoLZzlK05GWOwD9m+xRfa/mNK3cgGKMP5BfVEsl3Df8EJCIa/BWitvoPMjAeMTUfOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777477985; c=relaxed/simple;
	bh=TGSz45bAa51GW3JYy9+OgEGO1IyCbLKsvBst3zfkub8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lo7IVysXVTmgA1p91FrhNf89VXrRFRYBlssVzXwf3wy6JcEHTrWilqjqUcDtShWiA6gYJrVq2N71bnvfUCZV2ewm3Ok0/BZ3lNiktz0sqru2boN6h0QYbqeykAWBJxcOZgef4UhkCF6ajIbJPSPVeAklip9Yo9QvUBR4++17hOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=edONtCl4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ds8/5X9q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="edONtCl4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ds8/5X9q"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63TCefLR317331
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 15:53:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qsulGSvKt5+B90X7opqTC6uDAze5yO3lFk0legS6Ob4=; b=edONtCl4aA95CSAD
	mpMvPYynHqhy4nyVuIl/VzgvFFJ9eqUmH3L0eblb14g8xJ0rgf4LCN0wg9LgU6Kp
	wybojh5/59d8Gr0VsU060ITkDWuGy5uIGUtxuqhkq3LjDNO9SYqoBPwc+7mGJcWr
	ab9TlKYpXwqQpE/7/UM623sG0FshvbCu14dcpptxtJTDCNSqQazAzXLVz96usV4d
	KUWNjSyeLVwt3f2SIve4fsFPJXtn13ANWmoVrR2dXgjQkpDKVQHTj8AQFOu1QfUA
	zYbB8xUWrOpUTVRSb0y6wekHSFxB0cv22iIS1Pbeu+Od6n8oSkhCES0SHbszAbDE
	+11YTQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4duj6t8qdk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 15:53:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-35da4795b3cso24459015a91.2
        for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 08:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1777477981; x=1778082781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qsulGSvKt5+B90X7opqTC6uDAze5yO3lFk0legS6Ob4=;
        b=Ds8/5X9qladdxLvFA5dliBiWsqqARZzBv6JLYyBFJ3JPQ1qdtY5lDSBHG7UjxeWDNZ
         9FtIwGot15SSz+yFKCe2gGCt9NQrM+CaSAh/fqvpKueuD8tUBdVwoipbNdHGe55IJYMb
         shJhXgXqqtmOxLNH56r4dQZBxxpcu7h/aOhrl9QUSZwyc2auYFF4iqJ+Ek1elnccVz4z
         tiW930tisHhGZWyMo5sRZZxeFFTnRXNuZIbb90OiZxJTtqv5H6FTiwV1TLm6AmRzBujI
         gSdfBWUvL7z9uG1sTGag/3JhV0oX5zwPX3frkDzSGwgEZhAnA4yCa5Pgw/hF2vvtjrEm
         Gm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777477981; x=1778082781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qsulGSvKt5+B90X7opqTC6uDAze5yO3lFk0legS6Ob4=;
        b=W5TyNhGORl6d64j+ntuOHg/jF2BA1KvNiSEU6pya0am3zg/7Zam4NZQdfriOGVd+PK
         pLrZuujgq6RjBKpvEuJy1Nc1UHBWhB7Ufowy4Kvzht6NbYJ1A2w5ki9WZ32mwtmqhKYV
         h1BmxdlFixAZrHRpsUvP8hmo88JwrH55tNQ3le08R1qshpyIXCoOWTorZbcY/rCBdrNM
         XQZg7Lt3J52fRjEhm4pk6TdCzlN3W4uK7WcnfAjDiPFMjElsRCIPYNAgPeZp46v14usj
         xpDcwKMgig3C9HCTeMdj+uXr45WW6BzsUnCeeK7qepEWwRJlP6rtROUH7oH5LNwZB/Jk
         cBbA==
X-Forwarded-Encrypted: i=1; AFNElJ8aSJ+TGUijCwUAoqjsoH3tcb0Z7PyDsh5eF2lhR5L6bIKuLSnUj0xZ+5OTaVFYi6O9CY1L1mHz/SM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRlq/+srVmYCYI+S9bTFfbrob5l11VyyBa+8teBAS9aZulukJO
	podMD4MrqbLM+uaKXUwAdzsBWS04ojKw+RHW1LqMzEBDZj2fdQsZ3Qa5gJOJpcrM49yVtkZlEh3
	ycz9+Edaz98vqz5qpkaFM3DxwMZxYAIxjGyEGgH3bUapDvLRgl/zok+3wSI1jXTo=
X-Gm-Gg: AeBDievEqt69FzO+XsvTJIiJiEQgamSSz3CZLV71KL8MTQr0Q1B0WduP+TEoeW9vCXw
	hfdQsbN1BXxB1lmj9o9sGnvwTT/VxXZ/cVgp/H075juOKlTrvXHnlgHakHfxNCBenzo262YppRV
	3Fo2ktBd8B8BC9/WFnrQGuiAEETMc4JWsIWm9zK1PPqyjoEmnRXLRJFamssKlyhAuRJC4sikTcC
	DRup9VryadFT7T0S+zbfJkRgzXxSZnIQbMf53H0ThPdj09HtodO1wTNjbSmYjVhVqG9Md5THS2E
	pNEMkIgt5VLNvCH1ztg4h+jUHdB6IYe7mlfCkw/wxUvuZDEGja9uBltEa688kABHJQykfli7zVP
	oMy7CF2vGm4njg4w3Y9oZaIU3OvfHX10ZkW+doNjQF4qHc2+A4srpTcGng6+p+96/Cac=
X-Received: by 2002:a05:6a20:258d:b0:398:8870:b58f with SMTP id adf61e73a8af0-3a39c174b39mr9500657637.14.1777477981543;
        Wed, 29 Apr 2026 08:53:01 -0700 (PDT)
X-Received: by 2002:a05:6a20:258d:b0:398:8870:b58f with SMTP id adf61e73a8af0-3a39c174b39mr9500615637.14.1777477981057;
        Wed, 29 Apr 2026 08:53:01 -0700 (PDT)
Received: from [192.168.1.8] ([106.222.229.211])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fd6514688sm2588534a12.32.2026.04.29.08.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 08:53:00 -0700 (PDT)
Message-ID: <dcdd1d49-a1e4-4c7b-a29b-187b2cbbdb7a@oss.qualcomm.com>
Date: Wed, 29 Apr 2026 21:22:54 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] Add QSPI support for QCS615 and improve
 interconnect handling
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260429-spi-nor-v4-0-73fb1bab03ba@oss.qualcomm.com>
 <afGNdfKrJCzGPy6y@sirena.co.uk>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <afGNdfKrJCzGPy6y@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: WNqEdBC-NZ0aPIIQ8DH2YBdFEWOCFPpd
X-Authority-Analysis: v=2.4 cv=KcHidwYD c=1 sm=1 tr=0 ts=69f2295e cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=wpQWusq9l5L7COxpp74EdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=8pjqX-Atbf6zV5YDAiYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: WNqEdBC-NZ0aPIIQ8DH2YBdFEWOCFPpd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI5MDE2MCBTYWx0ZWRfX63OnngiBaQ+s
 6x8Wa73GV4vzHxtRpJxJW5PyPhb/WcQU3Vxz426eo926AS/ZmB4Lmm+YzPyAlHs4VuW9ZalPyog
 OO16HTlTbUwmmw3nugVSuQjww1x8vLXwJR7U/nTz1DZ56XQUKh2P1JzuCl6v7/v15zao1pM2lrf
 nAB64aqJcsI4F1VRDfxAO5iHB1dZofGXnKQr8lbFUI4ykTM9k25qkNqsr6EAinJYxmR7sT/irhS
 RmYpwm43CWPClQ/lyuN4gceizB7IPkHIe20ChBdky7icsVmkcXzhG/Vcq54dB78bEAfBi82JlTz
 K8mbGW0KeDYtEVLsBz1ipHsnoT1Eh8zbbFcrwGXB3c2lKOtWp8jRqR4dvcFwFxRAUY3xax4pmCl
 GbosfD0AXnVRi6TRY44z0pa0OHg5B1zUATL4QzzqR7hay5t5NAZQphXPcGLWA7NCwDB5LAFeycq
 uoAQhp1HCpeNoSSdnTQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-29_01,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604290160



On 4/29/2026 10:17 AM, Mark Brown wrote:
> On Wed, Apr 29, 2026 at 09:52:39AM +0530, Viken Dadhaniya wrote:
>> Add QSPI controller support for the QCS615 (Talos) platform and improve
>> interconnect bandwidth management for QSPI controllers across multiple
>> Qualcomm SoCs.
> 
> This doesn't apply against current code, please check and resend.

Sure, I’ll rebase the changes and send them.
