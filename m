Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAD23CFF7F
	for <linux-spi@vger.kernel.org>; Mon, 30 Mar 2026 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876755; cv=none; b=qG6/KmHDpGmrBPckNhKT/g6Brj59wB86KANRMS5SVK1DDvVXeaKdAUZOXt1fj3s7lYwLTcd/Ebx+L+6Ls5Mhb8/PidbxPOwX4z8UlJFLGWTvE/4HVPuGxyQKkAKN4aspr/O7N+Ji6xYeF9nklv2HcuKCYcTQ5wsdqCoNX9mglTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876755; c=relaxed/simple;
	bh=fa0YDhKwhZ5+jDZZzT8LMkH3gOrvByVwmZV0YEiz/uA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ra3n010qTGdur4dtCt4rwcvzdQRPY7ZXENSA0jjFz+aWg9xdBiopbjtCOV6WVBJPbcrFIcliN8ACg7PPk8rVcCp6Ua7gvVf6d1+OX9ofqrVPxdRk8DpEcFsQWVsOAAyoVupj5FulUdNEMqdbEeZIKjlRYxcvzAWmj9jpwmXpmy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B2k1iVls; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cMMkKS3A; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B2k1iVls";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cMMkKS3A"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UCP4LV2525265
	for <linux-spi@vger.kernel.org>; Mon, 30 Mar 2026 13:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gp/uAhNpvhPnAUsObjj3qF3uuB/aBnDtd70JcAQP+kc=; b=B2k1iVls70uAYgIk
	snrpdmdAwIqq5Ojpgb5vsRnNgpo4fqn4ZmsyTwxCfeX/nPSyMl12kudsfhVzHIKS
	SiI+xOKGVgq4E7iAMRWpLAUccqXRDmaIa5PnMfcp6rXrNo0UIgTOd+oKkcnDLpc8
	3743izqBfYbNMM7NR8eUXeeIUW4ky2xY6MiyPUfCpIaqGnsODOuUAlKj+1MngQEE
	GDHXLTtVPvjC6kiEAuzeLGL6T4W2FKAE+rqv/3IZu/VUjgssMVZpGOWCYEmUzvO1
	2dVtrZBmYaf7GTSGl/qmoYi4Qoyr4PoPV89I8d3GHUjSjuKGEOPsQv9/Oquz9+yV
	UdYbTQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d6ufmmfha-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 30 Mar 2026 13:19:11 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-953b34649a3so21140241.1
        for <linux-spi@vger.kernel.org>; Mon, 30 Mar 2026 06:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774876751; x=1775481551; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gp/uAhNpvhPnAUsObjj3qF3uuB/aBnDtd70JcAQP+kc=;
        b=cMMkKS3AcTvUhMpFBh9tvpDQnK443y+t8cMR6PEZbv6VOE/CMmD+r4QiFIlkkcpFYY
         bMRVEcfP6EcAKe2KZo9CgbkoIhepk/JRq8rf6htlmPnPY/xfMtRfDHb5xbegXRs0h5Qz
         aAziCFMeWdh+olLqRU4CjlDD8gW/0HvN0a9umMrJ+OYPE4j2kroFHufJyJSTqKQSpDim
         TWvTZCuy+wGIO2oPasiW4OKAfqg8Hw62P3kVpLJNE1ERI9UEMwMmloXL0CkWh3W+piNu
         h4B8+KZWfQo6Nu/TPxip13FT2oQVxrsNBv68ts8vaMEgph3419uZAcyhDfJFFj3G3NzA
         Gotg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774876751; x=1775481551;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gp/uAhNpvhPnAUsObjj3qF3uuB/aBnDtd70JcAQP+kc=;
        b=SPGYdD8r1c6VcO6DedwxChn4Di7Pd60hsM7MICKycbSMXqDN9DOkB6R9HgJVQqD76c
         s6y3aXa9oTOdDU4NtxHbmkiq9TpnliP8WGTw5zQzX0+rz0OSIOe/vU7PkC9PY0AtB1h5
         kw0k3IT9oQ6d/CUgKomxWEJQ2Yv+SRMEV3Ix0NOrU8vLL2r2Ea3mhLlTxQxFAdG+e1QO
         uXH/0smWsRlPaEfWse5KxISZDPUjxfbqzweVpHQSkSWCdYBaS7kY2GzDPc5n6Oo1UZHc
         XCRXTisrdrbXwxcpdnvf5Se35RM0qzxOzd+TaYON/6v7tAvAAUR799yY+xj8rL2vfEzU
         hLZw==
X-Forwarded-Encrypted: i=1; AJvYcCVKR/PxccXB2q4LfUlrK6zZMmpIJcVSjYK+O0kIBBgqWFcPR20SUy2BIbGDT2G0C1/mCCjImlLUQoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgEk4CJirOTJti5bsrHJ00sb/0trM001iWWZzf7EUmWO61C43Q
	DkZNYky2rmMNNiGg0kBRTuywsD71Uvc/hnVMhxZgYuzPGLim9TwDo74E9/9g1TAOEinYhGPPPBI
	QD006jtp1LwWPj0NOfL+2Ja4722iQSehixH0N7R+VA1DECkyoYvMCyGLTs2Xufd4=
X-Gm-Gg: ATEYQzyklrd361Wpe7lXQaPNPQuS5zb5a57yUgBK8Rw9seDQ2HFyZTp+afMKPaGqOaK
	gZhBSuSBiSZIfKFcAREi68G/14s9k+oLkZ1/lvwBOAK2Xnkp2t8hqlUQvjPt4UQ26H0PXEuT3MP
	7Jo5dIV+IoVw4SNdfI23lEsYpf1te/7WFjXBx3JCmfyd75Hluc71DaHaWCBO4T5Qak6udjJRf03
	zq9mn6Z4KlaZ/JifWwy5+xuxAhSJL1J12y/LwbKKoAlLCgG/OzNzPyR/9qFHVOEDBbEafDn9vtN
	ToGyqYeluxm3m1MPAT2beI3J8aAuZrtmQ3xOhxVMmDtaFFNMweFPYMaDb4UiwAIHst/duGtMOzP
	2IKn0qXfpiotSiEqSY0nlUVRbGQ+qkKsKulJ6WuIek0tqIoBAfPoqL6ejgZO45aAzhRhrbxYBqC
	PKVaA=
X-Received: by 2002:a05:6102:5cc:b0:602:9acb:64ed with SMTP id ada2fe7eead31-604f92f2a6dmr1649189137.7.1774876750961;
        Mon, 30 Mar 2026 06:19:10 -0700 (PDT)
X-Received: by 2002:a05:6102:5cc:b0:602:9acb:64ed with SMTP id ada2fe7eead31-604f92f2a6dmr1649182137.7.1774876750536;
        Mon, 30 Mar 2026 06:19:10 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38c838e171fsm15451261fa.37.2026.03.30.06.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2026 06:19:09 -0700 (PDT)
Message-ID: <9214ca24-77a0-4597-9c28-12574452fdd9@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 15:19:06 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/6] arm64: dts: qcom: talos: Add QSPI support
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260324-spi-nor-v1-0-3efe59c1c119@oss.qualcomm.com>
 <20260324-spi-nor-v1-3-3efe59c1c119@oss.qualcomm.com>
 <34cifkyw3pgky4nhcu4jwf2uveszre23kvesr7ksyjvmqhfspo@avsvwa3quvsp>
 <9d7c5d36-c981-43ed-a08b-3b75c25fad1e@oss.qualcomm.com>
 <20062190-609a-4977-99be-c27df90ff321@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20062190-609a-4977-99be-c27df90ff321@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDEwMyBTYWx0ZWRfX6LoFqfiPO5My
 S3XQXlg6w+UgiZIwcD6USbVg98/1tAx8QhNNfVwG+z/giozQh/BGSU5YMZtZpLVInM58lrM6GyJ
 yko1nCs4jMhrFRedK+NaeFzKucdWBSV+FJnIptcK2rXmTg2WtYte7lNv40A86gQCvRMgilwx0At
 ijBjYEEwjW+AeZY29WYhhlORrMRROx8PPyVK+oXeayZJAen/kiI8Uz9+mtBH+rqMzJlkZHs5I7p
 HXFV+PmGBJKK2zEW4tX0wp0NKIevRwMEcJ/A6zGWJhvFlvFfVc9D7r00kdifdhR6k/Zz5ThP2RK
 PekkJ7sY0HRBjIPWboYBW1xcmOCiblQFB6NimrJ+O22C2ge90fu1EplDN/OTO4H79fpuWwFHl9y
 rVXmPN7qlMd8U0XGJ9z6lEcVx681rGCh5Rfu22V/7O6Vi9nvyFQY9+wtsKD14Ms1ise6urgMz42
 MpuXQaZyR09pH3K9MVw==
X-Authority-Analysis: v=2.4 cv=aOT9aL9m c=1 sm=1 tr=0 ts=69ca784f cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=_JphER5ef4O4mSyQYpUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: DJNo7NqkPhVDPQCLdY3xhjSFwIxFsP21
X-Proofpoint-GUID: DJNo7NqkPhVDPQCLdY3xhjSFwIxFsP21
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300103

On 3/30/26 1:23 PM, Viken Dadhaniya wrote:
> 
> 
> On 3/25/2026 3:02 PM, Konrad Dybcio wrote:
>> On 3/24/26 9:51 PM, Dmitry Baryshkov wrote:
>>> On Tue, Mar 24, 2026 at 06:43:20PM +0530, Viken Dadhaniya wrote:
>>>> The Talos (QCS615) platform includes a QSPI controller used for accessing
>>>> external flash storage. Add the QSPI OPP table, TLMM pinmux entries, and
>>>> the QSPI controller node to enable support for this hardware.
>>>>
>>>> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>>>> ---
>>>>  arch/arm64/boot/dts/qcom/talos.dtsi | 80 +++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 80 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
>>>> index 75716b4a58d6..fd727924b8ca 100644
>>>> --- a/arch/arm64/boot/dts/qcom/talos.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/talos.dtsi
>>>> @@ -530,6 +530,25 @@ cdsp_smp2p_in: slave-kernel {
>>>>  
>>>>  	};
>>>>  
>>>> +	qspi_opp_table: opp-table-qspi {
>>>
>>> Why is it not defined inside the QSPI device itself?
>>
>> The QSPI device has #address-cells = <1>, so we'd get:
>>
>> Warning (spi_bus_reg): /soc@0/spi@88dc000/opp-table-qspi: missing or empty reg property
>>
>> Konrad
> 
> Yes, I am seeing the same warning when the OPP table is placed inline
> under the QSPI node.
> 
> Given that opp-table nodes are not addressable bus devices and therefore
> do not define a reg property, what would be your preferred way to model
> this while keeping the DT warning‑free?
> 
> Would placing the OPP table as a sibling of the QSPI node (for example
> under the same &soc scope) and referencing it via operating-points-v2 be
> acceptable in this case, even though there is only a single QSPI instance?

I personally don't mind it being in the place where the current version
of the patch puts it, Krzysztof?

Konrad
