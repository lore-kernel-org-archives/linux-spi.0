Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9370C3074B1
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188860; cv=none; b=eHh789strdPXId4MNfHQUquUeXfajGW0YnkKqdE4cOnNoIs/gaDjongCaxYKfnXawcDo3hZVWFoo8isiams+da9RAcNyUwwUdN6wVn1/OxUGKNUaY6tqYuJmvTrcOX9ke0tA//YNtfzSCyWaGTDvtMDHB7Tk4k3NlwtV3dhnOuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188860; c=relaxed/simple;
	bh=sbHR1rCEAF5+p7nGhZgXKdMzGgrIdalpdSavKNQMrGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qigDVHjcVEbD28fqUMepUouVeHZxMVL2rLIx66f7XQPRw0w2YD28CWUXDlILTq9V4XNEVGTufDokqeFgnfXAXj4EFYobwQsjC1pJZR++Hu4+ypxH7eZIfhdOh8Iaoj5Hi+DOYTAIdUAyu/dc3IZ/hZJoJUVz/NoEK7EazFCzqcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OUveyinP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BoL1HOLC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OUveyinP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BoL1HOLC"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EHcHrq3100795
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=fIysXbHVdbDHIRrNfD8gUrC8
	tNZD2pCNsJSliIQfnW8=; b=OUveyinPJ3DC89CYHJHZxuqMq6S6520aPZo2tTPa
	WSfB8/4Wsy3rU/sMvflJZ19/GSuU7bqz5hZu8mMAfRHU0ahG5CfSrI8nFR+1Jm7q
	Uy8y0w5Z3M0WAQe8dwDRu0kWysjbj2OGQi+B0b8Wawoe66i/f+Rr0rsNNeOz1wtd
	lAgaL3px7jmML1dqWWJmBwgUuWMzAmCjVsNxRNwqsB1zo0PVCb3GtJ4lbMRg9rX0
	JbMuRfbkcBlu3RrBNs9b6zctTrQzuoc7XcxLC+V2krEDkCvMsaxdSLtR+0UePwjA
	zgy2snPMMRRoVC5tZTc/+wIDzJYuP5JPO9+mmCIjUssOhA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dht5h019r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:47:38 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50d812c898cso152091851cf.1
        for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 10:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776188858; x=1776793658; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fIysXbHVdbDHIRrNfD8gUrC8tNZD2pCNsJSliIQfnW8=;
        b=BoL1HOLCNT/w/TAVBjZw3T1wk+GfVcEHkkisPWszD2YkeCYQNX+JPi1GNrHnAxOcya
         rTvq/XDPq0536xn24/n7ab+HVB+CFbtOZGvR4xajTaMiJP55spm/YWD529KkV/IF7ypY
         6pToEVauhBS4Kpcy6z8GcZGzDX5zi1kr2kYJDZegt91aSxiG7sY2RA1z/6ui4GU3NTtw
         jahiFCFIWDmzS9xse7vUjs1oLDxe9F+Pb0+etlWbOiGHQ5csRTl6us++n9NkhfpvLj+c
         Mjsb8bh2WYvECXfRhcb2HphwcOmrNKbbeH+Bg/um31OY2M+Jv/mG8090AJHAoiuLSqqt
         ZOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776188858; x=1776793658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIysXbHVdbDHIRrNfD8gUrC8tNZD2pCNsJSliIQfnW8=;
        b=oTetZokO5k+7BO6WEFCeb3fUG3nH1wR4eI2zYrmn6ISh2AOagfRmpkyQCii4tPm2j4
         Ei6YGLyah12BLTa25BMNHSvz/dTP3yGEpnbeHep4WG2XgSKJ6pW5SqmKQXDugE08ksO6
         jCFMDlIyi5aWTFWgaNtsmK8RKZewCcXb2UOQCybzVjytyf2wRy1x0EvnXcQg2NZ3YRWL
         zhChMUDyGFq09QQ5PhtCswxQACv8HXmedupoRNOcgV+ZDu63zrm6w34/hIf9Qddkn3eP
         Z88U2+ViOZp8Vuzpv4YglWLvUIRTl9OVTIEj30ZpJ4sgFUYbmK4l3GTF2ykMvAZuLev2
         ArBA==
X-Forwarded-Encrypted: i=1; AFNElJ9BujIoDWNwQSfcHPMBRVKp3+k9QsLYyZS0GqwTMIICaJPpu77vBstblLlUJf4126TlNeDLOdoT4T4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJSdpodGDIqpavSPbOUolrM5ttDBj+sUo1xxtQpPEe67vKEXtg
	+DsU3AAdXc1P6NUnO9hN0IO6Wo7cTkP3i8pfGT56cJC1sqS29yirzO5yj4yeZGe/QTQ08DSf5Pi
	ZL21iOolsNRIfzQCH+cDuyQwVNBr1hQBmQGrTkER9E0XeHQ7YbexBZNEVL2G8TCg=
X-Gm-Gg: AeBDievrd2jepTAdBGEC6yxY3oNzibK3XD7vQvdtjboIEfNvZb4OIyU5dqelRC8B6OE
	SLOvbykPUapZmCvXx2c9Hw06R3BgRDnjvgA2GLdMmSWs+ERGMIHFePydhxY/BAazIk1N91NEf43
	eGJ2CgZ0lQ9slDGJ0crI+jpepr7Wn2L0vz6npCuxOEvjYYXch2X4EZKvBpKYM5xKTCjY0XU7iE8
	C2YhT5vON0xnWdkTsnn71/IIJnzR29rRUcEtleksWNkDzCiAuud/519vwCjSSlssJ0UsyAF43Dh
	e+zibNP1T8zZLvYdITurige9jWzfvhnJe0Zp8z6Q55RIBJm03tazjU7qLbmTgBlhkVev3lvheIC
	Mb884yPpIeZrSjpINwaoIAU6V88EfFK/TOC0WkOqu0dsw1Pv7mnwmJcJsXssvM9W2Oie7xx+Jfb
	zvobHTxeo5YNwzcTLdJ5W7WQ3zzdbEHx8kkJ3VWUDWgqlIvg==
X-Received: by 2002:a05:622a:1344:b0:50b:496c:baa8 with SMTP id d75a77b69052e-50dd5c3df8bmr263789061cf.29.1776188857954;
        Tue, 14 Apr 2026 10:47:37 -0700 (PDT)
X-Received: by 2002:a05:622a:1344:b0:50b:496c:baa8 with SMTP id d75a77b69052e-50dd5c3df8bmr263788501cf.29.1776188857494;
        Tue, 14 Apr 2026 10:47:37 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a3eef0b4c6sm3480555e87.84.2026.04.14.10.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 10:47:36 -0700 (PDT)
Date: Tue, 14 Apr 2026 20:47:33 +0300
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
Subject: Re: [PATCH v2 3/7] spi: qcom-qspi: Add interconnect support for
 memory path
Message-ID: <6awjhtzjsvtustjp4ghy7dyiujzrkbu6szq3iorsk2og7jhyr7@nmkzfejq7upb>
References: <20260414-spi-nor-v2-0-bcca40de4b5f@oss.qualcomm.com>
 <20260414-spi-nor-v2-3-bcca40de4b5f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-spi-nor-v2-3-bcca40de4b5f@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE2NiBTYWx0ZWRfX9zXRQuC+qJhK
 Y4YoBLrEcDmGJwgpFRvOjUpBO8ZNutlYKieEp7Z4qZx1Q1RzBWxXyuomdD566+lICMWXdPrbTg5
 +xheC7mpG3i4gqGeXP8JX6x7WobBvTuG6If32thmMAt2dIw0yjo6nbp1+A+d5ZK3ryjPmGnzZpB
 KkLI2rR5HU5e7SWmf7zxAzleVyEkpovY7/3CiiRpohG8a0+/chupsWsHmZ13A3Tx2BWntzgX9Tx
 Iycjv7BM977pAXdbkn0vlVIvBI3zTdQBjoV0Ve/ooaOC1C89BZyXcsbqdjfLjr1CoVbg8D//V0+
 7bq8a1ftVvuxBaJS4iy/ABLHMr7y5zdjU5o0MEOZCtHcg42wjgusSXl2R7D2xtY7Ih7Nek9PVa9
 xaa2Uo/eCRRgCHcBnMqMp49nklntDjrm3kIE82rjqwpE1/GuAECQaxPsY73n3VLhEDRm8I2U1Vg
 lbwOSszW4SNVfXtiD6w==
X-Proofpoint-ORIG-GUID: AITA_dN7qArsgyWI9awvh2hQ-DjY8n5y
X-Proofpoint-GUID: AITA_dN7qArsgyWI9awvh2hQ-DjY8n5y
X-Authority-Analysis: v=2.4 cv=afFRWxot c=1 sm=1 tr=0 ts=69de7dba cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=HcHoBLZgMIbup_Q7xnoA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140166

On Tue, Apr 14, 2026 at 10:38:21PM +0530, Viken Dadhaniya wrote:
> The QSPI controller has two interconnect paths:
> 1. qspi-config: CPU to QSPI controller for register access
> 2. qspi-memory: QSPI controller to memory for DMA operations
> 
> Currently, the driver only manages the qspi-config path. Add support for
> the qspi-memory path to ensure proper bandwidth allocation for QSPI data
> transfers to/from memory. Enable and disable both paths during runtime PM
> transitions.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>  drivers/spi/spi-qcom-qspi.c | 41 +++++++++++++++++++++++++++++++++++------
>  1 file changed, 35 insertions(+), 6 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
