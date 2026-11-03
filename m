Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793685466;
	b=1Hyl0er5diOubrthk2gFvJQ/VwiqEwuPW8RotYWOle4KEHfX+B9gH0iLPUj2ml+0++vP
	 +dnRF5LYIOBafPf+tTDMag6TDn+bOoZ+Im6a7TwSbRtBbfauRqrjEMgRjfyxenaNji38b
	 YCiaZ7CUtZ7t0aXWk1fi5HEKO8Qfqo97sk5wqKUEg0kFyEA66/Nt67srInGhZ6xMbSpad
	 87UCQuvff7UfSNWf5i5z1Et3f/7p8px13pMaTbAFaSzwafbXMw6zOq2M1GcI1jMqUR5ep
	 ngDhV93zRzQm3vf9PJH+hQd5b8zmgC4HsjEMykxLXH+UoTCUmbt3ECV+qOL1fvVA6Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793685466;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=PJsG2kFUzmWIVpV233fDLAY1GQdDB0aSN4idiIfFSMg=;
	b=pYKQDQgNkYtQOsTljydMqmjWVcTGgdmdEY8QzTlNWv+Q0Fcad3dR4vkrbOe9YR80ftYb
	 3EpmWmkT3CQEsatSRfSqTIQ5on+6Lz+RkG3FHVxWgvuMRLLD9jUkY/421Uq9/TpZQFqFq
	 pY4BXgUtQpKcMSUwvG5eMVhytJ2DxsIXmciV00Tb8SA82MQpHpDNxnA4QKKVL1DfIbGue
	 KEEB+41nCdB2tBNJZDdGMVZlN2C7dfgGffQGroAlPKBQJ5ld0gzXAGtbWNChJSXrOJcUE
	 bVPvYMj/dGALHub18IVfF9FQu5EseXuVbrTSoAuF+n97Ag606C+NkGzDJqydNfWfaiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S9AesGBP;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IPCl2tQ2;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647F2606A324
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 05:57:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 647F2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=S9AesGBP;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IPCl2tQ2
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A34h9uf750953
	for <linux-spi@vger.kernel.org>; Tue, 3 Nov 2026 05:57:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PJsG2kFUzmWIVpV233fDLAY1GQdDB0aSN4idiIfFSMg=; b=S9AesGBP9hSJljeV
	ww3dgpha13lRM5zcSnS3feur4P1jZnXP0q+bCwLoaM83bVFreJ4eKk4lSO7sV0Ju
	0aZdeeRvA5X2Pqj0IKuLFuPKq8CXb02W0x7Sv89jEDg7Sosv+PFys6myY2RL4yKZ
	IAz2j4Mq7an33cLPGhd/LK9OM4Zo3Cbx9+hnNfnMTZ1uu+4a+mRtiFoqjDOdrhC4
	EmU7TKiKJvt4+Z9GWSaXI2kVjgIXmmi+N5LylNICjm5ZKaGdQ9n05GjNfWVNKJYg
	y3DIqexGT/ypBE5B1L+98PYcm2zv2p6Az+5eSxdYn7d67IMV7ZON/Ipop7xAEFkj
	uimAsQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq8u5g7x2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 05:57:45 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ae72da2f57so4968203a91.1
        for <linux-spi@vger.kernel.org>; Mon, 02 Nov 2026 21:57:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793685464; x=1794290264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PJsG2kFUzmWIVpV233fDLAY1GQdDB0aSN4idiIfFSMg=;
        b=IPCl2tQ2nWBR383KPUh4rk9EnWD83UOyzXaLKMgjZBIVNl+DnwTqIRLkWroTvhn6DN
         ePGjlsCtFqIfCs0N2COVeIFqTOVV6afBkokvGlxlPd0bH230BLe0n7jJaPZ/s0KtEIxl
         8JEBtDkaMrVnQ09kZf4egi3fgQYUxDCcylwquijPWMXdd6ygNRy1s5CEzSKaOOU7jH0V
         VIezK2Mp6IbzZ9gez8CP7Df1hKIEiSf8pIUWpMbTZsMq/C0PQmKmNIsa3BJu95g8TjoE
         qXTrm7wJUqY2DGoNE6NpC1/ZoC9T+uyd7mFCWFV8afN8IGLrGObO/iy0IjvGXJMAnoNJ
         lVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793685464; x=1794290264;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PJsG2kFUzmWIVpV233fDLAY1GQdDB0aSN4idiIfFSMg=;
        b=zSY4m9V39t2T65E6PEkn4Rrra0IoWwekqaFJM6pXXxULyrRSYutWjP+ob3soXmpt1T
         YqPWSXyKriqfFRQUBlFpVjMJt40yfpywtUR7wPbVtnA7c7Dsl0eqAiv73QS+ibEtrJAw
         iirUJp1jhZ60K0gE7mc30bksuEjLzNQYpowEgotRSUfHtArIhMcNBEUHnyL6qB4XlYi4
         uPXBSW4oyeZ+R2aizb3K9ZPVr4YZSzfRJHkYgFPFsCiOggstoCeNDcZUpAvBkV/ibVtI
         EyGwPqrvPHJrmjnnRkZb9BnmMgDDTluwPW15PWqF6IROWPMcQeiHqwZwq7ndALgmbIH2
         NgYA==
X-Forwarded-Encrypted: i=1; AKwUvBxFQLNPEFTyAP6gUxbAP31Jwa2SQoEDBl5W/bjW1bOT6vjDUXbaVf9yB/zUQ1BHKb1yToKM2GP1uPg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9tyoqA0lFQz7UVRsnnecgDI2eSeH4OkvX64T6A1xr2alTporQF
	QR30/GipQMckE5npgCGpKFQR8BurQQ6Xu05GRdJcY1o8BkStu+J1IJ2Y+Wwp3dF6FlBMCYTgsw2
	wuCaTles0wr061hKuoV6W+apQvi5LIbwjNbVl0sK56cvWTDWc8BwFAhbI62TPmQI=
X-Gm-Gg: AYBFou3OnRhNFqnYjdYEYOagS/q6MaXQU7B5/Ia1HRs0oFSndduzvI8Cy4zzgi66tDR
	jOhrU+kbouxssZQXH2f0wAvWBPziDqpICVU6uYDZ84I9Mu5pQXf6lm3WlCwaJTE9xcYRvTbaSqb
	DM/tdJLneVhFsT52uAW9qAnypEGINGNEz6KCVtRxieukVC3R2c4IrBSYGXd6xM//A2u4T5HECuv
	ViulO/gEqgYYJ/WVanWtUyCHTjkyTtVMBZyZYIm6qGLEWxJL1GXw6VHaACH+dbRuRgTKgpheBsi
	ajUtdckci9gTfCY6TjKCi95ghr9Xp+3nEv3CFP8lw/OB3l4wLJssR44AMjrwHywMxd8vrySIwkj
	BPJGYNAgTxdLeCGPekK+89HylyWH5DlfjND2XpH0kNnbwC73JoqoE9tAd/YKt0H4wEO9W5x11zY
	AEKA==
X-Received: by 2002:a17:90a:c88c:b0:3ab:884b:65b4 with SMTP id 98e67ed59e1d1-3ae8984ceddmr10250878a91.59.1793685464297;
        Mon, 02 Nov 2026 21:57:44 -0800 (PST)
X-Received: by 2002:a17:90a:c88c:b0:3ab:884b:65b4 with SMTP id 98e67ed59e1d1-3ae8984ceddmr10250861a91.59.1793685463790;
        Mon, 02 Nov 2026 21:57:43 -0800 (PST)
Received: from [10.218.50.86] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c5d7f82sm2470465a91.5.2026.11.02.21.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 21:57:43 -0800 (PST)
Message-ID: <c394d2b5-8f66-4fba-a38d-4ba52778b471@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 11:27:38 +0530
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: spi: qcom,spi-geni-qcom: Document QSPI
 support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261030-qspi_dt_binding-v1-1-5249111cf870@oss.qualcomm.com>
 <f71369ca-5963-41c7-9103-dd39a7369e38@kernel.org>
 <53640a9c-395f-4faf-bbac-20c47013cec4@oss.qualcomm.com>
 <20261102-crafty-beautiful-lizard-36db2b@quoll>
Content-Language: en-US
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
In-Reply-To: <20261102-crafty-beautiful-lizard-36db2b@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: LXuCRJzzKnrQigHNqvumCd_ZA-itlvll
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAyMyBTYWx0ZWRfXwOOPTviszBrJ
 KwNOAHL0O8x+HafhjUWL2JCKmzRK5fH0R94cJEdv10vSfpitzGUQ6dlB7RHjlbDqjcCcO+ZuKcl
 lgZy2xgCtVROcSVDdxv2iCE56sm8xGE=
X-Authority-Analysis: v=2.4 cv=RZ0FmFtv c=1 sm=1 tr=0 ts=6ae977d9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=3EltNRdik5pUTb2ctQ8A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: LXuCRJzzKnrQigHNqvumCd_ZA-itlvll
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAyMyBTYWx0ZWRfXyYD5wmmkLzQ2
 xk5n+/5T1CKbIAcO1vjnkWVEg/DvsN2fXZ2y+SSnKlYhNlBPNUIweNxy0EPeEtdYPQ67irEgbAv
 o9WbT1ntFF5dmNsar5A+zqlhZctmOIRWWWgLOIKAzJF1NidEqXuaADjI0+hwwZ+Pruvd5s4YLnj
 EY1V2OBQp3/SvajQI79kkTfzWzKuF6NvTyFRHMom3igPtViUP+aEcurn8Ub0g0xgDh+wJc+hf9T
 RS0xHEW/i1Qsxr8uSqJOCb90ISrfdTIadEuXXsM3iENT14EkuXvLH61DVdBT3qAGRUsY95CnZ/e
 Mmu1AZ8Sl9kuCmHhj1ucFuuVfhBFkLlF7OZSoZ7aRU8ZGo1tLGJaIXnSJMHz/vYv27YW81YIwb6
 E7qcIyUZ0G3I41IzH3MbXz+PIzWtzLK8qhzbcuafW1rEt8iKNW/ULpG5MV9lHPg+HBWrwvNZ/AE
 ulsheEVQ66Q/158P73Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030023



On 11/2/2026 4:59 PM, Krzysztof Kozlowski wrote:
> On Fri, Oct 30, 2026 at 07:28:57PM +0530, Jyothi Kumar Seerapu wrote:
>>
>>
>> On 10/30/2026 7:06 PM, Krzysztof Kozlowski wrote:
>>> On 30/10/2026 14:30, Jyothi Kumar Seerapu wrote:
>>>> Add the "qcom,geni-qspi" compatible to identify GENI Serial Engine
>>>> instances configured for QSPI operation.
>>>>
>>>> The compatible also allows the driver to select the appropriate protocol
>>>> firmware when the Serial Engine is unconfigured (GENI_SE_INVALID_PROTO),
>>>> distinguishing between SPI and QSPI firmware.
>>>>
>>>> Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
>>>
>>> Where is any user of this? You speak about driver, but there is no driver.
>>>
>> Thanks for the review. This patch only adds the QSPI binding change. The
> 
> Please avoid stating obvious. I can read the patch.
> 
>> corresponding driver changes to add QSPI support will be submitted in an
>> upcoming separate patch.
> 
> So no point for this submission. Please read submitting patches
> documents (both).

Understood. I will submit the binding change together with the 
corresponding QSPI driver support.

> 
> Best regards,
> Krzysztof

