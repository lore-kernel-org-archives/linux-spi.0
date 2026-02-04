Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BB1310768
	for <linux-spi@vger.kernel.org>; Wed,  4 Feb 2026 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223140; cv=none; b=mCMNpmGSaJeD703JaILvusUcOU4DS2rQCTxXy8PoUlvUiDvKSMs8iofHWkQidpZdzjRIqdAfAYty6DjsIE+rqkS9Jh1wPnxw4opkVXRgqXaoCmMb4MktsjQ37oKDYgiMmGoI7tad7CeT6i5Z2i5GqUorkfA+7tcP8eL0XX11yOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223140; c=relaxed/simple;
	bh=CLXZhBKhN3maLcFgh5thcSo9kFIPXaIprbv/R7G0TfQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=toadllxpYibZc6TvAckY/fLIcj/GzcHAepmVxm1RWho1hHxMPv+mVOCBWeZ87hwINAsPwNVD0LaRp23Lhp5LaUgWvadW/dznHw7eC2FDhJPC5cjE7mfFOMQLofrTDmMjbhw0554+hSI33xrEyDFlSemYuRdnKMgnAvXu92y6epc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LYKTtLwF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kCXARTEc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LYKTtLwF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kCXARTEc"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CIOGL1032395
	for <linux-spi@vger.kernel.org>; Wed, 4 Feb 2026 16:38:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	F1Iffj+H2jDf8Ae/fhDoY4kT4z6q0W3uyYv3Jd/Ctng=; b=LYKTtLwFYVhbQVg+
	aQUCZ41ln6iY5S3qYSr/Lcfxn+h1Og7hE1VZxKcxU49GDszT3r1rXMpUYgIzHoTm
	yeDUhY+IIoZAKT9UGP1tUQdKWlw8LBIt/dadLmwS6B5Wv3VNxq/JpLK3mOUiKBDK
	J9S7tfrAOoz/7s+o9F0sMDfxxh6rBX9sztQQ+PIukj5OyHMtRI6rNo2jW6KK85qH
	whzp6or+jS9c6VH0/ard1XY5MGK9p1erboyAE79UcXGVc+9F98cHU+pPSaKLYkRE
	qV44DnRh35SnnuaHaOwDqKH2lXxcGgjHDba+O7dV40IuQSX84eJ6JX+qXsIZdWVG
	m2AfDA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c3ne7v2cp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 04 Feb 2026 16:38:58 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c6d6b0f193so131691685a.1
        for <linux-spi@vger.kernel.org>; Wed, 04 Feb 2026 08:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770223138; x=1770827938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F1Iffj+H2jDf8Ae/fhDoY4kT4z6q0W3uyYv3Jd/Ctng=;
        b=kCXARTEclM6Qdn5FVG1EaWGJ/tloMVzHl0Upb8+tCEnEOHCToooNhG7r4q78282EHn
         g8k+9YyP5B8OkeAMqgc+UxjFEXt+SDDFayIv5Z52ymjKKFWmjY4ZT7DHrb6+wpuJ8M3a
         H6QjcUMJQk1GQ10VeFDjTL0qlQoyUk4c3mqPwpUjEQ4kw6sDGeNVNpRzYUvqxitgzICn
         +x1S68+FCAbE0BlXMmiSLOTZhbU32HgorwtcF4qR4mGwcJsYCoOdg1ni0/8R13/Xfj/C
         thEEeSV3qdJzu+WEKCm/jLLmcnfCog/F+znst7P2MOHkXlujfvbK9h0a/Vap4wCDQ4CW
         Zi+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770223138; x=1770827938;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F1Iffj+H2jDf8Ae/fhDoY4kT4z6q0W3uyYv3Jd/Ctng=;
        b=hkEAGYBl1CX9Otben41zXFF4D6zHlvSXYDbBxA/nnl/NCWqw/3FG0eADByhJzZK4bE
         Pzd9P9F3d1KODaeoHB8ZhwA5z/MNbN+Sj0QKKL/tQdRa+qRKeInfIOZEzcrNb5lN2Qhk
         m93TiSyv4rxFzemtWJCC+EpyVATUdfmMjQ53M78UROnOgCJhmYQrFBzrGpiQFvm/sTfu
         VLYvVaAlZAY+UOJFh/H3T6923xkI/kXcgi89Okmf4fBDq8kEatqIREYj1RYZtrQ2XGb9
         XiAwHgqXkdih0FFcIT0HcIzSNqMKeu1JJAuFSrItnddRq4++0t5+OqNaUNd9JihWzmM4
         0Z9g==
X-Forwarded-Encrypted: i=1; AJvYcCU5OIM8Y+Zg3EvzwmbLrjRIkJO38gsAtU8buRmRPpji1Zyy4uFIHpABr3AV+taGqORsuCsHSe4yNYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNNtBPLDBiWnTYpTaYH8xuqzdB82UPdFxJ4RQvVmNNFTsLX8o6
	EjIGJQ9pYPQmXYG1feKuIQBnCvJTFKr/P2a/dIFh1YMvQ+Y1IZh3EMHhge3AYU6YWG2izucd+Qq
	Ssrk+QMKguklmAo/dl4O2rCXFeRusebTA3/6XUBcErXpfPIf6eUXk1Y9IPW4biUY=
X-Gm-Gg: AZuq6aL/yoPpxmogKphtavzxumHXDeV+MwG+S83ybasDAjhBbXkiVBq5A2DUiKVi8v1
	FMo4KfHn30S+yV8Ei90xYMTvmaYtQBwdGW1eAFxJ8zSQXq782LnaCFrBSyeTCR45IAcO20LCN9N
	HpURSyrvJwxQP9ELew0rmQClEoUJIF081wyqIkRfrDsqZU5C5UighjBQEuz8Bn/KshGk9YqPPKj
	Auq0LR4b6KgUdlsnY4ARntqMf7DYE8ENOLd7nJ34JBo55IkcYJi5An6lc/eKlnUmxaFcwamjxg+
	a0i7BiKbGcH4V1rES8fcraeQcMayw1FaV6PJT8udI8Kbg7GMwQny0RdJejOCowLUnnCy3wxZDKc
	WliM6NRY3EpVgkxO1+/2VzOU68rdHpaLK49bBPVBz2w4TW9io2hm4sfxS10LXAmyZJPc=
X-Received: by 2002:a05:620a:3943:b0:8c5:2ce6:dd4 with SMTP id af79cd13be357-8ca2f822612mr373105285a.2.1770223137970;
        Wed, 04 Feb 2026 08:38:57 -0800 (PST)
X-Received: by 2002:a05:620a:3943:b0:8c5:2ce6:dd4 with SMTP id af79cd13be357-8ca2f822612mr373102685a.2.1770223137436;
        Wed, 04 Feb 2026 08:38:57 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e9fd47de4sm141247866b.29.2026.02.04.08.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 08:38:56 -0800 (PST)
Message-ID: <dc28efde-1a0a-4820-af9f-4ce5f5ddd05e@oss.qualcomm.com>
Date: Wed, 4 Feb 2026 17:38:54 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] spi: qcom-geni: Drop unused msg parameter from
 timeout handlers
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        quic_vtanuku@quicinc.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260204162854.1206323-1-praveen.talari@oss.qualcomm.com>
 <20260204162854.1206323-4-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260204162854.1206323-4-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: I7Hx3Jl__Dv2cPTxOgXI-R1m-TETiHj-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEyNiBTYWx0ZWRfXxYa1uQS+uTdU
 boCiTqKU4ixLhp7dsXav2bCkygw1V0zD7cUpeCcvT+GkgmiFyGL4nYibvct4GbGgD852WEjrFin
 IwgnWpDK0sGksSiYuWHjWFK9q4fKTFW9LHDGkcNfDATEmwwvddfDNujifrmCU66Pto+t+eUdYQI
 46LjB2HqNMuKHbouyEkJZLhiz2dqAtMMh21PCpThfFUenY9qwLaL60oxPxQtT2oJpWWQRL0qBDY
 VHVeTq7Ar7GdtyCXKneKJKitSn0f4fF1MMIVuJ+gG8qPvjksxh9Ay+foQg0UaUNxuwC99w6CxKU
 hW3bMt+yTiHKd+yf7U26TcWaoX496DKnRm/xrTn5Yljuo4JzdpIYZuDCcjTpEQ9WgDQDGrDWPg8
 V7TQ70p66sbSiYLlaY2kpFYgLrVFInG+lYFvdiNoKZ+Gd3QcWZN+aW6oS+w06wKBXLeNzZCX4Ok
 7nakPECOZ8Me206FLuw==
X-Authority-Analysis: v=2.4 cv=TZmbdBQh c=1 sm=1 tr=0 ts=69837623 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=1O7fFdKsa9_7UK1TUcsA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: I7Hx3Jl__Dv2cPTxOgXI-R1m-TETiHj-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_05,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602040126

On 2/4/26 5:28 PM, Praveen Talari wrote:
> The timeout helpers (handle_se_timeout() and handle_gpi_timeout())
> took a 'struct spi_message *msg' that was never used. Remove this
> parameter and adjust the callers to simplify the interfaces.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
