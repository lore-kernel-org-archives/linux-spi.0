Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269E538F938
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 09:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776678352; cv=none; b=QfqDzTdIIaPiKW5wx47EI9EFODkeAhIt94TALd/0RjpebUWg4Tny2ItRk2RdpBjN9FuasRXdRHWQ2kIE+JiQDQTeFKb3PS47kM8rLKvrlT3/wNCSAA095T7wM6RlS0BHPHweJ+0Z9zVheIjH1oPBCfACQW2sf/MhYh7YyarJOVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776678352; c=relaxed/simple;
	bh=VZM+J9wy2pF1ST1d8Dr81X7N9+uaPGz8QDcnICd3iqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MnBa8cHC5Q06HwLMxXB6EfTnYdThPz1meD0ji1TQnKLopSnJh0dWJ/olKkn1KsJmSyWxCLMpQIGRt0Sa/GMU5Ls1PGwyq087aEl/4vnINyLeRikT9z/LaewGKL/RcLU7BqVAxhqfthiZZc/RAhqMu77jvCdrGtWwfbVGTJyLfTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QiSCxw1Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PGTsHIuz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QiSCxw1Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PGTsHIuz"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K7YqON3455270
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 09:45:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	u/hxKOQR8knJ33ZpSAKDOQasdw+ZOshf56WwdR5BKl0=; b=QiSCxw1ZmDjeAXwj
	lw9HTuS8A+MxK8UXjJg+IVbXrqfH5eYBalisABqBkjHRr5E2NXpPkojblhXPAxNE
	SE/OyzBuLp8b++Z+fCJ1D/ymAkqPXvAu+jEAHyYO6fTsQi030qmnRpiNtdRvHDjq
	60T/qekIn5V5Yetm4gm7/GpNLPuSUVhhPdXudLwxkU2yppoLYHpCVf8DWu28ftIh
	EakKcyGW9zb7j51IrmXew1QUcpZsgv8CLGknYUyzXUATFQRPp+D9kOOuMR14KYlu
	DbjYLYwdFFQoMKYpHv+c6ebMYOf12QUy1RAA+dmhEvuqJFCGNMhoGzKYHDfRUFFX
	Pn2h2g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfvjrpcf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 09:45:50 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50b33a19837so10904341cf.3
        for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 02:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776678349; x=1777283149; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u/hxKOQR8knJ33ZpSAKDOQasdw+ZOshf56WwdR5BKl0=;
        b=PGTsHIuz0P8xAwoBk/2D739IsiAoBgM6meSsaAdPlw5nXDai00t61WiyLo21L3thMa
         0Q7AgIuYTUoG3+9BthTiQjejARMdGagTDUwm45kRtsaaOfZ/OEp17a7TywVM3mITTU/i
         eVQazrtuSCEAdARYizYX9aqF+rKfXghIQqHaI8YzY/jy3HaNaAwkdaiODo+O1R16cYED
         8vvZbOWKvYc0YV/WhMhns1ZbxA3fSVP2b1Thp/DokqEEzrh4IuYftqbEaiWd2WCi56yd
         Pi71ov0zZZcKlb3kbagPjjBCg6yh4YUwnioCz5JvR6sAtVZShFUDg45NsaTksz6psBJx
         qV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776678349; x=1777283149;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/hxKOQR8knJ33ZpSAKDOQasdw+ZOshf56WwdR5BKl0=;
        b=ptX/jeGsSllV7oWUiPv7haO7bX8zBSDItc98AhMQi52srTFDO410HNu2ulO1hFpGA4
         A4JJjgCLwVsRkEv8Duj/+fsX4NwA+ltNoHfBIwdGIK51DbHB6AmwOlQw18ujzlghIWR9
         +vZAcjfcewlUKouOeSHVvQy44IzkA1nbWx0n6/y9ZnSsqCTl+2ew72qcVmvOYa6/LM92
         6JR63vJEAHPof6fbz7f3NSHXRfw8AAaLZopHF0i+KyTz0Q/u7nThezrmWNiogJUt24LS
         rrjnfAQy4rEUgknIC1FnF+ZMYgcRKsu8fuAnAPw8bUoPpjuQ288rY0JaVBd/buUakfZl
         ZW0g==
X-Forwarded-Encrypted: i=1; AFNElJ9lCiUH8zojrwm8s71mDg3Vm7FfrZ+O9XbFMceRgIIbsF1DRpvNkaHVcnksEABWoMNXQbr90zBTS3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Pv0d/v1AOUduFacXt1+v7l66iuRLJjw3j8q30zb2N9LQeeuO
	f4VJqjUXE0AVU1/cFvKPGZQlFY1RHZQJpPDyCU+UqSoNLHd6DFKuWtbUBCNXzjZouM6Xwdi3SIr
	ehN29XUGzPXjDvX3KucJ3xtU7uFNTSxUG17SfN+RSFOl6UxERu28gHtnfk7udDKU=
X-Gm-Gg: AeBDievLMeypLg1VdEPj/Kif/1SC2T6iaMq9dSh7vW1LXvP0nGl5KXvBJtuU5gLYNz7
	qh9RgG7DZnMRA81PY6G04HyYDslLT2WgCAewJTfunjDaOeAGcvvn88OPLGBilJ/HJ8jkUgmJf91
	FWOv6d4BsKdwASwL9upSRTlfFIWCXMoo+kpCC4bn5v6VS99xV8an3NL/Wsn6NB0MliLME6woDuu
	XNqtcVdu1Silqh0PxNGRiAxHkp87IgphDMuZA+4JhJOlxIIZKk2C5usmnjEoav9wu1BTX5DaWci
	/PdyI6sYU7nlVYA0vKTSklW24Gqku8FWO6xGkXBtBVlKOMAAsNlUdTAVICNeQU3WoVeQwuPrhAV
	Uv5ckZSBUPUCkI/ymz0tILjQk/m3I5GUob9pEBqrtkChhDk3AK78zdKBwubA9MgBIwGg4kfCPbU
	EqLqXbLsq9ok7mkA==
X-Received: by 2002:ac8:5e4b:0:b0:50d:aa1f:68be with SMTP id d75a77b69052e-50e36c1a80emr125781201cf.4.1776678349590;
        Mon, 20 Apr 2026 02:45:49 -0700 (PDT)
X-Received: by 2002:ac8:5e4b:0:b0:50d:aa1f:68be with SMTP id d75a77b69052e-50e36c1a80emr125781011cf.4.1776678349072;
        Mon, 20 Apr 2026 02:45:49 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba45121109csm334359466b.6.2026.04.20.02.45.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 02:45:48 -0700 (PDT)
Message-ID: <26b34f92-c336-43b3-8054-9de3379ce01a@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 11:45:45 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] arm64: dts: qcom: sc7180: Add QSPI memory
 interconnect path
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260420-spi-nor-v3-0-7de325a29010@oss.qualcomm.com>
 <20260420-spi-nor-v3-7-7de325a29010@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260420-spi-nor-v3-7-7de325a29010@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: lT36nLPENAjF_KpMQFsTZGRFzNj6Ff7n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA5MyBTYWx0ZWRfX0tpCcXg0VZCP
 jvLSjIJKhaemAl9lxPvIXXKMBUuBkmiaC2qFCiDNOu+sztFk3BlAlyvr78U2PuVDy5JNKjAQi9W
 +neRS4WsMNsJR/EHt6heaF01RjRpW0nQAeLTHe6TzoQ2uiSEfLV3Fk6jdi29hC18KPV0kq+Lp5b
 YeqI9dvvT33Sk4/JLeW5S+zXLGEQFr8eGuOFLxItFLVjSaAYZVJXs8b/jPcaEGVMlumMJKjyrm8
 rynWgCLnC5Ik7Hfbpn1N0TLMLV7+p3NvOIWPqbmlolT5pjtV28HsdJt7236NL0ov2qXb53Qmwk3
 MZVS21i7bvcMQsdyfa9GnWc4kiQWHt9ZywSxXzdkoJGAu+OeRueLgDG+3HlDQwamGBPqj/A8qF6
 BB/O5U6WspTDqcGaDlAdVpkqnmSMMVLgfxYFdFEiMM7bJ8BDHwtOeZwhfuAuqKko62EBBvAtx0s
 Cmfnl1PvJ0/lVJaAE5w==
X-Authority-Analysis: v=2.4 cv=XNMAjwhE c=1 sm=1 tr=0 ts=69e5f5ce cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=Qfo_qk6ajyruwQE2hCAA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: lT36nLPENAjF_KpMQFsTZGRFzNj6Ff7n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200093

On 4/20/26 8:12 AM, Viken Dadhaniya wrote:
> Add the missing QSPI-to-memory interconnect path alongside the existing
> configuration path. Without this path, the interconnect framework cannot
> correctly vote for the bandwidth required by QSPI DMA data transfers.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
