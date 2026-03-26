Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A323346782
	for <linux-spi@vger.kernel.org>; Thu, 26 Mar 2026 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774516067; cv=none; b=DaWfq3AkuJo4WNL68ubT+Iv78iSnNxS+t89uzQCRb6y9IIIknPhSJz8JUzTU/xll7kcGwEcq18znF/uP2busKrg4IQHHac6iLFbdxnnfTrJFRaHx61K3YFy0VZ8aMIPmfpEMdL4sEc1KKjw8yEafE/7I3Rp5e7RCguD3Ea0l5Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774516067; c=relaxed/simple;
	bh=nApw0kQWc810vBzMMiVPM+TGaNIYxGfE/VG104jP+ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUNEKwhRwk5txEdHHzyldak+8JaKma/8taPhKWiQW3CTsaVScahC0UoEw9sWkE/2FGQGzGyHuINK0Vp9ZxjyIsZHmYOh5KX20NV6q8PmvEauJQ/IGRymcDfVLdXbG4kDHdHnUY1KhTEIZl0Tk1NYR463f0yrT7pHf6zK/MfXF/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cM7llEjV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Th6M0IGS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cM7llEjV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Th6M0IGS"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q6RV5W141453
	for <linux-spi@vger.kernel.org>; Thu, 26 Mar 2026 09:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bPOQVGT19JgyNGrZiOTEkpfw4lSjz21DJ8/El5Wk6Dc=; b=cM7llEjV9Pqx/Ofs
	yztUbSsV+3CYEZ4anEKerucU+EooHmf2IqFcBpQscjxmHMeK3drUYBDe6e88CMuQ
	6vGwGVLNpgxCBcj7FUlyije4c1RGDZbqBuQy0f6s7YC5xriDEnfc7/mPV2SI4Bwx
	RoB6bIwV7tZAl0osH51K7m7gI7QGkxYD66tzM3gfNbHcUkMOzffMoYU7tAA5ySmD
	sCZNqMHX3fNwjrK/UfqNxjKgMAIq4gzDibkVHG3Tyk2XTrkY+dK0uqenGDVt7aKQ
	wH/x7OhTS/vC3JclQucsnUllpEe/qSPv2Q+6lLwW5js6kl6KpHS2UFECFrC2qSoG
	XEpLMw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d4q09248u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 26 Mar 2026 09:07:45 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50b9074bd42so2697421cf.0
        for <linux-spi@vger.kernel.org>; Thu, 26 Mar 2026 02:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774516065; x=1775120865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bPOQVGT19JgyNGrZiOTEkpfw4lSjz21DJ8/El5Wk6Dc=;
        b=Th6M0IGSxfKCwj3AeOokEgNVcgEsAVLWAbuWESX4TO7tRr4c4aSCPrw9VITye77Q5x
         oHWpHO8fBebn6CVNGMJ4xaK5QhPaUh5+e9q3ptZSP8gOHI8Do/bhxLIPodA4mxnMdZN7
         oQM371W8R/theUvRczXfGShToe92JV2QV0UrYQc3I40f2uiXnxDv+yAegYyGy1n++4Zv
         yi5ts6idO+xVEAUDXo1TtZnjL3/rU2O39U1tAX05Z5wJriX62uZuwCRCHdFBOkViLHOj
         /RfyshjpitppwW7yFXa2rS0uZ44sQt6JuDWeU6pfwQy6xUzdx1DXPJMA+XJgDAmZnorB
         j7RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774516065; x=1775120865;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPOQVGT19JgyNGrZiOTEkpfw4lSjz21DJ8/El5Wk6Dc=;
        b=OXGoTLW7PaEBvi5EN6DfY1ZRvFElOWu6B3OxmOceE6jSOPec5A1AgR6blaTeHvWXMK
         owT+91Zbw4kmksg1ilsRCy2C4jzf530eMywi2B/pRb9qxSxAvMm2qBdzfOOLtdOZ7Jl2
         cMTFBd3tu+aazCNJXXXmbfFHxfhv09HaXoyojEqSWdFsSZ4YoKXIOsXmox6eUI7dxzTJ
         7Q8Nj5otOKi6kbgyoWRV71PMiacWZ3ZBPsppYKZH6AnsdfuIVtqU3kNK6/B7WE3wHMEs
         2mustb9ik8+C5QZ/UbhOEOKYzCLT4p5gLBFbHp0I+iAX47JzzjB2g8TwyWw10m9aUm6A
         yQFA==
X-Forwarded-Encrypted: i=1; AJvYcCWg6l6NJbh6O/Obc0scvsml80zPEWvv5Od+5tAs9tf9ivJ3z4Ho//HnN8TyxS6TtoYh/xJev5AuNx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiW8ioDK694/+LFSPdzuynBZMfm17SjNnjIS1q7zO/O+dYjkbT
	afiEz8BgwczwS5iajmtxCTslOdduSu/zlEoVcUlW6HttzM6dvXTWAzn9MfI8vI8d7nOZadFKJ7c
	Wa2z26blIH5rkwXg6z3cq9e3h3t4xm9lg1p3PU9UBIsenb+mxh2ewV5xwasfwnXE=
X-Gm-Gg: ATEYQzy+Y60wXesKGezkJfFeDYsdyc3DkCM0YBzFJWN8FXhvXfaD6YFGVcivZ+PzTKv
	Rtt6r7oCJ4PXCSt31QpvxijJg3898bK9WJBcCMWbRxZhSltoiI6XsBWqSR/HcWURoaFsb4FZgfs
	md45qxLp17p+ED/qiHotl57WNITvijymd0faY58ezejLps6LX0J1mD2RZKKL4sKjhaLuy5uDgMS
	sJiu41wcwdpN2Xq0krL3IxfL5lbXBLoH7D9JujeRt8HnuyDrWnrSjYwWd0BQIksNVCHhRb3ReYS
	ShwvE9Eugb9FQ9/6j++YHDrcGvoJXftIgXqSrP3xawkwi8Y0TfMX003c8VQGSV4urfErfji9ZfG
	ohg/uN2QOxiH03ck3qEqbSQ9cmV3NDfsV5YjYgSzFDyG/HS3BUGqp7BsVlJEc07/pBjVnqXc1W8
	A5dBg=
X-Received: by 2002:a05:622a:6209:b0:50b:6b21:2a7f with SMTP id d75a77b69052e-50b80ccc148mr66925301cf.2.1774516064757;
        Thu, 26 Mar 2026 02:07:44 -0700 (PDT)
X-Received: by 2002:a05:622a:6209:b0:50b:6b21:2a7f with SMTP id d75a77b69052e-50b80ccc148mr66925031cf.2.1774516064301;
        Thu, 26 Mar 2026 02:07:44 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66ad5e3bb1csm770802a12.4.2026.03.26.02.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 02:07:43 -0700 (PDT)
Message-ID: <0c3c0d7d-b108-4295-96da-a261e65cd16e@oss.qualcomm.com>
Date: Thu, 26 Mar 2026 10:07:40 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/6] spi: dt-bindings: qcom-qspi: Add QCS615 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
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
 <20260324-spi-nor-v1-1-3efe59c1c119@oss.qualcomm.com>
 <20260325-vehement-bronze-manul-ce6bcb@quoll>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260325-vehement-bronze-manul-ce6bcb@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fufRpV4f c=1 sm=1 tr=0 ts=69c4f761 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=-OTHMHjyIvLZNMc1xfQA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: D77aS-akjrtwb1yXIyukE412q7klyMhA
X-Proofpoint-ORIG-GUID: D77aS-akjrtwb1yXIyukE412q7klyMhA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA2NiBTYWx0ZWRfXydkl9h9cdZJK
 rdQdY/ViWpEJBD+v9sZNOk3eRAxkS95Zfp6/cu2cdLG+jnkHRt2IXQD/AL3Wfv8hQhyMGFVuHvP
 xzrSm5YrJvbtSB+a2BmniY+P8LkARyqGfb6ic9DaIbKyzqhNXBitS6Vwd28+onn9IV7+kBS9u3P
 8oV5x1lqvYE8i8+907oafSoQYaP/D39wkTWaVUiFpa0PbKhGPB9djHCWU3PDHdOyvJsAW4kCOBr
 hUyzFFrK+ptV2gu9W/JauRYbxWggzLHxylnMXM8PFiLfBXaZdO2fOj/VmczZbkEeje1YI5bm8SG
 RaNtWXnA4gcBjCv0l4tNbU0qO6gxrTfFieIw9o+bX5TIRuK7ImLSDEgoWpazTRWCqx1KIy8xS2b
 AedWyxADdObre3IEqreo2kxFaGK8jqRTjkBMf4TvhYtIR4p8bTvHOCKRg6Y5YmVg2NpsnO+wmc6
 wgpwUbLmKMXEXwI8Srg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260066

On 3/25/26 12:12 PM, Krzysztof Kozlowski wrote:
> On Tue, Mar 24, 2026 at 06:43:18PM +0530, Viken Dadhaniya wrote:
>> Add the "qcom,qcs615-qspi" compatible string to the Qualcomm QSPI device-
>> tree binding
> 
> ^^ Full stop
> 
>> to enable QCS615-based platforms to use the existing QSPI
>> controller binding.
> 
> That's obvious, no need to state it. Writing longer texts without actual
> useful message is not helpful.
> 
>>
>> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>> ---
>>  Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
>> index 1696ac46a660..d9aac33b695b 100644
>> --- a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
>> +++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.yaml
>> @@ -20,6 +20,7 @@ properties:
>>    compatible:
>>      items:
>>        - enum:
>> +          - qcom,qcs615-qspi
> 
> Existing bindings allow flexible interconnects, but it should be
> constrained. At least for new variants. Please move allOf: to the bottom
> (after required:) and add there if:then: requiring min two interconnects
> for qcs615.

FWIW they should have never been flexible on any platform

Konrad
