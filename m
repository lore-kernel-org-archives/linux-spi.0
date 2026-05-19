Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03553F0750
	for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 10:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188187; cv=none; b=Npk6triKs78253dcFVZiTddWaFPnSohO8obwjaNhHBmEeByNNBfQehsk9XBw0+8MP8qK5oMaRMd6MojM/JKC3UU0gbqdB5Vj3o3ILkRxh3Crb/Wcp0Vt9kq0duBR30grtMJIwhrLb8YIPBUnzKtqCW26xHUpQVxomT0EjFRxy8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188187; c=relaxed/simple;
	bh=jS0E4ds8/7NpK9Bp+8ECil2/7vTa8+eivZTcr4pPqBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CHtsr4sNsfDALW/h/xWSS0XX5y98xNEc0X/cotyj92vn+lubPVnKfFzzhiSg5duRcXZnblsbtT7Lr6ULQ1muErDGp3uhZqGUz1RDkP+nmspIEU6f/94e87/NtTu7F+/HYI5T9OPkRM17ozLdWZi3yMi7qp7017+l9w8h6FUSfQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iVpymYBU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hejNOd1J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iVpymYBU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hejNOd1J"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64J6gmgH1737112
	for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 10:56:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x0Mm4DIy9+BUfoULHMzs81gTO4xbA3GMf+rXZ6LbHG0=; b=iVpymYBUSKPrxHBZ
	+zA3Sd1/rRCX4x5dXHvTVXNR9hZnOyWCc9+e1WKGYWe4CvnjPyYlME6v6z92WOEV
	mqXgTjMxwNsVZ3nXXk0cDxRX+ElBrnEjtgfWJkEH00xnGCe1tURqLu0ksneC42Xh
	OaVP7l65yeEoC56KW916tXhdExoh0N2xmotmaPV0IqVF230gWbxsU26frJQ4jR7D
	U2n10qJN9oO2kOBd/Gib//2ojCVosaD9pqACEEHwtMk8PhA4I74D3W8Tqi0nxYK6
	xDD+ldcUEIo+PT/3CxOXEyIdeptL0VPYDt+gRiAZh3T8h9H/AU88nR3sITmDiequ
	HgNDTw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8ju91285-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 10:56:23 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-368b0dc7731so1989183a91.3
        for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 03:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779188183; x=1779792983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x0Mm4DIy9+BUfoULHMzs81gTO4xbA3GMf+rXZ6LbHG0=;
        b=hejNOd1JSmsIkfRPXFPc2ND4ZZCQE7GzrcZ3LsIc2hOTgDTrmA0/WkaVAy27KHr0OQ
         k73WFW7PIXPn/3MiznanX1zlouCxDWTAAKyACWGWMhvMckTh9h3nm+izPyqJ82P5k++m
         z8OYY2mVoc0Qu3jnZh3HqgHJTHuvAg4Z66FFvjM2v0Yiuo0+BBGwv0C9Wuu0pb539SVU
         MqrOOG/5nqK0KBkTw9mqD/zDyPJCgr8o3mTA4JIt4t90tZedr18eZe0ydhOpqPK8/kXU
         iYITvjq4zcp+ojInRMdcBIJLdkAQJ9z4+tKC5LOTsxNNhKQIA8h77ZGh/Sz+PB2/CRxs
         LiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779188183; x=1779792983;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x0Mm4DIy9+BUfoULHMzs81gTO4xbA3GMf+rXZ6LbHG0=;
        b=k8EMlmq+QzE6NRPBlYuBs//oMUMVsIScfD3wAT/+xIjBPjOZAlCRK7hA6E+/4Kpsm1
         xi+YAm1k4lKcWjnyMg84VMVl/Ld5NpWTFFXarQi0H8NI+qTxI2artV06yMWZg5ZPnmY8
         d21a09jElhcwVouL710X5OdUA/GeIAeu7z53SPXK86WZrnRjtV8Q+ta6ypDdNoONQBdL
         Ogxzz6kDDohdpOiitAwPdBWjr5RD3eiSqLv5VouZQqBjHoSkdvOAUXHyrterRg44XzRX
         JAvsrHjAeqTPBAP3jJIqFA1W+avg2iCP2RedncnT4KNL6acw6+5zWvd9exNJ4U/EcQLh
         KTXQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1b/rl1Wr95C7yE7tdree8JwZKptIDsBSoUM6SNYRGpHOM3j/LjxnpTR7RfLlbsZJ+mSR4SU2TAtc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXxyI3sazWHqdgQ5IKQ0LiWO+pTw9dNzncE0nqs7FIVTUhvhjR
	F1rbKP9+1pvBhaTVNCl+wyOT/IHKbHb394RSWenfCrrSYngvJ1mhxlwKU7CeFSrRygXIvuzPARl
	m66mGum8klaB4px1ukECDTPW16U27GlncBebvGNv90GYdUi2sN/BTQ4UevUhHvrk=
X-Gm-Gg: Acq92OHF+Fk7g1R24cdsfIUibLNSb1UtSGo7+zD4DPwWKq+CnfjKJ4AN+nT5t5sdGBt
	AZ0Ap/Xv4gRPI8pLFghKF/wrVDIlV7Op+ZUmG5XH1Tybm0AovbyZOx464e/BpIXSpsj5HAVDkkA
	zQpoh0mRfp58TJjN2V7HEZ8sA6K3MVlrwzbgZrfWOMrmgenpSvL1iGMJLI9Tum40hjk1PNJfgb2
	IzpcVrHFp2nZT9YYrUQVzh9Yvw41jCCnLvV+W0fb389YMKDNAFPXkliln/XiDm0HTL95qHueQHY
	3Tw6mKYO7ypO0/UvECAxzgEQSctLLMf5glu6qd5kX5bwtF7ImY0Vd7aKPBbTBHJb7J3UN8a9T+B
	TlfzhDr72b5wK+NFGm1MqqAd+wtLeWkvb4xOp04ZnQ0724ggjnH8F1FN0
X-Received: by 2002:a17:90b:1c11:b0:368:a297:bd3d with SMTP id 98e67ed59e1d1-36951895b57mr16978038a91.3.1779188183247;
        Tue, 19 May 2026 03:56:23 -0700 (PDT)
X-Received: by 2002:a17:90b:1c11:b0:368:a297:bd3d with SMTP id 98e67ed59e1d1-36951895b57mr16978019a91.3.1779188182751;
        Tue, 19 May 2026 03:56:22 -0700 (PDT)
Received: from [10.217.219.207] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695124601asm13853485a91.2.2026.05.19.03.56.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 03:56:22 -0700 (PDT)
Message-ID: <5e8591b1-d1b2-4b58-b667-cc2d4c0a4b8b@oss.qualcomm.com>
Date: Tue, 19 May 2026 16:26:16 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] spi: qcom-geni: trace: Add trace events for
 Qualcomm GENI SPI
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu
 <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260518-add-tracepoints-for-qcom-geni-spi-v3-0-7928f6810a79@oss.qualcomm.com>
 <20260518-add-tracepoints-for-qcom-geni-spi-v3-1-7928f6810a79@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260518-add-tracepoints-for-qcom-geni-spi-v3-1-7928f6810a79@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: wZCG2TqtXUQZ0kMPN8Y6bqLDNgc5-q-_
X-Authority-Analysis: v=2.4 cv=eeUNubEH c=1 sm=1 tr=0 ts=6a0c41d7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=kAtbQewIYUbMTxBMGYQA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDEwOCBTYWx0ZWRfX6fLT92E9smH5
 ihKx/PxkShosz9Je0Y0wnTxvMwf+DBEfJbIaRy0OpK17IWX5K/sW7GzKMHgeEHfIhn0lVfEVyC1
 cwvG0mfJvbDxl2kDM3v67lc7Icgeq3EtRQvCUvTjvYczTlKV57gr8sPeCZ+VbpYCOKyxIPtDEwz
 lG4VjPnZa14uj42jGnqX7Dz8l4QoEUPMmn8+5l4NW9jOaLwJ4mxqyXGxvPUeusRYcHp67sEaBEG
 WiSSadsV5bXU4dCu+9TbZTv0Ghdiek6XHEkvhMOrRNnbbsfiW54ogrczO0zZwBjk/iTQemP8Io5
 GLuph1r92IGKw5DWpc3d5z44jQZPiavhGmmiiaMq4Ah0iaBueXPYl4pxmZsnIN2RCM3ndjDgBt3
 4AeqEGmx0KjWlyMfEasC6UT6mNxrNuPNcUpyefA74CwDcsIE85VDVf9kmeNPgzPtd/WY6x7q5Rz
 TVgQd8oG891uHK7MtlA==
X-Proofpoint-ORIG-GUID: wZCG2TqtXUQZ0kMPN8Y6bqLDNgc5-q-_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1011
 impostorscore=0 phishscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190108



On 5/18/2026 10:30 PM, Praveen Talari wrote:
> Add tracepoint support to the Qualcomm GENI SPI driver to provide
> runtime visibility into driver behavior without requiring invasive debug
> patches.
> 
> The trace events cover clock and setup parameter configuration,
> transfer metadata, interrupt status to be making it easier to diagnose
> communication issues in the field..
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
> v2->v3:
> - Renamed geni_spi_fifo_params to geni_spi_setup_params trace event.
> - Updated commit text.
> 
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
