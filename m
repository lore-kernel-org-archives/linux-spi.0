Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C022237CD22
	for <linux-spi@vger.kernel.org>; Mon, 30 Mar 2026 04:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774845628; cv=none; b=XQ3/yb0Ivv4JeeAQtjgWhVzwpyiTxC4FNS+jJzqf8NDxAWwdwqB0f7xdwrqqcowOjbOmXqTF5HSYRSlEeu+KdtYRhjY5Wz/xSmd738n3E5sdW1x5QiaoM7fq3YmbXMIaKo3f10ugyqlW+Ad/TFqXZ1qNyEeVZRAhnRGxUMmvFBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774845628; c=relaxed/simple;
	bh=R159vo/2gogafejfPEcTUgl2FWXZNcSUzLIw/hjie44=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GpkRkwjrLZRabp7FUI8dsbikVjK2Wg0/Hs6eBti768aBw0ooLqyWuTjFoBAytBHcXCVaz8f6q+FhI498x3BFKceyHNPMLSFguEd8mZmKkySKdGm9goW0ss02p87/d69IXapFQMcLag9zIZ7Os/WhSD8E2v7PxxuBateoRj7/Pl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pNplJOve; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NTtgv2tC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pNplJOve";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NTtgv2tC"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62TNKPPT2400664
	for <linux-spi@vger.kernel.org>; Mon, 30 Mar 2026 04:40:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jxIrz6lqgl8INlv2CG6vKfWIRSC2AzWItLIRoJEu4xc=; b=pNplJOveWazggGEJ
	03skUawdUr3uoJLHDAwXeBMGCB+TMSFFVg5Cb65AtwXFEg30aTKljlLSnJN4b/mZ
	7/z38cU0NCt/VmQ34HD7RmMudgg641UqDkGrpkKsY6UyxCL+A3DBKqyc8JHolze+
	MWFcIGqvSJwpUyEg/1UhlQZJIA+Q4eUsxQFNIeOEV+MdotFMw+23fzrffi5a8Cc/
	D9rC0NdqrxGEthHKUhpZvCaCURZF2HikjUFvcDrWKVyn8+PNS1JDkARTbJxT2szB
	ocY3Pv4IdoS3m9I8p1eJUHENCqhqP6UxgN+jfbgqXMuynGt6LG04JTDwHxeGjgT8
	otY1Bw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d685hcaym-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 30 Mar 2026 04:40:26 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-82c675116f1so8199396b3a.2
        for <linux-spi@vger.kernel.org>; Sun, 29 Mar 2026 21:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774845626; x=1775450426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jxIrz6lqgl8INlv2CG6vKfWIRSC2AzWItLIRoJEu4xc=;
        b=NTtgv2tC70f99ZO5yxHrZCKxjxiZm8mvVeelTQ7NRLGBc6GPST5bJqcCv7S2Jesjyb
         PQYIbgTgk3QyU8zn3remSZz5V9Zq2Y9DM0TvqgZFSYGeSq029XL2LNQEmfxntPAhMggQ
         23hZJdrz8YiLmtJfKJ2bpaOSRRI2kM58zq+O6SCQt4jtwMgy4WJ90nZwkqwcpjDfFLeQ
         k4evPfTz50ZqkhxZevM/LNtcptQLfzX2cF8WXduclSF3ez+DJcNcTqFQ2knCbLKHc3za
         mQ3QxGnX8rFlxtpPPixSO1g9ZLhQqRAQBpu1hsbYDKXD0u1QmEEuLFTbuhH+wR9kvxy6
         aAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774845626; x=1775450426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jxIrz6lqgl8INlv2CG6vKfWIRSC2AzWItLIRoJEu4xc=;
        b=XnI4BQK7vb9+hD41Jig2MYNhj2XAr0tKXI3pxabun/AHrHL6FMmpTS8LOEd0u0qBsg
         IJx5Oxg/52CO9I+TeMMl24RPfutqa7wrP+qCRXIeoxGjb8MsYxPDme+6/z1r3yAf1gRi
         AXajzX/qKIbdkonUBXI81PoPoova2T8fLYzo2KAuruFwi6iubqqDImitutakT6pY0nG9
         QReVn0Uitc1kjFGePgSu6xQM1FSN+NwHYzEaF73Wi5g99Wrdzq53f+klNtE+royHMEW5
         pi4UBjGM50rLRR1ZslIR9+v6o5UdAjF0z2kiME7J1ESyLUlzpJZF74CGG4fabAhpjc8j
         bHJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVVUexbCodQvEqRJjeWYmkTWbcWVCxcbZ+yvYNtNfBdaIy05KfrFN/jbb5H225/em0q+eSTw5kf8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjcbRlYptpLXpgmdL4S7f16xLED1j9cj5CE8AbbgQTLSjqPxyQ
	PzwWxDfOVjh9rKpq80B++g8pQcHxRfEzHq0zPBchWQX8k5rOgYg0O0gXNV9UW7lhFJHU8z5Xo9G
	hTXGc9i1QAe0WMcgAUX+ZGgEBuhlsFxQ1DO9wjBMVHiGeyNXfBZbcId+FayU3IKM=
X-Gm-Gg: ATEYQzz9SH0OjCtR/yWpfqKiLR53QB/Viclf5XF/jUtiGOlCozlnbW7l0bVzdCppwAc
	l8SWckYOrNpsG0FFEtfyxXBsiePLctJ8yBZ/KEYSwTlmUaMR3ocz++bznRn3gEOer54JlaIzXvx
	x5OeddfuAZ57wGXxjmH5gyPf/A7Y189UaCtzDmDQ90VkDtNuGxh8WbhYZ/1+ebwwpuObBCau/Y+
	TWmUtYRd44JtEXToBMt8u/a7+F0EqimcCLMGsp8f3YfziJadBW5DlRzVvUWih21tQqRDNGLFrF9
	HtsrgUvTljcm28I/6cdaEDd64cq14x+f42ZWt4XnoXQLdG6Bxnvi5OPG5vm/zacgM65JxrNWdTf
	Nix/okiHIe1FayyX33JTzsFYQE9WpSpgH/2Mkr2hPq3imbtjFC6Lj/w==
X-Received: by 2002:a05:6a00:4c0e:b0:827:370b:2695 with SMTP id d2e1a72fcca58-82c95eb8cc1mr10649768b3a.29.1774845626198;
        Sun, 29 Mar 2026 21:40:26 -0700 (PDT)
X-Received: by 2002:a05:6a00:4c0e:b0:827:370b:2695 with SMTP id d2e1a72fcca58-82c95eb8cc1mr10649745b3a.29.1774845625706;
        Sun, 29 Mar 2026 21:40:25 -0700 (PDT)
Received: from [10.218.4.221] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca843b20csm6926179b3a.8.2026.03.29.21.40.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2026 21:40:25 -0700 (PDT)
Message-ID: <2212d12a-8ce6-40ab-8bc3-ab8e3b9111b2@oss.qualcomm.com>
Date: Mon, 30 Mar 2026 10:10:20 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/6] arm64: dts: qcom: talos: Add QSPI support
To: Krzysztof Kozlowski <krzk@kernel.org>
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
 <20260325-dancing-macho-coyote-deaa55@quoll>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <20260325-dancing-macho-coyote-deaa55@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=csKWUl4i c=1 sm=1 tr=0 ts=69c9feba cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=dPh6dh2MmqIcn93rYEAA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDAzMyBTYWx0ZWRfX29e2O0UK1iAU
 MYCKIHAwrWTvUcH2rjltNvM7zst6oW3T2RDzpKZH4GxE+TSifsMWV4xVXNeyVB4qvDHn+7iUYSN
 fBv34tSA8mQxW3z0bh1lk5tvpSNecaGeR7WN3du8q3dG3e6kBgkIs4t1kCZHQeINZ4RaCEm1LlD
 JDX8jkb0Qb9LunqXAAJa5mMnHK/k/5ur+DTZeiAhOuGQgzsn92lmtu8i8R6o5h033+GaeM+DTn/
 kaxRkKzGGriaVPzhBI55hjDRr4fusmTZemat3dSCsS8xUbDhbb4YfW0Q9kMKlW9BUng3cxvXn/I
 4sSppH2y8NKrFY9NaFHyz7xRqOrLyZVIsGzTkT7x5TqwHevj5Kyx9LmH5Zuj50PWMnT8hX0/RnO
 gXcP5Xa8xEGN4rVF4VfozrYzhTpWJWxSB36bUJS9oYKGE7kAhpXx3baPqBZRClZ38OqcX/7dgQM
 oAQdZMp+rhX3YEZkHWQ==
X-Proofpoint-ORIG-GUID: 82m77v4QCfrsynKyvCjJjyN_qeSPdh8G
X-Proofpoint-GUID: 82m77v4QCfrsynKyvCjJjyN_qeSPdh8G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300033



On 3/25/2026 4:43 PM, Krzysztof Kozlowski wrote:
> On Tue, Mar 24, 2026 at 06:43:20PM +0530, Viken Dadhaniya wrote:
>> The Talos (QCS615) platform includes a QSPI controller used for accessing
>> external flash storage. Add the QSPI OPP table, TLMM pinmux entries, and
>> the QSPI controller node to enable support for this hardware.
>>
>> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>> ---
>>  arch/arm64/boot/dts/qcom/talos.dtsi | 80 +++++++++++++++++++++++++++++++++++++
>>  1 file changed, 80 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
>> index 75716b4a58d6..fd727924b8ca 100644
>> --- a/arch/arm64/boot/dts/qcom/talos.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/talos.dtsi
>> @@ -530,6 +530,25 @@ cdsp_smp2p_in: slave-kernel {
>>  
>>  	};
>>  
>> +	qspi_opp_table: opp-table-qspi {
> 
> Does device have only one QSPI? Then table goes to device node and
> binding needs "opp-table".

Yes, it has only one QSPI node. I will add the OPP table inside the node
and include it in the binding as well.

> 
> Best regards,
> Krzysztof
> 

