Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F802C237E
	for <linux-spi@vger.kernel.org>; Tue, 30 Jun 2026 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782813163; cv=none; b=IliLP7Wb7SBMsaJrubv6GhEgmdk9hQR8+SIwt6GW1OY7QtQbkp4ZLSDj5kaPCmjOWyPZXgkbdGpjg9sAdRUU5BYw83e41eC/uCSD+kBfNbseMMpDFkGd0WXvfZYuOsIOsEfEeRJtadsCQQX51DmglioS08kFePwhcCw2NTW2ROw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782813163; c=relaxed/simple;
	bh=XHVFIYZdq7kDCqEYfKMHnS6JrUs1jlCfBepzpNlvLB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CcU2Bo/gjKXPj/BKEkgDHS2Go/HluX54tj+YmJTo+5lEbJxYJQN2Zx76lsB/KPz06aygylszmW1Lzehxq4B4YInWPzKCSimENCinNvpA7jrTH/LW4DpB5hdK6yTBjLL4iQWhuPZezbAEqpbfM8+A7Vi+PCWSp9X1jsG0Ho+YXyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fAdX0uey; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UJy2OeSR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fAdX0uey";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UJy2OeSR"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9nEGW1590709
	for <linux-spi@vger.kernel.org>; Tue, 30 Jun 2026 09:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	hIHyDpjCFFNejxG5BaRizE1VIsC5hN9kk7je03IArLU=; b=fAdX0ueyfz13bzn2
	6yUJ3bg0/TouZE/4rHKQOVX2Ue+EOxMrSi4XgEC1Qy4+zKrjGIx7ZCts8OUIyc3E
	jR+fZbFLWAYzhxFQRoH8fW/kb4Ou1xFEaqQhXx7NHbZD1C4bCokGUTu3PUcY8KtQ
	AI7BFXAD2Ih0xxfAmWD0RuEUoFxtodj8bXnO7pWHIZO5kFAxTzqhgXLml2J52J7X
	yjJdPCD9aesd3moPDJxk7QAlWZrdNgeaCWFZKV15bBRDLv/5pf9I+QFzbMXe9tGl
	LPdKFqZcft94PafF+ZL45I0xhw4IJpMAfXLtAVqpcs8Rj5lZj0q+ohihB2+c1tHV
	U8o6sg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3y9k2u0y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 30 Jun 2026 09:52:40 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c98136ceff4so1986787a12.2
        for <linux-spi@vger.kernel.org>; Tue, 30 Jun 2026 02:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782813159; x=1783417959; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hIHyDpjCFFNejxG5BaRizE1VIsC5hN9kk7je03IArLU=;
        b=UJy2OeSRRefYF5XXlUjN09KBQ0ZQ7e4W09Ij6EGfMoM0LAeQ7OzzNtRD3Jgef9ioza
         Q9xJ/e/8qKF2ngz8TddSAFCUG9h55MV/lbvSSe+9tyXD8zKd7IkD5czELgTlgYw7ymRB
         WuJKVFKt0wNGSaFZB9cQz9KmU1bxhzlfeIrWWcpDFuuJTPlyTd20JRv9x1EX0c7pWhHT
         yrl/xoHWwMxFU29Rb4qXBqzA8fbyo14vRZbvWjUCZg0Tr/sYoc5EcK39siECJv7yRmKH
         3gUQ4frJpv3T+9Rp9THpWuZtc/Nb6H9JFkNByPF57XE/yNjh29C4FbEYXP/ECGWzUpxi
         50eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782813159; x=1783417959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hIHyDpjCFFNejxG5BaRizE1VIsC5hN9kk7je03IArLU=;
        b=TUO4xA8ds9UYpEGbgn+tsuKoAW/xjupznnfq18hzifxoMjZ8wC1nnUhpiSs5OzdWrp
         5W4Q6Nb5x8825x8RHABOZBtm+uISh99z9QAP6q7D9JKM9c8tETJqGlTxXIyJbVvLfTQL
         ir2mNDmvU/Rdddv2drTP/wB+t99uNNoknrfoLhg5Jrh9tw5oOfdkaEYuEqqG4fXSSNP2
         7KScSNKgT5mZJpa6pIRVJBGDY/uDCHzXSOK3749c37lta5ZXfpgsgA2KNM9jQgkTTGYe
         IWxokCRXQzSaf5pxfnOoMefi1lCr7UrW+EV8SOrZ6hyqBteEfFhn3MPkEaXE8N5GO/R3
         Ocfg==
X-Forwarded-Encrypted: i=1; AFNElJ/rvC6t1I+tHIepOL5P3YZkGA9gvz1uyIvhEsk9z63YXa4L+0EKcGIeL2712jvJLH4OTyM2nc18LK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ6iuNN777lvRzcdEflMtuD4zPjoDnzUCBGbM840dznqDEvf+m
	5oKX4P503zHs+RqYoXdYkTM/mbbC9jmyN6eBg6DSTmmOk6oh2wHSt5SJk8qoXTR9LZ0mINwnNiR
	GJSlX90YoSP8Xqx56OSwf0THuHVIfiN1bHsmFlGkUsp/i39RtX6gzO0oCWaAZMps=
X-Gm-Gg: AfdE7ckK7glMp+ONHDGD905hzKnlWwiS1Xu9akA9d2Mb4ANA7224m8W56SRIvdf4UYF
	oKouivQ15tUjD+Dhhv6i++nQ/FZNzkdKgb5s/841Oucq8WqYXC8Ai2c1Vdgr7zCR/3IUlVBeqT1
	b44xd5o29AAv7SIFLUq2KQTOFu0AYs12B1ZYYwH74nuQlQqCF7EnXx1Beov/w6wP1kovuR/H98X
	l57u5d3kfLboEG/OuDzBX5N+b6Mta2C6d2+fGoXsrcBRlWbTLuaqiHTDiubr+Pap//0hYNSR6BV
	QLxCmjRxP/V9oKwf0ZdS6WAnFfiix+aMMfi/Wyw6xlE6QT5Gcpx1P4g4HfIQbyLnLMdLV3+HWw2
	ZGCYSwh4teSbXkBwa7cjiiYYvCs9Xi9/VVyosTocQDv6S
X-Received: by 2002:a05:6a20:914f:b0:3af:6704:18ca with SMTP id adf61e73a8af0-3bfc527279fmr2374621637.35.1782813159134;
        Tue, 30 Jun 2026 02:52:39 -0700 (PDT)
X-Received: by 2002:a05:6a20:914f:b0:3af:6704:18ca with SMTP id adf61e73a8af0-3bfc527279fmr2374608637.35.1782813158642;
        Tue, 30 Jun 2026 02:52:38 -0700 (PDT)
Received: from [10.217.219.87] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847a03778basm1562456b3a.49.2026.06.30.02.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 02:52:38 -0700 (PDT)
Message-ID: <99eaf1d1-fbf9-4336-a13c-ae8ab789cc99@oss.qualcomm.com>
Date: Tue, 30 Jun 2026 15:22:32 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] spi: qcom-geni: Add property to force GSI mode
To: Pengyu Luo <mitltlatltl@gmail.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260614083424.464132-1-mitltlatltl@gmail.com>
 <20260614083424.464132-2-mitltlatltl@gmail.com>
 <qwbda435on6rhsbf5o4jqijakanjmnmswnc6g6qsubuqbyvbok@fuoclv6u7tq5>
 <c29776b4-04b8-4c59-8f1e-d766bf982a2f@oss.qualcomm.com>
 <CAH2e8h75xeRVvo+jOjRuFaBko5NNCnBX0dawFFsWBaiTwNd4Xw@mail.gmail.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <CAH2e8h75xeRVvo+jOjRuFaBko5NNCnBX0dawFFsWBaiTwNd4Xw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDA4OCBTYWx0ZWRfX8m/b5hZa4tEy
 gLpVcF8IwcbOBPrw8DREnWP+1H0+i1XM6XNGeCY7NZAmVkM2iN7uP4PdajFVY7gavKfPDRh2el0
 HUFHp3VRmIsBdJwwCpoFYZMSNJiy/MQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDA4OCBTYWx0ZWRfX6gsNnqlaJ853
 YoxSvUz2u+gFLmgmTMnhRw63iLqb3DvykQQoIiaiQviYiC53H22ksQHxxOULfe+kfsa4vvMdDrF
 iRQKkDZ5bG33jbTETq246NdiKcHPtuuWsgZES3tMowYFZh2KBPjFAt9u39+dVnqtjemqpEBu0fu
 IsqzS6hWy4Auqk1ia/AXriAwStJwSc35bhf8cGyWw/N7i0/ANpF8WtRCw3BHb+Guu84BVNfdfZk
 IHS9t+SOH2HTAdzCx9OBfTq/4MDA4IOH6GqNGfHPQCSTb7/n6MTtb2e1Pa0CSH7hgO1CAlYRxlY
 d3pNHjtOEsRG0VFjGM3XwDvNyySg4TZyveer6hU1cAsd7DvU6IF2qXLeFAoWjadGz/Pjdvft0JK
 mZ2aLwlYImFKZz44mLvD8dmFqtoRURnvz6Nac+hjdRj/KMuR8+bF9W2VvWm0GriLtQMZLzBfvqb
 L/Mee0rP/hNSJmJTi1w==
X-Proofpoint-ORIG-GUID: nRL0SpPK7Np6ptIltGIKE0Ho4AfjvP4N
X-Authority-Analysis: v=2.4 cv=TeqmcxQh c=1 sm=1 tr=0 ts=6a4391e8 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=j4H7mO88qUtPRE6yNQoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: nRL0SpPK7Np6ptIltGIKE0Ho4AfjvP4N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300088



On 6/29/2026 1:33 PM, Pengyu Luo wrote:
> On Mon, Jun 29, 2026 at 1:36 PM Mukesh Savaliya
> <mukesh.savaliya@oss.qualcomm.com> wrote:
>>
>> Hi Pengyu,
>>
>> On 6/15/2026 2:48 AM, Dmitry Baryshkov wrote:
>>> On Sun, Jun 14, 2026 at 04:34:24PM +0800, Pengyu Luo wrote:
>>>> Some devices (such as gaokun3) do not disable FIFO mode, causing the
>>>> driver to fallback to FIFO mode by default. However, these platforms
>>>> also support GSI mode, which is highly preferred for certain
>>>> peripherals like SPI touchscreens to improve performance.
>>>>
>>>> Introduce the "qcom,force-gsi-mode" device property to hint and force
>>>> the controller into GSI mode during initialization.
>> Why to force ? You can directly configure in GSI mode. Note there are
>> some configuration done prior to Linux bootup too.
> 
> Sorry, I don't get it. how? I know there may be a qupfw, but it is
> impossible for a normal user like me to generate one with GSI
> preferred.
> 
If firmware doesn't program in GSI, you can't have this working in GSI 
mode, its going to fail (and work with fallback). if it's programmed in 
GSI, anyway this will run in GSI mode. So why to add extra things 
without any usage ?

> Best wishes,
> Pengyu
> 
>>>
>>> Ideally, this should be decided by the SPI controller based on the
>>> requirements. Another option would be to prefer GSI for all transfers if
>>> it is available, ignoring the FIFO even if it is not disabled.
>>>
>> Yes, it should be decided in advance and configured accordingly for GSI
>> vs non GSI mode. Because there would be limited set of GSI pipes, which
>> will actually make must have GSI mode device run with FIFO mode.
>>
>> Why don't you decide prior and configure for GSI mode ? We don't need to
>> change the current logic of deciding FIFO vs GSI.
>>>>
>>>> Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
>>>> ---
>>>>    drivers/spi/spi-geni-qcom.c | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>
>>

