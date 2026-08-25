Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84D9481A8B
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 13:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787664867; cv=none; b=n4abtECdtWBnp+DL+a9Pa3mcuC1PtL6BzgnOmAQO1VODtb8jWs9xf9AEW+WmQoiRxy95TRMIAZzhuK1pq4OnVlLn3R7NsMMUFkQeUVz0DdsEptHJFHjAg5ZglxwtnDvMWhF7fQgEGG82Jc/q1tkY/H+EF+aM3gksEoTolGflDac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787664867; c=relaxed/simple;
	bh=bLAQYO2fVtjrZJZjogehxs4N3O4/AoaOHSJblctpWIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IfbkkdDsSB2GWm7JCoA8NOo55gqJ0IXIUPGhmmY5wkfbMKy/ijWt8ZZGHWdx1WrOhK5ex0C1NjHvceTg09Zq0xkZw8ojoTX7/6aXKtEBdb4xOYoTW4I4r/4QFpaFuRJgIDD5t5LBAI5lJzLrOC34dCpTZBYIoRaerT/ZS8KFdAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fnffekqe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fsCtb6M0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fnffekqe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fsCtb6M0"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PD7jaa3063050
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 13:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TaVfdGUEZ4eLonecVULryIdNy5Y/IszLAAF0qOUkWYs=; b=FnffekqeV8VFB+Ck
	19eFxD/ZL3SeOCpShcRv2c3Ha5sn3Offs2Oow35eByVWEaXH7foOXc9kBf8VrffX
	EhmcvQ4WsT7din/nntI5p8KYtNKnnxQxsQOQuiHv1MMlbHD6kMsfOBvHjpbAqtyZ
	ZYuJ99fzWV64B4SG2tZWxFNHn6JJtoN5rFLoX1GjAm5MbqL81OeJ5WU8+2eBLFDE
	/Yy/VwhB68O8TI9YcA3R8jtrnG8guEr7MyRkap8Wr32Xo8+oQgK5644aD+IMhvDT
	vvV7iaBydDKFowLV8EYzd/ErMlUsQIz8ZorUIfyzVVW58FowK4KwSLKn1Sh+e80F
	bNUdYg==
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9bnj844y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 13:34:25 +0000 (GMT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-7eb60cfd476so9713733a34.3
        for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 06:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787664864; x=1788269664; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TaVfdGUEZ4eLonecVULryIdNy5Y/IszLAAF0qOUkWYs=;
        b=fsCtb6M0SPeSoWTNKHAJ4U2W2WAzB43ii4Pbi1caVwXav9K5gfVykb9Ctq5ivGoBg+
         J/nboOSQegFUTf6zSybpBBeU4N2vJGfp0wm0FvRliVnGVwg0iS9pHhkAU43AG324yYT9
         CU2d1gmYBWnhwrLtFepLFV0dn+hDzfvZX6l5zkPzjWMYbOnXZUGRtL46m5NulXKjpvmU
         7/y3bbrM54cRImhCPM1NqANsKbc1BefqtnlIkm8sIQNxPB52ggRljxMl1ma5CWAi5A9e
         6OXlTR5PONbUHx0MzSLSfiVu75urEK591lfJEa20oSlBusSmzsqhcB7FAPMxAimJNhEv
         JnmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787664864; x=1788269664;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TaVfdGUEZ4eLonecVULryIdNy5Y/IszLAAF0qOUkWYs=;
        b=hHDW39njCvPadfkOq1R1fFNkDMY223orwqQs3UngxUGOEm9To4k7Zey2zGEDd98EkK
         RQ+QPIgJOaiDzm9sGs6N+5Je6CSglVODzIdKaZf+JsT5BcpmjXPOIAtDhSFKlFowdr4E
         d25bXGHqwEyDVmbQP7kLWiDdj10L7RRKonhAYa4ImB/QFyhORpNmesFHPB29WQ3v1Di1
         BnCCJfo5MXuiZgGwBdz+PPJqNFpqIpvJBy0HMKF725luUq1wbvjr1HKlfhN0sDH08/fN
         Pu0R4GnQL1XRgzj1O1O0edx4jSr4ZQ10OB1PKUsg678W/E/30kq0rYqj3FagSvEk5Jh/
         wrBg==
X-Forwarded-Encrypted: i=1; AHgh+RqS/n5Sd8LWhDdWF8NBjUw13BILqtfWfuvm2KWNakTSGwIeTP5H0cK/na9Av6jNhxqh5Srq++j9yE4=@vger.kernel.org
X-Gm-Message-State: AFuF++myuOGNci/guY+9ussPOkFWebSWdqAO4joYdFnZx6XI4fmagx5M
	QaaePFGO+N40kIizDjxUKIdYKPtG8INd1DerNJKjERPxYzWG5N422pG//R3YlIIUeuvmOdc5aOL
	wkHE7bKckr63l4NzqshD+C2mta2rJ4TgVvLUjTpgvsaJ0ETv/xUVWdBizcIxS0UQ=
X-Gm-Gg: AR+sD12fVfMtBuvaA+5FVDZnEJfIUiyn5Fp+qAnLSdYW7KJaOy1zltIy7DzZ+fTNFQ8
	/JJfbeTLOGQZ+dOI3vJI/XVnO3i9TjUr84fnsNc86zu3X6wtGKdgvdiRYJ4ovJah4Lv5zyqCZR2
	Dmc2gUkqpR9OcwmijbCwbqyK/naWbfTf5KtYgdWmh0H9y2PjSJmIO0hdaFl9BQ65MzZb2dyfvzX
	/cmjg5+0stQDxI6DqghYAg6rgRN8y3B/PmAHVTV1G9yqaRg8c3C782NRgb+svknqfVx1VyUA2Bx
	3LvOSaK87O3Hyv4xD9C9r2axP/c5yIEHKAiF+NLhom0feM/PRPekJfdRUwNzN5PUR1r+Uy9KlBm
	nWseeGvlxfcyut06jT/XVrEhMcvr+GfNm
X-Received: by 2002:a05:6830:4116:b0:7f3:a8ac:45fe with SMTP id 46e09a7af769-7f461510b2fmr33747261a34.11.1787664864237;
        Tue, 25 Aug 2026 06:34:24 -0700 (PDT)
X-Received: by 2002:a05:6830:4116:b0:7f3:a8ac:45fe with SMTP id 46e09a7af769-7f461510b2fmr33747175a34.11.1787664863701;
        Tue, 25 Aug 2026 06:34:23 -0700 (PDT)
Received: from [192.168.0.7] ([49.204.109.155])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f48fc866b5sm7180397a34.23.2026.08.25.06.34.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 06:34:23 -0700 (PDT)
Message-ID: <57b9cb3c-6fcc-4f61-b372-97de8058ffac@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 19:04:14 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] i2c: qcom-geni: Use common GENI resource
 initialization helper
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
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-6-61171ab1cdce@oss.qualcomm.com>
 <2329d1dc-9907-4338-8bb6-2a32e3e261ee@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <2329d1dc-9907-4338-8bb6-2a32e3e261ee@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: r7EC7TEghtaUg3F1yIe_2IRQYtCpcvoO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDExNSBTYWx0ZWRfX9LSvlsICMBTl
 FLbicjHaEHn9Uils+U/yJW1NC48vOeFiUbg/9yn9lEVB3pWi5VmPeChDysumhPsGFK9qw3tH/4e
 dgzkk3FTrdctrk6xc4yAQQgQIs9NCWBrTtDhs6Ue0qa0HzFe5oeShGQStx4fWr9OQsVs0Raqb5T
 m25gOwhFQr2Gjfu3VKrVGyiCAclEz9qrsTN8cOTbd0U1++g0my4zwYS39yMdZmdgDKY9tvWMHS5
 SCPuNdwnLTqzFzHZrxlBX284hTzTB1nt3HmTJZkJSvopo9XmN3RSc91757KHCVNNJCUmA4rHOAI
 pgsoN86bpvnBCOgZcyPu/bXtauzE1SJeggScGjDctrEykpa2ZNfz+rxSj/AcBiNOyS7OBoNMZ6f
 Z+qAxWmkdpyFDjjGDNG1pZH5SMgyA4Zrec5n/VwPiAJpkWwG0pd43jNDTa/JTohwjHxdKYQ7iS/
 CED/NYcthVV6JLVQu7Q==
X-Authority-Analysis: v=2.4 cv=ZuHd7d7G c=1 sm=1 tr=0 ts=6a8d99e1 cx=c_pps
 a=OI0sxtj7PyCX9F1bxD/puw==:117 a=V2Vt80KW7rYiXl8IeOG9JA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=atO44hwG55kBqV7UmNcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Z1Yy7GAxqfX1iEi80vsk:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDExNSBTYWx0ZWRfX6DTPwXLNDqeF
 QnbHIjX38Xomq+FgK0qyPOsGQRZLzIYZ61JbnJDHlxg6XfGWMEPWDlfWGO5zHi2ZP9+2KViUhAU
 sq9R0XdCN3tZECnhMusdAPv/FJSNFzk=
X-Proofpoint-ORIG-GUID: r7EC7TEghtaUg3F1yIe_2IRQYtCpcvoO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250115

Hi Mukesh

On 24-08-2026 18:42, Mukesh Savaliya wrote:
>
>
> On 8/5/2026 1:27 AM, Praveen Talari wrote:
>
> [...]
>
>> @@ -228,10 +228,13 @@ static int qcom_geni_i2c_conf(struct geni_se 
>> *se, unsigned long freq)
>>       val |= itr->t_low_cnt << LOW_COUNTER_SHFT;
>>       val |= itr->t_cycle_cnt;
>>       writel_relaxed(val, gi2c->se.base + SE_I2C_SCL_COUNTERS);
>> +
>>       trace_geni_i2c_bus_setup(gi2c->se.dev, gi2c->clk_freq_out,
>>                    itr->clk_div, itr->t_high_cnt,
>>                    itr->t_low_cnt, itr->t_cycle_cnt);
>> -    return 0;
>> +
>
> This looks wrong to me.
> First accessed registers and then we are setting ICC vote ? we should 
> enable resources first.

At this point the hardware resources are already enabled and  the ICC 
call only updates

the interconnect bandwidth vote. Therefore there is no dependency 
requiring the

ICC vote to be issued before these register accesses.

>
>> +    return geni_icc_set_bw_ab(&gi2c->se, GENI_DEFAULT_BW, 
>> GENI_DEFAULT_BW,
>> +                  Bps_to_icc(gi2c->clk_freq_out));
>>   }
>>     static void geni_i2c_err_misc(struct geni_i2c_dev *gi2c)
>> @@ -1100,24 +1103,6 @@ static int geni_i2c_init(struct geni_i2c_dev 
>> *gi2c)
>>       return ret;
>>   }
>>   -static int geni_i2c_resources_init(struct geni_se *se)
>> -{
>> -    struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
>> -    int ret;
>> -
>> -    ret = geni_se_resources_init(&gi2c->se);
>> -    if (ret)
>> -        return ret;
>> -
>> -    ret = geni_i2c_clk_map_idx(gi2c);
>> -    if (ret)
>> -        return dev_err_probe(gi2c->se.dev, ret, "Invalid clk 
>> frequency %d Hz\n",
>> -                     gi2c->clk_freq_out);
>> -
>> -    return geni_icc_set_bw_ab(&gi2c->se, GENI_DEFAULT_BW, 
>> GENI_DEFAULT_BW,
>> -                  Bps_to_icc(gi2c->clk_freq_out));
>> -}
>> -
>>   static int geni_i2c_probe(struct platform_device *pdev)
>>   {
>>       struct geni_i2c_dev *gi2c;
>> @@ -1188,6 +1173,11 @@ static int geni_i2c_probe(struct 
>> platform_device *pdev)
>>       if (ret < 0)
>>           return ret;
>>   +    ret = geni_i2c_clk_map_idx(gi2c);
>> +    if (ret)
>> +        return dev_err_probe(gi2c->se.dev, ret, "Invalid clk 
>> frequency %d Hz\n",
>> +                     gi2c->clk_freq_out);
>> +
>
> why not move to geni_i2c_init() ?
>
> Check recent patch @ i2c: qcom-geni: add I2C frequency table for 32 
> MHz firmware-based SEs.
Okay let me review it and update.
>
>
> Let's agree to move there, to avoid issue.
>
>>       ret = i2c_add_adapter(&gi2c->adap);
>>       if (ret)
>>           return dev_err_probe(dev, ret, "Error adding i2c adapter\n");
>> @@ -1281,7 +1271,7 @@ static const struct dev_pm_ops geni_i2c_pm_ops = {
>>   };
>>     static const struct geni_i2c_desc geni_i2c = {
>> -    .resources_init = geni_i2c_resources_init,
>> +    .resources_init = geni_se_resources_init,
>
> why to add common driver function to i2c ? and also spi, uart ?


The goal was to provide a common helper that avoids duplicating

the same logic across multiple consumer drivers. As a side note,

this refactoring was done based on Konrad's earlier suggestion to

consolidate the functionality into a generic implementation.

> Can we not call that function from within i2c specific hookup function 
> ? i think design wise should keep i2c as local function.
>
> Also driver specific anything can be managed in local function.
>
>>       .set_rate = qcom_geni_i2c_conf,
>>       .power_on = geni_se_resources_activate,
>>       .power_off = geni_se_resources_deactivate,
>> @@ -1290,7 +1280,7 @@ static const struct geni_i2c_desc geni_i2c = {
>>   static const struct geni_i2c_desc i2c_master_hub = {
>>       .no_dma_support = true,
>>       .tx_fifo_depth = 16,
>> -    .resources_init = geni_i2c_resources_init,
>> +    .resources_init = geni_se_resources_init,
>>       .set_rate = qcom_geni_i2c_conf,
>>       .power_on = geni_se_resources_activate,
>>       .power_off = geni_se_resources_deactivate,
>>
>
