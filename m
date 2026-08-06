Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08F337F33F
	for <linux-spi@vger.kernel.org>; Thu,  6 Aug 2026 16:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035250; cv=none; b=X1X5vbZEEVgSSZ6LmlEUtziAmshCalibZblYQauZvpa8RrNzHw0YU6P+0rwBggdzwVGpdLr72akKfxjxlVAzVllt6RoyoibpfrARm+8HPmc20GBNDoDj24dlcm5x5HJ5IW9eXXu2TvpgK5yLk5yJ89bfj0gkOVUmeBzbjvwg1AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035250; c=relaxed/simple;
	bh=vef/5r6uU1gPTr6I6ajyHBI08vZSWzfF6Er0iL1Zy84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LEFSjzZQXFsUMNQ6+XV3SvCvPB2GlpCkQJn5BDGgRTda3Tr2QfWYUNP6h9l1g6WX0spI+2dmdjwhJM89bSuSjFbrNviWTdUYyuof1cfLJiK/fFfH7b94CRKWnC7z03Wth9nO7mEUYHd/k/Urlus7sz4RVUbWpegJ2OCqfU6g8Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aXV4lJ8a; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KwRfsEVl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aXV4lJ8a";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KwRfsEVl"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676G63cc2144901
	for <linux-spi@vger.kernel.org>; Thu, 6 Aug 2026 16:54:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	vef/5r6uU1gPTr6I6ajyHBI08vZSWzfF6Er0iL1Zy84=; b=aXV4lJ8akAoLS8NI
	jknaC2am+nyiMewAdf8W6WZC7HAPyNsdPBYtk2eyKRPRHsGVDFKf2MlwzLYX5Jss
	F2+/fjVerkmydZLVVNOM6cUHXRLd5J24aJ6XcCiJ5cfoeb+fbqRFzulvnHwy4SZX
	ukcMvtOdHM4B7cD38yuztDFrN3YkyJMXy+BiodQ/6a8uwjWk8qmPrmZMzImRad09
	KjiYeU5bBExRLs+QtzndibYJJ3d2UkaPwmwvzCivAK3NA8i9E8Xw0niUdGxRr8jk
	TUA0PEj8w3crCUAKTf9at6y8oXrVuBdYbTjRlyFjT0n6kLLP4ZZ7S7s+eCUVUJMR
	1L4phQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvwg988xs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 06 Aug 2026 16:54:08 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dde0df80bso3392358a91.3
        for <linux-spi@vger.kernel.org>; Thu, 06 Aug 2026 09:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786035247; x=1786640047; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vef/5r6uU1gPTr6I6ajyHBI08vZSWzfF6Er0iL1Zy84=;
        b=KwRfsEVl1ZomwIgkfk08aSKpjLlZk8VRcE/VkJXP813QjxqYUAYTWYVs68WlF9XvQM
         oLvqJYddIuZ10PPK9QGIsfIu2FvBg9ReydMGCmLAGrnSOcGYJvcFnFNkYPAahGJgWpt1
         5TVigK8iJMWUAAnhnqUDp/MPGbtxpRLzLbSlGFBSDXlBwtoVLX3LZMfAXt7+v3pENHqD
         Fm2PX9A/e4p2WrG8TpioNvloH8DFrYZgP8hIefLjaiGmtsAncs0NX0kVEf1TqmHDLvR8
         NnmKOjjQccuzXtIPzhsQ/ykEpgbRHsi1mDi5/AaWuBql5H4f1jG/+YjA58wH8QEUOyMo
         GeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786035247; x=1786640047;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vef/5r6uU1gPTr6I6ajyHBI08vZSWzfF6Er0iL1Zy84=;
        b=kb1a7uNTanYqGpCasww1MWG+aMWwM84mB8nrdJ7u4TdzUzmdi2Xwhv6id3FXy0aIx5
         puE3Mdmj0R/RFjqT2Dl6lSXpFYgK7semEx8Qs8pxna4KF1oXgnGWr1XXduqw4qQPOs7f
         AYkP5EaA5YToKOTlmKSCZrWDX4gCdJmgk1ULC1PVxhn5eRUB12b0d1nW1VfKdtK0hFo4
         xWfr1HpcnQHpAKvcTKI05x3c5mf7ostS9kvYQ9nQDFKm3A7rg+WgusbXVC4L1IFoJ83S
         HNdgIFZ99GqPHSP2tkC8K+2YU1CBw0cGt+7dsn7xbf2qyJzacviZeo8m25u+rxj2ycRd
         qImg==
X-Forwarded-Encrypted: i=1; AHgh+RqKonewn1xdv8Ki6xgjjixD4PzY5C7g7FDqc4QmMeIjceZqgPMa6XuDfRWWqwilB33PflQlXjnmvxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2w71m+70ux5+ZSnXl9p+xJ778537wRNWjqNX3PFMFm+CIYLTI
	InNt7+feotr64jysRPsli5nSh0zCJumHu1BSDHG++9+80Hz6PTqy2JGkrZxu7VWT4Gpby7VHA4a
	zvKgMDQegF64Irm5I1wEQ2Rq6sKszKeucrWJiOK8aG2N8jzxW+WNyEdYfLS3Jbsw=
X-Gm-Gg: AR+sD11qt/aduPO4L0kTaQTbL2q/Mc9js87XK4shsKb8I8t84UPfdCOGABzTsD7l75l
	bI5VqZfzcyRK4JchFss2+pIjmGwBv9Kr+jaADB+dpM/smmZ+0VaOJBRWTrYzo2MX2Dpf5bDip+l
	u2i8lhC/IsJgGyoflQlB/OaVd/gk4RomxDo6TZ7oS5b9pXhpHpo4mUTynGoJBo1eDeKL9s8JjaW
	oKX77F5ZHJA6UHIWnFQ0+AfdYlENB2tnQXqFQiU2M7oM/J1kxom8JCQewhesr9D9uDLAYzjLOql
	9i7rNRYe92ueIeybxnkdhGs8RyhSyEl6MOgcvYzb8iAcFEz8za0y9vObTJUZQkEl60rFcsorsJg
	3CQVEyrYEr4G2CPeuCkXwe3VQge/Q+8BF
X-Received: by 2002:a17:90a:d445:b0:37e:b6a:6cdf with SMTP id 98e67ed59e1d1-3903c66ba04mr17215694a91.20.1786035247573;
        Thu, 06 Aug 2026 09:54:07 -0700 (PDT)
X-Received: by 2002:a17:90a:d445:b0:37e:b6a:6cdf with SMTP id 98e67ed59e1d1-3903c66ba04mr17215621a91.20.1786035247060;
        Thu, 06 Aug 2026 09:54:07 -0700 (PDT)
Received: from [192.168.0.7] ([49.204.111.196])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca9111b6sm25952515c88.13.2026.08.06.09.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 09:54:06 -0700 (PDT)
Message-ID: <d59efb31-c498-4d93-a277-c628c9eb6083@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 22:24:00 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: spi: qcom-geni: Document device-gpios
 property
To: Mark Brown <broonie@kernel.org>
Cc: konrad.dybcio@oss.qualcomm.com, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        chandana.chiluveru@oss.qualcomm.com,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260806-use_gpio_to_notify_master_of_spi_target_activity-v1-0-c363a9b5df69@oss.qualcomm.com>
 <20260806-use_gpio_to_notify_master_of_spi_target_activity-v1-1-c363a9b5df69@oss.qualcomm.com>
 <50834ed2-a3bd-40c6-bfe5-98a7f81856e6@sirena.org.uk>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <50834ed2-a3bd-40c6-bfe5-98a7f81856e6@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEzMiBTYWx0ZWRfX53DAfi9IQ1KE
 6a0601OejEE0gkHcyUaf+oP+SpK6Vts1OzD0Db82LjbgZa9anpB/J4pTJNNc6y+mLX/ZLTgEXup
 g4w/6aj7bzQesLFwDUge6cw8BSBCRFk=
X-Authority-Analysis: v=2.4 cv=HLLz0Itv c=1 sm=1 tr=0 ts=6a74bc30 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=7DW+zsgf7PPjz/i6iZMG3g==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=YUQeh1lwrLxke3GFIuoA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: uEdsC-Es1xxpnwLO9uAbMKKxVwYNzqtM
X-Proofpoint-GUID: uEdsC-Es1xxpnwLO9uAbMKKxVwYNzqtM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEzMiBTYWx0ZWRfX2L5k4ICWRCTg
 oxSQsNnksdWzeRGlxr6obEMrVnH3T16GSrP0rhbrREB4XHWpfCKD2aJDLor4LBbTqpYbrX856lf
 A/HVCHeB/IGT90YjHFIeQ8cq/z0rpbOjozkZE0UoOxmNPbohiAa/YuP7ayS66zxV3bzboPAh852
 yodHCoeSbJsvLI80UYhQc5xbPwmuklkzH+7p1kjN5RScAp6eooTGPr0wADjJ4qBIMYlqO31didc
 JO6S8lvVj4OdqbiPcv8+KLW9I8veXTskKJbWtJ1dkSAmwm0j8vkZ42Fe4LBcc6OSV/M51EOK22/
 JjqgQHs5zIQQQeTRJ8O7iXOmAnPMeNTmS3LFT2XqbVL2FSx+Hxw99VfUltLzloWCkKlZblVTLoL
 t77E3TcsOEulCD3ZZ5JwR+yDa7iG3FMFzfggs/f0npoa3GVGKF329rrgz7i7ludwxIf1prSJHfx
 WfEk4KpbLKPIFb+eneQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060132

HI Mark

On 06-08-2026 22:17, Mark Brown wrote:
> On Thu, Aug 06, 2026 at 03:43:44PM +0530, Praveen Talari wrote:
>> When operating in SPI target (slave) mode, the GENI SPI controller can
>> use an external GPIO to notify the SPI master about the target's
>> active state.
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.
Sure, will update in next patch.
