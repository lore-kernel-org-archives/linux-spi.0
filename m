Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C382D9780
	for <linux-spi@vger.kernel.org>; Mon, 15 Jun 2026 04:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781496500; cv=none; b=LUAIT3OO2UKcBgdBe0WQHxkychvp6sxXCeoUbwCtsPSO+/olH8nM/t3diLuo+Xa7W9ag1c4cmIJ7eCn9GKFEyLt5Rg7T4A4JUkpkZcfCXv0Ua2whYIktLDg8BD6CIecM5AHZiTzW6SKmkZ+NhY6TS+VhsL56Ad73Nl5NeAGMC0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781496500; c=relaxed/simple;
	bh=wgSyVO0iIUWYE87p1E6tP9DPgnR1SJcFx3srHn++h/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLFqPP0vGKZGALZnIuCY9fnFmfjbhWd+6q1oL7UL/XsSgtWMM+BbJdoE0F3uZmYl6VSoCPtwuBLb+MS/cxQRCPbmKUR/Buzxec3Dxoks3clA8D9ZB20kwWqBhBCVPYSyf3VGNc208dcqEdt9yENN6PWqbJGPw8Po9Ma9nCiOU0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=C2BE0zoP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B/6GegSu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="C2BE0zoP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B/6GegSu"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F1i2sb2727896
	for <linux-spi@vger.kernel.org>; Mon, 15 Jun 2026 04:08:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0p0MLtTlWKVebvI15ppDtod3gdrxS+s7urCWzK/2WKM=; b=C2BE0zoP8MWDEFHB
	53blho8FUzbbLHQWDG+xvyYaTwwBnRl+W7DTbswzcMzHu1On38a85VmKA8nphGiD
	j8FH86JQ7C4x8F0/qLziyiyWkQcTF/eXigfGhOWx5IIgwc8LC2a1UG2E/u9bOOKV
	h1sxXVsdk8Fgl3vXhiQe44JksSnt4jQ233EOV0t+cg1Emp0iJA4cHOVHe0oJ5lbf
	aKVkXs+ELB6mzvBHRdQwWegjtHzksBExvQaTLArhRAWLb8Dka2gABB7wYZ4kEeeV
	/raoq07b/xheeM1EX2+vNYuRJeobIxKwWY8Ckdc1ldAf1j201tfRTjSsrT+mrkxi
	IpzuXQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4erye15fgj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 15 Jun 2026 04:08:18 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-137fe4a3640so4256680c88.0
        for <linux-spi@vger.kernel.org>; Sun, 14 Jun 2026 21:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781496498; x=1782101298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0p0MLtTlWKVebvI15ppDtod3gdrxS+s7urCWzK/2WKM=;
        b=B/6GegSubAZ8VBPUuqBkBrt8yXLm07B8s6KpwwbELmycLB7NNr68VbVYjh4Kc1zaW1
         BaLP7x4xsV7E3fzfiCC2MV3ZXItN1tVPro0ZJ2OAYYCzijDDlHAcuWfiMUlg+MrlooJg
         WLMH91Ksb8RIMmRt0xtsKKDgT36GvmHwcWuPYkhdYsDpwnrvPFba4TR3gSOffRwRryft
         PKO9q+b5YpooeSkv2BYOiRtYVIV86+qlhs7fErJIVupqk6IbrWlQs+dnw/2WYGHtgNRV
         6QAkrN/FUizaISYzwjX6i74HIsHTssXgbQQ8HXtebVfbgV1s6/pJqRioHt2oZ5fSXKjD
         RBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781496498; x=1782101298;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0p0MLtTlWKVebvI15ppDtod3gdrxS+s7urCWzK/2WKM=;
        b=Bi/CiRYHtJiLAwcyJ9UwfI6/zKw6PQ3XSGcLsLoyslhuQKsVNr5E4042/8CXHmyeBc
         DaeIj8/07vGsDlDcuJkKBOLOyXqpOXeTlW3LGVZbdmJ4m8hXb+Q7XTt0zNHwx6Ycj2HS
         QK3uJosaZTxgJqLvGwTmZs4CORFHR+UpK8LDV7GE4QsBmstZklgliv5YM8LFvb0FRQOO
         YDGDNZHyc/zKg0wmwRtYovcPoCTew3pTRkLgHkRyMtQJa51yk5U3sOczCOmLr5AI8zV/
         UqkhTT47tuSsVv4Cc7XygJ/pSOAdCGvZt1jAkaSx8mRyevCiY/sRtWgT4z9esMQVoHmU
         CY1g==
X-Forwarded-Encrypted: i=1; AFNElJ/u+VL5a8cZ7FznlBRAWjXttv1Tbl7Bvf0jjAPwQPSfJfVmfuqvCuXQx4mwoSrnjD12BOMXaMFgFdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB6AkpJBC7SaWoFojNor1E9lPO0CoR8VdtKZYWjuXJAp/pGBQJ
	G8nvsjIthnbbdTUhyROekGxeXhqckQ7BFQw0V+kF13/sFFlQhxUDMnbNZjhv/BXOpDYLLiFN9G5
	cJga7qQKElFxG7dq3+uZpMzJAbnYCU9WMl+FCwGE2PPh8uI1ywjekcMpznuVFQhk=
X-Gm-Gg: Acq92OEZw/uO6DanwtVHNywgIrpE3ateitpYHrh7NQIhxyP5Fjrpjb/cfUaNU31aWad
	7dli6zGFKR63ta409ZIokE38IrhLSecoPKxtB+EvdjAUR87zY/1DbwSHQv6niV2FSDZNE9x65Ki
	zdNb4bub4t8qeVsKLF4B0VxySfX85Xg1MHv7wy9YypAW/Jh9X5h8bb4n2rmguhPZWQdDfnGzvQC
	bR6NnIYbXDDq6Ag0fBmlLt41MQvfifnZOiMS4Cr/DbdpzAKmOcA1Cg2UoK3jQOHPtU5+HFY+isM
	db2EFj1L6hTjWcprzWOe1TuACHX+BIC4DOCX4GJW+rZoen+0O4BGL0l67lu7hh7Y7XjK1MbI7BT
	uB+BJrR2ICsIr0AYG+HOkuqVlDcpu06ggn45vVtCXQj3psQlBn8dU
X-Received: by 2002:a05:7022:f9d:b0:138:177c:b971 with SMTP id a92af1059eb24-1384bb7fef1mr5255593c88.29.1781496497905;
        Sun, 14 Jun 2026 21:08:17 -0700 (PDT)
X-Received: by 2002:a05:7022:f9d:b0:138:177c:b971 with SMTP id a92af1059eb24-1384bb7fef1mr5255559c88.29.1781496497227;
        Sun, 14 Jun 2026 21:08:17 -0700 (PDT)
Received: from [192.168.0.5] ([49.204.108.63])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b97570asm8790480c88.12.2026.06.14.21.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2026 21:08:16 -0700 (PDT)
Message-ID: <f7391beb-bca5-416f-920d-cd9a1a9a4ca1@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 09:38:09 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] spi: qcom-geni: Use geni_se_resources_init() for
 resource initialization
To: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        bjorn.andersson@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mukesh.savaliya@oss.qualcomm.com,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com, chiluka.harish@oss.qualcomm.com
References: <20260604-enable-spi-on-sa8255p-v3-0-43984eac4c67@oss.qualcomm.com>
 <20260604-enable-spi-on-sa8255p-v3-2-43984eac4c67@oss.qualcomm.com>
 <aixBtqPq3MNgYOkk@sirena.co.uk>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <aixBtqPq3MNgYOkk@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 65VuMRwIe5NutdCsPBeBS8E2RYkpdtkp
X-Authority-Analysis: v=2.4 cv=MNlQXsZl c=1 sm=1 tr=0 ts=6a2f7ab2 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=CzlE4M4Y721Tu1n/tZ9MRw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=rXPX3GvGq0DlZHiU1VsA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA0MCBTYWx0ZWRfX1UcL6aGso9fh
 vx5h2m/6yeydyZHJ/TxehGFhHL1Th50zF1d3gwYLg8xIwSgUptfhu4rNbSS08M1jW2T3ttOzR2E
 q07RAhZeokGrWJ56DlSAgYIZPXG5X7c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA0MCBTYWx0ZWRfXzKCHmoHPzyJt
 lXwKpJrgVpMuz+rqJufRQmKvgjXB3+TM5SXoU78kV+FHdUhECOn+aE+BCLwJXz6iouTTNznwVOd
 p07URDVMO3v5KNTzqMh5I1htC4hLHBUGvAakFR2OVSPpTTUr+XsYZGRJMl91wI46raowvkF2uXb
 x+UdFZmnAsQzTtvuvqnR+/L4eSYaONisFCVEIzK2P+lk32Hbtu/UWGjjZ2gS/JMfs+MzXy0zbHf
 hqcrkw5FCc/WSaPlkbP1Gp0b6x+gEgJQ0zii6LUfa2KN/0slHq/FzDiCytN1MAuU8GP5Q5m6oJ4
 5HEEXGvMaXlqDpgMyEsroV5mAbB0S9b7pJ+PRetjjXidK/a6bb3PMz///xSirG9eAhbKV/HZLVz
 a1A3luyaE3cSHGkbXDC6aw6qWUQnsDnJJzzsaRBMZrfR/MlPPR/Uq94bWMBH1Qefrd3lyH37jLd
 89Xz0YME6QOhsr+EQUQ==
X-Proofpoint-ORIG-GUID: 65VuMRwIe5NutdCsPBeBS8E2RYkpdtkp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_01,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150040

HI Mark,

On 12-06-2026 22:58, Mark Brown wrote:
> On Thu, Jun 04, 2026 at 12:20:36PM +0530, Praveen Talari wrote:
>
>> -	ret = devm_pm_opp_set_clkname(&pdev->dev, "se");
>> +	ret = geni_se_resources_init(&mas->se);
>>   	if (ret)
>>   		return ret;
> Doesn't this still make qup-memory mandatory, breaking existing DTs that
> might not supply it?

No. "qup-memory" is optional only.

Ref
https://lore.kernel.org/all/20260227061544.1785978-2-praveen.talari@oss.qualcomm.com/


Thanks,

Praveen Talari

