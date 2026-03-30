Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E8B33CE92
	for <linux-spi@vger.kernel.org>; Mon, 30 Mar 2026 04:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774845805; cv=none; b=Dx8Qjj/m2o8NTCSJDTL9iJHqTLjj4LKR5NwZRMGnV1NyPKXFDISLG4nZ+JJTT9cvT8EY4IPHWZ+ceWpnmeFdeKUUru93PejwFsehcINsyDum+gr3nyzXyeovuzqugqDusIX+/E9dhbLnOzqTmKORVF+hT5QltM+ofp1DcDUu/nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774845805; c=relaxed/simple;
	bh=9WVzykcacsq22c50jNF208X+qoM9j8ADPetre1D+Iys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FXvmHeCsAFMSgAzLdS7PK/J2gneJVjhY/RUMY5LOtEXuVs99bvzc9ZormFLxAnufRwjNkfZ60EFemTTHaEI02Hy/pUPdy+YDQRD5Pdb1yibyyfOP7cQEh9+8crzxiynAzuZTUR9uBW6EAOEB5jlAAXG4c/uiu+XrfFKlC98w+PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DafHZeIn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NAb7WEGz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DafHZeIn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NAb7WEGz"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62U4cs0B4086214
	for <linux-spi@vger.kernel.org>; Mon, 30 Mar 2026 04:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eNczafUMsUWBgDmDWTP3kexVfHM3mf6OxUQJ6oZLC4I=; b=DafHZeInPcGt2fbd
	JhQK+So+maBhaBc7F3bYLKKZ7wepGrRZbmq2a7Bw+lCU9xEnOa8nzpP6vtqI+y96
	+aQt5oO03Q3RgAn4jCFuTHM+SLSSvunir4UJz7lt+rkshAwFqzIt2oY1XEJj0nZD
	mvsp20bMGZr8TR3WmyxoK/87kt2LnDWWpPfe3KxSQ4xX1U1iCKK9w0PhtuZJ/+8I
	Ghh96bpOb93Qfd0TxlyvXYCWgskX0EgLbDcjP6HY3pJU/2h26UQMdXJLONpSp4Oc
	imp2GLRfISRb2QkNZOyBzM81YocSeVzl9MYtUSraE/wScFHoVJLSOSz5MMavUs6P
	YG3EoQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d67714dh5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 30 Mar 2026 04:43:23 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-82a6906e35fso5786946b3a.0
        for <linux-spi@vger.kernel.org>; Sun, 29 Mar 2026 21:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774845803; x=1775450603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eNczafUMsUWBgDmDWTP3kexVfHM3mf6OxUQJ6oZLC4I=;
        b=NAb7WEGzRrjBmx7lOyqlgxttguhd39M3vqaWyA6C7HbRwnPxVipH5sisvY4KQR316Y
         MHxdRFte5SXDxU6opLRr9P9YsT61jo1IGS8SmK19wB7YH+HvORegDPqaJNf38T1sG6Sr
         zP4ueQ7yeaGT+mHTSQNi2S8SlLkHrV8A+QlbP9GLSLDIklRbKTK+Ze2jxalm/mHrhKsq
         3L2KqTG2XxKCzieT/0PzPKvLYkIO0Lk8P9Qd0LCTbfrY/6S96HXARwa4C5YlYPUMYU6A
         U125x335oef9wcgfMb6suGA2wYqjH87IjcAi7e1hd84kk8HH3y+SXRQnJ9j9gmswEKUn
         Xgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774845803; x=1775450603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNczafUMsUWBgDmDWTP3kexVfHM3mf6OxUQJ6oZLC4I=;
        b=QPLPcVgzpZ+cEfwayM4uHz4sq6Aa5AJsD5nfyQUU/tJpICOCmgEX5ZCxx4sMU7NEVR
         H/a8P66OoL4DJtlR7rHv8tp5lRuEI2Ujihsn9xzJgKbxspPqomrYhswipROMLepDumBx
         nXNloJWOB7XK8hzp7gAvFUJ4oCaoLGebPm6oFBrdmpuGBDhRT7QHg17XScDqwLwCc6qu
         TzQzPxdzRNUI+Nhbx/d1XEef+HV2tHpwWS564XOtAzZrFMQxAg1K1lKG1Xp2MHdEYOSK
         Vp/2LZsSBnviVzUh0+lMZBglp1HIc5SPgexuLCajfhRlKkeIvVqN4Y2Ry9BvVB+kj9Uq
         FEGA==
X-Forwarded-Encrypted: i=1; AJvYcCWq0C0If7dEWasjukYPk9cyCuxLQCbqw7Q9CbO4+lpIsgmX9Ek8GmmTdHFnZjNvVFAIvooFvcGKj/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlKJrY5PNDNoGVKAdMs4noCoclEkHnF0o2vfNel6LfZM8tO/Qh
	u8gdNTzMgMcWu+wHJvfhKswYaQ6fHLpEz7Jrizsz16wzV8bU5huEquNztnIWKro0lPf7gK0xeb2
	k7CXUW1DKDkEmC9QmLlHEDm9scDiXxFt3TZ9ypxgPjXdsWRJ7uAumyqioWWwdsUk=
X-Gm-Gg: ATEYQzznMIM2quetUB4EJoW4WIzW9+q1QHK6Mkdl4ytViJWs70RmzMHvt/okNin5Fz4
	YjF9WpPBem32yY9ZMd4TEogPQ/DSowWOHhBgnW/Reqj+IEUI7JJiO+Byrx5in+4H5dUdkrlgBka
	0uw8ZBf//XKwcLSKcyqFwfx80SaogE8jSR2WLDy/OCMe3HX75ioTQw14j2xpGmylwsidyxY2jCa
	rQE4cqOVAa6zTeDN0HIFdHSJ52DiED0M+xCTbwnZ+8/EdOh1KQbM1TM5dgLioW8L4buYFD9B/BV
	sRhfQGicKHPUfAx3Wza9i+v682BbvPR3m+GQAqOAxmLULJYsjFREiEL26mYK6hPt2jODhWhXNot
	Pvf4UUZ9pUPGO79snXCnme9wQYbgHiEi4dvItScgoBe4YEN3T8qAjJg==
X-Received: by 2002:a05:6a00:cd4:b0:82c:6d2b:7c53 with SMTP id d2e1a72fcca58-82c869c2554mr11585227b3a.19.1774845802696;
        Sun, 29 Mar 2026 21:43:22 -0700 (PDT)
X-Received: by 2002:a05:6a00:cd4:b0:82c:6d2b:7c53 with SMTP id d2e1a72fcca58-82c869c2554mr11585200b3a.19.1774845802153;
        Sun, 29 Mar 2026 21:43:22 -0700 (PDT)
Received: from [10.218.4.221] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82caa8be173sm5310354b3a.55.2026.03.29.21.43.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2026 21:43:21 -0700 (PDT)
Message-ID: <721b870f-400c-40dc-b33f-0241252ca886@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 10:13:17 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/6] spi: spi-qcom-qspi: Add interconnect support for
 memory path
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260324-spi-nor-v1-0-3efe59c1c119@oss.qualcomm.com>
 <20260324-spi-nor-v1-2-3efe59c1c119@oss.qualcomm.com>
 <92c58ea3-5492-4de9-bcf7-d4a419480002@sirena.org.uk>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <92c58ea3-5492-4de9-bcf7-d4a419480002@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: Q8VRokjd69JrtDvc9LexdIlo9nTUF4fa
X-Authority-Analysis: v=2.4 cv=efYwvrEH c=1 sm=1 tr=0 ts=69c9ff6b cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=N23bROnFMMGRNAIHwXUA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: Q8VRokjd69JrtDvc9LexdIlo9nTUF4fa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDAzMyBTYWx0ZWRfX+NSqHe1jjWxI
 /ihaKtuuNZ5X5W8cXUBfX475zIc4vdchbtckQR3tNZz9hPQNLP3+1gSV02/h700v1EwhMDe8zVg
 VD/5zV98zCHRmS0GTy7f23ScyfWE/voxkWcVfoInC1FpjzsTMPhMLEIlsm+5xoyBHl2uQix1PgL
 fEuRVnAP+hLqr4qO1oDaNSEUI+TuB0D9pTQLB6oNFvPempj5Wyt5trQw7uqAbk9gXnWH2eUu3mr
 p1Uwaas51a4HChuSkr1wxaH7RCihjHbQJR/0DxWrwM5tG/fPtmKCfbHO62XpFntji52tv6erWJz
 MrUCyFxm0l3nZhT2Kl2GrYl7JCQx52OB2WZ/nebZRzscGqoHAbfiEy1UHLBpPGYfIciZuBv0xQZ
 0QOuEa5VtTH7pm8M1jD+Cxg7G7com8hBNxVPeGot3qTIsyyacmkXSA730eXm5CcI7W0mqwgWf5S
 Zr8VKroUWa1SX0TN0GA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300033



On 3/24/2026 9:54 PM, Mark Brown wrote:
> On Tue, Mar 24, 2026 at 06:43:19PM +0530, Viken Dadhaniya wrote:
> 
>> @@ -829,6 +842,13 @@ static int __maybe_unused qcom_qspi_runtime_suspend(struct device *dev)
>>  		return ret;
>>  	}
>>  
>> +	ret = icc_disable(ctrl->icc_path_mem);
>> +	if (ret) {
>> +		dev_err_ratelimited(ctrl->dev, "ICC disable failed for memory: %d\n", ret);
>> +		icc_enable(ctrl->icc_path_cpu_to_qspi);
>> +		return ret;
>> +	}
>> +
> 
> This reenables the ICC but not the clocks on error (which is a
> preexisting bug with the error handling if the other ICC fails but
> still...).

I will add proper error handling in the runtime PM path in v2.
