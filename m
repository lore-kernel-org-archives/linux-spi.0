Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CA2364021
	for <linux-spi@vger.kernel.org>; Fri, 10 Jul 2026 04:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783656698; cv=none; b=RgbOFBRRpV+CEqjnqE3EhjIucxwQrHwvJT9OiDRQQGNzFBvqUxmI7JeLEO00XzHsiUMfy4VQsL+zWhhtq9Q7S2t5XSgi4Y/6AQnpKlTOCWAJcOXw5Fu0/shYOz7mah/xT1QR0Es8HnB4lWi9OTDfkSFNDayhrWJuYLQwJeMiOQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783656698; c=relaxed/simple;
	bh=LfFIKIOcm55z/amtHtkeCs37XEJtSuSYSN8HZUHOrRE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCImstlv9/QmIfjzyoqheUsFuurOiiDxzBPpnChlt7+bkkIfJu3I3ZzPtIQUt0NGkH1UPP+B+pmbSGHa4BZPKfAHnSu+9OhOJCjQD9iCHKdrR6Yq3VfI0YJWI7gCR9mE4Ib3Fb5Ty2ew/z6FOw+2tlClJfGYf/5s+7btK7itpug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gSyaD+Vk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=F+cQjiPV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gSyaD+Vk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="F+cQjiPV"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A3miqF3721099
	for <linux-spi@vger.kernel.org>; Fri, 10 Jul 2026 04:11:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FKVns+xih/NaHnE7xaZ9w5LtVBrsREGYlKhm+lRa+Ao=; b=gSyaD+VkX2sfDi/T
	5hpsgGIUT25JEfmeh77dPtu+ft2wW6efCMtYviLn3vy2GHIh98iXNn37QE47P2o7
	hBCi4R/IOZSfi0VLkkk8QwDlj6Z4v8JBi7ATTve0uGnKKiDTpjiBTxvcQRR7hLhj
	XUlSHLvcpJGyOtk3WmlKJtxZV8ltBAyApMwzYhHrYRIGX2Bh8/p5czEIuD4VhfXG
	4CdBz6MaJ9PVLFwtnWAOEb25aKzDo+I6SJErXfzY/TPtVgEMdyFhWlwC20bux3uC
	rKGSzQDx9DgpdBB9qU6NSZ3Y2p0TmEPPZd7l/dYx9v6wItbdw8lWWFjw2eCv5LeW
	n66Bew==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajwt96d0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 10 Jul 2026 04:11:36 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so367592a12.1
        for <linux-spi@vger.kernel.org>; Thu, 09 Jul 2026 21:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783656696; x=1784261496; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FKVns+xih/NaHnE7xaZ9w5LtVBrsREGYlKhm+lRa+Ao=;
        b=F+cQjiPVZSH1LehALqsOxAAaiANek58OyhD+kj/gbQT6/PZsz9PkiUJpOZCmch71ar
         7d6SdoUGjyd1/3UQMAWvstoRTmRGJweuGPghBqG8LixAkKhK3CAIBybzWa5z4g+VItiM
         a5ylt6i73vmICkL9csfXqo9heuzDHxbDTBLo642xqXH2cULFwPxi9C8JSlOcnruwcmkP
         HkjPTtBjZBGGeemB09k6KOQ1tffQDcHCloMyxC4vQoEz8KK/UQvmyzk3TsT7m5D2mdXZ
         D4aWCmbPUASz7xC2tPkhu789/06Zm9rhnMVQphtWoyPdLws7BpFMwy6sNo0WtoyGfQfJ
         8WoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783656696; x=1784261496;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FKVns+xih/NaHnE7xaZ9w5LtVBrsREGYlKhm+lRa+Ao=;
        b=gepCLWOvf9HIS2nwrV8wqAAzw0aGTTWW+DMSWYDvRQZVuua5wnpmgPRnA7SwzpT1mZ
         UVgeB26JzJGMb2jitSSMdg/7iPUyd44ew/VKqMW8aAEgNHS8ltZywcY56r0ngZ1NiqaY
         nk/SXAEbD/AXwbfsSeNzPGfoVHf8dYEIV175aQV1829Ut0Hbup0Yc/qwFoRD6o7lASlF
         g1vea0Wv80RYvKKrz4C8X586frob4KIT7By76HKfQh+fQiTX3FFonvIAAlbpDX6LeQaH
         kvUnGVDaz4bAqcLhrJuMMocP5ugUsZLM2K94q1fnFycFVszgztaBOormy9NMlT72mqAR
         5OEg==
X-Forwarded-Encrypted: i=1; AHgh+Rp+aNyC140o+rUW5eOCKXfvj9kqJ7As/hzhaBx0f7wS+sZJi9S0NEIzJSWqF2hXUeGl9hxdjhRAYDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHUmPe4B9TIf/lfjGT2HlATkr/vvNp7/Z7AKpyQd3C30CixgQ/
	IUZKuOErzWAB6vpk9fUAcG1b+I/78uGuAfx3q5S/Yi6kvGFwfVEhBrubiDat0gcsVAihPuxthQA
	2HYFyoAUoHtXIwlxhqJKIivxWtvoI8NsCV7HvXuVSFiOYqCUOJx1iN8cHYW2c8nA=
X-Gm-Gg: AfdE7cnyKwoRIW1R4YJfKcxPbjL0YthD19QOwvi2zB2jRf7bL7fBeDD9FHHBAAgXZ1b
	gySeqrE6i/VSnNwuHE5yJwEqWbbtJ9hdqIE66DY1O/YUiwaU+bgjkjpvM276jtTDj2Ml5svm9T/
	I5f6jfJv5plfqBZjbA2+zEkoeSRUbKVKZ9lVBU9K7+PEv+kpZBwdEdR1EmTUTs/FPZJKNX5Kdt4
	FmSh2HD0Qh3FIAVgB5IWkdWEWt+II9Tjolrbey2NhfFR3t+rCOPVFD/ajjRlkK/t7Et6iKZ1sOA
	ZcFDAOFwALWcc14c/biUBEFN1Y//pLGI9IJGQO9gvdnkFELZ+ds7urU9BNUiWsNZ3j+CZ1ubjpu
	X+m9JmUFcwZVs6tOmVCtxCpzX3RVrpkViVUhSvlcRFWE=
X-Received: by 2002:a05:6a20:4304:b0:3bf:a543:e7f5 with SMTP id adf61e73a8af0-3c0bce1eb1bmr11867074637.3.1783656696005;
        Thu, 09 Jul 2026 21:11:36 -0700 (PDT)
X-Received: by 2002:a05:6a20:4304:b0:3bf:a543:e7f5 with SMTP id adf61e73a8af0-3c0bce1eb1bmr11867023637.3.1783656695407;
        Thu, 09 Jul 2026 21:11:35 -0700 (PDT)
Received: from [10.92.212.146] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659fa13bsm34378016c88.15.2026.07.09.21.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2026 21:11:34 -0700 (PDT)
Message-ID: <0e52adba-dff2-4cc3-a13b-758c8d92e60e@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 09:41:26 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] spi: qcom-geni: Fix missing error check on
 pm_runtime_get_sync()
To: Mark Brown <broonie@kernel.org>
Cc: Dilip Kota <dkota@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>, bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Douglas Anderson
 <dianders@chromium.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev
References: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-0-92feb5a7b926@oss.qualcomm.com>
 <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-2-92feb5a7b926@oss.qualcomm.com>
 <2fe34b3c-11cf-417e-9440-75a5d6e3f4d7@sirena.org.uk>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <2fe34b3c-11cf-417e-9440-75a5d6e3f4d7@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XOYAjwhE c=1 sm=1 tr=0 ts=6a5070f8 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=BZ6NEH6zplJ_bYS8KZUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: QSbP0PQ57kYFghO5Ybim_KxLtcIkxnas
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDAzNCBTYWx0ZWRfX5tjzsoWRN9Ac
 vPlxmWl2dGWFj8m0ctrMy11ArbPGDB7o6VBc2o3f6LhSed9f1gAtM0A/1bfI1gwLqXQqnom4Qoh
 8gJLDbmMvLmqC8fFVgNGuOxxxWid9OA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDAzNCBTYWx0ZWRfX5/RZGI1KF328
 fl+kkh114GXBgIjg5xayN8BxijKRj5Rc/8vnc4FVt18ulImSrnpB3yad6cc7bE6LPJJmcOppi7y
 zhPgEShQX29Sl4gOpRhOoQFao3rEKkcMbCSyufvO2/xPFpTUhcT6a6bcWpnM4ooHaazHtV+At+I
 F3LSIPEBOsVuZfS4Hdep6n11Ng04zh1kZSExF9+sFJl9wRXi4i+I3hRl0lQmURtFaXz1+HU51dM
 A6Y79DbHE5Ok6wFfvwC0DOFqWHnFVAdXVuba4QHuYJK2DNxiD+i8oR2lbbvkOctpVRXDXEmi9y/
 gQAkLT9Dw8tZn58HHN3iQvTxu1U1zc2YgnLiTBAsHT48RJ8W1TmhXb0D8ldOcBN2qScbzOL9NJH
 Acxoysz3fC+8TZdMq2PXN4M3rDW9s8Qq6s2ASuDjH5JoYEYX2HFczfv2tX+6Gjx4PyebD7prOyH
 1Pq7dHQ4vxQByP3B1+A==
X-Proofpoint-ORIG-GUID: QSbP0PQ57kYFghO5Ybim_KxLtcIkxnas
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100034

Hi Mark,

On 09-07-2026 23:59, Mark Brown wrote:
> On Mon, Jul 06, 2026 at 02:23:10PM +0530, Praveen Talari wrote:
>> spi_geni_init() calls pm_runtime_get_sync() to power up the device
>> before accessing hardware registers, but never checks the return value.
>> @@ -693,10 +698,7 @@ static int spi_geni_init(struct spi_geni_master *mas)
>>   		writel(spi_tx_cfg, se->base + SE_SPI_TRANS_CFG);
>>   	}
>>   
>> -out_pm:
>> -	pm_runtime_put(mas->dev);
>>   	return ret;
>> -}
>>   
>>   static unsigned int geni_byte_per_fifo_word(struct spi_geni_master *mas)
> The above breaks the build due to removing the closing brace for the
> function:
Its my bad. It appears this was inadvertently removed in v3, although 
there were no issues up to v2.

Please let me know if you can add it while picking up this change, or if 
you would prefer that I send a v4 with the update included.

[PATCH v2 2/2] spi: qcom-geni: Fix missing error check on 
pm_runtime_get_sync() - Praveen Talari


Thanks,

Praveen Talari

>
> /build/stage/linux/drivers/spi/spi-geni-qcom.c: In function ‘spi_geni_init’:
> /build/stage/linux/drivers/spi/spi-geni-qcom.c:712:21: error: invalid storage class for function ‘geni_byte_per_fifo_word’
>    712 | static unsigned int geni_byte_per_fifo_word(struct spi_geni_master *mas)
>        |                     ^~~~~~~~~~~~~~~~~~~~~~~
> /build/stage/linux/drivers/spi/spi-geni-qcom.c:726:13: error: invalid storage class for function ‘geni_spi_handle_tx’
>    726 | static bool geni_spi_handle_tx(struct spi_geni_master *mas)
>        |             ^~~~~~~~~~~~~~~~~~
> /build/stage/linux/drivers/spi/spi-geni-qcom.c:764:13: error: invalid storage class for function ‘geni_spi_handle_rx’
>    764 | static void geni_spi_handle_rx(struct spi_geni_master *mas)
>        |             ^~~~~~~~~~~~~~~~~~
> /build/stage/linux/drivers/spi/spi-geni-qcom.c:808:12: error: invalid storage class for function ‘setup_se_xfer’
>    808 | static int setup_se_xfer(struct spi_transfer *xfer,
>
> and so on.
