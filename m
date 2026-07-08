Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2DD38D3F4
	for <linux-spi@vger.kernel.org>; Wed,  8 Jul 2026 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505208; cv=none; b=g63Wh4sb1tOFDi9LAxIfIoF00pBVAcdHvRP4sN/CHjj877KA8HaLTzB9rPe1gpX0U2Zogas5z9dmoGqA3NR2U1YQvI4FsNaBO7IWGbnEsvnoQPv6O0XMXYZYxolmsdo2VXGqDoKYWJuf1u95UcorJ1d6MlgV167SHSXTh8z1DIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505208; c=relaxed/simple;
	bh=EoXA71ibmjqOvkjzzpn8D9oPOeu2IQ1QWWUCUKERV9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTywFVWwjumzFTDJ5OCYfBwBLIaf3apBDrfsit0fD64i3LzdGdIHUzg4r8GCn2aY5C234/ZoBsR8GRHTvar2AE5SNUT0tK+qqMjXkdfqx2OmF1rpup8stmMQ0gZAoUl+IxBuFyMRmP2/Z5o24a8zmhVji/cMCDFzHKM9znpJ7e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KVkjqRco; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HfkMJBiv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KVkjqRco";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HfkMJBiv"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66888wYM2219056
	for <linux-spi@vger.kernel.org>; Wed, 8 Jul 2026 10:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RKyVHN/hTdPLVDp/F78lAoGgPhhbNMc9fh34edmUY8g=; b=KVkjqRco+xZ5SIER
	XguwaPQhCE7knmso+6amahyT25hzdC6R4Ei4ojBOrvDSt5ElGa5+5RBTdL8GQnE8
	M8prhmMyVJaesmiAwzXv8eS3OKJVA3o6U1/KG6r/eVyITIbuoR2Cwh8QBapVx8M8
	tgHGudz8IiapIFDSf3FWkGGWWHw+JRG2ouNOF6Mp6FmaZ7XUxAChgQyAzvC1jaay
	Y9xNZIyl8ChxrVg8fbGyHkreHsewTLf1xACEJMoeZF+/QJQ43lCLLqYPMCTF/9s3
	qkkq1WAhmFe4elYmvZ9bkmLKIQVDo0bVgiGhAZATT1/DH+sjlvQ7dh6YzYpB/J5K
	o3Tdfg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9g7hh4k6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 08 Jul 2026 10:06:44 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ccb687f82eso11058175ad.3
        for <linux-spi@vger.kernel.org>; Wed, 08 Jul 2026 03:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783505204; x=1784110004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RKyVHN/hTdPLVDp/F78lAoGgPhhbNMc9fh34edmUY8g=;
        b=HfkMJBivbQYs4ALMNdt1SqhVM/WDZuqeKDguyGwtuMDg4EmoB2pD6ybbTI9RaKVxxk
         /8Ne8K6V9YGAAy7oeNt6yeBc4x2amB36PVrd2QUbVLX7j+PGtjep6lB2lcwp5n6VAGnr
         n4WBX+vuoe+5mqn+9+QMoUcTSm2XjIiD1UDPO904VAWQhEffX/aH3/ubtYxobjO6WDhR
         vXXgaFsWC+hQ7oEUWfo5WZtVh0XqbEwrxdE5EcXSSsZAGtpntBtWi8Y9VFq+McZdjUwI
         oF/EkbS1CBz9WgE+/L4K9wBIukSkc/PSRtsc8stLmXV9Dy+vauSbfBgXY4MNS7bCr7+1
         AnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783505204; x=1784110004;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKyVHN/hTdPLVDp/F78lAoGgPhhbNMc9fh34edmUY8g=;
        b=s2Q+SKJ3YYdGttq+FQu9R94KtCF7MT9fZvKFl8ynntJX7Kqm9qBmtpwhcUqTy/cunR
         ct50c6lV6Acs0x28Xvq5uvLnt/FPBNyDPRKgC7vvfZPYTaWe9kTr/5zN/mZ8UW/4yDxi
         s+oONLrOmEhQfHMTSu/x5LrYgA1GgT/T4t25ylNIObAOaZRmO9e3iriMRfdMP0Q3wZmt
         e+MFAqYajwWadyIP110sdMl5OKe1iL2n0Iz2jPyLzssZoqekXheBBOanrlbW2urm4Ayj
         WhcF++dDf4+t4A9A7TqurwRB8qyPwLFcqxTQdd/TDqzGZcEBs/rByY2XRhGU6t0awEPm
         OhEg==
X-Forwarded-Encrypted: i=1; AHgh+RrjvtvahFj4WF4AFnPdqLjXvRlkmkgYGEqTkEzoWZRAxRKCs179bKq4RmsBpOSoyrUyqZCw1nef0QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY0j6beAcsrJTJHiJe9174XeaahbUmBH11MLhkDgPyRJm5i5HU
	dzXvCMzG8eW56SJNKxMLoLiMLuGhE3SPsay4o/moDt9zMpZYmEiSyNEsC9MG0lrKEvFP9WfJl1Z
	YSyFb2x5iVNn7tgJ/pWdCDsbOe+BacFON8n6ltbt0lj5FAWUkCPOyyCSofZP6QWQ=
X-Gm-Gg: AfdE7clhChKk44pkAQYIWm8v0Wz4G/TWupaufBS/0tktanu4VFi5XJen5Wz1cS1OYVu
	00gH0GV0Ow9//jc0hzQqO8MUtLM9Li/y7sK/9Un+zn7tc/HQ1J6x9MdgWQyjF2iosS0Z9ZaYT7d
	v0pPxtzg+8pV0OuQaoBbO8+uB+THvxHDILQlTebtgU4RIjHSUtmuXkm36U4taz8rVYphteJjQYm
	3Y3j1kMwLoZrEeLgABtkgWOIvHqHMngpIUgH8zbAYcY2k+kzxxiHIygR2yvkaQWRvSXfFiH9IYo
	l9TFUz3rx7jFu5AnPLjDF/UKhqewIiUqF8MjhlHv1fO06eFTcDNVP6n51i6V8Nppey42iTOy6GO
	CZLrG37O68MhaX4Ur4POIbiDq8SaEOxsrpjAlKt8uniEV
X-Received: by 2002:a17:902:daca:b0:2ca:c4a5:84bb with SMTP id d9443c01a7336-2ccea3a737fmr19597825ad.38.1783505203766;
        Wed, 08 Jul 2026 03:06:43 -0700 (PDT)
X-Received: by 2002:a17:902:daca:b0:2ca:c4a5:84bb with SMTP id d9443c01a7336-2ccea3a737fmr19597365ad.38.1783505203310;
        Wed, 08 Jul 2026 03:06:43 -0700 (PDT)
Received: from [10.217.219.87] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bfe040sm25704505ad.31.2026.07.08.03.06.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2026 03:06:42 -0700 (PDT)
Message-ID: <7bf2e909-211b-47d5-9c95-fb1ebf917dc9@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 15:36:37 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] spi: qcom-geni: add GENI SE registers trace event on
 error paths
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Steven Rostedt
 <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
References: <20260706-add-tracepoints-for-se-reg-dump-v1-0-48bd08e28cf2@oss.qualcomm.com>
 <20260706-add-tracepoints-for-se-reg-dump-v1-2-48bd08e28cf2@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260706-add-tracepoints-for-se-reg-dump-v1-2-48bd08e28cf2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA5NyBTYWx0ZWRfXxmXDzAHTgIgU
 ApTk9u91fi0PDB5nkL0IuADV5hoda2DHLMjeZKyjILrOfkvsD9n0w+TiG+l8q30TQrNB6dgOVH+
 2ovh6w66Du50C4AEWF+JpdPFt2p/Ndptb+ggaSMj1b4aYBkJ4D96d5eg6vpx1ykiBc9VhhBXU/Y
 XV85bCZ8bM/Ik0fs5KWypWtQN3/2LihW5oWm0EdwBhGX/QOkQrA50iJ3BpFNL3iXVSkTjq8/Rrr
 qX5MSHWESN4vwiBM8wjLfyLcZ+6Qic+j4Anl2uFcLkGQ72At67jcNIkZehgDPxrjdK+0Ixy1MVx
 3at6zyyCXuGeIkCZMsTQw4z+SI5UdIicJhefZu9tjsQlRbg1qE1Swuc1ldZ3WC/HjtE5HfdYjni
 4ybc9RDmSAWAyqu044gHhRSMrwAJ2OB6bwRdkU91F7gRD+R40lAIa0xCj1J+KOE5lw1ppWXeC2X
 rTjoa3oQTgOEkdURnvA==
X-Proofpoint-GUID: OPPt4DCbuJRyc7AvttgC65OGLavFmYV-
X-Authority-Analysis: v=2.4 cv=TMp1jVla c=1 sm=1 tr=0 ts=6a4e2134 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=wRhyhPH_MPSplg4SnB4A:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA5NyBTYWx0ZWRfX8CMNHLhLnvVY
 QN4erY+EzgfGJNeQPmiPhDo7wOxHSK9nuZcN/eMikz9zlKD5lzpYB9LAnu5Qz/9rQEBMjOgSl2c
 +ARLKSgsyV/WPbylBo+0W6jJLDaOH6k=
X-Proofpoint-ORIG-GUID: OPPt4DCbuJRyc7AvttgC65OGLavFmYV-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080097



On 7/6/2026 4:38 PM, Praveen Talari wrote:
> The GENI SPI driver reports various transfer failures such as command
> timeouts, DMA reset timeouts, DMA transaction errors, and unexpected
> interrupt conditions. However, diagnosing the root cause of these
> failures is difficult as the hardware state is not captured when the
> error occurs.
> 
> Add trace_geni_se_regs() calls at critical SPI error handling paths to
> automatically capture GENI serial engine debug registers when failures
> are detected. This includes:
> 
> - M_CMD abort/cancel timeout
> - DMA TX/RX FSM reset timeout
> - DMA transaction failures and pending residue conditions
> - Unexpected interrupt error status
> - Premature transfer completion with pending TX/RX data
> 
> Dumping the SE debug registers at the time of failure provides
> additional hardware context and significantly improves post-mortem
> analysis of SPI transfer issues without affecting normal operation.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>   drivers/spi/spi-geni-qcom.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
> 

Acked-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
