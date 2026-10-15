Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E5B2EEE66
	for <linux-spi@vger.kernel.org>; Thu, 15 Oct 2026 03:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792036745; cv=none; b=O3NaZPInAIUq9RQWiYUlEWYDC381apuPZsz3pOxQ/xIx/nBFFa+Qb7HqACoGn1G39oDtidWQGFNX+4hk4g9cMWiZiTcB6yOkEw8WOFZfMh/FGtHlilFhvC0PNd7URzX0h7T3kkyrggXPyAS1XkzPv9vZaXMB9KWfyLwiGynPe7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792036745; c=relaxed/simple;
	bh=nguePDkbSX8CdLrI5jeCiApYYmALGzarrJu+OM9Fqm4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aT+UXESGI0dOlcTepThTTTbBFOdQw55sLAFQqwPPB8GOcKAaI5ilHF1Osk1yEDfQiZZIoL3hd7teFw6aAuTHd85+4YjRXlxr14o44vi57tW1jZKoa/GrCmdNyomN8pynt6WXQBbh+ZGRZVz12DBsoc8fAx62NMBRzHZbLTK3vmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a7kG2EMK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bZ+62dYM; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a7kG2EMK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bZ+62dYM"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F0p0Uq3469215
	for <linux-spi@vger.kernel.org>; Thu, 15 Oct 2026 03:59:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yLcj2xFJ+ldAWy0+daCRV0vS+QgpQC6UVrd5FcRL0HE=; b=a7kG2EMKtNc3ppFV
	ogttzL9XW4vzOAZkDYPt2ffRra6tQRSjZqEc5ss7PKoRXS3+CC1neU11bs5H+wJJ
	hv0t6JzmuVAVNBJMNpYtXtmAHgvs0ZLgHPfCtsrwNzyRUiFaFgblwJe1V3XC0PN6
	5e+BVu6dTNcrxA0F6uGaN2XuN3U1OMcoMCDwscp9ZABI6fTaQcSDKunlFPDiWZXz
	U7uPDBBOcvNuwLLzE9W3WPH5sc8IN6Vq+iPqdYETcyY7IVg5T/j0sSvSx/BEH4d5
	1QpW/a0vbZDFtNGyLXbtAzN3PEPir4XiS13YiIp+WaDrZsNUxAmRnoE9UN1eiaua
	Q34uFg==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hadd7a7vu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 15 Oct 2026 03:58:34 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-139b62317d0so18393687c88.0
        for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 20:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792036711; x=1792641511; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yLcj2xFJ+ldAWy0+daCRV0vS+QgpQC6UVrd5FcRL0HE=;
        b=bZ+62dYM1MkDW+yNCtwXnFmU0rRsmt+hOm2R86MsgwR1TaaWRYEqHLXkUEj5D3aFrZ
         b3UFjMCJyjGE2cziPtAYBuZFBczQlt76fBuDeXTPYGDswpoWy8u9tNWx4PNLOHIutaLG
         XarRFDMreyQPNY2MoG6slsLkyR3XPUovtr2rNzNW2yHaGGm9+5c/4DLoXwRy7RIJoYmM
         emdfwIpgVNEitVE84sUW0rhyUf7MwauLw9oxMWv6gf1QHNSVYSrgqALoLbgkR6brV2/e
         MYgV0o0NSChJi9SPbwCVNVpqL2thU+hPlrsfudKNBwm52Qz0ei8dSYQu4a1tc/Fv19ix
         v0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792036711; x=1792641511;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yLcj2xFJ+ldAWy0+daCRV0vS+QgpQC6UVrd5FcRL0HE=;
        b=J4Wdp3PFofqz6MrA5L+PaoVmyO/5qG7RHWArezlpgyNtfc1MVb+0hUbTq5ftE2sa0k
         8rsRiz2OHC2SzNtW20uqWbS0ajeuOGHNYccOlF9UfK08Yo+I977o6dsRHjN2Qoyp4E2F
         BDLF980ZzInFRRjHj93FQFe7HL8yPpA5+YoJV8b/OAwIqjZf+ijDtaT75wlLKjGXn4S+
         P2xFlSQy3/Icl7nCHHHBKfaI4oKJCkW8e9FsW+MGbNkGBTWkrejtYuVMQCfOktkylKTK
         pse128pzjT3fssTMgAGjxQmnetoURGvzYXgsdMMHZokBfw1mGceTHnE3v0BP3L4yajvd
         KZ3g==
X-Forwarded-Encrypted: i=1; AKwUvBwQVFgbMnTzSzy1iRTQpoF5rPnK7HrLTDX1FwKLkXwo16g99qmWw3udSRWzyKqB7QZR65/1smP8Aso=@vger.kernel.org
X-Gm-Message-State: AFq9FYIECP+PQhAdQzgmgJ7KH+0ZOquR194AJ9ljc0LDROYDQ45lgwyM
	GW99htsqhBhiTtPvWk44OmsqgYNMX6NoOXf1bkhSrsY8oP9Tddu3iVN9wd7MDn5zZsZCUsWWxPS
	Ryr/eqZWJzQVLqcMZjOQEx9L0h9jihs0K7fPVrp938Ko24k1GIXryuEL9HAN3X9g=
X-Gm-Gg: AYBFou3Zz2lZRrcMevuHvgGrVL5SL/GivnhifW/vEqFo5fqzRnG2gQPEQUQ+LKWjfdK
	/BLMs544BGjyWNk+pxfUbExw2YDeEsLgZgcZKR/Wcclh9hmkNBIC5p0Cek5EL1XbmtzWoX0limf
	GWDteIT0LxKsU6nnCGkEvmDMBvidWJvXpkSW153BT/4aeIaLXHBJV8oX89+Jl9dzsrsJXP/ieWo
	B3J/27oIbe3oeE7n0hbnHU80vsRyd6iu8acw+Kpwjo0TG6BAOoZjsxzeofTIYHElDV/+b5NFXa5
	eZhrSpi5I+vUuqd9bKxoLhCld+sFS/n2KMUeLVShsuG8iBbaPyeF8MkkdndUyUUaqohEH8Sm26Y
	AoD0hg/mhjm1sOkyiZGa09WQLTWVyBg==
X-Received: by 2002:a05:7022:e806:b0:178:4a98:8751 with SMTP id a92af1059eb24-1784ab70e5cmr12450020c88.37.1792036710726;
        Wed, 14 Oct 2026 20:58:30 -0700 (PDT)
X-Received: by 2002:a05:7022:e806:b0:178:4a98:8751 with SMTP id a92af1059eb24-1784ab70e5cmr12449972c88.37.1792036710046;
        Wed, 14 Oct 2026 20:58:30 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35b29c2f861sm41853429eec.11.2026.10.14.20.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 20:58:29 -0700 (PDT)
Message-ID: <666e2768-28a8-4bb7-8c15-457ad20970a8@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 09:28:22 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] serial: qcom-geni: Use geni_se_set_rate() for
 source clock configuration
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
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
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-5-091697dbeb02@oss.qualcomm.com>
 <cf4b63ca-adef-46f2-a616-01841a70b173@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <cf4b63ca-adef-46f2-a616-01841a70b173@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=BaVNQbt2 c=1 sm=1 tr=0 ts=6ad04f6d cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=ip-HRx4nHBnhdLLshUsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: 2t_-AvGCRBX3938ZKAzSdoLFzujrwYx0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDAxNSBTYWx0ZWRfX0WY+LLbhCZFO
 pZEGCUt0KVSABWJzM+xmU3pajZP9Om7/ICghUdc7gB9nhkUWEV9qZsQUtyXzpe2q6BnavuEf7+m
 lMDUEkB3LkvNvS9m/xiYZEMBlikdgxiPFoPJ3lmOWrWGflBcKL3bYx6DSrcBVrmiC58EwnRD6kb
 1xzNkSyoceXZMU+jk9kQDQDYI0pbFM907NfbEphiEnnbibiZA+cAA1e+7Zm2E05eQxBtgNdv9Hg
 haFmyEneT+I38Tu1IXQ2m9tONh/psoUa0fyS3faBYa1bL7UsWfVIN7ZA12cTaSK9ukRWVnOsxsD
 qjvZL53V8Pcd3xVP4ZsOhLrAUuYXKRy6OG/nfl1yNtr57JDGieRChmcDA807rgIg+YjjcuIKcsb
 1Tj2bBgqcAmrXtR1rIf4y58um+EYihn1vhQeYqMkc1JyqseYv2GIlf/ST/OMgEa9RtdHWjSfB3L
 6TfCScF8QvD/WvEeLVg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDAxNSBTYWx0ZWRfX87ASESYDbvCL
 ilYdwOlIKO41WlC/ZFtpBN311gpAFGEwr3eBEGJg+bNSbq3owA99RRoahHgGGKxoCShwZ0VvPbl
 tQ3tKzuQW6FGet7ltFUHSd6bSQgZs8I=
X-Proofpoint-ORIG-GUID: 2t_-AvGCRBX3938ZKAzSdoLFzujrwYx0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150015

Hi Mukesh

On 08-10-2026 13:05, Mukesh Savaliya wrote:
>
>
> On 8/27/2026 11:29 PM, Praveen Talari wrote:
>
> [...]> @@ -2039,15 +2041,19 @@ static void 
> qcom_geni_serial_remove(struct platform_device *pdev)
>>   static int __maybe_unused qcom_geni_serial_runtime_suspend(struct 
>> device *dev)
>>   {
>>       struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
>> +    int ret;
>>   -    return port->dev_data->power_off ?
>> -           port->dev_data->power_off(&port->se) : 0;
>> +    ret = port->dev_data->power_off ?
>> +          port->dev_data->power_off(&port->se) : 0;
>> +    if (ret)
>> +        return ret;
>> +
>> +    return geni_se_set_rate(&port->se, 0);
> Is there any register access happening as part of this 
> geni_se_set_rate() ? i was searching but could not see after seeing 
> set_rate() callback removed.>   }

No, there is no SE register access as part of geni_se_set_rate(), nor is 
there SE register access immediately after it.

Thanks,

Praveen Talari

>>     static int __maybe_unused qcom_geni_serial_runtime_resume(struct 
>> device *dev)
>>   {
>>       struct qcom_geni_serial_port *port = dev_get_drvdata(dev);
>> -    struct uart_port *uport = &port->uport;
>>       int ret;
>>         if (port->dev_data->power_on) {
>> @@ -2056,8 +2062,8 @@ static int __maybe_unused 
>> qcom_geni_serial_runtime_resume(struct device *dev)
>>               return ret;
>>       }
>>   -    if (port->se.has_opp && port->clk_rate)
>> -        return dev_pm_opp_set_rate(uport->dev, port->clk_rate);
>> +    if (port->clk_rate)
>> +        return geni_se_set_rate(&port->se, port->clk_rate);
>>         return 0;
>>   }
> [...]
