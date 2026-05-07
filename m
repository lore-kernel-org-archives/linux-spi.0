Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0AC4317D
	for <linux-spi@vger.kernel.org>; Thu,  7 May 2026 03:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778124538; cv=none; b=LNfr8nk3+5edyoq8vfHtH1E4XvIfdH/dCX2ixt0qqRm//jDpgMthj17xjb5BLOJ/n9BlD12dZg0CQBBdu9mqnr8UZMzN3cXf3CoaBfguh8buSmYtQI0+MLm1xFVMeqD2NXyq55ogSbU+6fjgJPcjL3Io06A/LHVQw8MX9yIlGtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778124538; c=relaxed/simple;
	bh=gi2ObkCraQrs04SQ8ny/M/6gQkScLLeAkIE525W0jVc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lB8feH7gIqGgrn+N63X7cvzzo3QJy/DPChtaDNOek65zays6UiwHSfIleAaZnTkavGILg/1bPxYiNZsxH/LUl4Su4g+ToLS/TszuMJgr/ACXvZSUHvOAjqWGBBXrCUPLDZsBIO3l4Wx0EEUer6vTWKuCL11aDvbmNxVNLqQ5o+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FBga6zSa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fWqAuJrx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FBga6zSa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fWqAuJrx"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6472ZSXL1953101
	for <linux-spi@vger.kernel.org>; Thu, 7 May 2026 03:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3gqWZYqm+m8nGCsJyj2+TkIzkgEHJKGfXdeU5g5E6Bw=; b=FBga6zSadj7d/WdR
	2qYBsk60KzIOx9MCi7xA/m62yLD1w+T+Uw1UxbwYj7MS0q90ie+/sJs9xO+83SLi
	iIEY+Xo8b7eT2Jx0yltelgMBa5ni+zSaVD1sQvel+i7oXvV/GqbgY2l4bZ9krtgO
	2lDrl+uOZbI7FppHdnhEi3dO7FkdqYsJHF95GOF1zvVyhrydPSXK0z0H1WUNOilD
	Zl5i1+NvF4CAlnoOwmdvaWb3QTmzjAU8hCB6wesRoPvnG1foIVr8x4RnV5yIl7Oo
	CoAqDsaQcfqYxPL/dkngQRV0DaeJSpizvLYgErMS6ZZUlLQlBqI9++FUym9VXSin
	DjYonw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e03jc3dwe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 07 May 2026 03:28:56 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-2f5943ca81aso1535897eec.0
        for <linux-spi@vger.kernel.org>; Wed, 06 May 2026 20:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778124536; x=1778729336; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3gqWZYqm+m8nGCsJyj2+TkIzkgEHJKGfXdeU5g5E6Bw=;
        b=fWqAuJrxaIff0+TfXSgGXkYmkX4IqCwFY5/jIp/bCsx6vAdfsYI2dqLysBaRfhVEVI
         +tc/hooq4HoBdiVKO5tU0Z+l7oPvx6WgkHyyrR2SGxLw/7u0dAeEjL1LkmzYo7QfzMcp
         pQhr2QPPnCbbI6Toz2/ZMYLSQxK7TSNGq5SrUFAV2gU7GSkT7lr/54GSPzJuRtKI4E2H
         Ua+C1vHtbYKWWWiuKvJeLX+KiorShj7iOryMK53xibnz5pJznjsMnMMvtQ+//ADq3S8W
         HqgltY3922jQVNfqbbISHF1NoqlJ/zHpHfpufF+3OydA+cBBA0wOeAuj0fhfietjrHFM
         z5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778124536; x=1778729336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3gqWZYqm+m8nGCsJyj2+TkIzkgEHJKGfXdeU5g5E6Bw=;
        b=NXAK9yB2NfTm1fg8WGoSUrUTRZ3nWaM6yjO/rJCRtXiOkDDQNCfMUvzy9NQpdETvzA
         X3NA91d6VD3cztIIFmCCYcinYjobCD+2cPNmiQplmn/F1Gh6niw9aeITNyIImVAdpHVA
         +dIx4gveSlinkb//kEnViFK8km0YF1ETT3LazfqhJkevZso9wyf1wrp0jGgJ7I1CNh99
         fHNzBrfI2XRpkJn0pwVsmljw0gZZIC2LZvlBLLy97gOEDGoYMrErNTACYA0270tnw7fX
         niZ1mAecWDMbtFhReGvubH59N2UF0UX/rgo7uHixIWmQ0oAy6a5njWAh8QBDWjf46hmB
         x5bw==
X-Forwarded-Encrypted: i=1; AFNElJ+ov3IyAipHrY1gnpefuqHPW5KlE6SS2za9P5vpxqbokjgplz6M+yNR7r/k+lfJfvm6swi8KSzJlDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2oCEMxST2CKgdMTjx6849xWRr+5Ly5R6byNq5z2zWIdzkKeac
	jh051QmaU6Cdppzu9emnwzsR/GBxgMAnxHrsJO4IfvmBr57fbJ9RVcTuf6nQHArXrAW7o4j6CJD
	Vx8Pk6uMAVhuRAei/7ywsoeaKQ5my5n0Go+JgScuznaorSAnC8Ils3yf4Z64N8IU=
X-Gm-Gg: AeBDietCf9hiRwxdS5bDDs+mUq4h55+kWohUMCw4rU+XL7dKu1/I4TOLiA1/mVS/jK5
	1+gbNU+t5uE8fK1cJUzbxc2GE+BQrQNIFyfgfd4Xhs8rcK8rsQPU78hjqArbce0a+arCjED48B7
	qppUrKrDzKWfCQxj2K4xJaIdWBJOPXN/6Xnb/BaUnItkisHotbxl8Kf+j9u5UOdvMgHuJzvnoDd
	41GMv0Gqi8E9uYRWR1o8Xg0rb15nxJ32DBLY7Cgvgin7jmYhttQ2Pe6ImBtJ2FgGeNjwUUMXeab
	vpFJXF8KKhexrnf5jqYJD8VnGEgbR99sQ1YkcPNfUdIJZPmjtKFix85i2IUaFgRtuRz3Jsb1Rqe
	/CS6uzKrgaWK607vzvgswwxOXH5968EgcrMoD+dDRHGKNryPjpjAV6r/WHPWC70Y=
X-Received: by 2002:a05:7300:cc90:b0:2ed:6f94:9d94 with SMTP id 5a478bee46e88-2f549f5f684mr1839112eec.19.1778124536028;
        Wed, 06 May 2026 20:28:56 -0700 (PDT)
X-Received: by 2002:a05:7300:cc90:b0:2ed:6f94:9d94 with SMTP id 5a478bee46e88-2f549f5f684mr1839097eec.19.1778124535413;
        Wed, 06 May 2026 20:28:55 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56fd8fa8csm5660643eec.21.2026.05.06.20.28.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 20:28:54 -0700 (PDT)
Message-ID: <3ab480af-247f-498f-95f4-ab17526876a5@oss.qualcomm.com>
Date: Thu, 7 May 2026 08:58:49 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] spi: qcom-geni: Add trace events for Qualcomm GENI
 SPI driver
To: Mark Brown <broonie@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        MukeshKumarSavaliyamukesh.savaliya@oss.qualcomm.com,
        AniketRandiveaniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260506-add-tracepoints-for-qcom-geni-spi-v1-0-c957cfe712d1@oss.qualcomm.com>
 <20260506-add-tracepoints-for-qcom-geni-spi-v1-2-c957cfe712d1@oss.qualcomm.com>
 <afvltFJzKLaO9weP@sirena.co.uk>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <afvltFJzKLaO9weP@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDAzMCBTYWx0ZWRfX2DSlaDRKVMFK
 CTzH8nXnHfJLG0sBNuv7wP90BUkuI36PHTxZhseStJqNOurNx5eAWKGuElcI86DLTN89Z5ivryh
 WkFdggXvOmKvVhtxaoilnSlEXD4KXus9yzLI/zZwmaXx4gNUCKuG0zyuxa5DoMYob2S5PRiA3IN
 6o3zitQJA4OisBFzlN37lTAAvu3uO9WAkrhny5ntg9uJvFQXDILKHxrjdYH3XjjisZs1WzTE4Kj
 tPZJDK0b8kmrTdRXz90mhZAkI11y/MwCSlyaGGgc9XxYmyEu/zNSXTbuii97bdfDY/O3L/t1rug
 pLCSivdU8rfjj1jxbwtz15WZhLsDYQTLDTPmtlVL/oSAmoGYPZMrLcy/k//xwVyPUXCSzLU9GTd
 ZXtz4kkXZYNEkXtQBdJMrfv533fOharr9xPI8+nhTR3WK/3TMujgZtSIBmURInU6MRtgtURb55M
 xHwh3gB7CbVKtDBylLQ==
X-Proofpoint-ORIG-GUID: 7Y7HGeE_ZrIOlEl1wLe1TsAN2AvjEKpr
X-Proofpoint-GUID: 7Y7HGeE_ZrIOlEl1wLe1TsAN2AvjEKpr
X-Authority-Analysis: v=2.4 cv=EpHiaycA c=1 sm=1 tr=0 ts=69fc06f8 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=1VmPbvypwqz_8yqDh7oA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070030

Hi Mark,

On 07-05-2026 06:37, Mark Brown wrote:
> On Wed, May 06, 2026 at 10:59:43PM +0530, Praveen Talari wrote:
>
>> @@ -717,6 +726,7 @@ static bool geni_spi_handle_tx(struct spi_geni_master *mas)
>>   		max_bytes = mas->tx_rem_bytes;
>>   
>>   	tx_buf = mas->cur_xfer->tx_buf + mas->cur_xfer->len - mas->tx_rem_bytes;
>> +
>>   	while (i < max_bytes) {
>>   		unsigned int j;
>>   		unsigned int bytes_to_write;
> Unrelated whitespace change.

oh its my bad. will fix in next patch set.


Thanks,

Praveen Talari

