Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5684835E1B9
	for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 07:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786519494; cv=none; b=oB2ge9bikWawSdjyUURoAlKSJgn8BdBqYn9IoXqp3PvS6mlSaKMoIYZHSc4yJK5EGLkS+YDeoMRqkwc7VP5wX2wtXPY7n/FeVOcfmOhXBg9ADpgJkyOBSsb8rmDsqXIsTjD+iD761vV8JKA4KR9eBhJITR0t0TfOTp2wNFCaIdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786519494; c=relaxed/simple;
	bh=idEgIKuwLufALjp/jBV+Ut+lHDpRAhTiRSvAWJe3BF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S+x1zkK8HrCQ+PwYBEUeGNPEVzbdavhCzrc6zYljE1Xnk9TY6jCq8IW3WYQ+bLYy2htHBg2EzLWXbD3fWD+eLj0g51UhZHh3UodOt5JFOTFaqK9c3VBncFWTSbxSzpoyhsFjScG+ISFJN95c/QuBU5tucJdSo1Nnh7tSkOYdj/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Zm+rjJtA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UQeO8ynG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zm+rjJtA";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UQeO8ynG"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C79SYF3144252
	for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 07:24:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j8zmE4Z0t67Uc/IxjelkCGk5duWoHHbuKL7WpxEI2yY=; b=Zm+rjJtAIhhcVVmq
	JDFGgDHRb4vGNP0a3JP6Bkam278h3H4CuLU/ueuWx94zrh+FIQwq4a9AkdnaiGei
	RpZh9f8IMHxtsHa2o968rt4MLpIrUn2oufEH7/LFDsl48yVS6dDwYyT0s7tI8AqY
	A9uHYU0yc+BADE8Xluuv5PbuQyfsJm+vFwMVw8ZujWwUldlsUeVDmk13qWxnPUqm
	QUnLr0QdYLIfinuax6pszF6kZTtozeassr6PvRvCwrrT18Y6AxGnFK6whzABp3E1
	rkwV+TJ2KWan2wv0aEQdJSUqzlc/w37QkaA6DgRPXHzqM7a8tfhkek+3OBkvP7OS
	zIs9OQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0m6rg1we-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 07:24:50 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cca5e0a0c9so18896815ad.1
        for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 00:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786519490; x=1787124290; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j8zmE4Z0t67Uc/IxjelkCGk5duWoHHbuKL7WpxEI2yY=;
        b=UQeO8ynGeX4EQtAhzgsoXL4ypXKcAAmepTP5+2bbvAUpK/sfYPTCK4XTvo//6bgh8+
         3UMhSwV1PezGWGBuMV0N8YulgbbvZstm9DwljMlb7XcGAzc43Uy7UYpIkawVPruSeZ3q
         kNig8kasg8PHO3y2vs1kNH3bs5B43zQmJNEKXo/6U/pqO0xfSNb/b0PqhD0J8+juaeTf
         kMCr0rlr4DPUun43AcJv1mgl9BAx8aC55KmIxt0s3vdonNVPIc/d2zqysXNJ3bgbhdZl
         nnGZYNZotjSJA4vAIlc3m78G6Idn8KmhhzhYHfKZpScYZHPQKf8z7/Q45JU1epmDh3yQ
         rNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786519490; x=1787124290;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j8zmE4Z0t67Uc/IxjelkCGk5duWoHHbuKL7WpxEI2yY=;
        b=Zl52K1bMSfUpO2PTdMVGFsuhJiR3gQE0JKuXFGNHdHSm0LvNGMd0bEXxZednXaXLB7
         4HzkE2Ul2CsqPTQ59DEXoAgsS5HnKD5zksePfYeyxyM8Hi8iN+z00/z1E/NGLhI2mIyD
         mjRbZY7DGJ3XMe3E64uQt9SCeaVfIzoLuK9KPyODmu39/lezBOKBCxOjG/QFhSe341TB
         40wK85yENhLwLhPhaif40j3K7UqS2XtRAZeunqoJi2i737N5dscgh8PAITo63l/Wd2Kz
         SNYTTWBHVlyiijNX4HE2JknX59Ehz6dsqLqviD14VTHvliiNs74euCqTqbvBqIIOG9hh
         jTQA==
X-Forwarded-Encrypted: i=1; AHgh+RppvzxephBhetuO4Ak6Z3+riFbKQ9leW1IceF6MKYRsbuPmJT2NtPYeZlosEOqDbMkMUJiZ/PB206Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzfyBCyfBuFtrfsIOxMa+Trn5/Ml8AjKOMDSlVy0LRCTOoiqkm
	VzawqcFVtQ4ruiKlxryi/uZTdFTBAn3x279fWnFVgqoXio0kH5C3JtoKi8X/gkamkwukDrKM3Oj
	wSihIC6INs2BtjpiYtA/rt5oTLxzrJ4DuB+2rwiD192cSg3WVwTib7psUJsb5rIg=
X-Gm-Gg: AR+sD10s3Tf3Q5+W7MKFVgw0oMQE8RcD3vEfcESQ0rQOfWhDFRHQD3iwCCOISTcv963
	7GMhczbaSkG80wYI3y/bpGEs/RwaIlyZOSQOmkGmAQq2oyZHycfo94kgndyrO//70Th8lyG4RyR
	2iSZIsUEO+k4ODZp4sJ2DDZBuhylv0tE5zLI0EtBe+V5xBMXec0k5S7igajZm+ZLW1aQNeoaaNY
	4lQhdwL37b5DMvSPAonVm70/jQ4O4Y9JUHSP4U02Cctg2PtrPuG5UT8Kj1KzQ8gKi4cZZIphzjf
	R/PMVf6CySxgZHIkvzT8H4ELNXkWthlqGrahJLK3mPWC4yoByllOKAh6imXu3p0ltnK2JTfeEsf
	UWAqencwApSXmmDGHNkd9eOD0D5nZP6Uvjg==
X-Received: by 2002:a17:902:cf0f:b0:2ca:e565:7b15 with SMTP id d9443c01a7336-2d3453cce11mr40084005ad.10.1786519489970;
        Wed, 12 Aug 2026 00:24:49 -0700 (PDT)
X-Received: by 2002:a17:902:cf0f:b0:2ca:e565:7b15 with SMTP id d9443c01a7336-2d3453cce11mr40083855ad.10.1786519489524;
        Wed, 12 Aug 2026 00:24:49 -0700 (PDT)
Received: from [10.217.219.92] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d351145d87sm2545055ad.23.2026.08.12.00.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 00:24:49 -0700 (PDT)
Message-ID: <d5d64ea3-9c6f-41f5-adc4-9923381d732b@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 12:54:41 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] pmdomain: arm: Fix -EINVAL from
 scmi_pd_set_perf_state() on state 0
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-1-61171ab1cdce@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-1-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA1NyBTYWx0ZWRfX9mSxAHscS329
 OoxGxBf5U4ctqyIIecy9l+TuPGpmz1eZ87N5ogkzEvjVvs/mza291f5OeazxMl6y5qnBXkNB609
 lx4f63JYAk2LxqWWYo+PF62sKyjeCYh3b8xBZCHvEpzghcHmeSPuNUgyKE61Zm11w05tx+VCPdB
 +HMRI6DDauj2mOWTm1ahnba9/sP5V6TtVogcM37yHocfzCzlQ28pZsjVz0e8Eugq8v+y+RbOMm+
 lP17X+E7pu6d9QDEBIMV7Rwp3I8eSom+JWW4yqPfXOq3GjLhcAngtSgsmJgLzDILKRGmPR7EHsa
 S65jsjD3QyTtXjTLM9mUuFNcdpzXZZXwH/rRsLAjzjT+sDi9DJwYt1BppiQ+iBRJ/xvIymJSNz/
 M/Q8n6cYFCGRAbwu2s9e5MaK6l4adE4lxIqeT8FZ8ssLozB+FHudgt3jG+JAfBczdr933plruqX
 1XApxryed2xmZEXQ/gw==
X-Authority-Analysis: v=2.4 cv=Wb08rUhX c=1 sm=1 tr=0 ts=6a7c1fc2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=9TDyKcSpi701ZX69LQcA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: HaNgLJtHNbi5gZtTUfpNdn1lSblE6Nt1
X-Proofpoint-ORIG-GUID: HaNgLJtHNbi5gZtTUfpNdn1lSblE6Nt1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA1NyBTYWx0ZWRfX8A5tWrlxyz2D
 B5rgZ1dRaBb98hjHGb1BVXN5fSP+pwjP4Xx40kgpR3jMOGJQlK1n2AzTihtyZ5jib9guJde4iKc
 bt/Sk1k218zYaS5VgIwozzfj5TZctLA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120057



On 8/5/2026 1:27 AM, Praveen Talari wrote:
[...]

> ---
>   drivers/pmdomain/arm/scmi_perf_domain.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pmdomain/arm/scmi_perf_domain.c b/drivers/pmdomain/arm/scmi_perf_domain.c
> index 3693423459c9..e390f902a444 100644
> --- a/drivers/pmdomain/arm/scmi_perf_domain.c
> +++ b/drivers/pmdomain/arm/scmi_perf_domain.c
> @@ -33,7 +33,7 @@ scmi_pd_set_perf_state(struct generic_pm_domain *genpd, unsigned int state)
>   		return 0;
>   
>   	if (!state)
> -		return -EINVAL;
> +		return 0;

Won't this cause an issue to other drivers ? how are they going to take 
action based on changed return value ?

Remove Acked-by due to this till i give back.
>   
>   	ret = pd->perf_ops->level_set(pd->ph, pd->domain_id, state, false);
>   	if (ret)
> 

