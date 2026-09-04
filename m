Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AC13ACF02
	for <linux-spi@vger.kernel.org>; Fri,  4 Sep 2026 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788512472; cv=none; b=im2dsqxJRFTODJweGrm9MsRZl+RMnHvCD0ByDSX8Uo3joU2i1+zZHoQ4kA+drhtea/fd04NhNKGhmJns8nKT7sP0t4PS+m3LWxehIETrOWz0bCbRy8L03AeHgEuvwB/VHInlbICzctpAGY8T/cyjkX8FlkjSSru4VOQZ5Qg2z/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788512472; c=relaxed/simple;
	bh=z8mUeY8jdDe+OPla++cCBqYJoVtldQxpArBHUi5E2dA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n3ppq6OyLPLXJodQ0odQkv20NTayH5MXnC3NIQQVghzHAEt3Xb3i0JDZbBMIVp1GSKNyROaF/dJMWQCSj1yWhjWWw4iGhhhoZ8re/Bunai9d9Z6HMs6r21c5sTrg7voNlkJ3p5eaBC0qdTXj05aWwwAxElhKvqtdgH1oxrPVCXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jdPDAK05; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QBhOSDB8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jdPDAK05";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QBhOSDB8"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6847mgAJ3112792
	for <linux-spi@vger.kernel.org>; Fri, 4 Sep 2026 09:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XfbM+zSlZv8MMTw8htQZYg+PCfRFWtMlG3dHQRCYpuc=; b=jdPDAK053fGQzOXD
	4cj+xPyScRRHFDeNL8zcHzs4mOeJur0khdg/RqOwN2LWNkaAIBRuQ66CDy9SNfUz
	cdjxEZOdcuoo5xTcBheqPhDXrE3G5fga5X8nlO191lDpsOMTqPXi6oWY2jljfKQV
	59dl4zlsOQKAGJaFwidGakLayrYMXJrPbLTGEjifEYBP7lgmaCOAlYeIx9GCaBDf
	M2HQZMn55+SmjevbfDJp9azLFpkl/eyqSfKf8dsWQyuZeGef6wUQhnewV2I6jRla
	FTBgBvCfz4S00/OEhRxPpzd4j/JAyFQY6vx5JFZwoS0qJnO2TdcU0HCQ3mRYVUjR
	lvuEAg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfp780yd9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 04 Sep 2026 09:01:09 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51bfd1772d8so1662621cf.1
        for <linux-spi@vger.kernel.org>; Fri, 04 Sep 2026 02:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788512469; x=1789117269; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XfbM+zSlZv8MMTw8htQZYg+PCfRFWtMlG3dHQRCYpuc=;
        b=QBhOSDB8lo6bge+DCDfeiHrVM3sOSlH3kqz/P13gL8NurK61xFei5bbILuU5+kCB3a
         HMuo8xfm6vu62yaXy99Q2EzMEN17Jl6BqBXBliwKiK5YHcEbMBsKim8/hO/0fLC8czUY
         V7cko+I/GHTDzh0aTA8wyJOBZGTC2sKct13hFtlHGPIZhsFVEGrsFcCOzra7m3nvKEU5
         H2TeuKSNP03m41L3Mb1lp+PrUwJfVNFynnTrnaTGu2hvkVLJzeJMv2q4ak8AHWXCYid6
         Soshfdw4gGGdrbNcwN8p08KQ25FQ6E3bET9rqHYItl1N3y+LI1odM/49RIoDs8yTkoMv
         IwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788512469; x=1789117269;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XfbM+zSlZv8MMTw8htQZYg+PCfRFWtMlG3dHQRCYpuc=;
        b=CuKE6O2+x5ivmQEfvvU1K7pb77mDugVlABBW7Uz3fgHkn/Q2TXNfH/yZFO43eRrFaF
         uUVIN+Q26nRdQKsm8sSGpexba2tvMFdTf/VTZr3r8H4UrUG6Zk1gVhcIpp4txBhMRGdV
         u10b/E5xnCKSNENDTND79vSh88UyzV8xXDIxAHFcPF4kKrMvrVcVZSSOvzjqwxQ7LYB2
         Fjx1suKtSEV4pKnNG59itX/KZBmvV6KoIDQ0BuTZzrk0qw/rBH14K2QrZJPyjwSdUd7s
         +NjzdR2W/Am4CeWSE6Q4YpxImV35Y3lzVDO7zDH2cXOk+fToVvJGZKDdQsYz+eR1JB3h
         iPZA==
X-Forwarded-Encrypted: i=1; AKwUvBxb0FTGgUvB8s70hYi2BqhT+0QTXaliwk0ZTDIljvuok6FbmevuGQtLxp1uXhPI6XkW2EewAtbRfn8=@vger.kernel.org
X-Gm-Message-State: AFuF++mromUIa1KrnixuKinb/ASgH2dspT2dkHS1oTilA1FF9Bxb1FZK
	6xgVcHvUJgTxG4ARDHwkIY5ATdggqY790O+A+rlaE8/08d3odG1eFr7bb9tZ4/Vhb3aZkc0WvLK
	yla4uE6mtVVJo+dzE/Lu8EwTotSz47ioJEhey5DlsPJwDpyKe3NU1ZMMpUfQS1Hw=
X-Gm-Gg: AYBFou3OqRG5YJK9mzSKdG9u/Q170rrMXYdHWYN6SMyrVvlAwtIn7c9M1wzySl2/+/F
	Y/L46lPYdVyM0u64fCMVWAWxGdi3it0cPgG99Isg6AiSuwvYbHB3be+jalEIoK/2JueHKpJItci
	by9QSDOqH5nje6/lT1TN6HgW2d1lwZIsm6y2vB6JEL6mxy7zcMsie3/JdLMwveff3xTuEkEwLzs
	BFKmEuwbDUmH2SAr/cj8dS3Pv/Qzu04gZ7WuRC1GLMEKr80PkH7Z5/diA6vyLWb633P5LpYq/rg
	aibdhGf1cDEcoVlnpW8iQhezdOdufeoPrf6829WhFDuX9x8erznfiyucQTc7LOUtvQlyTs1m+KA
	fT2ySPv35ciUKGCQWRrfGTg==
X-Received: by 2002:a05:620a:1b81:b0:939:2c96:1551 with SMTP id af79cd13be357-9398055cc61mr341377985a.1.1788512469161;
        Fri, 04 Sep 2026 02:01:09 -0700 (PDT)
X-Received: by 2002:a05:620a:1b81:b0:939:2c96:1551 with SMTP id af79cd13be357-9398055cc61mr341372085a.1.1788512468661;
        Fri, 04 Sep 2026 02:01:08 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5773c5sm76155866b.40.2026.09.04.02.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 02:01:07 -0700 (PDT)
Message-ID: <b245d6c2-825c-403e-ac73-d569820895e4@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 11:01:05 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/9] soc: qcom: geni-se: Add helper to set SE clock
 rate via OPP
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-3-091697dbeb02@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-3-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA4MSBTYWx0ZWRfX2/by3zJvBz14
 UmMAzRolnIWNsLIEOjmlsB6xfIaRPhK5PVx6wdfg6wxFZYYCDyBaD9jke/R0FxLXSO48KsV4ZC1
 1JM4cU3K0gvdsglvQnLl22unJgVmqv4=
X-Proofpoint-ORIG-GUID: C49JtPi6M8_1Hlabz9zFhSghmjxYTHjJ
X-Authority-Analysis: v=2.4 cv=ab5RWxot c=1 sm=1 tr=0 ts=6a9a88d5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=9aiwZt7zaXvVnErAyWsA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: C49JtPi6M8_1Hlabz9zFhSghmjxYTHjJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA4MSBTYWx0ZWRfX4RTGHSmyFjrc
 W3WE8N9UVNzaoOacVKycolj+CV+h9siTqGq9AxijGykPHH9aKFzsGSTZ5OMI9lVQk+Li7Um9WJz
 5OK6QX6DkDJubTmeJ88O+xuiO77IyOxh7PuDCqaMuTnoJDQLvt9RTpbHzPMoW45vnzhrtnNIX5i
 U+y6p+XKOSO2KfBmfL6zLln5NPSq11dawTwJSP2zcYhDknM1s/vjJIXKtGKR50LP/mDnRD2MsJW
 bgCfhTB0e5uT0LBlo1Cq/lUmWTwgtPgRVMEZ4CVTFP4vwjQzarrSKstiuSBx1ibSbPrZ/VLlA+9
 atH285tFFyslQJI6YBF4wUaxcFar+aj3xjvE1SLYLBJq/y/Vjor7oOoXkj3b1c99VKqi28Kuqk/
 U7gg/PcMb0M9Pk5PYZ/mjk0GyzFhQqI3+IHyPd7Zb/Su9Iuj0IXZgiGuzgcifXP/SsD0fRgJMWj
 88hMSrM2T+NLdfYZutg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040081

On 8/27/26 7:59 PM, Praveen Talari wrote:
> GENI protocol drivers need a common way to scale the SE source clock
> through the OPP framework. However, the device that owns the OPP table
> differs depending on how the SE resources are managed. For Linux clock
> managed platforms, the OPP table is associated with the SE device,
> whereas on firmware-managed platforms it is associated with the
> performance power-domain device. This requires protocol drivers to be
> aware of the underlying resource management model when requesting
> frequency changes.

[...]


> +int geni_se_set_rate(struct geni_se *se, unsigned long freq)
> +{
> +	struct device *perf_dev = se->dev;
> +
> +	if (se->pd_list && se->pd_list->pd_devs[DOMAIN_IDX_PERF])
> +		perf_dev = se->pd_list->pd_devs[DOMAIN_IDX_PERF];
> +
> +	return se->has_opp ? dev_pm_opp_set_rate(perf_dev, freq) : 0;

For !se->has_opp, this silently does nothing, which presumably
may have bad consequences if the caller is unaware

Konrad
