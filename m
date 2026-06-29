Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F077B1ADC83
	for <linux-spi@vger.kernel.org>; Mon, 29 Jun 2026 05:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782711421; cv=none; b=bQq6XgfsC6xsVhHFZNN01QFnw9HN8YftlBf5KW0Q6VhtrkUwl7VbgJleU9BlttAoPYmlZSg5jIfW/tNNf6qxI3wfE1VkB9ALy+ge1AA0IhO4ry9+zG21acUXdZXKT4xlA/ePKJLOecPL6tGzX3wTAmHRt8vU5l0ICH/e9fRtLiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782711421; c=relaxed/simple;
	bh=T5xDfj4gTS1yOYXj9otH5qZUmbNKwm2UXsV/Ibrt4Go=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y3BBAiXFzgVR5dS3MPPw3GcH1LyLNmLWNh+QkyojLrVlXt7Hb2RFDjE+VMCTwYSy+Dzw3q6kUo5VDLvSOAr+B5DqYTun1qg8Lxbi3DB4IGaj3+XifnQTD5LeG/3luB2x7Ggl6OBPbZwcRzuywLgAkfeDiVCqEEns/mgtCFFGwU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h4EVGE6C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a1CiB3Nj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h4EVGE6C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a1CiB3Nj"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T4NH5a1737513
	for <linux-spi@vger.kernel.org>; Mon, 29 Jun 2026 05:36:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4+qSzHrPZLIcegIwXCxSbL9utxNx2NUsdPB6ywBdPMY=; b=h4EVGE6CPcygfKJ8
	J/ppWPnDwOBiqTIwRNMgaubFk3tCr4lqdG8L5H85zcRFV+s3H2Y4dXfPWRqKzZH+
	ygq7yuHDuxKl12II/s9PZTQGAnvsxAvDMSRJ2q/6aNfloFXw64HoZCG0ZDZJ19vk
	d7TpdkteWu9iWjA+rbalfRH0okiiqoT2A6R4g6NIEMBhrZDTFo1IeJaHVPHROaDM
	OvbEZZNTWeq7EWvyHZC/AAM9H5OjkxIegBMjQchOEDox7RC7E5SP4hdP7YzYhdpa
	H/J0vMo/KSfgy9UGExB2XG2aEK9Ok6IMLif4W1H+r2CZ9IyyuDM6eipBTnD2FgVf
	Zf/oOg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f279cmjvm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 29 Jun 2026 05:36:59 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c916d17dd43so2986601a12.3
        for <linux-spi@vger.kernel.org>; Sun, 28 Jun 2026 22:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782711418; x=1783316218; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4+qSzHrPZLIcegIwXCxSbL9utxNx2NUsdPB6ywBdPMY=;
        b=a1CiB3Nj22ItZj6GgzZfHu/47G3nBRR1m/QHaJhyK0YID992+BzE1favQXB4RTkKdf
         oi8komVNWMNVh3BRWY/g0v524BaIzsIj1dxWX6rHpdZja8JAKHBIhAy4xPgsccv+DnzJ
         PO6BSkd3QUQZGKkJCbRfX6Qz+xe90aMeb2tk2G2h1KxdVBY7a/surXplTuH4X3no3GTv
         xJXfBGL5j+BqCDun3xaEFjlPwwVKWiFbxoq4fxZl67svwQfnkSlz3cF4jNrHbIyLLypE
         48U+fYEPmPdsGw1Rw0Lw7RxxOjs8CH0CpJ3EpvMOtuSkY0yCarwvNXVFUWzYj1BvRIu8
         8NAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782711418; x=1783316218;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4+qSzHrPZLIcegIwXCxSbL9utxNx2NUsdPB6ywBdPMY=;
        b=GTeYHPPO0E1FxhLw/0iQDwQIaruu+0lh5HoP2qyhfLH5JCT2MGLKbM+Pn2pyx+w3HJ
         L0XOeORe9FbI0B8Z49c45xJvN6+lv1NPkNl7xNi33ciBKHBjbLyyXLfhvhVDwUTZgglF
         4xpOh/FLngK4m15FLNQCenFmYRSJGk9q2E+dL/b9uiyWEuYxD2uHylVxPyfGjkOrGKHm
         CWDakAP5AJQgVapFVv7olU2ZmrgcbbuSZ+v9mk2MzgTTPpxCBUx58CdAOYHCn9xcCNQy
         MEBejDc/X2BxKfIwf5c0Ip2NZ0deE15n3/Gqd1zwd1uoBRTCWQgeB4nmHGMFTki4r6vC
         n/tQ==
X-Forwarded-Encrypted: i=1; AFNElJ8wzVQ9KAJYkQKox5h3ErUt0Nw8yPV+sjus/6mh+thaGcGbE37YRaY/QflXY7hyO9eYOyD2QBjRJhA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4D6A3HaVge5AOIKvWHO6ngsiObsTagyut/wspF6GKX1EauP74
	Qu5fqWmmIN1suTjvi6R74nRP/0asXVo1+WfegmwzW0ZX4zNfTEuiDZ/Nb5vLD+FOYnLoN6zNSjK
	//1DkDtLN6x9652WKBISr6WBo3XsKtNY6wLwhAda0a13m6OilQxvAsYUojkcFmhs=
X-Gm-Gg: AfdE7cl2Ph0LlWX9E8p2ayakGvreIDaBdq2hJDBcZXeaRzoqNbrFLS29hjlhLTgEsMK
	w2MpTJQ/i1DAul2JDHBO3DddTvZOCrD0JapSsgxdyVcLe2isg+kMH/Aj2KzynMFL8E9UAuhYCVP
	LzCRSNmBsCLZfKrM2kvmDTw98+n+X0cNu0CTQ0PEjBGeJkZ8j2C+SGYoa5NCVOH0LvOZY5SxK56
	DvDjPo8BFcemjywJXt84S2My4qDFD6/kUY19ASGcnQf/FAD2zQUPfv9ysHZRn8hDGMcea007MnD
	D9JiBRB5RPNGp8LylhmuKvKkxpt2M/sWtf8ln/UIYOvwzDJ/w8us3AU82OcQj7vFyTE6J0rAaS5
	bd4oRQT1WD2WeVMtKD3JbFh/4TRElwBAcqVeMxihUIRI1
X-Received: by 2002:a05:6a21:9984:b0:3b1:cce5:9140 with SMTP id adf61e73a8af0-3bd4af44f93mr14859449637.33.1782711418499;
        Sun, 28 Jun 2026 22:36:58 -0700 (PDT)
X-Received: by 2002:a05:6a21:9984:b0:3b1:cce5:9140 with SMTP id adf61e73a8af0-3bd4af44f93mr14859429637.33.1782711418079;
        Sun, 28 Jun 2026 22:36:58 -0700 (PDT)
Received: from [10.217.219.87] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c92bc1e0a90sm7143143a12.15.2026.06.28.22.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Jun 2026 22:36:57 -0700 (PDT)
Message-ID: <afb7e30c-c9c8-49d6-80a9-1aa9671b3a03@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:06:52 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] spi: qcom-geni: Add property to force GSI mode
To: Pengyu Luo <mitltlatltl@gmail.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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
 <CAH2e8h5Swn2mWoz+t_nrSw1=hQttwi1Hx=dg=cd9S3QRnHjpSQ@mail.gmail.com>
 <3451facc-4a2e-43bf-ba13-944488bce437@oss.qualcomm.com>
 <14491fd8-f785-4404-878b-5764bb8fd593@oss.qualcomm.com>
 <c22f82e1-65a8-4472-924d-91908f4d6104@oss.qualcomm.com>
 <CAH2e8h52YaKNHvX11HheFAK9XJT9KREQrQ115AOEOJS22UWV9w@mail.gmail.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <CAH2e8h52YaKNHvX11HheFAK9XJT9KREQrQ115AOEOJS22UWV9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=evzvCIpX c=1 sm=1 tr=0 ts=6a42047b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=-sOukg-g24Gd-ASWQDMA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA0NSBTYWx0ZWRfX8dd1wRdflLIP
 wJINVY6Z9IqTd7+0M6d6GdDeE/ESFaBH4rL+a+JnHlai8or7OgUMrTeJYHB5lsQNy92c2hnlPOI
 /y/SftdGXbu05Fs86L77Diebf3ev9QU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA0NSBTYWx0ZWRfX93V7Swe08/Yc
 KZXtFEvPV+oR+JfTORNCMJN4mv1fJf6GoHaK+bO3RuQvwvGp0n01NG3GIBFEIfeEbiQEjesblNA
 F4qU9FfIDSDiPqF16GPqe7ZHcQuAcGOHjU75/MIZLPs+JniEj1+KxIllsH7jIqTUe7ypH+Tuxg9
 RujlaL4sEZvOtJ3jsvtv+iCGcDu7IgRvRjLrBiNtei5SlutSZ8kqzYaxIQXq28+KcgreWILuNHM
 WswQhTzSP9kequQVmuaHXUTveF3zAyryUetLOdZGq7bikNNNBtcD7nTWhVNgmNs8bYN83f0sTwJ
 Fth0PwSzhKFpIKry0chmM4ruC8YQX1FtKVIBhs0oZeOnun3AiKSZ79jxolgfyf6yNWaHeXf7XGC
 jcUfNHJBY1HPaqLTcVi2Bwg91gQ8mYS9963tw2nI9rfFuQa54cvsDpFxCVNrQmjjA+6kWM48hpi
 kNGWeMFQ42peWBRnrzg==
X-Proofpoint-GUID: -_P5aTXx14F6ChmfLPbUwsdJPO4Rmj9C
X-Proofpoint-ORIG-GUID: -_P5aTXx14F6ChmfLPbUwsdJPO4Rmj9C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290045



On 6/27/2026 10:52 AM, Pengyu Luo wrote:
[...]
>>>> This hunk is very odd:
>>>>
>>>> /*
>>>>    * in case of failure to get gpi dma channel, we can still do the
>>>>    * FIFO mode, so fallthrough
>>>>    */
>>>> dev_warn(mas->dev, "FIFO mode disabled, but couldn't get DMA, fall back to FIFO mode\n");
>>>>
>>>> In my understanding, GSI DMA mode is always preferable. +Mukesh, do
>>>> you have any insights?
>>>>
>>> GSI mode is preferable but if for some reason it fails, we try to continue with the FIFO mode. Just fallback mechanism.
>>
>> So, would making GSI the default and FIFO the fallback option
>> sound good?
>>
> 
> Yes, I have sent v2, please check here
> https://lore.kernel.org/linux-arm-msm/20260616122605.668908-1-mitltlatltl@gmail.com
> 
Just Reviewed and Commented on V2.
> Best wishes,
> Pengyu
> 
>> Konrad
>>

