Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CCC33C536
	for <linux-spi@vger.kernel.org>; Wed, 15 Apr 2026 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246381; cv=none; b=pOUlTi/0kxp0Dm70QCHgP4vDzd7lHxO/6rfeybqMy3Ny8IlT17bunlWwViUK9HR8ZUBwo5KUhA8cL5BNfhIA/SjSSk362AwZcJqOT01myfOAVC3Wds+fDNqymvQospfwUxhqEVNWGiCcB39ExHlEh4rel1SKFdrru0+NJTV182E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246381; c=relaxed/simple;
	bh=c1MflrFeD5+n6mMO7gCo+moEzz1iszLgws2k7cI6kzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FIVr/8JrTH+JqVcsKC6s8SXPLLfJnjkU0uuz7iFAe9xPZ5bXyqbXO/uASmci5pgjzCJoFP7feDRS7AKb0mQZr4cSiuKUKvJ9ZRtmopRORO2A3eCCiIdBM2pCM7HLSuz7mp4gChLGoF/k2pRg6dJ1IsFXvtpq916MG/9HMgoU6fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HtScilSw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q5nhE36O; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HtScilSw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q5nhE36O"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F96rO41778950
	for <linux-spi@vger.kernel.org>; Wed, 15 Apr 2026 09:46:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	v78e2uOfVUD/HRkOWd5/vidxUP+SE5hsufWwy8VQQAY=; b=HtScilSwhJX676xc
	/n/A5kt9foi60TuCnYLh4Wg8ER5+i5Meftx8IwufrgCZ4fi1hoSISZtLd5kpPLQD
	6GRwznk1q6Gys96RFBo80hbbtLx5qYTIFFR5pAFpdvL2BgAZcngJ3z5OYkPJguHQ
	K7rWYZ+264TTmSO2MDWdOKDhAZYefcCzjSZKGbVInCQcnl71UzfMvVCc1qJByVPf
	O8zhFmNAIOwykWgU+bc7sDOxzPLM14GGNyGhF3UBvpL4OIpVMqULrYDl7Fqu+voS
	PW+QpcB67sYxTLZ1lecu9yPBa6yOF5GPEzkmqHeneIplF1rAE5shTDpzZIpV6Z+9
	VAFDsQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dhrw031xg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 15 Apr 2026 09:46:18 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8acb4b340f4so8724676d6.1
        for <linux-spi@vger.kernel.org>; Wed, 15 Apr 2026 02:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776246377; x=1776851177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v78e2uOfVUD/HRkOWd5/vidxUP+SE5hsufWwy8VQQAY=;
        b=Q5nhE36OdM0AGN8rn8/LNRIZqzC0BrnB4Lcqm4D80maFUqsyLYzjief5cDBx00N/zH
         mODXbSpuIjkArvma09mAYFbQc2OEW4NUdWSq+qXsPT5M9pSvAg+aDvYNUkDVRnWcGAkV
         sSqIlPI8Sa6OODiwbCIE7kNbr++px2MzxtyffsnIR2vfjKXQg13Q2rf7ps3Vzz3ni6E/
         t4pcLGij9WpwNnw9uWWMvU40sRof4djGmefpGSUPjqzAyJIIbtvspNQP9O8HLk2JRWjG
         I+sWIk0LxGgiBgm++NEsWRj1zKTdMU7fllSDwihAlp184QvhTfcwmkuQcu0j0rlNBlPk
         4RrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776246377; x=1776851177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v78e2uOfVUD/HRkOWd5/vidxUP+SE5hsufWwy8VQQAY=;
        b=mw+xYpe7JKsmF7FDIcWL2NbzOGGZ6YoqfOlziIz2grheLOWnu5jdmmfSdidabAXa+F
         QknscUSlGJ/doucayO4OIwkCc6zwQ04vkBAccbCvoR0TELXDyQuZoCsHlNDAP828air9
         LDHhFCoqan+CEg+4DwZqdxNlZXok41rfxtG3Y+V79nhk4lLlGGHj5w4a+KBJDc5jCMDC
         SwtFP3yZYHqlQ9CRU5ExD2ojXixZhfPL8Zi7O+0nfOLOt0QXJHqcg0jdH8AdQ9BeftRy
         4s8mMMJJjPzF6G73MVnq/j6ul0gE0USKHCJYGyxI8Q7jjSjf7eh8KCfp4XkQy/Msphzp
         Q6UQ==
X-Forwarded-Encrypted: i=1; AFNElJ8fcjP692ZyTNsCuqmYdUVfcBV42XT9mao2k2zeUkCaj1fA3MHpdnfAxA7dDmBnCwngn3hmacbwflE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx12t/YPNsNokjAVyhQygs0TdwHRicfLeHZTYjf/2BSicLBCrgJ
	Xehbshr1BJVOWgQKpUtlrAeppUDyL4jB3CnGb8FhaCy7SuLPanC6aMjHY8NwaBGZ4wrp4N88Uws
	lhXpUoMXdKra7joFY3km3wFEtu7olS8Ef5gpRsm9j7LvJgcToFeStVRtvAnuiRoo=
X-Gm-Gg: AeBDievvJLEOOFFfa6Y+Q4A0mFRmZ8foKCDpZ3X29fBBy2lMw2Yzo+4O5bjsX37jZ3X
	3kdnpUl6oWmp7bs1qQrDw8zos9if86kSfP+D+efF8soPr7uMUNguWvIIKW9iZPl1haDjP3zjLSf
	S2tbQim+VWk4HmpNgZ953kRxM947qRECdb24KOM3h9GBdfBNra+a+OcYYs+IqzLmjnEzj2KY1w1
	y1SIedkvSijEh6ctqLuWyG/0AYDqYSz0CreJL6T1GIAVzjcgqRGkrPrBx9nn6PPw5mdU5xxIgnI
	1jdGcvYiZyLEaogDN89FHrrV+vgKvRDC8MGLVS5/jZdqXri828+Sg6ZTh4bkaHFSPFwiMGQNM+R
	Ihum5qsiyiVVCHmOauEWxpHu8ejzju5dqKz672WXDiMd74mHwRITVY+4zff0D8PttcfHBsKmQ0F
	ojeqoSSEjS4OmIjg==
X-Received: by 2002:a05:6214:27ce:b0:89c:d639:e7be with SMTP id 6a1803df08f44-8ae6a92307dmr17279736d6.5.1776246377571;
        Wed, 15 Apr 2026 02:46:17 -0700 (PDT)
X-Received: by 2002:a05:6214:27ce:b0:89c:d639:e7be with SMTP id 6a1803df08f44-8ae6a92307dmr17279476d6.5.1776246377082;
        Wed, 15 Apr 2026 02:46:17 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba17392e952sm39513466b.15.2026.04.15.02.46.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 02:46:16 -0700 (PDT)
Message-ID: <fe30cca9-c348-4ab2-b190-33016242aa64@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 11:46:13 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] spi: qcom-qspi: Fix incomplete error handling in
 runtime PM
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
References: <20260414-spi-nor-v2-0-bcca40de4b5f@oss.qualcomm.com>
 <20260414-spi-nor-v2-2-bcca40de4b5f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260414-spi-nor-v2-2-bcca40de4b5f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: -hOt0e5GNLWj72z7Q2thTGPf2sU3qY0L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA4OSBTYWx0ZWRfX8sfckzDZtQ7V
 oJtHOyBLDGq1psQ66qM42RTTSvTh0DU962RSqA+Dni/A9zt7VXlfJc0Q9q4SRcjTH3+T0qw7Fg5
 LLmYDTERXz7FA/sr6/PcZrysPDv9YwgpnsJOUkWXdETECZ5veYbVnHny4wxPBsUcaJZoqHIv6wP
 Gnc3VD25uOfKdmy+Db3AxO1KWW/EeUP9+iDi1QYR6IS0EtCH4VmtnOo2ySQLHqQ1S8M4la9XIlP
 Eznv5oEJzk56lgWbLo/3uN8ekop+hW1nwu2fpFME5KSRQdJ0HaBazLVILf1UPTkUDND8P59G7/x
 vxr6gtjTF2grvFz28lIMDDh7/3+D0cpruZMKWgJTX0kaZD8CpOyqH53sKyZeqs6b6M58/P0n8lR
 UlqunW7b72eG9qT6aHPBgp9DZg8yO55TktruzSRdqBAzqTQeafxTg4fVJ9DJWRU31Xgv6sUcY6N
 yy5YT2Qdy24kWzDqQYw==
X-Proofpoint-ORIG-GUID: -hOt0e5GNLWj72z7Q2thTGPf2sU3qY0L
X-Authority-Analysis: v=2.4 cv=YMGvDxGx c=1 sm=1 tr=0 ts=69df5e6a cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=3Z6IiVtUJ8LA7v5DzrMA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0
 suspectscore=0 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150089

On 4/14/26 7:08 PM, Viken Dadhaniya wrote:
> The runtime PM functions had incomplete error handling that could leave the
> system in an inconsistent state. If any operation failed midway through
> suspend or resume, some resources would be left in the wrong state while
> others were already changed, leading to potential clock/power imbalances.
> 
> Fix by adding proper error checking for all operations and using goto-based
> cleanup to ensure all successfully acquired resources are properly released
> on any error.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>  drivers/spi/spi-qcom-qspi.c | 40 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/spi/spi-qcom-qspi.c b/drivers/spi/spi-qcom-qspi.c
> index 7e39038160e0..38af859713a7 100644
> --- a/drivers/spi/spi-qcom-qspi.c
> +++ b/drivers/spi/spi-qcom-qspi.c
> @@ -819,19 +819,31 @@ static int __maybe_unused qcom_qspi_runtime_suspend(struct device *dev)
>  	int ret;
>  
>  	/* Drop the performance state vote */
> -	dev_pm_opp_set_rate(dev, 0);
> +	ret = dev_pm_opp_set_rate(dev, 0);
> +	if (ret)
> +		return ret;
> +
>  	clk_bulk_disable_unprepare(QSPI_NUM_CLKS, ctrl->clks);

You first need to disable the clocks and only then potentially reduce the
performance state, otherwise there's a brief period of brownout risk

[...]

>  static int __maybe_unused qcom_qspi_runtime_resume(struct device *dev)
> @@ -840,20 +852,34 @@ static int __maybe_unused qcom_qspi_runtime_resume(struct device *dev)
>  	struct qcom_qspi *ctrl = spi_controller_get_devdata(host);
>  	int ret;
>  
> -	pinctrl_pm_select_default_state(dev);
> +	ret = pinctrl_pm_select_default_state(dev);
> +	if (ret)
> +		return ret;
>  
>  	ret = icc_enable(ctrl->icc_path_cpu_to_qspi);
>  	if (ret) {
>  		dev_err_ratelimited(ctrl->dev, "%s: ICC enable failed for cpu: %d\n",
>  			__func__, ret);
> -		return ret;
> +		goto err_select_sleep_state;
>  	}
>  
>  	ret = clk_bulk_prepare_enable(QSPI_NUM_CLKS, ctrl->clks);
>  	if (ret)
> -		return ret;
> +		goto err_disable_icc;
>  
> -	return dev_pm_opp_set_rate(dev, ctrl->last_speed * 4);
> +	ret = dev_pm_opp_set_rate(dev, ctrl->last_speed * 4);
> +	if (ret)
> +		goto err_disable_clk;

similarly here, the OPP state is only altered after the clocks are
running (potentially at a high speed because the rate is cached)

Konrad
