Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C102B3955EA
	for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 09:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784194601; cv=none; b=D6vtUkfnEXGHwmJ77IeALjjKt8Nfk/XAvWliyrjErX61X5TzIzYnYQ1MasHDYXFdn1mDdY8gEW1kMY2utMZyb5qWgh9BzQRim2HIsJ6M2dw/dXN5KHql51gLKqflBzmY6L6miql4LOPQp8Ag4y8l7j8w+2QSyiX99kKBmQKYmP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784194601; c=relaxed/simple;
	bh=m+4b3aLkvYKYXjk/5jBk13X1toi/h2jJT0j9yCVHa34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MYhLIMJF0FGuwkS85kwjy5fV6wZj7SJnvbnNaLey4/ZQWCelUmS112mEawL0qFAVCYCeJbekD32kX2XTx9RbRujtqGuUTw7vjyHgEN6l5erHrUzCL2QTbr+LnhHPvj7UTjQ8unH+8dJ2sqN4B2MABZfcpHXVvfE6OaGo9jU24o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ImarmEFv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Y+g+lcFu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ImarmEFv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y+g+lcFu"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G7DQCm2102717
	for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 09:36:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	iQneF3Snhi2o+9zW2iPm4mlK7O1KLd3pE5NOe2Pedfg=; b=ImarmEFvRplhQtnn
	96EQn0rHWlVLm/2BIio7tnfNugFZSYwdkNTl0hgpbjgS1HGNliGGk7VXOU/Dc7UK
	C1IGWEIs23ZXlEG9sK40DMsu1sC5Kp1bjcyNggvOiGYmR6CoBCc9oGpJXQKJbZUK
	yakevVvt5ztCkKKZJcEg0jCJsUCzpYnXQpjdXbpNautrp0V4xjK3teVliJkPSH7o
	WywlIOVcVrvV5qaMWtRh/Tmsm/73wHnsDxv7EWbWJQ5VfNs/4bK5ktEVWUFaJrO/
	66CkOD7sDDY1JSlyiRCIS0G0hHRwjlKlhTbe05UmaB+p1RkMvkZQac4V6NZv3MBk
	GjGEvg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fen4w9pex-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 09:36:38 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51bfa45b280so14704991cf.3
        for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 02:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784194598; x=1784799398; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iQneF3Snhi2o+9zW2iPm4mlK7O1KLd3pE5NOe2Pedfg=;
        b=Y+g+lcFuCuW8WY/8qVtVpBZ0s1Ed53WUxsFjh+D1inETbgXkS/9p2WKZmMkvLlGvsT
         tX9p797VnRoAFbcnjIA9NCekDYz+RBta5ZOLSJa3aKyoBEKjcd4b8XDBxzVpw+Tk7xTs
         +t4rZZA3t/aKDOUEawUAl7+xIRIVv1Nq7X0DWlY2Jq4/yAKbwCp9dABV2VUFSagG6VdC
         OkrazWvLmYIcQ27AetY7LA8tIo+CDiXkydPY5OkyIN5iGrCAmDgqcOK6m8Bq1thGhNGU
         j5bGCkk1xveslA0zfh+3j14D2l3Mu96HQml2Hh9p+ONpN1y0g2SscVKO3ul4UDFs4NZ/
         o1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784194598; x=1784799398;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iQneF3Snhi2o+9zW2iPm4mlK7O1KLd3pE5NOe2Pedfg=;
        b=BVsDXkakHeC7KB81Ok7j2OsHGUcf+jJymP7m0wSpwbajuvXntVWCXEowhRixzUfyKv
         VQKJPkwTkBvxOT8+/k3jkvea9egjrqsg3eAjBUMOFpvdRGl6u31IbEJtJ0DTHc555xB1
         sh4oeckgWqqtcH5AYcUiCfmR2SSzMs//k8LT9a09lIIPkKIz+4NXsyXc2NrdEWrkab5l
         rzfqbSkKt/lcr8Tsdu9r+iYhyM3OMRqkz3l2MokR0od/SsrUwOhuxWv84b9FnZ+NFa1P
         NRZc4txLLgzN3t6wf4euOizDNo2C0VR77XfkUAAYl1o3y6BjKr3PnbS90b/q/ctc2RI6
         7gOg==
X-Forwarded-Encrypted: i=1; AHgh+RrUTudkW/qtYEl5svlBp5bHa5Toub3xg8tY/+y1hwIkqPeFrAV8++cGUtgwTVMuVPdwAtbwgT405Ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQTpDnP9tAHzd5M6ozoRfZFIetvyAqfGTpl1OfQlMspMIn0L9U
	CB8nEODJ2iYUNf5lZsI/n3hCqyfk10KCR5bf64LbjSbh05jrd0NrvpmbJdES+bWSh5hqDFkPgsK
	66kCB7bbLqoulXwnqMASPRHCNx1xp8D4EuQwI1O7+HJeNVOSuo7QN0uTDzTorpcc=
X-Gm-Gg: AfdE7cmWGy0EHaea1Wpw2vlfax8FJujGMvFdtl9bZg3ag4vxboWOHAlqzhqr+9BjHA7
	CMVy5Kq3ofRAqcnmTh+sE6A7Q3hD6jTshlYuBEQpv5lsFuDvxRHaLaQ2tO/ubO3fXMoMOCQ8CRU
	zY7/YlpIqnRkYqgIfUMLkSgRet9lR/cZP5VNGm11fbnqegOf5aKGUt13PNE9upmcIYpcKDSt5J/
	IWDKT0qQQEf6Qn50SRM03O4L3+SJxxigavV4NC2kgioeQhQxStpVXiW6NwJt9uLpVqXoSByWAMf
	7xQHWjeuHLpNdzYvZY9GBVoVoH65ACZWdAuREtwkcA2alhNGJOOc016nimOYN1qwY8/4Q2gZxEu
	VDCx7UR8BlMTPWwPckAAdMexs
X-Received: by 2002:a05:622a:389:b0:51c:83f1:bcd4 with SMTP id d75a77b69052e-51cbed7dccbmr25593721cf.0.1784194598033;
        Thu, 16 Jul 2026 02:36:38 -0700 (PDT)
X-Received: by 2002:a05:622a:389:b0:51c:83f1:bcd4 with SMTP id d75a77b69052e-51cbed7dccbmr25593571cf.0.1784194597674;
        Thu, 16 Jul 2026 02:36:37 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1687126353sm178908166b.13.2026.07.16.02.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 02:36:36 -0700 (PDT)
Message-ID: <c6cf4da0-15f6-4f43-8f06-0e47d8058ff4@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 11:36:34 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: geni-qcom: Fix sticky ret causing wrong return value
 on invalid proto
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        kernel test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>
References: <20260716-fix_return_error_code-v1-1-3295003aacd5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260716-fix_return_error_code-v1-1-3295003aacd5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=PsejqQM3 c=1 sm=1 tr=0 ts=6a58a627 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=hRfWpAjuP3xw3JzzUMgA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: oT-AZsdsXRM-FQqqG0NBO4p7ypaSnFzr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA5OCBTYWx0ZWRfX37hW/XM2h3tl
 GQ7Nvv3e6eUvrLnPQLpyLbCziT2hWJ1bpJvt0UBjGCSx3nA2CgL5puwcOn1FWt+vC2OfHYUx272
 h3Ek82yg5pJDaMS2T8Ss+DKB1OLIVNc=
X-Proofpoint-ORIG-GUID: oT-AZsdsXRM-FQqqG0NBO4p7ypaSnFzr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA5OCBTYWx0ZWRfX9xOp4SvAhJ+O
 QjfKkWOXvrAZWcslXvFe7BTG/inV4IZ7/j+VANvV6qQFTU8KwIbMT610rrTDbqWtWMSIZ1dMWBs
 TGy4EKpCwLL36UZmWAyhJdvK1tX13BpbU3vmQi67osk3HaGGjj4h5xZBTdSilCLVGhEAD2JUnJg
 IAs49apYuPm/XMcTJpcS+fQ2eKuhGVgPYOI0WCWW8sSLbvlQ6oaPHloNG1MKjK8WwJpAKlVWYIR
 9c1i8FUCap2IcruW50yHb0okQyfPn6stYdrdkUvdLFUlQpYsHMHJTeqAFVAg0a/Y+cSnFVkXSby
 idFrWyCbu6wTqlHF2aKialUYz6c4xFyQk7Z0yRLdvXBHLiVRNnj71z/FJA6vqmcExCIYbQnm+hu
 2FeJS6Pk7s8aX8aONLFYb1JigQ7uq6w+TC5mvT8EPrjKf141Oun1kcD5vIYwuThNGkmC4GH8I23
 z8/qe88F2JPSH6+WNHw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160098

On 7/16/26 10:25 AM, Praveen Talari wrote:
> spi_geni_init() reuses 'ret' after it has already been set by the
> runtime PM acquire check earlier in the function. When an invalid
> protocol is later detected, the function returns this stale 'ret'
> value instead of a proper error code, so it can end up returning 0
> (or some other non-error value) even though the protocol check
> failed.
> 
> Fix this by returning -EINVAL directly on both invalid-proto paths.
> 
> Fixes: d8e9ea989acb ("spi: qcom-geni: Fix missing error check on pm_runtime_get_sync()")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202607122241.qzP3QAXF-lkp@intel.com/
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
