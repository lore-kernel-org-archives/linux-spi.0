Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABE93033FC
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188820; cv=none; b=Bfr3QU/Ksp7o74Qyy9z5Gay3mZh9FnnxSfZrw48La1a40ztfNiimO/5G4k3wCZZHKR50Bv/CEHx8o4Ig3hlD0DNJFhbahbvR6tmk5qcjEj2+feuj5c6baUXlHM+E5uAejUJ/vzBll/uksmzgEvUdlwkxwKF0fhKzNZNCvW4v/HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188820; c=relaxed/simple;
	bh=Az8jUdqjdALxclH4zeNPwiXwr4cGG16iIaRABsqhT1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQSviAXvOzl/ZFX3RJwcp2KSMVJbTL96m8xhENlWMjji633I6HEMmn10CnUX1ZQC0u3jpPPS9MY5ea/ss/IMtWCOok5wA5YUexc4sb0MWZib2Lq6jWdGyk79hV9GabOp4OBRYbJBT/tC/Vp38O0NvzijOUjPYCJlrw0okjo1LYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V/Kh6z4n; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fQBENdZu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V/Kh6z4n";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fQBENdZu"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EHbZVo3126733
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:46:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aGTVhNHPdzV7VNIwQ2/A5yra
	FcoMaJ4fGpKnAXy6Ivs=; b=V/Kh6z4nP1cj7/7WhFQ7m7ovv8sATNrePAssnP/J
	gq31iFCDyKRYbmOhgQvlZtxGZFNP6jb/70ln6PPhZPKwhoOInO9ZCvmgQ/gW/JQT
	AXfIMupFjlErmMHYhMkHcxRSGJVoZsL+q1rSGFBSXI19LshaCnstBGeTDktyTthj
	GDuhmXF7M2T4B1ks4NKEwwxNZg/wIjFKCrLCd3FnW2bIkl9gU0MMxF7iis8o3dqu
	ros8AYi7Y6HEDEtWan1YHSLluf0JZsb9C9g1Sn+vGKYUJ4PpIIEfhJmolrIezFcW
	qpUNsb58jPatZdESFLWZs1BeW2lPqUCWC0eP6owhLRMgOw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dht56r16d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:46:57 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50d5aa81907so137672771cf.0
        for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 10:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776188817; x=1776793617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aGTVhNHPdzV7VNIwQ2/A5yraFcoMaJ4fGpKnAXy6Ivs=;
        b=fQBENdZu2RPHw6dVQoyUfxXdv9IJadebNRtV0M0yLCimIBr2BirhrPtzMBoWngxc3u
         mHMBAXHzfJwzxLIHfo1K1bLt+lMROKI5sqpcbpHws+gIJr7hJUB0HVU55szIh6dDR+JQ
         gaKQeqBtZacemL5NwuRLHR0/ofXxti1lJoErzPAwimpaGthrmA4p8wcrCnpHIl0TZ1qJ
         yvcvUVK+YZ8iqTjLUkhy9DB2JgMjxSrEITi5SBZo8Uvo2J7RTKt9gv3XdOnhld1YCIMm
         CI1JsmbaHZVxBP2pr3KXh8lMcvYSg7mmGBkmhRyDymcP02AZk/jUBjdPgdoShY4Efzdh
         wYEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776188817; x=1776793617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aGTVhNHPdzV7VNIwQ2/A5yraFcoMaJ4fGpKnAXy6Ivs=;
        b=Io90u+xdWhAeirjEq1URYzSIFanscHyAKevZxX0ROmHV/ObfgaUXYUutEpAyfYA9Vm
         eNGXV7ib1MWDSqsXR5uOBoQBSqx8fwJnKNal4W4A5OhmCDk3Kow525Us2aVV5ai43JC2
         H+4Cd3E7PyXoh7zVkpFpgfkMAEa3hYERynydZ+E0aIoAI0AH4sMIe4NMoiKR7dZsdcI+
         6ot+CLzpoN7TxWGAMiuYEw92WajeFRDsAQVZrGchbcFZZknMTR5tyMugUw4rJfTTgw3x
         zXM8QLanYDjfopK3S539kOt6WrUFuBhFZs74cskuSpDyWJ/d1PU22bzzwVXIqz56s687
         hoJQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ObZnj846q/P8sd97x+cVnXnXCY1jGJDMlZpbUhT42fipdpdxgwdMC+nxe9oPcPIKcyE8r46m1uCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5n/4YcTfbVjD84AlvvvnomIFjNRNzai/BLa9yLEiNzGcK7X01
	KaJk9wg5N8ECckTdtU+4NZVuoGypmhQawwe58HxvyuEdsD8ksHxW2kuOAzhQM04+xXQU21yf7fX
	JxCmRXazK5/qnqzgA5e7qHSe90gtm7/ODJjE+SXSwE7rIntnx7FUWItXw2vfW880=
X-Gm-Gg: AeBDiesLEBVcq1FtBxABK9xj/5Am/zMgws8GqhvPQsZ333IOeSkawCC8xgDndwtt/cJ
	cfYLPcrNcdtJsxhUgtAm9dzlQiBAOl/ZKxUEJ/HmB5rTJiIqLCcjQGuCZi/R7B556gk5Ww90xAp
	JtnNBBUZdylNE2UAmepnwKo9kSCDzqE/4AORdh+yWZf0xFZqqXHDOL8W5zzkRRzr4rC611hUgwG
	s9xcvs1lAuP1tL14rK2fSYWW3BS7F4ngkx9fxUg8gZ63cCtkUJZJ6cxCzc+1uCoIzNdFsBDTm7+
	y0kZFpCsLK9Bc9zHxGgxyECfoCTgAgeiTcA98ujPj5sQgXWyNsjuMDOunHrScOpIDl8X9mYrAuG
	K9DpExJmPvLVcmVRhZ2MgkxdDKMFMayy0jpvL9CgH6b+BqEkABIG+K0j/YfiJzjwRY8Be4ApfeN
	qRJslGUDU3eBYDMdqsW2I9vI2mrvE1Pe40GoxLuGH1vEFLKQ==
X-Received: by 2002:a05:622a:4d4e:b0:50d:6ef4:b38c with SMTP id d75a77b69052e-50dd5acb6c3mr246211361cf.20.1776188816858;
        Tue, 14 Apr 2026 10:46:56 -0700 (PDT)
X-Received: by 2002:a05:622a:4d4e:b0:50d:6ef4:b38c with SMTP id d75a77b69052e-50dd5acb6c3mr246210721cf.20.1776188816199;
        Tue, 14 Apr 2026 10:46:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a3fe7db18bsm1378509e87.47.2026.04.14.10.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 10:46:55 -0700 (PDT)
Date: Tue, 14 Apr 2026 20:46:53 +0300
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
Subject: Re: [PATCH v2 2/7] spi: qcom-qspi: Fix incomplete error handling in
 runtime PM
Message-ID: <p3nx234uwvrsrrpyfhwoc6lfzax5mvaixhaqtbehbiirvp4h3m@vzalm3esidnn>
References: <20260414-spi-nor-v2-0-bcca40de4b5f@oss.qualcomm.com>
 <20260414-spi-nor-v2-2-bcca40de4b5f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-spi-nor-v2-2-bcca40de4b5f@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=LuiiDHdc c=1 sm=1 tr=0 ts=69de7d91 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=nVvXuFPTU1805r-_gQIA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE2NiBTYWx0ZWRfXwvb6nHdxX2Kk
 q0Q9Rqi3MOzxXfgNCLZfAoWDWEGE7SzpiY2fo9BbiUVhDkNpPmTsYpsf0GX1k3fAk1I4qQP4rd8
 x5qiyY4TNcqiBOjpHVqoyyck2W3yHQZ1exOpo8aryQLxkil+Sxy+gALq/S/OtEjq4c7dEBDRV+3
 Qk94vCQTN8e44xLwz+bf0uCJ3PPnFqbPqEA4GLNHEM5p8PgCTg+7KJ9o9SUB7BcY+bRC7UyxqTc
 bkV41ZfuEnTrQCl+IYJZVbkwon2HWoek265ertKbigVIXa0VpAFy0s4e8ku7O0/PR3d8uhdgb4S
 68Jp8Jgo409HuA+r/2FWLrqedrzg3UB3sYmeQ9DE4BA2e0iV4EOkCbeKRP23vbtaD32mjIt79U8
 4pvdn3v2PhSMMKHqmrZC8XvYV20EADXJZU+xAtFLIOBXJr4uLJTSCmT5F3BqJP/B020qCZaW/Io
 8XfkbgGv2kSvvBdMThg==
X-Proofpoint-ORIG-GUID: sY6vJGWt4rXwfeKwy69uBWQvorU3BMwS
X-Proofpoint-GUID: sY6vJGWt4rXwfeKwy69uBWQvorU3BMwS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140166

On Tue, Apr 14, 2026 at 10:38:20PM +0530, Viken Dadhaniya wrote:
> The runtime PM functions had incomplete error handling that could leave the
> system in an inconsistent state. If any operation failed midway through
> suspend or resume, some resources would be left in the wrong state while
> others were already changed, leading to potential clock/power imbalances.
> 
> Fix by adding proper error checking for all operations and using goto-based
> cleanup to ensure all successfully acquired resources are properly released
> on any error.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>  drivers/spi/spi-qcom-qspi.c | 40 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 7 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
