Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C304E421223
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787577169; cv=none; b=CBewBdzZ8XXOzzrI3I0yEecxHwK2BWRTcS58c1kTCSgjE1Q1p4/LHjZqg12Az/wkg6mf5OY82bZnIGOGmS8hfOJII5iNtUPFVjgQ/0+CizvrbslLM3DfTWIHx/jP4E2+S8uYXNp0RJIFSfzMlc0tO9J2CVDhPntrkcZIhn046g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787577169; c=relaxed/simple;
	bh=XsBMHAWN4RghzlvwrXqgof1mlIw+SjmfHFjk6r+5B0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MwDJgU4Mvd1e/BI65fF+cIZRL861+pS8yj9Hvfr1u34+H0eBPdMl76opLNHHpY2NpKcnH+WhceSB00plZxM/FgZfb/7Vgne5FEZHa+InwoBPFR+rNcwXoOgrp9DIzjB5v4Aept88ZFC0i4lt607OhkfFYYN1+HcyU82LP74bvLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YSATzLFn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=f5PJBvuh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YSATzLFn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="f5PJBvuh"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OCuuis3053456
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 13:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	AP8FPC79TXKJzXH5HK0VofQkMOzeJIwaszQhzrpV2s8=; b=YSATzLFnnZ+16q3D
	VP+z8TjUTxnbRnz24+6Ir1k401gnJmtxWw58juPIrAsYpFc0bbdcTslnnzzcsCSQ
	6vvgKAKL35YVkIywBiDM4eai4pRnuVpESxcfxZdVs5qkH/mv4TevM7IiXw5GaPKj
	TuOmmICeRG4DlFZcmu1jS48G1lAGTG6M8zRvpQ12eF41pNYUfwbL8P2TQltPmwpL
	yyReKJMbu48DgFNyQdyKVSmVCNFPXL33ep1ubIxU/HjiSAMTK+L88m+ecOIRQbcL
	kIBGQJ9AWbtVPtr77+hAoTZzEUq6r84B3n373onzvC/jROWzHuzP47aXn7elfbXE
	cCSHdA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g88k7jx3h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 13:12:46 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1d7886cdso71344641cf.1
        for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 06:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787577166; x=1788181966; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AP8FPC79TXKJzXH5HK0VofQkMOzeJIwaszQhzrpV2s8=;
        b=f5PJBvuhfiC7sjrXVl+oHfP9aD8E8AOzSuGzKEvOVFs4n+Pg3pCjSpN8gA6B+d7ubH
         34Z/tt1CjZ0i6eTAOzBE4VXuSXEQOJ73/EYA00DDjcu5IpA1/2paC873E1XdaLmhkYtl
         sB85lXbR901d9J9JGnnO1kns4MgZzosN7LzFqkpauhFhizw9qqbOceLXfFRzapvLa5jC
         SfGrgXwioiltV5ud7za63cp8IFx08cLkT+vc6a1aMrJIlPA7i+mRfclYtIxQNYtfOj+F
         ZSVmRlLRnx7O4DzD1JKCafNMhnGb3KN48nAyS2j945tLOiYY8gMNybNsSa7SVZn1CfIp
         +zfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787577166; x=1788181966;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AP8FPC79TXKJzXH5HK0VofQkMOzeJIwaszQhzrpV2s8=;
        b=GCbWGedk98J05OYDGRo98MZUaItB9x9Ae68awKptsc4GAlcB0nd3FmXbpA4tR9pQ7R
         E13RUoLmFT1OlyM8N8s2nrhRIDCoecTg0vrC2EniGAYDWGe9bgN226+fhpSJlWubh3mI
         1zHeFW1PRzumWKlOwmmFamLrFH2BwP7+wT0dyzqo3+wHUWeyxXQadJog0AzrZ0tEQq44
         9oLNnd7C9yz3JP5niWa3ZjkVRGqWVt4+h/9O/J/p6d6Zc7dplRKaVRxj/qvE49wz4ekA
         oVzrlh4QGu/5E/nHGZyIyFl0PkQ2BxJsKsw0+GQaSNVO4PE03Ba64qLMam8ayDfMxtyB
         9rbg==
X-Forwarded-Encrypted: i=1; AHgh+RoZw1Vm1wYV5CidGHlA+xBpUht1/XjBtfrWIBx/LvCDlAu2rDY/D8jrCRcNcPwWTl1fx0wm0Mx17Q4=@vger.kernel.org
X-Gm-Message-State: AFuF++nhAonqDDzwI7lmNmSVcdm7UkQ0t0GAqYhXquhm1KEydKUMUAua
	BpoDHWSXMP7m9LDt4Lht3hvPHedkVjdsjnOhlqduUdF6IguMdEUe/iSK1yzDLqIowewuEOSb/Bz
	bNdyQRSiiCMHY4GIbUuMHIsahwjH9Dh/3dV3p5cwy3nQCbNw0fjD+qau4twZ5Zm0=
X-Gm-Gg: AR+sD10kkNrGjGqZ4YD53wUun364MGl4baBn22B8rT4d+X3W6hAkPKznZJ+UzB53xGK
	I+V8gTbYMeYI24NjUnBuX8HisaiwvMivrTtoXC+du7mx3wmk8b3Mbhz3FtlfjjCUiWhs7ZshLUL
	SG9CKsET4OUfTPEhw/ind6BJozpi4Vp41JK0/GNNPWQuVHqGQ2uFeapaO/7tGPFIYxy+6JwSUeh
	z+VxbgUvtJFE1FellflzEx2IG1q1st7oDdNG7RMVI9ei6KXgG9XZpc46FNtlsPDgUJKxNCkXIsC
	QcvE9mPCpS/vgKn/TA2MTrYc2sSZhZ3S59voVAS01A2UbDMtiqxVJWfsmBxEjjiVVoRNI3jHBl9
	zUc9goh5OizruCinFX5zfipgl3ck3I0kBot0=
X-Received: by 2002:a05:622a:1646:b0:51b:e92f:ec5 with SMTP id d75a77b69052e-52e09bb3048mr171483261cf.3.1787577165532;
        Mon, 24 Aug 2026 06:12:45 -0700 (PDT)
X-Received: by 2002:a05:622a:1646:b0:51b:e92f:ec5 with SMTP id d75a77b69052e-52e09bb3048mr171482641cf.3.1787577165102;
        Mon, 24 Aug 2026 06:12:45 -0700 (PDT)
Received: from [10.217.218.158] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499d560f66csm527895e9.1.2026.08.24.06.12.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 06:12:43 -0700 (PDT)
Message-ID: <2329d1dc-9907-4338-8bb6-2a32e3e261ee@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 18:42:31 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] i2c: qcom-geni: Use common GENI resource
 initialization helper
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
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-6-61171ab1cdce@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-6-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=b4iCJNGx c=1 sm=1 tr=0 ts=6a8c434e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=M9ZTtoZWvZtrIhbvBKUA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExMSBTYWx0ZWRfX4bl9M7CqSLDX
 yHZm7oAyKgAKBg74TnUQ/OSG7expKumiackEcAIs20/vWhakf8fVFpYeuU47mg2cuPn9OzVnaKg
 0AXhtt4EfmnSH68ERMk9dM075w23jIw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExMSBTYWx0ZWRfX8NIsYOmUBV7B
 fI/PqfSv6OhPXRrhIxLYXs+P9PPLDe3VXUoos6bgNyfEh/qHdlKf6YWo3aJdrbbqXTourgq+qK0
 h7hVHthtihNdGOflsLonfJPo6oI6g6xDFhTpNVs3OWOa9bktCKH/FdojrWaPKlTGlW19Je83//G
 c6FFv8b6KWbedhZuKSWYKozJ9UC0T+G0NLv2McNMzTapdF7WosY8geUbpL2V2XVKTFx7dsWPMQ3
 qxeRBlFz8wocSziKevHt8PtS2T5r0lQC7qWC6sGIu0favkqnRE6uYAv3tsRd3MhEv6HeHwWEiFJ
 YckOw0iRArHxJjsPabCl6TQsN6aX4WXgaXyifpLpP6U/3EmfCNELkkj+2M1TNdHzuutvz1rR3rD
 B3vYU3gnKn0Yxgtg3hLW4OaoOKpY2KELg+ndMzx73WlNAAyv8YVcpeb1yB//2QI+UllIQkDHBkc
 Yep7JjqEMVVBS/TbWXA==
X-Proofpoint-ORIG-GUID: Ih9q30rNYYk_E5-h4IWx9ggNAPtK68pe
X-Proofpoint-GUID: Ih9q30rNYYk_E5-h4IWx9ggNAPtK68pe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240111



On 8/5/2026 1:27 AM, Praveen Talari wrote:

[...]

> @@ -228,10 +228,13 @@ static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
>   	val |= itr->t_low_cnt << LOW_COUNTER_SHFT;
>   	val |= itr->t_cycle_cnt;
>   	writel_relaxed(val, gi2c->se.base + SE_I2C_SCL_COUNTERS);
> +
>   	trace_geni_i2c_bus_setup(gi2c->se.dev, gi2c->clk_freq_out,
>   				 itr->clk_div, itr->t_high_cnt,
>   				 itr->t_low_cnt, itr->t_cycle_cnt);
> -	return 0;
> +

This looks wrong to me.
First accessed registers and then we are setting ICC vote ? we should 
enable resources first.

> +	return geni_icc_set_bw_ab(&gi2c->se, GENI_DEFAULT_BW, GENI_DEFAULT_BW,
> +				  Bps_to_icc(gi2c->clk_freq_out));
>   }
>   
>   static void geni_i2c_err_misc(struct geni_i2c_dev *gi2c)
> @@ -1100,24 +1103,6 @@ static int geni_i2c_init(struct geni_i2c_dev *gi2c)
>   	return ret;
>   }
>   
> -static int geni_i2c_resources_init(struct geni_se *se)
> -{
> -	struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
> -	int ret;
> -
> -	ret = geni_se_resources_init(&gi2c->se);
> -	if (ret)
> -		return ret;
> -
> -	ret = geni_i2c_clk_map_idx(gi2c);
> -	if (ret)
> -		return dev_err_probe(gi2c->se.dev, ret, "Invalid clk frequency %d Hz\n",
> -				     gi2c->clk_freq_out);
> -
> -	return geni_icc_set_bw_ab(&gi2c->se, GENI_DEFAULT_BW, GENI_DEFAULT_BW,
> -				  Bps_to_icc(gi2c->clk_freq_out));
> -}
> -
>   static int geni_i2c_probe(struct platform_device *pdev)
>   {
>   	struct geni_i2c_dev *gi2c;
> @@ -1188,6 +1173,11 @@ static int geni_i2c_probe(struct platform_device *pdev)
>   	if (ret < 0)
>   		return ret;
>   
> +	ret = geni_i2c_clk_map_idx(gi2c);
> +	if (ret)
> +		return dev_err_probe(gi2c->se.dev, ret, "Invalid clk frequency %d Hz\n",
> +				     gi2c->clk_freq_out);
> +

why not move to geni_i2c_init() ?

Check recent patch @ i2c: qcom-geni: add I2C frequency table for 32 MHz 
firmware-based SEs.

Let's agree to move there, to avoid issue.

>   	ret = i2c_add_adapter(&gi2c->adap);
>   	if (ret)
>   		return dev_err_probe(dev, ret, "Error adding i2c adapter\n");
> @@ -1281,7 +1271,7 @@ static const struct dev_pm_ops geni_i2c_pm_ops = {
>   };
>   
>   static const struct geni_i2c_desc geni_i2c = {
> -	.resources_init = geni_i2c_resources_init,
> +	.resources_init = geni_se_resources_init,

why to add common driver function to i2c ? and also spi, uart ?
Can we not call that function from within i2c specific hookup function ? 
i think design wise should keep i2c as local function.

Also driver specific anything can be managed in local function.

>   	.set_rate = qcom_geni_i2c_conf,
>   	.power_on = geni_se_resources_activate,
>   	.power_off = geni_se_resources_deactivate,
> @@ -1290,7 +1280,7 @@ static const struct geni_i2c_desc geni_i2c = {
>   static const struct geni_i2c_desc i2c_master_hub = {
>   	.no_dma_support = true,
>   	.tx_fifo_depth = 16,
> -	.resources_init = geni_i2c_resources_init,
> +	.resources_init = geni_se_resources_init,
>   	.set_rate = qcom_geni_i2c_conf,
>   	.power_on = geni_se_resources_activate,
>   	.power_off = geni_se_resources_deactivate,
> 

