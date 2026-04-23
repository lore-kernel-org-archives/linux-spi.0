Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE336364959
	for <linux-spi@vger.kernel.org>; Thu, 23 Apr 2026 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776943210; cv=none; b=eszGVK1MX8Pj7JFQ7GcWEFstG8MpR9Y/YqkyUUmlf7qiMl+9XGCYcAA8wE81yYHGDCjPrv7gNyl/sOnnKDb4j0Z31DJFlZWmqUeabdLgnjFiiuIeQyLSQnr+l8zsMzKDyt1cH+GxYCvmeVDjBFtsQLv9rChat5tu+DUgE/8mFRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776943210; c=relaxed/simple;
	bh=GP9L8s3+6Dna8OPJunaRkww/VynNPAuD1ynp9SUd5jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Amr6JvfBHCa2uvKZjHYJGeVTBTt2ODupFnJjL2Xdomkx/uXSiS6ojqPgAH+kI7aIjOukiSI7xO3HbTjKCCJ8At90BH0q3jQbJ2L6AHzo4YoItCgcnLfkXBTulcuQ9L4Fag57GDSDGdq92Ygv5JmZG8RsJ4+JB+LRJ9sAi+ECPgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pvLo8/Gd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gpAjG6s2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pvLo8/Gd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gpAjG6s2"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N8u5Bg3769050
	for <linux-spi@vger.kernel.org>; Thu, 23 Apr 2026 11:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Eyjs36fm74EJZijLcHA0ssTPFQ4dZB0D3TOhVHv00JY=; b=pvLo8/Gd3m6MMxE9
	aLhoIUoAjJwWxJYyIdyrDqh/x+ivNhy+EKA8XoOtKhe6L2ZgGvP1Gpm1RDp4Ge6A
	2wzl6KJYJyrR8WrqRWkI4TTZ4aLTPZ4prthp658Qw7etp09gKHQxQc0nb6/3acLT
	VCl7k5jy2YRA/0Y4AGUr4piHI5BFqtSqIAlWOO8JPFMAuTwr33hx5wKKsDg2j/7W
	W9ssAH3K+jdiEA1TOJNtz2Uf1PlN79WJNo3k5YmQlr0PLXSgMCgvtUZexzH/m6fl
	5TbwtSJP/Lg76YXsfV9K8yOZwaMBQ+i7oxIiWnp3Zziz25O/zEnsU61mc5MHojF3
	sKl7/g==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dq1hq3jek-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 23 Apr 2026 11:20:07 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8b2156efafeso412296d6.3
        for <linux-spi@vger.kernel.org>; Thu, 23 Apr 2026 04:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776943207; x=1777548007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eyjs36fm74EJZijLcHA0ssTPFQ4dZB0D3TOhVHv00JY=;
        b=gpAjG6s2WlTXMzJHkGT/6JVVWAFUMMRzHKYfw/QUnXrMN5iGs66bubbNLncRZ4/OG0
         iWveFMtQiEf4QlVgyVm/SE1UL8gsCS9S6OtmXcckCYjlEg3YfHfpTy0UpadA/dG1/g37
         Wokg8gE5fQGa6Q5uZzQEor2ELQfvvpSRe6cFqVcxjQpDECt504WeZ8wHhQ1ME+yF5Vf7
         i1iilrUWCJlL5Vtj8LpbPGfUUc4c3LY0GfeoxmEP3NbLuhjFec7BKMCqgw6daCaDC0kd
         9LkHLnWCSgg3G/bDgHveNwVypsKyFBYoIJLdpx3lflbZjcX/QzPRo8GM+FCn7VBMbSs2
         E+Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776943207; x=1777548007;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eyjs36fm74EJZijLcHA0ssTPFQ4dZB0D3TOhVHv00JY=;
        b=di82FZP3uUh+AGEcdHspk4L+VStpRH0QZ6p9dIow6sL3McwwycsUzAU0Y4AIeDgMf2
         pgqMejMhjcjbr3DU7Is3AJkcD1m/EIaPr/a5OpNl/x0BBl2e3KfEWpWPqgRu9hTvBOoE
         5KUEOsZRxC/Ay+eQTIbXkQGhB6xuuxQ4bHDxyI8IvAXMYdS2KeTg4w2ld0yQ0fRP4h0Y
         /IBjSbFRfY0RBJ0fhimo2GdiqNI4ArgYIl7PqcE2+H9clvxorhnaHqwPLJ8gHuO1umwt
         euy26lUnIp0bg2+sgbQarh02jzMNF3RE5OyD23QZXsfldNl7Uixyf82nvdW1io6SkJeB
         bVqw==
X-Forwarded-Encrypted: i=1; AFNElJ9iTXAiglwflX/qyAFwYhEXUgWr/Bg6RyKFXY3l84Rl2wy+WdSwHeUmHMNftBMObq7H+BeuMfk/tYE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqORzXIylwAc0fzgAOKCGNS51Cb5n2Ia8/w1rZ0UZUsJElW42i
	LEh3/R/MPqEDd7trUum1ivJK0dInMjr3+mYOCNAHR8cn4AaByL1XMNoyFePux8BPzYp33EPt42l
	vTB8LM+reXkuPMz8zG7zxvqeO466l6B/QQr+hP1QkO60JoK0LTrPesP1Wmh/y9bY=
X-Gm-Gg: AeBDiesG3Vfpfl6pPEGQ5/4UxLuFuxDL3feXjUkz0TDCsXo4zeimwQN1C9B2HGlLckI
	XZ8TrG0hZTi46/2+SpHkCmhL0uh5lN+0dyXa3I9dIzPDDaEByvXbvl9LXlQ7r4D3stzLNdd+UbR
	Hplwo+q7pVNW2E7fp8YBrz9bLBRZSO7y2hfVHo8eLeztmtWIV7U9xGjoVx+U7TWGT3C6w1UgzPo
	DKO6UzUcP7e6dtHxqvGDhTgGBKXURSsJR0v7ngDS3nNEtRb/vXdGaPETPkzHE4JJii4YoPSWky8
	LdIwX0gWECpD/1ss0C0wYILNe+/zyv1fFVl2I8ssDDEkW4lxFCjauGeE1mEjgP6TT+cjYmgnitp
	/d0qb3fXXdXQtNuGO63Cmgb/7hINYP5gTqkrOn4UJ50ag8LOwqGqMoKO2fqsW9pdjd0+cSmLvlI
	2StnJt1rPUCDkcRg==
X-Received: by 2002:a05:622a:1c0c:b0:50d:9138:3322 with SMTP id d75a77b69052e-50e36c8e98amr256855301cf.7.1776943207078;
        Thu, 23 Apr 2026 04:20:07 -0700 (PDT)
X-Received: by 2002:a05:622a:1c0c:b0:50d:9138:3322 with SMTP id d75a77b69052e-50e36c8e98amr256854981cf.7.1776943206696;
        Thu, 23 Apr 2026 04:20:06 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-678974e23adsm61612a12.13.2026.04.23.04.20.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 04:20:04 -0700 (PDT)
Message-ID: <8ca34203-68cd-4e5a-a4d7-de36c0c35f91@oss.qualcomm.com>
Date: Thu, 23 Apr 2026 13:20:01 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/7] spi: qcom-qspi: Add interconnect support for
 memory path
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>
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
 <84bab102-9b40-434a-9882-f6cbcb00c038@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <84bab102-9b40-434a-9882-f6cbcb00c038@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDExMiBTYWx0ZWRfXzLNHpsJuZe/V
 LgrZ+1BtmGJDFvX5N1iZgavbIy1ADc9fF4jYZyq2i1QRMyib6QvG0trjISAGYAyxFhAKlOsM8B0
 QypoaggakCAf6kXXQGtMnvcp0t1+S7uzZz/coe5Y2/Fg+2DGRPCbF3m5T60B3BbnAt6CqWTQCg4
 6ivhvg3wxSL4bkGI7l9A7o446LQVS7t8qidgSIe7NgARxJfHEUAzOURYSq7ZRH+NdpsmMX+Bk5k
 9wLx5UDgB6ypcMUYg8HYfqnVWwIPlIUDDm+zgEKyP/5Xumf31LtcrvAYeOJdRKk4GHCyHpfsb8v
 4ptSxhgG79dJ0uP9T8qZOn4+SXZa4hYtZ8xl0EDdS5bQ9SAhyWoelfY5Iif+ygzpmyevACZ8ruA
 dk9zxfH3Xd5XUw+cY5XzEnqOnCLKLRDmkHUEGpvBE7kIqyQpc+4zVD7ozr6Wu/VM+Gx1ztDmKiQ
 3wZ7bNbJGywZ8Djd00Q==
X-Proofpoint-ORIG-GUID: -Sj1sRAPAyIxwTcsOou6WIVbE8l_lDcJ
X-Proofpoint-GUID: -Sj1sRAPAyIxwTcsOou6WIVbE8l_lDcJ
X-Authority-Analysis: v=2.4 cv=TJt1jVla c=1 sm=1 tr=0 ts=69ea0067 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=X9vs7x0jcKjliShTIuoA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230112

On 4/23/26 6:41 AM, Viken Dadhaniya wrote:
> 
> 
> On 4/20/2026 10:14 PM, Mark Brown wrote:
>> On Mon, Apr 20, 2026 at 11:42:50AM +0530, Viken Dadhaniya wrote:
>>> The QSPI controller has two interconnect paths:
>>> 1. qspi-config: CPU to QSPI controller for register access
>>> 2. qspi-memory: QSPI controller to memory for DMA operations
>>
>>> @@ -729,6 +737,11 @@ static int qcom_qspi_probe(struct platform_device *pdev)
>>>  		return dev_err_probe(dev, PTR_ERR(ctrl->icc_path_cpu_to_qspi),
>>>  				     "Failed to get cpu path\n");
>>>  
>>> +	ctrl->icc_path_mem = devm_of_icc_get(dev, "qspi-memory");
>>> +	if (IS_ERR(ctrl->icc_path_mem))
>>> +		return dev_err_probe(dev, PTR_ERR(ctrl->icc_path_mem),
>>> +				     "Failed to get memory path\n");
>>> +
>>
>> Does this handle missing qspi-memory properly?  It's not conditional on
>> the compatible so it'll run even for existing devices.
> 
> All existing device trees have been updated to include this path,
> so there won't be any probe failures for existing devices.

The problem is, not all users of the new kernel also update the device
trees

Konrad
