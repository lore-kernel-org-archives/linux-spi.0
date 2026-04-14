Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD839318ED2
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776189391; cv=none; b=Y1BrVEI2Xly/5fVIne0E2NK5oOjTQBuoxiPqly0VN+9UZfs0u6inWmtRjixuIQtgiKMMsExmeUvQhXSZL1MbLS9+vDUUV+cadI1fhwdhmWTk12c4cKaxJbWKn6QEYkgk3uwml38oHgQIZbH2OjzOKF+nk0AM8phdlyMw8wxXBoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776189391; c=relaxed/simple;
	bh=7aBT2DK7EHhd1zMiHlKrhw0mccqkDL6WTD1AjS25XJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6U7R63TCAiqKivNGKn5KeyS2wUXqBln4+kl4AsorCgyT8X9/oA6Fo8sBu8OzaOIpftQmNIrSalt2OdbF47S/irs+SP8SCYomiyLdl3HhoO2xJhwRdVhc8JgBluVQBrs7MXyVSUnRxQ23WnojC+XxOkNviKyOTX+JnJuIM1vmTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=haTNbaQ8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Qm4eM/Nl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="haTNbaQ8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qm4eM/Nl"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63EG7hpu031137
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=yBCQAoKuaAbhqEJpnCtly0r8
	8WL53vqH1z95hkDBEPY=; b=haTNbaQ81NXFL/jxs5evOseocmMoZvkGthci9wa4
	kMchjbnE0usUgZrYK7JFakcPvxNDbtHPiBB2sDWAYXZwf6e+zfC/ar7HFZMldFRY
	vsxbhsyxag31AfVfHGebx1fcQgvnZg32KecZTyfdtdIGyBMcMePAWybG6HkZIyQN
	H4bw3e9NLyPVBT2S+q887s5V3JJmQLwAZcsEGOsLwniJYzJxj28QxUd729eA9+/W
	mNdWYw/+s0jFhKKJO/wmQ2C/KJUHB/skn1tn8ZmFJisN73bI/tzWkkeYlk+2L3jz
	3E9fRaeIwok0ch/zOgPRnaGVTP+183H6p/x/lQEa2n+EZw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhkgmhq54-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 17:56:28 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50e136aff17so13125121cf.3
        for <linux-spi@vger.kernel.org>; Tue, 14 Apr 2026 10:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776189386; x=1776794186; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yBCQAoKuaAbhqEJpnCtly0r88WL53vqH1z95hkDBEPY=;
        b=Qm4eM/NlWORnaJj/X6wkb+FM6uYSnUzlNMM6vRaCm9BjYgBERbEYGJB8/Xct6MXEWS
         A7g0Haa5ddk9QVsshnRtM7IbKG9Q51n1A0KsVxSP7qKW5joHNtcmvX6449hu67ympB3X
         CvD70ixH1lKSe6KJVWWE3/ixUKvWjhsSonORVwV8r/Pdsz9vwvHvv4JY3x7kjCnUjps/
         6sIqOE2/m9R5Pc1XUk7OEnvG9AiQTz4HFUUZaISueruR/Ma2fKrBbBaFIbXgldgpWqvg
         08dxBAp9AmvqSvXPQKfCST0l8B0S0FfjNgzuT0x9Ni4bVwLrEop86wG+3C97TcyC1kip
         4QLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776189386; x=1776794186;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBCQAoKuaAbhqEJpnCtly0r88WL53vqH1z95hkDBEPY=;
        b=BNj5u3DZxRcKJFta6Tm8WaWN5qP4F4PKgRrhPi0H+9pDjNGJmR8KTR4klHFrygPqUX
         ulM25UTDgNx9B3Zlia0rKtIktSgosLxw0I1xb4+SbT+zhtv5wTliMaBlbdWYxRC24zz3
         pWVRw9dRApbAwRgqcBhMEvShnCs6xjedjfvUXRLUZuEofj8elBjddQ63kBmUamfsYXn6
         eCkPCX9o7OJKncfsM6wugVDJKuvz0K/OI+3faMRds+v8GfoAkQ8KfuDMmrjOgKcQjyW8
         andw19uACE2YV7plTVJqtd5GuGZ18X7Fk/FjhZX5CexKivOt63oWcN9C4rAbEBc1j3QL
         Gw8Q==
X-Forwarded-Encrypted: i=1; AFNElJ8yO9CiX+Ii6V2aZDFS5eRuBZXk0vS0JH5Jwvc/F7XhGxUDq0zwnpO05FgAhhwiVXYcSOsMBHB9CDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNBsapsDF+97Sv77jTaCkLxyjCneyxcczsAxs4OQCeiK9L0YVf
	h2vDNE6wwPH3VJLFbqvOYVAu/zOjRDpnPi0UPKWhYOW/DWKu55G2iUSapmREkJLsjPA7oyZJ172
	V+nb3r2WX/grFFb/aYvTdkkmTJabm+9Kr+tzn/enjnC5JDUrWFn86a/YUmFw85uc=
X-Gm-Gg: AeBDieuOXYoB5oVfTe+drWlcu99lxleLxBhKcOFfjCFUeGc3CPS6IZA5eTKZQZHEaNl
	Vw3WvC7B7bIJSjbQAwZHXXiPOEm3QadX+bva97LgZsaodsErWCPH9WkasQlI5lIQIxyc/+3h1Qa
	83NguEVwFUxp5Z0ATRJIAauuDxJ2mVHZ5mJI9jhxPmaj40diAi4fYhmsOCeCn9AsfkCnA51d/Nq
	igGeSWSNsdG6ojo5fDE5/djHB9wKZjKVtH/TsIZJp1ev0AEIceTAoAvpcOShfEPx3OnDkcmMOjt
	CZjnatdcA4tvfqcbbNs8Xfr3+5SpuUAdWu+xmRx84nCPhv90EpB5qyZRZdXy2bAQtRHQWJyf6ui
	8Jq+0E+o/4MMZSOvXIGeTgk8Yy1Ids6lvHn041CiEGhIUgebAbuUIUaPA5ZrPuYoiC/S36LVpe4
	khGI/Ew2xJs572r4tlOBadaRNHYDrDkk+u4vgFa7YzbnTwTQ==
X-Received: by 2002:a05:622a:598a:b0:50b:526c:541c with SMTP id d75a77b69052e-50dd5c13154mr259578051cf.50.1776189385936;
        Tue, 14 Apr 2026 10:56:25 -0700 (PDT)
X-Received: by 2002:a05:622a:598a:b0:50b:526c:541c with SMTP id d75a77b69052e-50dd5c13154mr259577551cf.50.1776189385445;
        Tue, 14 Apr 2026 10:56:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e4957eb1esm31525781fa.35.2026.04.14.10.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 10:56:24 -0700 (PDT)
Date: Tue, 14 Apr 2026 20:56:22 +0300
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
Subject: Re: [PATCH v2 7/7] arm64: dts: qcom: sc7180: Add QSPI memory
 interconnect path
Message-ID: <vp5x6ood2guxtcqnb4fp5sqy2j2tyf37lk2pkypawexxkopf5g@4lfznaqhehix>
References: <20260414-spi-nor-v2-0-bcca40de4b5f@oss.qualcomm.com>
 <20260414-spi-nor-v2-7-bcca40de4b5f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-spi-nor-v2-7-bcca40de4b5f@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDE2NyBTYWx0ZWRfXyc84b5glTrSY
 2buhsrJd9VnPdh6RQknxyA2AW2bu8sOuaG0v8s/Mfila9kz5YPtOjoxswbg7vzkADEdjzKYKIRv
 NxVWZwPjX+OPQf/mCzWcUAJPhtN+23l/otBGcth8Xy8cQouP2/WLx92AtBQJ3tOnCdMDE0Jy6fm
 BWjP8d3PmmttsMUYhqEkFo6t9TTufHzkdvrqjn/o2nyk9XlivHCG2HmbZyIUIHi/5ozg3WXLdmo
 mA96FUESGh4PWn2dscohim7M6nZzbxHRXKujHF184Sg3arbR1VpIa5aaHheB3zcTjTENcQN9bej
 Q2cLVyj/rqlujxHErysgjHadvNF2NkTV9P4K663qUGT3jEvIKOOF9BxFOEB0QaKUBNN5jVntCcT
 crtu8dVUTMEC3ulHCBoh+Mpj8gfpwKA+v4VTkGljHqShv0Jxuma/RA0OSwsXMRcqrY9P8GwyqUF
 yqB8gj4Lr9IRRoPbtZA==
X-Proofpoint-ORIG-GUID: 4kDUX15182aCtZ--rXzfzFXXf38H8EWT
X-Proofpoint-GUID: 4kDUX15182aCtZ--rXzfzFXXf38H8EWT
X-Authority-Analysis: v=2.4 cv=HJLz0Itv c=1 sm=1 tr=0 ts=69de7fcc cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=CipEwJKW4Sg1KE0sZiEA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604140167

On Tue, Apr 14, 2026 at 10:38:25PM +0530, Viken Dadhaniya wrote:
> Add the missing QSPI-to-memory interconnect path alongside the existing
> configuration path. Without this path, the interconnect framework cannot
> correctly vote for the bandwidth required by QSPI DMA data transfers.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7180.dtsi | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
