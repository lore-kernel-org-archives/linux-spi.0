Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3226F388395
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776678326; cv=none; b=KBN919kcl5YXyVoQlcH/Wwb7KvihSDYDJyLN8nAaoQUGsdN6J8JUHTAMFAieT0XsXIcFjs00PU7OvnBQzQsGtUgrtBeiPC0tphgQwOLigjkxT9hTLjwiw7qP0lx2a3j+3aEU6tDmWOEegcNbDTt9aqj4U1ptRBkD7T9+MVvoYV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776678326; c=relaxed/simple;
	bh=bYSwmUjGtLvHCdtVR/0+t4pA3GFfCehUNhWs06XWDCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h8HvO/pIoYf0U98AiIhOrPT+lJnPr2iynZsTGX1t4Pqn63H+BoYh3WZ+OQ+Xpv1ChjOoxwtaBst+/6NT0JSirRFHM7YacWJMl9Ko38ckrG1rp5ovBwofWpdPEdOA0qE8Tl2KYlOawx396Z0v0FuMhWMXYe7yuoiOoZqSjHp8Two=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pGk94qRE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V/j3wtXk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pGk94qRE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V/j3wtXk"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K97R1k084489
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 09:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	y33D5UjjNCecB2uHxdjgRCYaxrrJ89ADDV/1ve9CS7A=; b=pGk94qREZgzRdAWt
	h5jF2GTN4Gx48ZrIDfShqM4WDnQP0ZZH8EUBQM8NmbWKZSm+xIUDaIo4JZLh2OGp
	mw1nYeAnjnur1NmD01BY17yvEweX1+ui7cJSF1Ob+eLs/kphP5LlvST0UaYM8xtN
	HOQkXGjTBtRq299gOX7JeeoZFl9y/ltIkXZhP8ZPHwv55hxtTQnxy1vJd9FHyhvN
	3nLqc+vxtugKHO9gA+FjVQIVPeBKObTGs44Hg/FJ7/CtY+K3kEZsErhTY5kqFYsE
	4B+9OBpvNXCwdM3kvp4P2okgNsLXNA6GSS7NeJ0xWNBFg19RdmEgxWWHcbY0ekWx
	54PqJQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnh81g551-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 09:45:24 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50fad7b0ae2so110721cf.2
        for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 02:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776678323; x=1777283123; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y33D5UjjNCecB2uHxdjgRCYaxrrJ89ADDV/1ve9CS7A=;
        b=V/j3wtXkaRlR7ACzAcXdYJTA5PHBBRYDeMg/RI+6W6Y7D7zdqlIWNzvUwBV7IIySas
         cddQu5U2wzqXC4SGlxpx2YAPufvAyJV5N76Z3EF11roLvhQoaF5PcDeaNLPInncjOkWJ
         fMSra950xo2RV1acne0djucY6LOKxY3sbpjYv4qjdrW7rw6AS+tvXN6NJQ424NMcFlTS
         gJWBFg2P/lQx0H2Em0WE13Rx2zWHIvGssXDI5KloOgXNSod24kkcmUSE4uYXyfr0+684
         OM+qnJ/3kFOieL1/IDK81QgLBZYyAEydvGiOADIHqnovTUhEXkCaUsOdyjgwdF9SY+Tc
         2yjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776678323; x=1777283123;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y33D5UjjNCecB2uHxdjgRCYaxrrJ89ADDV/1ve9CS7A=;
        b=R3Z1OX0LzMU8QHhEgDpXzlST6rUiF6Leu/SiG+zCR8WG4FiXZqKrDAnN3n8cWg0PNC
         sjRqu7R6A8s1mrr3B6K5bxHJDMC5lPf1as/HVJOl2MMAliY6b7klZiZ3L0aKKSNa0K9k
         e28q94Hm2vYOXfFOLsbeyhARhQeVTQBfBfsNQIVTRJ+CseDHltP9VLdk1BtZ1FRxSg0C
         IHhxZ4WBoqhpxzgE87V6G3dz1yRafuKAzsvzJrl377422GtSDig0fwsreY9Xr0nCD2UA
         HbnCXPJ/zfXzZrvqwqPCusrCvZZ9IIJySLwtFUDggerXWVn8FoZ8xxUOMFVMbfC/qOZ/
         EvHw==
X-Forwarded-Encrypted: i=1; AFNElJ9beUo7hhm+siVK3NA+kVCQWGkNI+OpAuNNSaqCHpCFFKZU4pC80pBkeoopSA9nbjsVHgup6WeRtvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrQu3mFKuPDMubg9At+hYo7JWH/XdoZWZ04XwqtEblMUXInbFO
	2eq8X60stg5Ufh3CiVKZc6A1Ho/iAV14dc7ofcDA5a0vBapt02NXrHnzSB2/vj3awWpUNtQ7Blw
	blzKM/TttqxY5qYOFQmu/TrPwl0bLJ+EA5HRj+HlOv0Nx9GTCArxcfbsQBKpFrsQ=
X-Gm-Gg: AeBDiesn3ULjfFq21Y7Eb51NE1mFc2+VUDthP+bj1SbKKWs0av2WwrE6JrXcZvxk7qC
	a2c9KiWBqTpobgzRIDFBy9AAHfvBwvrT3pt/5bSrXQh+6QbY8B7WmK9cAy8w6ix+6sgaU4B4+Yo
	KqTQ65yDZFwRWOybGY3ATLpaC2VbpSzHoJ88AyaOW0qayqpi7pG/s7EyGlDOirVMNpEW8ja+tBD
	3DcYIq+OCcuV1vdN4gKJeL+XHdePbhqxB6T/sLZSp5f8sxMHg8k4IZIVXfqFSrHSpXVV4LGji67
	0R/9A+6CdCPGssLGoyrX3YyLSp2LwHUfoiLOkdl7+C4/Efq7aElBqOGRF31qztaS6ad841ZaVx+
	6slUNBLqErQFJb0d+0mBnbU/MAd8SlpCvq93L+cmzL+K/SJTHuQ936n9hSY5FfRkxgnSqN9OGu/
	CkX3/i47I+ZZ31Ug==
X-Received: by 2002:a05:622a:1ba9:b0:50d:a978:6ece with SMTP id d75a77b69052e-50e3693546emr131044311cf.1.1776678323560;
        Mon, 20 Apr 2026 02:45:23 -0700 (PDT)
X-Received: by 2002:a05:622a:1ba9:b0:50d:a978:6ece with SMTP id d75a77b69052e-50e3693546emr131044101cf.1.1776678323076;
        Mon, 20 Apr 2026 02:45:23 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba455045652sm329858566b.51.2026.04.20.02.45.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 02:45:22 -0700 (PDT)
Message-ID: <f8fe7790-90d4-4c34-8662-f15555e5e2c6@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 11:45:19 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] arm64: dts: qcom: kodiak: Add QSPI memory
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
 <20260420-spi-nor-v3-6-7de325a29010@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260420-spi-nor-v3-6-7de325a29010@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA5NCBTYWx0ZWRfXzXWZb8TrWmc5
 pPN/36XLfnCZ5vNOJeug06zVfPwcGkKHqLYGCkNVeu6WL9/P2ytcOPnFvRThWfR07XPwNTPkl+O
 cO8/Ix3D1GYVTpTE9vWEoZTk/gzA32g0L1HkrXb4a/lgZ2tnhywtDeKc2eVXvxkIWUh2kz7PG/2
 NAMzxLGl4ZGV8MWlLzlFWWrjeqPmYiIV4CAp0yLc//P7RfeaQAMTuPCdQ7htDBZV/JxiJd3lpbQ
 m9/ED66U48fZZH0TiuXuGLBo/ZGJhKmrdVVoLOI9hhJ7GpBG40+GBu1ojhcLOnLBZsjb5cfhAPW
 YKM33zYJdeL6JsVHPgOSXKejHyvMrkfgm4gUfLNPYO89WmyYWtCDxurlClNsvr7pbKmBhsjdT4T
 qRgpP1J0JID4oVU5uVGNgnNMc+NZEIbfsWV6UGgRWq5TX7ONYZ/GhSKLAwuURjy5W/XxLi2VbqL
 9B+2aMSz7drqnFUP7UA==
X-Proofpoint-GUID: ZbD2tR1-2VBv3_X0Mzovc9XeaQGvhLvX
X-Proofpoint-ORIG-GUID: ZbD2tR1-2VBv3_X0Mzovc9XeaQGvhLvX
X-Authority-Analysis: v=2.4 cv=PsKjqQM3 c=1 sm=1 tr=0 ts=69e5f5b4 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=Qfo_qk6ajyruwQE2hCAA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200094

On 4/20/26 8:12 AM, Viken Dadhaniya wrote:
> Add the missing QSPI-to-memory interconnect path alongside the existing
> configuration path. Without it, the interconnect framework cannot vote for
> the bandwidth required by QSPI DMA data transfers.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
