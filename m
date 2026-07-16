Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68F4379EE2
	for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 10:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784196647; cv=none; b=A/ON2FYrkNyVPH5WrropuOSAhbSkQP0tNsnf7aLyIVD4annjtVG/Uo5VXNmyEVKUD0oVtDChrZ97tJY3Av5qIYMZzsECkaIvmGnEwWZlOYEwKJZIuYfsQqsvZfi7mJQLVujKGeURsnm0wSWnhj6PBBMa3l2C7coZyVN82v5bDsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784196647; c=relaxed/simple;
	bh=twhUx38eH4qiG2ma4mh6WJi4kCf8F8rtWTBtv0EIWpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2OIkh/eLUMiUejMPqgP37/Fc2Ulg4ulqR4yRdfG4/TUmvXR6aAyGIUEnR/6ZO35dREHLiZAGnUx14vG/FBM5Uh9Q5YEwImd+WUgcS5nYa70TXXk0xAGJARgVvFNaurwSk0mIdGZV8KuAtV+ctPfFDxJWBNx+QyDUL0a7HRk9uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jLViiwzL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D5sffXLE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jLViiwzL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D5sffXLE"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G9r92L2215293
	for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 10:10:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QN0SyLSXER9wXPtaRKAI1HftDAC7W1HO9axuocXmIPw=; b=jLViiwzLF34KY+zg
	TeJflCON7eMVGt+27rpCdtlqnUPTewEouBMTD3YilGBi/3T0KuUEtie43rF2Pmso
	VkgVn3b/dkiQr7GQ//PsObnI4iS7ElE6ISV6MJQZglcqh/Ls6H0Sy/LQhyIEleH/
	tPbSdlmatPg5PrTDE5NvE7CaRRdVFhy959cyIoPCJ+OYw+oYX2lwzEbVdfgCuGBj
	xgVcLBlX75OZ/M5Ddz18WSqw+7R0Gkm4/ZREuxE34EVxEdbCNVEf5kz2LvuEuoGX
	pQDSh43gscrNlbfqMQY4VJhbFH4lArCY7CHgecaZj+WLnmcW7HVl0GRjdIFG6+V2
	1dLeJA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fetb7rs8j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 10:10:44 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c88ab059052so563406a12.1
        for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 03:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784196644; x=1784801444; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QN0SyLSXER9wXPtaRKAI1HftDAC7W1HO9axuocXmIPw=;
        b=D5sffXLEuLToFtkLo30y9TQnu/uzv91xgpHi2CNJpt406t8Zg1Go/hCq9uxRtsbtsB
         N5HR2z+vcl5ecYEJspcNpduLrPmGdX/6jsDu7SMUE3EerWVk1cQV/njtgiG0UdKPJpkT
         yEt8OY+Twstmy7cWe3d88rMKXZWgq5E2DPVBcg/4n6Vb5hWzD1euXP3Nj+ChpJPMyo3X
         sdeuoUn6KziKZFfdVqvewd7IF7E7JCccCeF+bLuqMPnJLP5xwrbD+v9AIakgqL7oQ0Si
         vkS2RoXbhzFhrisKhXgUPqO+aUj+SG11oKgaTyc8BrJul46xeswd+iRMRoQtZxNkfbdF
         t0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784196644; x=1784801444;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QN0SyLSXER9wXPtaRKAI1HftDAC7W1HO9axuocXmIPw=;
        b=DLUdR6LHrEiul6ziP1ipudoDmsaL9F6BWLVBAf+W2mKgxY4WXIvZ+8rW/tX4jLQ/0v
         tQD5/Sf0sAjTbnxsI+q1BZBIW5sZp5RBNInwU64K8Pgdx/a66uod1k92ykiXB9f83iqu
         JSLM0FLjqD64LL6l3G6pvm2aZwn3+eBHbRejJx7XjOMSxBr3/rlG0I5G0amGKfMz81cy
         VCwJSEt+Syorfbdn+lScZrUKNZF9aWuuz7oC/HwvahKVLMiZHshwadrLcHwNMLuYQN05
         biQgZ22xr55VKbpP2/KjtEvjFOLbSNkZjtuYmKhrBajopLjnkm5iNchSU6IVrOg82Do3
         5Pfw==
X-Forwarded-Encrypted: i=1; AHgh+RrY5R4oORzqevwT4JOreu0NMEAycIDqvFmmajq8pZ2CYY7rOiNxrPaM3i39YXd0wEEJGawgSorPyXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI9WPKMjPZR5Ir0jONZ9N0XeWP3jQJ/CAAX3lcVRS3eNbG8J7C
	xXowQgfFhUggQMW3IIiOvdOv0rHXmOmghI0Xh4DD32hL0Fz+szucLeYcaA2YeziyJVqv35Mv9Fm
	6PzrTFo66d2K0n+NAlSpAuWWag0rzzgiBZ+WoUrXPpns6/vcGw4R6fT1TTkBPSxc=
X-Gm-Gg: AfdE7cm1o5N7pJtCWornBPLTqUqjHaw+ZJGHFSoga2uYIsTJtoJcnWeUvZ8y3rctHLa
	gzo2fOVr7y2FJ80XJy8K7zi78s0I0nF+iT2Fh+F3WcMCUStqvdsUr/DZVDBe4VdytAOgfTZPFM3
	3rwIMhABVOtXuiXR93t6JoAUk1weszRp4VIO/4fPBxUyB62GxX69Vz73rLEYHmf0uEUNIoI0XPa
	aV3axXoF+5GQbOT86K+dGF5OcDpvCqvmiom65J7cwxXLIIaBr8f1q8vLOOC7x9EortBZzvmovrr
	lylHOsQOJd2kHT6IDXNgMDZgfANKFh8N70p2CWBHsvJufo6bFoYuHqqzymck+/e/96qM5ErCYUD
	1sXZcRSOJ14GeL0hAJQkP2ewqn81Td0nSsso=
X-Received: by 2002:a05:6a20:e293:b0:3b4:6af4:bdd5 with SMTP id adf61e73a8af0-3c38d90e685mr2611985637.15.1784196644201;
        Thu, 16 Jul 2026 03:10:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:e293:b0:3b4:6af4:bdd5 with SMTP id adf61e73a8af0-3c38d90e685mr2611951637.15.1784196643655;
        Thu, 16 Jul 2026 03:10:43 -0700 (PDT)
Received: from [10.217.219.142] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd4344b8bsm9552696c88.13.2026.07.16.03.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 03:10:43 -0700 (PDT)
Message-ID: <f62d1576-ec39-466a-90bf-a6510f68cbad@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 15:40:38 +0530
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
        "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
References: <20260716-fix_return_error_code-v1-1-3295003aacd5@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260716-fix_return_error_code-v1-1-3295003aacd5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEwNCBTYWx0ZWRfX/8AY1wSneXKM
 dS8iuFzn7C7BdRKqsDsm1CTULCupSXo2buhWht2YQiaM+uDmJY2WTljboZQTC2twSkUPQ8Q1QLz
 v0ppDsxxsItyelFufDMHJRhjYtbW/Z0=
X-Authority-Analysis: v=2.4 cv=dM2WXuZb c=1 sm=1 tr=0 ts=6a58ae24 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=hRfWpAjuP3xw3JzzUMgA:9 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEwNCBTYWx0ZWRfXxeBNLB3q7PMk
 9/gbskgLhmU/0TDrZevg3IZG8nEpzuO3XPyBvFlbJNYQ5PtcQEHBj2VPsbzy6Ibn64DC8hDUZZy
 LTch/VtGNi/MMvsOMd27w9D5a+UpGBasMr36u4og3rZ8Z2UlPmPrQuNav1FrdWV9apTBf7b/7iz
 TO4dIFvsj/rv6jv4exM15PtqgmUXE13+gWerXsqPs8wlIqwP3m41igRR2uny9JhVAQ/gLgpC2D/
 zG8Fx57LrNVvZjt8DdpOJusL78pJf3S3yb++F3TLIF0ezJ8GOJ+L2NrsB+V84WifqejkTjA76Lk
 eM7BaqPevUDJl1G9+n+mxnjiZl9+eiXlm7ZOY5wom1UqRszQ3OFQZeGaCIADmMVE5kIYgEW55/2
 Oxc2uAGm7/ZjbTcXTF0tubJoHrg6gO1CDy2gHp8cz8zwliu/fmo+BGrJFcpPcj+k2WEWcbgtI6b
 63Pm+gguraIjBsTCGcg==
X-Proofpoint-ORIG-GUID: g9y0b43TPZPYkNk4DQpqrMmXB6pF1WMJ
X-Proofpoint-GUID: g9y0b43TPZPYkNk4DQpqrMmXB6pF1WMJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160104



On 7/16/2026 1:55 PM, Praveen Talari wrote:
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
>   drivers/spi/spi-geni-qcom.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
