Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D706275AFB
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776189377; cv=none; b=jAysWHSiiRTD0n/XQ8GL5odaNuE1/jIDGcUqr6gdDCCwxdL5QBcbgt4gt+W3ytbRe0rUj4sJ4BNXj3yBYQQaT4zNtdIhU9qFODFAEPLYJHK60S1v/hFjopCkEfzfB4HAMMeoqJZ4Oj84J5wCwY6KhE2m/zhXQrKGTwi6NPRz0V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776189377; c=relaxed/simple;
	bh=sujtAKk+T7XyzLJV3sWvURJUp2YcVbTYukhr8ZVBGLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kkpzlcltd4wM2X3oqHSlsrPb8nj0vnwMCaNr0urszQuau/K6Y6CueLJEBGnfMWzEx2RDgHB68rqcQeVlfS7Khb3+E7Nl4px8D7+c1NpG2Gcg66PTCl2d43LxrEMyov+8aG+Z+HSupbibCeDCid/hTAikGqm1RCjPrB3Dq99bhsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DDhoyDl+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CfnJezc9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DDhoyDl+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CfnJezc9"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EG9LbG731084
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:56:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=92cOdrzkvy2wsq8U5FBiGJgp
	keDCiW3kVyU8oL/89W0=; b=DDhoyDl+Gnd0V94q/SKUb78vAwArOWUEga0HVkuH
	FyBUpbMlZ6Qed3/fJPFVohzFqmAdK3mDwXS+02G/Z/urDdnj+SRhhEnKErZGNR6f
	sFBoS6MR48zWPZstEeONDvK+b6Ib/2KVAzgj9GOXPyAE5tF5QVzqh1BvGcEpNmYE
	WmlYKFQOBWm7EcVkeT+pFqCvxSFLnMa4QYShJYCYENV9vFwBsz1uRNYKNIITUfFD
	k4iKjDXkQtCgdxK+kPO3hcEoZaZ3KKJOpGHGJsGRKwDa/Y1ahsvsuIxK9/mU/ro0
	1kxM+g2TUAhCfuHR58KCwW6WkEK/KnAVKU80HiB45sj9wQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhruu8et3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:56:15 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50d63962d83so138198621cf.2
        for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 10:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776189375; x=1776794175; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=92cOdrzkvy2wsq8U5FBiGJgpkeDCiW3kVyU8oL/89W0=;
        b=CfnJezc9q8x4bKzSKojtYj5fD2z16W9SYxKcy60w4M01yjri/axSinwRP4i9wh1PAx
         QcWAX6BN7JXHP96VYvp+Kvgnz4lQqxV7m8pZnXfSkrsi5aPp0931UXzb4jlN4eP4sa5C
         EtUh8LRVelej2/iXXGjtObIs655YMXvd6caDWK+EqQrDUhIXlnrSSdVtHkSxlPvpQERY
         RgaMhJpK7EcnlYl6U2ZQ4FIetdqNw1WXfQ0PlYO0gRJowYPE44I/KnMb+rKBtJqBmS1G
         wryvRpFdcdLTwfi74jV4gwZcZYWi5alVqYeYzznN4FnKOlYX+6Ts0Q9td7Lbu8VAL2DI
         bsbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776189375; x=1776794175;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92cOdrzkvy2wsq8U5FBiGJgpkeDCiW3kVyU8oL/89W0=;
        b=RLLjhZk+De6MaOyT6KAuIsQgL21RY68gDy2L4fi/pkk/f+O2eCsU6URn8LaxKfcvb/
         LC4iI8YoivfZakJWA7KJvdMpoiVC+RRPCGLXd1i142wWxho9K2Eu/9QhgGyItqtzb00W
         tYi1pngeOGXa/PsjQRJb9yabeom6gSj3nhgA/MmyyZxLPntYShBo8orADTqn48lmZFvz
         wqqWJOZghpoW+JtYuNHwkefcFXeL+EfbT7tlW1J7nl7a+M124YS9e1QP0QCOPVfn8tFu
         k6dKf+vOaDRgfByP0hUZrh5/FnZ5MHdpkZ85JeWMOBDTQbWfVllVfjBWPoDXUKJftQpN
         AAaA==
X-Forwarded-Encrypted: i=1; AFNElJ9kUORy0AF+HXhW/sTePnd5M2z8ekF26hw3PcGTUBlFY2eH8ttIKYMKRBy44LhHGYEmXqkJCW9IQ1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBxugmd07540vtyFKP1c8gwiIwtLAQngkWw8WKCDXIqXfEZbQ1
	cXSpoGTrJMFwrk9NBQwoy8uxZPyBVaqsl+K7D0cdkD7JJ0mhj7VsYCsADAVU6lQBzQlqCD/9Uyq
	HF4qs93pdDZSQV4LV77SUNlzcDicaNEsD9gSwWAjW4wQGemXDSrxlDfGeVeqCc9w=
X-Gm-Gg: AeBDieta3Gucn2+h7M1RNtsI3//pJLk4oevcErQbYabqjNenQ7aR8tITV5sT8X3ZbkP
	cCup1baIVGRJmt8F+V8+y/76MVwEV+6uUpIfb2JjcBZHmVUQ6t1GotO/xtWuP2o94Dun7ZV5Nem
	aNFoUVSU/xV/6No3+2A420OO6PwAEJ2z4Y3njM3Z6cO29408XyZXfqUxRbIVmJlHja9K8FiJnjz
	PKe9A33G30LShcZVTKK3tI3UAZ+kvk8HnUTSgL65toCd8Ahku+LVRK/Y6191mZUDrseMiMcYQSE
	G9/Y7QIxBM2W/t7Gc1xBlgfBbep5ItO+YSpt+teC/QgTE/3Fgkar87eJcGek4rF5lZeR62/2at2
	FtkhPtkm6c3uopd8Kt15jwK7ik+XztfHyXjVZJokEAN6L7eFKD5tDmRUZ8EVO+JcwY/wpFoXsMQ
	10JoBjSRfsMwFMwmWm1vbTllgpLzwQwLpehunSx6F/Sgrszg==
X-Received: by 2002:a05:622a:998:b0:50d:830a:4213 with SMTP id d75a77b69052e-50dd5b2ef3dmr288491821cf.6.1776189374791;
        Tue, 14 Apr 2026 10:56:14 -0700 (PDT)
X-Received: by 2002:a05:622a:998:b0:50d:830a:4213 with SMTP id d75a77b69052e-50dd5b2ef3dmr288491291cf.6.1776189374332;
        Tue, 14 Apr 2026 10:56:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a400d8d33fsm1083112e87.28.2026.04.14.10.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 10:56:13 -0700 (PDT)
Date: Tue, 14 Apr 2026 20:56:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] arm64: dts: qcom: kodiak: Add QSPI memory
 interconnect path
Message-ID: <u2nfci7pul42sj65udak5liwpddqzrm23g5af56u3ancjixuf2@kwmxmiindqc4>
References: <20260414-spi-nor-v2-0-bcca40de4b5f@oss.qualcomm.com>
 <20260414-spi-nor-v2-6-bcca40de4b5f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-spi-nor-v2-6-bcca40de4b5f@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 7xo4_kTLJqH01Ts3C0c1ATGJFty0fsvm
X-Authority-Analysis: v=2.4 cv=dpfrzVg4 c=1 sm=1 tr=0 ts=69de7fbf cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=CipEwJKW4Sg1KE0sZiEA:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE2NyBTYWx0ZWRfX6/w0L7gjA/4I
 YjfJ71ZE+dwIr+qgHXGkB+SiQ+hVC9KrknA25Dzpv3BvZtjN6GXoNDNGFkNUNBOy8xBsucqE9v4
 NLtMsmFybSwcyyWBeso3HX6953QlgUWoD+XEoeFV/PhX67H8xbUPfBtGMh6pDuFgXMDUkt22A5Y
 +Reu1l/6j/o2ZeZoKjPlFmQdM1KO6sTpjfW9tmegm0Z+n1YarhAhF6rECJt38s8JcfpY9awq87y
 E2qk2JOl84Ypg2jkenMSy2cjDZiZ3vgMGjHEJ6Uc9nqFUin7wqk2KUZ3eeVl/KbYHkGtIjac0MX
 3dm1uZwoH6HQ8RsqtGcjcMCYXAowQz9lpKxVqJoWZvPATOrMQIah8YhxRaugENRl9EMnJr2DBWY
 jpVTcofNJbD2zgc9mAykA3FMxywRqPhn4KOU1uWDfnjmlQplzf6TpM6O6D2UzkqSirhkofjgDUq
 X7UAgfpKra5yvxPiHew==
X-Proofpoint-GUID: 7xo4_kTLJqH01Ts3C0c1ATGJFty0fsvm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140167

On Tue, Apr 14, 2026 at 10:38:24PM +0530, Viken Dadhaniya wrote:
> Add the missing QSPI-to-memory interconnect path alongside the existing
> configuration path. Without it, the interconnect framework cannot vote for
> the bandwidth required by QSPI DMA data transfers.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kodiak.dtsi | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
