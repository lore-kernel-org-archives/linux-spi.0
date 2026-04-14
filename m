Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AA5299A87
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188873; cv=none; b=F2sMo+JAkluWedW/QU86eP/ocLm79rIHyfF83ts1aUlp/hV0zoSI6577XCR9ghmGh0PEUseTepiWyhFP3eFk7vAzTsFPa8Wvq82Y87XBBGtOQYpS8Qkq4KYSYcuQ26Xh7L/v1KB5nNfXdbeBUviFfzdiaJnj9mb8IeJdzsZFjl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188873; c=relaxed/simple;
	bh=DLjWKHUr4fRxC7wkQ2bqbDdeW+P7NVBJrstnjpTYplo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=THxY76QZSoEmtna4+G8bz2A1uxIAu61mCsv/96m3001UcqMzMPaDOcReE+nVNLlKA7bqoTJv9B2uXV/dHFvQUo0p5pTq5DBIE/6656LsGE45xo4RsGnVkOd8Wd95GIAJS9zNN6lmHe9iAaY52c+OO+uaLmSwQ8o9g6KeZkMBaLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S1eygQgs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DnGYVCLw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S1eygQgs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DnGYVCLw"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EHcZ2I3101518
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6Api2ABxaJJAGN35zZEsXO5N
	hSOE43cphMm15sGI/1s=; b=S1eygQgsbYVkJgCFnijQvOiZIdcNsOhrpnc23tcQ
	g562nRtn8PWUy6MkEmD4Hi/fPpsPu4BXWeijmJXR3OSeRgOziPNlVUMXIgN0DoqH
	VGxj4uHTMfhp1I8teemER4hamaNChq2CP5SesMgDk0pdjHdcBMVoHuHRpEYRIz+9
	x32qQ7Jtlkc6O7W0f3mRDDuQSi/AZEJsdexjDKB8TjwLbZNFLLk167Mw5NwcIcqm
	UfQ/5dMZSIfp5ylcQZfZRcBX45Jif0UdT9xnvxw2khofOLb8mzrzyTxpzYjGuLq+
	ErJIRxxXqT4AWraEczMhcLiCWQ+XIawon+wsaxhox4VXvw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dht5h01af-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:47:51 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50e0534a7b1so23126731cf.2
        for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 10:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776188871; x=1776793671; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Api2ABxaJJAGN35zZEsXO5NhSOE43cphMm15sGI/1s=;
        b=DnGYVCLw+bHpZ6XFepR9PDKvrmzhI/a0m50sEUhfyE2f0lNIIrV/Q5TTyPHuqRQcAV
         zkaR63JRiW5z2nNZZp4EsghNYybE/qGwDDsmdq//53b/ejGLWh2m1h1AEX2+KsqYOyS5
         iKA9QzP+prPRRjnvsiwrFbEd+kEzNAcfQ3gLQ9NJIFFId2XUsHG2FmjJChl3ewKI3H1P
         YUFNedE1iBsWkhvKpi//oZIQ2DHPJ+5RKoGD8Sl/y2wTyKUnoYzKsF78IqdMTiOV1Ct3
         +YJBG10f8ltfXiX0mdAaN5H6Txdce3FX313WNBv8/YNu0Av9nxH6LC+QPOs7aP2Sv/fU
         y+kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776188871; x=1776793671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Api2ABxaJJAGN35zZEsXO5NhSOE43cphMm15sGI/1s=;
        b=P3doPuoofGobderHBi/HR4wwyI/jsnkXz3N/qWpXFnaOqbI0HfqBmg2j89OZTzycLq
         bA8bYP8pPrYVzVl/oDBcOWITI5pZ39jFn1s1jjNVmP+ykkcBO/H1ytakCmjRDOY9INvs
         u23y/aK5aEkyiBo1kFtg6YSdxEAGMbH0wCqam9t6art4UjnKE0bD2rxBj8AOZC8m4fKg
         XUGCEZ0nAtMAtzU4fmflqLWToSJ0LbmECIQMG6EHhPxnGTs0cxyxaNOiANfcASlYdNfk
         6Ndl33Bn79UYiYPAlMO50vv6VgWabFfgf5/hYA07AeVAHlNIyGTdKon2aTfXMXYyHXrs
         +9cg==
X-Forwarded-Encrypted: i=1; AFNElJ/niMbmq4iHpkr9WrXjK4H7RbtV/ZUtR7JNl9zANq7IjjFmeFK2Za3MMAVVlR9m4S8Otd+iGRbiJhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ8SK8Xwny963GQvxK32IAMtfUuPKL4WZZBuHuXi3c+LggCA/n
	mceBcNpVxM5AEJBWx5U3Vb7xnM4bANd0QqeyhcmLQmgTkgs8KzufiRAaufO3cmpGpLTA6be8ge7
	/0fsw/rtVce3CyseKL7HTUo4e0m9Nd2/EgsbTXWusd1qnxiSFw06xhLTIm46GnLI=
X-Gm-Gg: AeBDieseUWcAQMWPDL5dgUgWwzSHJ+6hOHeZhaoA1E09ZmUYruAOOpiZqvoIIXQ/eRY
	FghFuZJr/OlJcQ2AaSuyElYFAXmjyuuWqPttBQJt1SXJbmEv2CZ6+HFkJQqcTWwUgjN7lyGlbBF
	piKIdRCubLSv+DTvT1Ei5Px+QsO6dC0YFroPnYBySH6fIiaouHziWN13i9zMOccVvprif1Z6DF5
	7RbtB0UIWmEFVCcNa9i0Ysb2zA/49mxlq8+0K49CvNK6t+u1GiAVkVi9QVv/m/o7yRRSUS8dgVQ
	t/WcJTV3S52+sfkCnW9xMSWhvifHJ3W5E878fmpRFLLJBtYVfJlS+t3cjX+f1UMhgWoVuKSZ5B+
	xXHqtzf76QsWWP9ZavNueQaWmh8rP1poVS+sYts2APS+6PAaSqMTNy5KBP0fbOKO+FaWokGKJPC
	SWMoe+2zk2FZZRxOPdxevY177pUJUBDz02o2Laf43t+pmWXg==
X-Received: by 2002:ac8:5f51:0:b0:50d:cd5a:577b with SMTP id d75a77b69052e-50dd5b9aacdmr280256231cf.35.1776188870623;
        Tue, 14 Apr 2026 10:47:50 -0700 (PDT)
X-Received: by 2002:ac8:5f51:0:b0:50d:cd5a:577b with SMTP id d75a77b69052e-50dd5b9aacdmr280255661cf.35.1776188869942;
        Tue, 14 Apr 2026 10:47:49 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a3ff46fe7esm1333287e87.36.2026.04.14.10.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 10:47:47 -0700 (PDT)
Date: Tue, 14 Apr 2026 20:47:44 +0300
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
Subject: Re: [PATCH v2 4/7] arm64: dts: qcom: talos: Add QSPI support
Message-ID: <4o3n5bnxijobin2ds7s2hhwjj3ow5q2csw67qfb5epri6okqj6@5i4mmzuetyj2>
References: <20260414-spi-nor-v2-0-bcca40de4b5f@oss.qualcomm.com>
 <20260414-spi-nor-v2-4-bcca40de4b5f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-spi-nor-v2-4-bcca40de4b5f@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE2NiBTYWx0ZWRfX1LGg2KQaG5i6
 0JYIBFJFzSYI6+bdzw9t2ZTUlnP5YedsZhKT2srNwescM2v5XNzu2x0O3AnHRv/M5K48EstzMjb
 DVxrC5XKFrU2mcNShLBRnZIxliufjcv8FL/h0E2ZepGDYWS0hFPprd9+gRNBZGxs9Eh/SCP3Yw1
 d2/MWTbMeAjGzMphs37FCxkhHcwaCK8NLMk3gOW/uX7WqPcBg+Qz28AkEnM1aPITKlYWenQcXGU
 ZvKnbD8Grzq/t6YnkGppAb/kHmOUq5bD+BDyQUnS2kCyONKgNUbWnSymMpAt+4/r9K8+E2dwkfm
 gR/Di30z36JtRaSCmLeUOOI2evP59FX0ie46NL10JhSbuvtH5lnn7byxkbHzMFS8OEBD6T5Id2X
 jsA9MqCYjvOrlPJjVwBJU/ippjIMGB4WjRDxXeWsGF5sCpqR2c6sIwNJj3Rp26JfkcPTKqsu2Sj
 B4uyIXuaRQJtSuQxkgQ==
X-Proofpoint-ORIG-GUID: sr49UMBwL8EExKJ68XsSRH0Tw60QbUkO
X-Proofpoint-GUID: sr49UMBwL8EExKJ68XsSRH0Tw60QbUkO
X-Authority-Analysis: v=2.4 cv=afFRWxot c=1 sm=1 tr=0 ts=69de7dc7 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=6S0_C-bIcAkUoJHK8-sA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140166

On Tue, Apr 14, 2026 at 10:38:22PM +0530, Viken Dadhaniya wrote:
> The Talos (QCS615) platform includes a QSPI controller used for accessing
> external flash storage. Add the QSPI OPP table, TLMM pinmux entries, and
> the QSPI controller node to enable support for this hardware.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/talos.dtsi | 80 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
