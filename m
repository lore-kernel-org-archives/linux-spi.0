Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7673362151
	for <linux-spi@vger.kernel.org>; Mon, 30 Mar 2026 04:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774845867; cv=none; b=FYrKqBKZb6eVacJdw1wYdSPeIr+lbDwMiYh4Tw3fV3iLaTURfy9GnMMTTI47ITUgJClU/26C+uZnrl1lrnAg3wzSfPzp4TlwcbwzjN5wtOt3p5aA7KTWKkibIgrXXo2Tr6nFH37aRav/WNEMHe/kwKsw6GSrA/aCfH0DNFgXn8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774845867; c=relaxed/simple;
	bh=uyfQilYdCCjAPT8/So/ShWe6NNCP5J9ta3jF8nqK/lU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UnZZGxtn+gh+vvwxJTBHIMgjMPDjhTrfDHLJtJTGyA8nyYXNEgaBFVnbXqKD8ec+AT76e5iN/RPL4mq/vunPaCI5dtBVwUXezwZyIG9znBxG+Vm/CRigkVVJFJiuZOZgt2AL2Hkg3BJkpzQSI4iAnV4CsWdx/FgxeUz0IZtj7Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jAU+51BD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e7r7ncy+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jAU+51BD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e7r7ncy+"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62U3g8bA3864100
	for <linux-spi@vger.kernel.org>; Mon, 30 Mar 2026 04:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CRwWQquz2DyYJPWRUFS4WTKAOMFffdNJez/Sd08E0pU=; b=jAU+51BD/H5ctyI6
	hEfhf4aK7TC7Ml4LYiUzHWuvbt8BdcZto/8B6oTEjgXZOUoeN6+khLSoe3RPDjtH
	jSi4Qcuc+K1mhA05zeEWywJ9BOcUldYnYk88JBZzZXaBFCjnVJm1eDUH5RPGQAjS
	rPENex1dHDQWxt28Tc31XoOl7qVq/vEBoi7fw5IwHI4txUkBWD7eaAvf8h8VXFEB
	tOlu9x+/0MjC0mJszMGwIqF7by4zfzO76pMkRLPn1COpg3/PABNHYLMlSgH6hjo6
	qzqd112FtWBk1s3yqXdTc2Qf+3YWYtajI8zPJlrfWf/Y/8q836+K9QN+I7wfa1O/
	1scEmw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d64bm4rm0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 30 Mar 2026 04:44:24 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2b242062308so59058515ad.2
        for <linux-spi@vger.kernel.org>; Sun, 29 Mar 2026 21:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774845864; x=1775450664; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CRwWQquz2DyYJPWRUFS4WTKAOMFffdNJez/Sd08E0pU=;
        b=e7r7ncy+YtCRCDxWcY4H+K/+ts7MZ/DD9rctQ5rInF31eK+WtzzpmiEcVGcDlZYYwv
         EUJxQBrKLnm6Q7z7uANoGCEGY69tPUWhgMqOZdd0bBtJDIIZCU4IR8EnV7iUn1B0VOVw
         L3zHmNz8v9ONpTysGQDjZXHhmUoX0H5K/1cm2NSUJEe+yloejaFH9rHGSfNLVMhOWlUF
         nvcToyvwhBMFr1L1xEjyIDgysL+W/F6Q/QoXouJvnI4xRLfOgiQYdjJCoqBwVfdYTGaf
         /unTXDVP+MqH8Sgz2NYS9nDMOOK62sQ3/Yp/W0X52APlLiQyrKmfQqFiD3VHOw1m3BFd
         GZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774845864; x=1775450664;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CRwWQquz2DyYJPWRUFS4WTKAOMFffdNJez/Sd08E0pU=;
        b=jes2aSmn3ok11CgeL8bth9tSA24dI4rPJHZBtIR7ct4xmyqH73AyDhpj0+PT2qQ2Di
         5B7Q+9boL/JqRjAwX6EyyITDpJuwH/bZLpyCDEIM8l2Hrpf6KnF/iFgKuldFd4Y7OD/j
         QCUmW4CM/BbukNcD2eN5fByy0tU01qPiimWMRDUbyrimnriaVCTEpVC9zxHIBqrUYU6m
         azIXMHimhisP7/Igz4TWJs70dJM/tVUjlMvjzS3lHsGcBaXrhNg3m6p/F49OaAeko5IS
         s2CauQE63kXC8k/bUiYKS0hDeVxCREf5aJMNGx3ExMuPwE7FGGoIacmTqdqFlw+4OvLZ
         Vm0g==
X-Forwarded-Encrypted: i=1; AJvYcCVkqMsRPXrJNgyGIBjNHYGNwf4BTUEn68hqfawk5xyhORB7MUuq0iIPtW+628V+SU1j/FanjbJOueo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQtZ7XD5z0Z/Z9Bio/sVZgKY/Q9PTqF0SLGqJHN4E4l7IGbVss
	skCjGTn/htTNJckljv+qh7DMfb62imxRu8VxOzsJn30EybjkV+ihfqCdfYEiQuS5/PVuY90KFxj
	LBDeSrdgYaLMb1qiu6tk2eUbsvkc0vhTLIOv5d0FAV9T2XkxBgOB0YcWPtW1WPH8=
X-Gm-Gg: ATEYQzxLxHJL2qIz3sB6C6RWGLlcnqSlhAfcNck3cI+a9fLSLc65Q9pSfy6vIsys+8E
	yj7c2+m6/tnHk+7S0ef3QZIUrp9bt0HqkoU8/v4t8FId/8ROSHXFRhxjO0rOcyHiW/Ag5Vdm+w5
	qhPYNe+4bZChc+PqX7p8sUidUwersty6uhcKVdW0NOeyenx9nLmBIJGtcq8Fj7ZjzXZPgJByAbC
	R2JJCDgkUQb1Eyu7rxFEOdpf97GiRYIgAVR+T6vd+JLyb0z2i4L7VJFVBGC52TW7UKcGGOw02ov
	8xzhs3WtBhkHIgCYm+ueNDkObMSvKFCRJ4rvLQPYpQKprfnnSghIF3sQZqR+w2TlXYVdPaQYuRI
	0r8conqzhyRx3zDI4bE3fQz745BqN6ohXUdYN2Yg4ZROi908Q1lwMzQ==
X-Received: by 2002:a17:902:e74a:b0:2b2:41a9:8e10 with SMTP id d9443c01a7336-2b241a99166mr80322905ad.23.1774845863925;
        Sun, 29 Mar 2026 21:44:23 -0700 (PDT)
X-Received: by 2002:a17:902:e74a:b0:2b2:41a9:8e10 with SMTP id d9443c01a7336-2b241a99166mr80322645ad.23.1774845863429;
        Sun, 29 Mar 2026 21:44:23 -0700 (PDT)
Received: from [10.218.4.221] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24266e487sm63551405ad.24.2026.03.29.21.44.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2026 21:44:23 -0700 (PDT)
Message-ID: <4659529c-c3af-43b1-a5e9-c65b968f098e@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 10:14:18 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/6] arm64: dts: qcom: kodiak: Add QSPI memory
 interconnect path
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260324-spi-nor-v1-0-3efe59c1c119@oss.qualcomm.com>
 <20260324-spi-nor-v1-5-3efe59c1c119@oss.qualcomm.com>
 <i73fny3nxdljztry4qn3rotjtrjnlau7oxzjfj2bfsox42ylti@lllrvsc4eyum>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <i73fny3nxdljztry4qn3rotjtrjnlau7oxzjfj2bfsox42ylti@lllrvsc4eyum>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MQVCrhhWcWnyoDTlLw8SRkXI5ul57aJO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDAzMyBTYWx0ZWRfXz80dXDWzof4B
 AWNeK16Ti6Q2IwyvXivL7PUQ6AJPFJ3Dgljhx2IAB78AiEqXe07TSQnr0PJ9Hs5z8tPHcnSCZat
 Bi76JN7F+dO0xc+aIoC+CDURYjsPw3OZKt54KylwfhS91r1KZNGq78IkBcu5i/+3Z7UgqpIr8Tb
 mBiyJLjtNnOc5KG3txf3MxJDb4sWA4Sne+iQkjqk8JBJ4/9gRkhs5EeuEuR6bSbsjxK0+HnhiPX
 CEX8CSPYZ1V+4iQREcf8ImqnHzNONiQ8b1pZ39CWudsuy5//JGRJeMgbnOKqKqyHeaLZfOO0/vk
 04D8fFOUL3NIqx0HQfOpNb91amhf2B5Xd2wOxoUTeiZP8+YrKEgHFV0aN0WXEsTrBNqjEsMMEgG
 kG8DEZlEBueVdstwIGHumW0s67i2l4f4+snTdDe/sYwzB50hU7xbHX2+OoJysn7pTae1+sTy1aG
 aDspOF8LkVZTbnmSq0Q==
X-Authority-Analysis: v=2.4 cv=eJAeTXp1 c=1 sm=1 tr=0 ts=69c9ffa8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=jSZtOnyutIQV87HTN0sA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: MQVCrhhWcWnyoDTlLw8SRkXI5ul57aJO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300033



On 3/25/2026 2:24 AM, Dmitry Baryshkov wrote:
> On Tue, Mar 24, 2026 at 06:43:22PM +0530, Viken Dadhaniya wrote:
>> Add the missing QSPI-to-memory interconnect path alongside the existing
>> configuration path. Without it, the interconnect framework cannot vote for
>> the bandwidth required by QSPI DMA data transfers.
>>
>> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/kodiak.dtsi | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
>> index 6079e67ea829..9a44bb3811a7 100644
>> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
>> @@ -4312,9 +4312,10 @@ qspi: spi@88dc000 {
>>  			clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
>>  				 <&gcc GCC_QSPI_CORE_CLK>;
>>  			clock-names = "iface", "core";
>> -			interconnects = <&gem_noc MASTER_APPSS_PROC 0
>> -					&cnoc2 SLAVE_QSPI_0 0>;
>> -			interconnect-names = "qspi-config";
>> +			interconnects = <&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QSPI_0 0>,
>> +					<&aggre1_noc MASTER_QSPI_0 0 &mc_virt SLAVE_EBI1 0>;
> 
> As you are touching thse lines, please also switch to correspodning
> QCOM_ICC_TAGs (and I'm not sure if those should be ALWAYS).

Sure, I will add it in v2.

> 
> 
>> +			interconnect-names = "qspi-config",
>> +					     "qspi-memory";
>>  			power-domains = <&rpmhpd SC7280_CX>;
>>  			operating-points-v2 = <&qspi_opp_table>;
>>  			status = "disabled";
>>
>> -- 
>> 2.34.1
>>
> 

