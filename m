Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1DD3F20FA
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787571609; cv=none; b=ptpsVbgano9Aoryqg25dcO5PQlnHRgoeMqD+siDtbiv+BDrElnsSzlUMwdfxH++5WD8M9GmVEbJf65kuX6UXwS95Q5lq6/Ym4JGIrG8Dkxr/3bnhrF3e1xabnOTkBVNorxeDjkRvggiwEjIwE1LRFY9y1iH2gi8AqixkkhCGylA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787571609; c=relaxed/simple;
	bh=mhM1nJgariA7Drln0GvxSUCFkFDiM3od2qwlyHrudFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uj+52caPk9g5k1dysp+0xytfOreTNvGrNw03+lLEv2cKMa3Bx2PPi9Ag1JdoU6ifm/ngv0rgYezW3Ui2W29FBwImTlOo63OxKOzo/l+lZ/6yQBBAvnWtzrvHfG4lihEFcawVEQgtzGS+Nu9kTlm0YnWBZ+jWcx9c2JuCGOMeN48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iFJI3fRU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DbsCTWw9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iFJI3fRU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DbsCTWw9"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OBMYnD2376903
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 11:40:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3PFyPMRWHHZzfiXJ+pBlyqnTTzHCJvh3CG4+6T4pjYU=; b=iFJI3fRU23uszfgu
	5sEEIzYEiTTWjY1lLLHsvKScGW1RZlun7PE2G2leVNNyC5gj+t4lxuZpkWDMJBoZ
	7EFRFKRd1CkFXa2bxK4W4YfsWUUTBSkkAQTsXFtU86Ys5cOj6uMCbzUrtrag4eVb
	cJl/kxC9jSRcvT5OkGz06ZeFsHdmpF68J5Be8yqRhapo5MsFG38diRuSJIk+XBTu
	tushN3mu71MMuQnbh3Ln2PThkoIYOfGfVBX39ZSTJQnrpqVpYNiH5vXzCbIw7FEx
	6+UeqFTb9ea82QUhLuPY69R2WrpoCo7diq1RQKGBo5bL3oLbeLX6Mvp6+fg4q1R8
	G7cD8Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8hbth2u2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 11:40:06 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f0fe57470so4691056a91.0
        for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 04:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787571605; x=1788176405; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3PFyPMRWHHZzfiXJ+pBlyqnTTzHCJvh3CG4+6T4pjYU=;
        b=DbsCTWw9qBigNpukJCfLohk0niBZIcPnLiUe5MK1YvR1kNtfOL9bxrmgeE24mIz/Qw
         YVPNF3l961Db6M4e8+Kozmr4Ubs0I018s/DyrOW3PjyCZbTYE7jO2peV/HYk0vXjrxN8
         Tt1LjCIi+EFKNVqLIIoLmfDRntM7X/W4RkYUFyUEzge/wo7M/yI06K3Fj/Yj6oltqX3f
         NeRXNY/BtInmePjX2EGPotcRnsQODsm7UR6gFvSw7B7LpTB/rD5OSXGjD9FVZJpH+KeH
         7UidrantMfF5xAQmM2QKktkZcpDZYj8DpuUBJyTRvJHoh+AQl5gB/tgRKpCyuqmEXGdR
         9V4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787571605; x=1788176405;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3PFyPMRWHHZzfiXJ+pBlyqnTTzHCJvh3CG4+6T4pjYU=;
        b=BEP9N1eExLMQJ17Cq9nU+qBO8o73H/HIN9FkQiilT2mo/1rsiGx1EAdZf4koMtwL1u
         FBUVf+ppti8wSbSxLCG04ebCpPMf2bh8PvnryQ5hz1SeL3wNFz+nLWvYueWk80Oq3hNI
         JFVZUHoHUuu20BIuR8fDlAq4KHcwGxMphz364tLr+qswlBPZqXgciEUSyUO4BjHnmmGc
         isQjLt3E8XGofj/qjUE61dsoBqz7uJldjSb2vJD0Z2xmIwRR+MHNS5laLmr5IOcN8usf
         EOXBVMKINrPfvcC5Qv0zr5j0hbJxX9zh0n4an0E2HcFRaVrn2p4nBc6rVoGQ0Nkv4mFT
         QUGg==
X-Forwarded-Encrypted: i=1; AHgh+Rr5hZtv8597khtqq8oeF1tJqB83Hjxf0o67xLDiZGICOXybdWcAtKr+hYlcEozpFBhrFFPA2GwDGR8=@vger.kernel.org
X-Gm-Message-State: AFuF++kYLThN5FYOP3g9Go2ab2ZNgKycqMLKnasBMNIaj018mNpXbrce
	zbvv2ciDuMSl/4K8fxbklaIP54CoLE5vn/13Hpgy9GvyUGLLKQZeXc57m7YE48vCcyrlxUBReQ2
	M0zl6Wvz872axDlbuD0J8IoRr1nDk67pIcbj8yJLxTLBFxlG7DPwNVDcjXwhxyMw=
X-Gm-Gg: AR+sD13X7qsQIyj9CN5e/7b6Ohlq5gjnAT5cy/8GGkhJUrG9Y3lIJgarkeZwgNH+4rn
	t7vjB42yb1BhAmPn7nvOz+IBjmix/JaWVhgOJ6e4g2kxl2Z3Ocol2orB6ee0RnCXx9Vz3Q51A55
	Rdk58DRM6Jvx0GHVzkZGuuEFIEymNMGs8SzcGncgXb0/T53t4f6bN0wrDM18KjCls0272FUug3H
	4LzPsXJsN/PM/vHKnAoqn2totWLJve/aPmHlivmZI5UC8jhUP5N4d8glw8MAnkFKpCKDyulegM9
	Z+ihhEYYZ0m8o0W7hQGHNv1kfsMdkTIu1oyw7J846hNabdB/zQaJ6uW9yZYikCtHa1ebBGT70yX
	EM1E6dY3Hk+9N4sXyc0+ZaLOe8Uxou7Nrn3Y=
X-Received: by 2002:a17:90b:57c3:b0:395:8124:ac53 with SMTP id 98e67ed59e1d1-395c4fa443fmr22916679a91.6.1787571605398;
        Mon, 24 Aug 2026 04:40:05 -0700 (PDT)
X-Received: by 2002:a17:90b:57c3:b0:395:8124:ac53 with SMTP id 98e67ed59e1d1-395c4fa443fmr22916593a91.6.1787571604902;
        Mon, 24 Aug 2026 04:40:04 -0700 (PDT)
Received: from [10.217.218.158] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e49e6f59sm9678818a91.12.2026.08.24.04.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 04:40:03 -0700 (PDT)
Message-ID: <9d73e9aa-240c-40b5-94cb-9b1b9c2ee380@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 17:09:55 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] serial: qcom-geni: Use geni_se_set_rate() for source
 clock configuration
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
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-4-61171ab1cdce@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-4-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5NyBTYWx0ZWRfXwNwSdN7bxK0V
 eCM30Dr481xfGcfdws0QpJTlV0yNAD/j/owZvE7oyd7TDq55PJZVUbnFRHa9q3vsPvVRTmyfKAz
 yDOQK3Zw3Xwv/RvQEV9kEI6aLJe/y0RsC+FuHuhm9cvJjkt2eijZH+qICWhvZ8bd1wUcu0jXutM
 t/v2+1uv//vcNHCaWxmYdCsgU5/+bzpr4Rwa7QtAIAGusjbw+Z6b06+bvq4HgOgbKGBRn5HCKq3
 nQ7+GpQ2UfFtewBmz7KiCtQxK9SMwMTYA2FiWbs4FoaahaRGvVdZOyYRBTPp3VpYirR6X6yZeew
 PipY0nTo/NYMXJk8EL31FKr8qjfLQKa+VLyuLWA9U4yGpTZH/NGA9lNAgzwthUfKT9aQv8BemjU
 EkdrFywE+Zcl69KVs1eu93DaF2LPKXhrSc7bqIUtSqO0LJZ32av6HfWQHoAAVq5gG5C2j95W6Ro
 r2KofUXyIWsr+r1czDg==
X-Authority-Analysis: v=2.4 cv=JL0LdcKb c=1 sm=1 tr=0 ts=6a8c2d96 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=qpM7YB9Ikm2qReIqoCUA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5NyBTYWx0ZWRfX4ZDGEb538BX0
 3LNPEY2uvEi5qAw2Vb2ezg3BiZchvOpUoXTqgBGJnyAS7whP4bLS49qQ87H6E66o5ptl92dtj6w
 /ThJ9bo/GC4+Z/8yRglWJEkr9ALB4TY=
X-Proofpoint-GUID: Qqs5eSD9lhXEslmTBrG8z0y19jUMaq4n
X-Proofpoint-ORIG-GUID: Qqs5eSD9lhXEslmTBrG8z0y19jUMaq4n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 adultscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240097




On 8/5/2026 1:27 AM, Praveen Talari wrote:


> @@ -1474,7 +1473,10 @@ static int geni_serial_set_rate(struct geni_se *se, unsigned long baud)
>   
>   	uport->uartclk = clk_rate;
>   	port->clk_rate = clk_rate;
> -	dev_pm_opp_set_rate(uport->dev, clk_rate);
> +	ret = geni_se_set_rate(&port->se, clk_rate);
> +	if (ret)
Can you add trace log with an error for geni serial driver ?> +		return ret;
> +
>   	ser_clk_cfg = SER_CLK_EN;
>   	ser_clk_cfg |= clk_div << CLK_DIV_SHFT;
>   
> @@ -1513,7 +1515,7 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,

[...]

