Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4B424E4A1
	for <linux-spi@vger.kernel.org>; Thu, 23 Apr 2026 04:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776919279; cv=none; b=Iv7BZKsC0kHseRPXWmaXzE5iwST9BuAjJvVWLHtb0+ZEiYVc1R4cV0O4vK0QhzZO5Sq2WK4mZxd8O6bYtD1pXEX0hnDB6LsCvN6uUmvrUBjEK73wMtWiFPR7iVSIR+A//MbreBCBBQC8t+Q0z6W3b84Pl25M6aUjOYPwEIpJ0eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776919279; c=relaxed/simple;
	bh=9J4BxM7gtyEKauNKqbRS21TUg8P0EpQ40xplG6+3a/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oZfzy7drrWFbYttmvGMtvMgrUfQzGk7zH1652TCXGbgztf6wYyWrAndIzpq3gdruj9KDLGDR250stUhy/N/oXhDIz9rRFQGITnPGW8vLLwlIL6dXraUOJdPNpC6X7CYyVy95pR/8O64/aGPGEQ2EnmHMJL539iyYyAKwxz+Clz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bIThHOPj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ks05OSAI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bIThHOPj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ks05OSAI"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N35PBs2185960
	for <linux-spi@vger.kernel.org>; Thu, 23 Apr 2026 04:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PXcarQ3/SORvCcBXZAV2XtrZqcRRpX62RDXzsLa4WYw=; b=bIThHOPj8YOdhejd
	7i9zM1dNoAy4uU2h3aT58PQU8GGeJ1Uv8c32GfIJ98HfX9m9mGeWYOS9hgFeOvid
	pYI7PW8a+Pqnedab+41b4os6XlqvubiHjFSL0gT7y5YsMJ+lm6dSjTfewvgcrnZ7
	yG67bRtb7nfJYei7VXaiQNtYS5Zso9XIpjpEBt++0m9aHi9PLcZma6PXLDaMP4ZT
	X52mVEPcu1ZnJoBUuRBJFmyt0IyxIzlrkRlapqAUF+QZNHuq/B/6fooSpVsyFr4P
	8g7SFKlRQJY55U6lHaaV02eiAFpmrmEGVa4dHnYNMqVlijFTHt1TJh3kb+o32zI9
	jwzm9w==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1hvj6re-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 23 Apr 2026 04:41:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-354c44bf176so7457128a91.0
        for <linux-spi@vger.kernel.org>; Wed, 22 Apr 2026 21:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776919276; x=1777524076; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PXcarQ3/SORvCcBXZAV2XtrZqcRRpX62RDXzsLa4WYw=;
        b=ks05OSAIWzSYL8SjGV8ej7Kw2wU7O19mp+EjOTSVDZENF57AB07qmxAM0/VpeeYiXt
         NuyUoGxQ7cXwJRbPGCEf+EjqgZA1t3tq8yUx2EGLiRsb2ewj4TLd7YWOgBEwbkVLtS4A
         CmDBQTGsf6bD0QOx32rP7tqtBNAB8zOLwzEdTUu0bThdb7o1nff1IPU2Nbk71huYjQrZ
         Gqz5IG/iSVbvJyM+3onSCETsQafWd6xXrtXcHdELJjlLJ0oI7tUEZ/1YqG2bmsEiBNqg
         iAWEsG8w7iPSAejdvwy2Vrm/Io8xYy2/psAvPVHT/jY5YZ2WYgYbAbwIMQF2Qz5YrGMX
         qRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776919276; x=1777524076;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXcarQ3/SORvCcBXZAV2XtrZqcRRpX62RDXzsLa4WYw=;
        b=hl+5BzYTlY/a8/eqnT0G1DQZ3+dm/xOXnmEmiZ7jVMIYvvfZRG0uMh7AYXMXnmX/CJ
         nc+KhI4195l1OmWwI6KizicTqenrojF0M/lW+0SGxgdwOt7SUD9Jg/XY65EUBBaPO8zx
         O5M/d41WhJgmgERg+56NpKqmsnB+HGPiX+Jq09IZt5Q+iKoUg2E8bAjRJvzd11eiVHpE
         0aEmE2tGPBpozYB4ttPgGhHmLZUiKP5wIVCQM+g+irXDa565rAAUGcbKvNeVT828+ruw
         6X0a06U8u7Fzg8FKdM0/eoO0Gc0xjd3Hekj+kzNKEL7Y2Fppamyg6GORFqhJ/GAXOHiA
         VrVg==
X-Forwarded-Encrypted: i=1; AFNElJ9qkHGMuiq2LTJPfnVUthJPAmUppUzuBDeTlVXN/rRMs+8btFkzt0qWLLL+VUkDqs3IKKnV92vr2qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLe1KLWPQXGnfHu92Nmv9P44/D369tIAQxB+AtAjTYn/yIecSD
	Y0vqFkoV0w9CuNvGmpa/7O8bEr2EhD6OwS8vd8kZ0ZSoP0MIhSOG2CLXMjPRLKY67tHipCmUw3Q
	x2QsymKjADZd6S1CaR7Wxpnr9Dx9rk3YFO+nF8JCzjQ0umlr8hmgdNIs5hROAxHM=
X-Gm-Gg: AeBDiesowRVozg7HvvrOup/UuJXZC8tJOHQj0FGqsLGK9Z0W4aaBWnBjs5SGATdAfRG
	gklnr/4YoXE5oBSOjhBlT6CP7UL2gGTIsWc8G+R0Wx8XzmypXiKTzeCNciFSG9UdIP8xc7sDWzH
	G0RHCbzvsVw+/Qfr7T/a4TV+OsgQB0okyuKxNROqSTFVOmFNBzd64XDYw/0vI1kEYEklt/yfdGP
	tCKqpJBS6o+Lkdp3WjqC6SB9bsj9lEbUhyeYwzltfT3cSOlfnHQ0vjM3Il7Q8KBqQPOz7PiSeDX
	N+96JsEEnNl7MqAzejViwBhZM8+AVOR9F/r7Clo9CCioz/GEargOI8AwKa2Y41R29qJ9awZ22yq
	pY4m8ozVQsYvHx3BvpYIkOo82hCdlez+Rby7xDGTWtwssghnSra0nQk5GjIBZNhrh
X-Received: by 2002:a17:90b:1d50:b0:35e:599f:aef0 with SMTP id 98e67ed59e1d1-361404254c0mr23419616a91.11.1776919276423;
        Wed, 22 Apr 2026 21:41:16 -0700 (PDT)
X-Received: by 2002:a17:90b:1d50:b0:35e:599f:aef0 with SMTP id 98e67ed59e1d1-361404254c0mr23419574a91.11.1776919275975;
        Wed, 22 Apr 2026 21:41:15 -0700 (PDT)
Received: from [10.218.4.221] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614195a9fbsm24124355a91.11.2026.04.22.21.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 21:41:15 -0700 (PDT)
Message-ID: <84bab102-9b40-434a-9882-f6cbcb00c038@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 10:11:10 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] spi: qcom-qspi: Add interconnect support for
 memory path
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260420-spi-nor-v3-0-7de325a29010@oss.qualcomm.com>
 <20260420-spi-nor-v3-3-7de325a29010@oss.qualcomm.com>
 <e7873eb0-bfcc-4ad2-8016-17b0db80feea@sirena.org.uk>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <e7873eb0-bfcc-4ad2-8016-17b0db80feea@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDA0MSBTYWx0ZWRfX4u4bSw1SMJs0
 6P6J+0gx9hmcbv27PFCCpBasZnlrqqZMB+PTCAu3zQCcoGTvgxcgZBiy0oVzBHQ3B6EdJY7S1/g
 ZPditoMuxZaFIUALuZy00fZ6gGLRdDiSZAhsk+wJDlutwORR3V9nEbifAhpk4etcdVW85YpRGHa
 lHlw04WbS7QWD9hf03GYZjv2VinED4VlvAIW8XsilJn+aUG8/VGI2RXhdFR9VU5T88xR8Q6g2eN
 krMvESS6GDogVw44msru0w7ACrLcAiOqoPCrJ1G1P7S+4MNEcoxLxDA++t4ZjLpl9+HbrPFBWx4
 QMSrS3tN9mfK/zFSkN19j3x81TmmK/a40mlhqAmvpj8lbD3lpopvw0WPfJ27SjaG9+n3PZXzdqi
 AFilbkENkGJ6nT8hlpRBWVGjsEeNJlyMSil63VNUIhP6P3fr6pGst/+YnVS4de4h0pP/gwHsxNL
 BrZWr7F/YlfzwIWNetA==
X-Proofpoint-GUID: Tkn2Lp0LG6p9dLkTVhJkiobH1mEGl8UU
X-Proofpoint-ORIG-GUID: Tkn2Lp0LG6p9dLkTVhJkiobH1mEGl8UU
X-Authority-Analysis: v=2.4 cv=HJvz0Itv c=1 sm=1 tr=0 ts=69e9a2ed cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=Ktr-gnuM6ESvd8fC0OUA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230041



On 4/20/2026 10:14 PM, Mark Brown wrote:
> On Mon, Apr 20, 2026 at 11:42:50AM +0530, Viken Dadhaniya wrote:
>> The QSPI controller has two interconnect paths:
>> 1. qspi-config: CPU to QSPI controller for register access
>> 2. qspi-memory: QSPI controller to memory for DMA operations
> 
>> @@ -729,6 +737,11 @@ static int qcom_qspi_probe(struct platform_device *pdev)
>>  		return dev_err_probe(dev, PTR_ERR(ctrl->icc_path_cpu_to_qspi),
>>  				     "Failed to get cpu path\n");
>>  
>> +	ctrl->icc_path_mem = devm_of_icc_get(dev, "qspi-memory");
>> +	if (IS_ERR(ctrl->icc_path_mem))
>> +		return dev_err_probe(dev, PTR_ERR(ctrl->icc_path_mem),
>> +				     "Failed to get memory path\n");
>> +
> 
> Does this handle missing qspi-memory properly?  It's not conditional on
> the compatible so it'll run even for existing devices.

All existing device trees have been updated to include this path,
so there won't be any probe failures for existing devices.
