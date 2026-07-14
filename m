Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8693D36F428
	for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784043266; cv=none; b=ZZSSGXUMPlDvReBrRz7nsfsMl7SHcAqKdsedQ7++RYPmv47FhOb3EaKS715dpirDY5LpRKvYauupzGVAaLMoiGlXSLrIa0QFefNymgeDQoANGWI6HF0dCvESKlXin/R7OVA8H6FFREb0KJeP1dYbjnlgY095Hn3IXjJH393af4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784043266; c=relaxed/simple;
	bh=0r0JNOoHNbWlCuhfm9OucnKnlLuGPVOqCDsXMshhENo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IEGbC1FtEenJBnG6gl52r016svDgC5RR51JpqwBkelgNoDOjJYbbsRyRQShG28GXXh1AjttZRVvMs62CnPrJ6JFiLyBryUL67b56Cgo7DjLl/W5OmSLy4DEvo9fgwCkfOQOph2/ZpsFjEHscF1t0DE2eu3lR5MRx0M4w6ojex24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SSF8tryj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WJBI5x/t; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SSF8tryj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WJBI5x/t"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66EEcWNs674502
	for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 15:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zGpsLT9I5vT3mdvWKpIvDp+nCgXQYoSoxh3a19izebI=; b=SSF8tryjkwNsNHT9
	AvLvTW/kq2G9Nogm8hgny+FvxnXjygS8UdCUzfwVlVWV3gu2cGzV/pC/r+m8wJGR
	mtjs9qPoVpuWymGecs6xTTznOqaVUvr/cy5eSW3YOiyBlgccqnvHfk/wTDL8qhps
	C1oc/dIHdWOmZ2AOwZy1PBXUsIe1Ab6hFryzwkqJdZaRY1sZCmoop+lifHlXGyxn
	LqYhrm9a6aLTlaikQaohYeyQqxZqLyVf1y7o58A8eCg4Hlys9YYyb4zrtsagkDN7
	f3Isz3StRIg8bd3sGZMrlMvjTytMvs5LiTM5MRVMKGucesQMZd25Nd/bE5j9wPpj
	BOULKA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdnp0gnnh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 15:34:24 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c8952346bb9so3773220a12.2
        for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 08:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784043264; x=1784648064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zGpsLT9I5vT3mdvWKpIvDp+nCgXQYoSoxh3a19izebI=;
        b=WJBI5x/tAQ6XOaJncBQnDzLikSi/BQ8BVG1BnwCB+yY11v1rBccAPlHcucwVL8m2VS
         sAfbEtM5R0+XizcI6p7V2hyOOXvurje4ffesH9+R0Vtbql1YRyBlaPkZ2VocAA1vhZmU
         7ENWQUIuSQCAWyb+oXExXVeeHL3nbzSH5SOe9ozgS6XZwJoiOd4M78j49gRDyn96+HWT
         2HLgVra+DEth8kye2vOUrXMwTSzsOIwshGN1uA8m4w07J0WzQ7X4aDZPe7Mz5K0Amizq
         UvAprJjXobOzzaWTVwOHK+CFNs7zrDl+75vcm+/3TZvyYu/qyp9pT7XYul3L/eT5r8SA
         qqQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784043264; x=1784648064;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zGpsLT9I5vT3mdvWKpIvDp+nCgXQYoSoxh3a19izebI=;
        b=P8LF7bJQuyJlbZvDW+QUL3rKoKjwSwL4BejeO3N0xahNfhGFHKtoAlwZBJYB9I1osH
         UjUG5ePQjGX+C0rHFjQ3XGHaY78NKPF/f+erCbfqLO4f/IfWK7i4PO4hMAm51XQmvlOP
         b7kbayUz6xcMsCxHNo1KH3xZmc2wDVU7K/dxT655Wv320MOLvqvKvCpsP6nitkHmEPH+
         kx3pAqFvQ5H37GrQWKCg5ANJ69+sPD01miX8yyVU8bttFD3hGAgxEavG1I6PeTKpp1r7
         tUFdElt1herVEFO+7/bS3zJhmjicD27Wz7tBlGSv2qh2SStddnW30KJHHyicMiYyvFCY
         oVTg==
X-Forwarded-Encrypted: i=1; AHgh+RoGXOG0xMDJMlQUcsL1IIqcU0m3iVTzegBL7ZmQFtZXS96XjN/a24iQ4CDZPdqpUjkzhzcMmkPh1Eo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg5CAFzDl5dL/SDC80eBlC4VowIAPOKNXQjEg59neCF+pEQDmV
	xAREVpHFzbthsw8CkTM0B7Z7a+2No0VfkN0YTDIKPlfBbzqjlapUyVcEUL5IB13/iP9IMxtrIvQ
	Ul7KQlqGBZNX93wnkCjpjW1H4XlBoXlcg0TbjBRlz+A1rlfQpVQkkYZQSaCCrvBk=
X-Gm-Gg: AfdE7ckBdXD+jhOi3Tdl9/kC51c1B3eN7G5MeZk89Qy/yMjNMYxUMrfbFjalG3WKtFH
	t4hXbcvAXozB6KjX2mx4o/LfLve9oZsgd41jrH3XYZNUvHqpb988EAM2NAM/o7qK0cXnq9C3w1V
	11cLYuV2zczLCHAPLKwrgc0+Z55ksRw+ZGxyPosLD3GbDUCd5QW3giLhxaQ5eZwfF3K1RzVnq1G
	DTYZCroqk6hb0AUySf2CDyxHv65MPIkvF1EJjeY3Wls0EMssJ7978mGgIHb0V4dtKggYWkbZbUK
	ehfgtQmbtSt6TMxwsWoCxCgaz3JUjnTMUXCPDIhYifwGYXvuGaVP48GYP4o+xW63YPj+/JI7Ww5
	KOT7kn3MhViOHtvv+6QRFuPHMUkBjoEPThJ7uif0vGQ==
X-Received: by 2002:a05:6a21:b8d:b0:3c0:9c19:659a with SMTP id adf61e73a8af0-3c110b7b9f2mr15857535637.66.1784043264028;
        Tue, 14 Jul 2026 08:34:24 -0700 (PDT)
X-Received: by 2002:a05:6a21:b8d:b0:3c0:9c19:659a with SMTP id adf61e73a8af0-3c110b7b9f2mr15857483637.66.1784043263511;
        Tue, 14 Jul 2026 08:34:23 -0700 (PDT)
Received: from [192.168.0.5] ([49.204.105.43])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6091dsm98267315eec.14.2026.07.14.08.34.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 08:34:22 -0700 (PDT)
Message-ID: <ec43ecce-9029-4d52-b8e2-f634840eba11@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 21:04:17 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] spi: qcom-geni: add GENI SE registers trace event
 on error paths
To: Mark Brown <broonie@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Steven Rostedt
 <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20260711-add-tracepoints-for-se-reg-dump-v2-0-ca1e9ba62359@oss.qualcomm.com>
 <20260711-add-tracepoints-for-se-reg-dump-v2-2-ca1e9ba62359@oss.qualcomm.com>
 <cc4797fa-6911-45a3-8775-69c2ef32a338@sirena.org.uk>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <cc4797fa-6911-45a3-8775-69c2ef32a338@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE2MiBTYWx0ZWRfX/0sVGkT7Xunr
 M3k3SYxuPNIuDMRxNwO3s0fG6gUM0eilKIpT44c/hou8BRIqf1CWvpYN8b21UH87sr9fih/0YMy
 l3LW7tXc6qwds4S6qQYk+amy7jW7gdk=
X-Proofpoint-GUID: Fidj8FCLc-BA6u5E1Hqu7iFDZw1ikkhY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE2MiBTYWx0ZWRfX8J2GD8yP/hQl
 InGj43DiryQUU5w77BJSmgDEvWHgoFrUwJ1y2oA3ZJrl24hRnhhceeKcQ20bCDwP9TYuubtwZGH
 +hZvd1dex7+OZ+4A6typ584XRZ2UZaUwmzB8E/7clOvi6tzN4AfvWXrCGNkyv4jDVtedu+15QiS
 EYrDnSMNPFVXJWAigBb0trsXxm9rHJFjhWaCys9W1pT7PO/kNVDKstQUSSUbFT1mCfuRWaJVguq
 YKvTaX0+THcuMoemC3PNcwumTEGWZwdcJaalt91zvC2HAAy58irlD46nzSOoLBZgIc8YCPAtuxL
 p1Xwvo4m4NB5/OZCZf5C6n6YgePBAh9VNyzm7tJZsNIxSArv6pCUv7blqCZkXuWpJxZgcsxfgzj
 7judfpx3jU47iZRCGJgU/om+CwAgtoOFjKC2x/81/0DvJnFS3lDBNNtZvIY896vDjffpt2E1uvh
 QXXCnVc0kV4hbNU1l2g==
X-Authority-Analysis: v=2.4 cv=FtM1OWrq c=1 sm=1 tr=0 ts=6a565700 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ua2K4HyBCek8nw/sr3ra2Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=o-iBtrM1MSidxli5CHcA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: Fidj8FCLc-BA6u5E1Hqu7iFDZw1ikkhY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_03,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140162

Hi Mark,

On 11-07-2026 02:56, Mark Brown wrote:
> On Sat, Jul 11, 2026 at 12:18:42AM +0530, Praveen Talari wrote:
>
>> The GENI SPI driver reports various transfer failures such as command
>> timeouts, DMA reset timeouts, DMA transaction errors, and unexpected
>> interrupt conditions. However, diagnosing the root cause of these
>> failures is difficult as the hardware state is not captured when the
>> error occurs.
>> +#include <trace/events/qcom_geni_se.h>
> Should this be in rivers/soc/qcom/qcom-geni-se.c (and the first patch?)
> - that way if another driver starts using them we won't multiply define
> the tracepoints.
>
>> @@ -986,10 +997,13 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
>>   					writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
>>   					dev_err(mas->dev, "Premature done. tx_rem = %d bpw%d\n",
>>   						mas->tx_rem_bytes, mas->cur_bits_per_word);
>> +					trace_geni_se_regs(se);
> SE_GENI_TX_WATERMARK_REG is one of the registers in the tracepoint,
> perhaps trace before we write to clear it?

I got you now.

Yes you are correct, its better trace before clearing it.
Will update in next patch.

Thanks,

Praveen Talari

