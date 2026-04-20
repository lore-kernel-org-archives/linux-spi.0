Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2B52F531B
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776678510; cv=none; b=DiGfwXk25yV5dp9dFC8DcnJ9v2rCFxd41DOwh02lf/uTW0QrPLNkG0N2dsQhupzV6V0GxccFYShYOGV2tBAhjxs6NBsUeTazfzWiUNGseE5sEohjrg1zEoihrV1XqXmTqGXkQZBD0tt9nhKIZoc/XlnL9C5DhVDytAJb7MoafY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776678510; c=relaxed/simple;
	bh=Y0VZfMMDGtnkJYhGf+U9Z5MtZVR+mZz8AJlSieCPJKU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FSAzom4DA7FCbvWIuQtOHImJoskyfnW0D7BWlMG/HExBrqr/ZYHmsxkZpCwWLcdqmyENcquXBUpLMjQ1gNxY8HKseVN3nmQ87pce8qcOayuEikJU6X0WQW6AwzlivktfL4evmnYmwJ510OobT7d/xzTtUmBEGl3WHD4j+vsaddA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hj6QWsVK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Fro+B+lw; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hj6QWsVK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Fro+B+lw"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K79IVT1598349
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 09:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HQ8ZoOouZ4BrjvsYaJON/pwnwqOqCBNwUORSK1JbGIo=; b=Hj6QWsVKeOBMGENc
	UMoFGwqmbTMHVPx7dLpoz91xhUY7REEm6sigWQIlrafCi289JxodOTD37fDR+jk6
	/GTDDFxCHeLe0jbPvkpVV+OxVFzPoJQh4jjfVkJHuFDBaRzdd9wsL0EVW65E0XyZ
	epa2tJVxHMcEW2+uQTI6aHBSQ1Glu/5VudwfQUHWCEgqV2Wp5yCPOgR9EsAgnzlb
	VoW3adil/qfuqYjaXjnRYglP+gB2TAIKZRTjTI/Av8lRwnDmCsVaP20vu4q0yfQD
	ADU99l5zmmxSom83ltF8BAs4ySWgBrirkJSmYwwhpXaS0XqQH4gybB7fQjbro5Rb
	+VR6pQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnfgngw36-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 09:48:25 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50f1b94ac9dso1058621cf.1
        for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 02:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776678505; x=1777283305; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HQ8ZoOouZ4BrjvsYaJON/pwnwqOqCBNwUORSK1JbGIo=;
        b=Fro+B+lwlPtRqLoEYmwBJ9RjZxQ9xxpMEg2qFGn34dAc37oLLXkmUQvrl7gC55yiY2
         JCaCdkLXCQk2ad+BztW48iVN9CiBo+gN+HbBe1OmhTEmifr/o5oUjR3Bkj2k+fDigsjb
         JXrUxAZwlYRCfHqCaDtD2j8qIxZyMzo1mKabC+jFwezuk1RWdKs6d0XzVfpY+iIGvOH8
         Y/LOmj/Naxhp0L2hrw4JrGPO5ZIyJPjgvPMnzF2TlgTOT0kN6ykDeCyZK7vyhKFxqf7H
         SRk8HisblEHsC6cFU5AYQyWfbExi4YQMGjVX8MrAg+E7pRi3XuOq07YPpC662d5vjy2t
         miXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776678505; x=1777283305;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQ8ZoOouZ4BrjvsYaJON/pwnwqOqCBNwUORSK1JbGIo=;
        b=X0di5urjY1p2OaJ9aDObv1xFWtfqLmdVMS/8/hRP6cIEk8sVxmlN8lP/v8ewRctniG
         +4nnimSHSLpoM6jofpXpycgxDEYyQsr0/JfH3lTPEumKEl3w1n5VvfiutpfgUU/mucNm
         p22FM6/7fGjNzLQMcVUbHscKICBSrReetIPZm6SAtvz0pRXIFZy65OjO50nQwx1VEImV
         SbwHftPqHnEvpNpkV6JCxV5tzldgnV1qCZGzkovB7uQFEUrW4SdKKDdPwdMs6Y9OOZXA
         XUiMa5M8na2+ZrULd/cNQIJJmNAjtlBSrBKVEd/UEhWBp2Qne/8ly+/0aXwpiKmE27cT
         /7rQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Win9uavNqUcCyeNdDaL8LPeYJ8QfwFee1U6ya0470XF9AAjb2gs/R63YnWDYae1qHqcOu8rhD/lI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0xmG0r8Xit/gdwg1WaoEUZZ1a17xVaj3sGf4vppSO7Z2pRRFa
	UBaGeu4ZTOSRQwMZD8hyuWgEcVa5Js0zNL8EpTB2MYiY2vz8fVTHwYjbM3OEulOY0I6rBNKqIUq
	6Snk1zyrvEYZVXYTMZeLCLjI+Xhxdj23mJCjqc13Sd4Loqd/mTG4A23RQ7GMUKtM=
X-Gm-Gg: AeBDietVsbeKUuS183Thh1DF3uqgRXcZI/rRx2qebi2uOYsq9oZqJCCTCT0peaopOuK
	en4TsVt05ODm9FuJZ1jjNkhyB3vyvP0pgdrUvfLZiXhrZ4MUm/pb3MU054lT/gF/1b/dcbICT7f
	CV7VGdQqsmG0mnw0VgzHl3r+1ejCfcnhjbpzIWMYdk4Ou+uiqeNcu6FSdW//WoomJK1/yoM9jd3
	bgZTCJIrWvrUdSwEOUlgVG7KeFwLME9waissSaCGj4JIAtgDJ4ih0wHYQ9c5LKLTdfDNdPr1BYT
	mwLLA8marv6u0QkZHO9cERFYVIK5AfDvWrfSSEcidyYXCRUGQ0EAdi6BobVaY/YSvXfLpb1U8FY
	0EkmT23IzQJnsanbA+fwOQBgpp2ww4PiRG4YPiyi10XeEc94pgP6iTgnu1nUgfvTG9LxtSIOeaG
	EGxLTPe/ZxEUd21Q==
X-Received: by 2002:a05:622a:2587:b0:50e:a1ab:67e6 with SMTP id d75a77b69052e-50ea1ab6a40mr9032051cf.4.1776678504866;
        Mon, 20 Apr 2026 02:48:24 -0700 (PDT)
X-Received: by 2002:a05:622a:2587:b0:50e:a1ab:67e6 with SMTP id d75a77b69052e-50ea1ab6a40mr9031811cf.4.1776678504448;
        Mon, 20 Apr 2026 02:48:24 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-672c480e22asm2021642a12.9.2026.04.20.02.48.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 02:48:22 -0700 (PDT)
Message-ID: <221187cb-e28f-4cd2-bc7d-0f738a01770e@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 11:48:20 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] arm64: dts: qcom: talos: Add QSPI support
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
References: <20260420-spi-nor-v3-0-7de325a29010@oss.qualcomm.com>
 <20260420-spi-nor-v3-4-7de325a29010@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260420-spi-nor-v3-4-7de325a29010@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3lW1hZeFB_RspbOPrGGByFgfevTGhJOF
X-Proofpoint-GUID: 3lW1hZeFB_RspbOPrGGByFgfevTGhJOF
X-Authority-Analysis: v=2.4 cv=TK11jVla c=1 sm=1 tr=0 ts=69e5f669 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=v9HvSh1xhsShxInwDaAA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA5NCBTYWx0ZWRfX+bpMxxD4KE4t
 XBua0arieJsAqXvR4rGSYsLjsOhQUadBJGh3jkcs9tpsTP1xGvxRLhgiRh+UuJFH14rBYsDaRUj
 k75UCJQQhK2Jq15JEGaADZ5MYcGcREQpGvVyNlKW/gsx+Ax5amLiLuzuhWtJhtxOfrc9Yf8F1ir
 5E3rbBeeGxIo66B5ROASLHIIkFsEX9Gjs6syF6BIDSJhGBGq1L0jv1vZGaVPz6o9JIgJb8PJbie
 cMqlVWZKrKaTOsXYNXr/Cz4tjDHgif1jOokzlt1NM655kkvIPrTT9nsvzMqP35+EbAqW3X+4Nfc
 DC2dd/JJGdIF8m30s4pLQt3lBq9E1esuKiGu5Wns12vwibKpvgkPS8nhwpzt4iPrEhpX1RtLWSp
 WUBOPT6Vtt/pTAMBfRLlJ1OBTt5IdkHcxkRjUKEDILZdx89R6oNe4ysErmiLtdBi0Xv/SKr+dNo
 jTzczBeIFRFXGt3tgag==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200094

On 4/20/26 8:12 AM, Viken Dadhaniya wrote:
> The Talos (QCS615) platform includes a QSPI controller used for accessing
> external flash storage. Add the QSPI OPP table, TLMM pinmux entries, and
> the QSPI controller node to enable support for this hardware.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
