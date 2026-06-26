Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5562E387361
	for <linux-spi@vger.kernel.org>; Fri, 26 Jun 2026 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782487771; cv=none; b=gkZglJgC3O1x/VGWFyeHsUNR3UKGjGMzv5YDn4dNrKmuKSJCki71s9Cigd8EUVYDhh2BeUCL/9L9R4DtrvDxXnHFyDHzSoSaSGNXjwCy4or7UQ6gimk+aL2JjaGipvkWZEL9T2IQPQMJYS4DaCM6T8hm7CMV6HtXwxybffXEV0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782487771; c=relaxed/simple;
	bh=qznWgINjW89HZ8XKIFLhN6m3p2kCb3UuuAC7xhAjnnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qfYFA0wo4oh2zQVRE59Na/VMBJhQOaxX2hc6qF4C0KjGFahGScHv1hFECJzt9OX0t9s8eLl32LhCXaqgy5tnfhIEj3TyhcgbmOADg8Rry3NOAAVpAA3jZXXFsrzSNNy/WwXjiij+wbSlW+pPUBM8D6OFLnt1or+PNlmaC6JKoqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UqhEW8qK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WAJIRb/H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UqhEW8qK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WAJIRb/H"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QF3uID2828260
	for <linux-spi@vger.kernel.org>; Fri, 26 Jun 2026 15:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+1vg18RtT494U3bFpv0heAeJOQn+0JqtY4stHDRp+6s=; b=UqhEW8qKS9sKsVcC
	XfA59BwtqBqPIdcn+JE6PXgTAhbq+3mbc+NJ74H7dGvMThqLoxGU23oZxnbE80f9
	BdlrPmYgA0nBwr/PA3MWiPnpslXuplL6nI3DzbwjcJZKq9AfUYoxNfRV8dCgZtk1
	0h9ABYvZPql+S5rpBWLg2LrULClpJHAi5m+p8jounl8J5J3LLDclSaLW23wKSlE0
	nqaIOLK8fs+AU4IRpP7fpF3BaTRUcbHQstR4qc/inFov9i6Otg4gSTa21Pfrs2BW
	S8PU2erYH7irXUm2y8K7skaTF/cjsSzY1joFJG90Hid+3FysOFUVf6XL6n9pifiw
	HHIbBg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1fgc31kg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 26 Jun 2026 15:29:29 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51a07295d67so1321191cf.2
        for <linux-spi@vger.kernel.org>; Fri, 26 Jun 2026 08:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782487768; x=1783092568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+1vg18RtT494U3bFpv0heAeJOQn+0JqtY4stHDRp+6s=;
        b=WAJIRb/HnH5T0Npcf6wfogtI5l03r0l3LZKxK5iUrEGRepJioU+i0D4k0dAiQug6vN
         kKV35QcGXbWNba33XgnzpjPYdKK5HLMaWw5/H7Y7EQiIKbTf5UC1avF0tXMrmsdAq2H7
         66DsGn1gFcyzr/rmWaZNKtjhvrAnLDG2GKL+JtdsMaKcpetYHL4Rj939bznUVnlHzxLi
         clPhtSojLGgIhsju8pqLQhDuSJV05+475Z8VqekhgY3haUxGveH/c1gGvP+jpacgfUmP
         S9bGO9lpdosp9aBexbJ4x/HjGmhadWkQYJS045e1Bm/sGZJ7bxYcPVDnp0Zbt9OqcrT0
         zH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782487768; x=1783092568;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+1vg18RtT494U3bFpv0heAeJOQn+0JqtY4stHDRp+6s=;
        b=QFGza27t/dLipspjxih3pGnnri5pVGUVpfBSRUqHN8rMvExFAcxTqYcTBAuqeT5qTd
         oIOgggL5pGYSFTFhxhQ7HR/bFfvITXnhST+uJkRLlm/yzgKugk1J7qZnuM+Y+wMguNcx
         l4QI/Xv/TunVdyyw2QD9slUEgZGPYauaa0W8T2tRsicAvkBzNsqldgGCyY6efL/9PsaV
         avDpu6u5tsZBbC/IUbfSABkPu19Ic6pm1vpGI3BoAowYPoLuToLa7C7mtgaLlssy7VOT
         MGWkqF1qiYBW4nWnUQrLjT6OgYT7dbH3r2Qq/sQA0AkmugAiNa80ITnaIDASx9I5AFD8
         OSvQ==
X-Forwarded-Encrypted: i=1; AFNElJ9B8qw1q/XszjMpqozvAVmIOcFnmu7yDaTLxxGcqScR2oThotDDymG8KUO+qa1KWw1Bl0hib73wAoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaFRivqEeDjXxO7u67ebdboyx46NANrGWsNZJCJNCeMW6G5kPa
	+5ZWaF47oSiibnTpDXFiSpc5+NgASKOnJ1zkkVAeD1wNmlQMxNhpLMU96O44tQK86seeSHP6Odk
	dR6L9TXjjP+e1vmBdmHj9E7WXWR2JDJj6falec2UYh2PsAtGkQRxE5+vjfckv7zY=
X-Gm-Gg: AfdE7clUBhVXoBwjTLFUUTuAges/mmXxL3rFcKzAsNsjZXdm+94qmhV6+02VxvJJqk8
	jcQ9d6wiSWIg6SUE2QNbBcmTbLAGDO8m/T+3fhLfxlWpzhYnPSFgsQW2ZgxETp0D7QmkXknCWO7
	LVS78w3PpO9wao++uQaCZd9iOrjxQqPTT3h3dkIF1SLgrpnlsxpsbVVPVz5Sro0qOg+xJ2MFOjZ
	pNYb8SdISOXFOjMecBNlUCumGdjuP492HWsonXC7yC4+UcpyN62qW5BpOrtmF7+T0jzIq6B+tnk
	dmZByMfi0gBGcEZQq9Cw8ycJ+b2qFBaHd/pkxbt1npjOSzq1RuTcAoLQosule+mU56WTZ0wdbZs
	zUltnZynTFTI6ZpPtgVHlF3KFcLtvMUsJ+6U=
X-Received: by 2002:ac8:5e4f:0:b0:51a:8c9b:6493 with SMTP id d75a77b69052e-51a8c9b9492mr4776231cf.10.1782487768421;
        Fri, 26 Jun 2026 08:29:28 -0700 (PDT)
X-Received: by 2002:ac8:5e4f:0:b0:51a:8c9b:6493 with SMTP id d75a77b69052e-51a8c9b9492mr4775551cf.10.1782487767667;
        Fri, 26 Jun 2026 08:29:27 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbe05b62sm355657266b.41.2026.06.26.08.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 08:29:26 -0700 (PDT)
Message-ID: <8f45613b-7046-4a68-8023-8abb8efa697b@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 17:29:24 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] spi: qcom-geni: Enable SPI on SA8255p Qualcomm
 platforms
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, bjorn.andersson@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mukesh.savaliya@oss.qualcomm.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com,
        chiluka.harish@oss.qualcomm.com
References: <20260618-enable-spi-on-sa8255p-v4-0-f5b5067e7e1e@oss.qualcomm.com>
 <20260618-enable-spi-on-sa8255p-v4-4-f5b5067e7e1e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260618-enable-spi-on-sa8255p-v4-4-f5b5067e7e1e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDEyOCBTYWx0ZWRfX1i+8GgUvsPkG
 yNKxhMvxVFyQjP7n3L8iQmE7XpF+4afXpJD0PeMbenBq6M5GFeYO5Abtrs2cWW+aHshU8sLLAlf
 89QrScsY6Fe5EQtadgRADZJhfxVyP7c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDEyOCBTYWx0ZWRfX7kPjOwDwyTIv
 CCoO+trUYGS67O2F7WQVJYXFIX1zbzKtR99SepI2EXVsU0NZMbIVsoEfUMwl4Uh4gAGcCLZdVKz
 5wXuFiXgNhY3iJTmLtFLoVzhluJ75LEdY/WYRLiuNYA3PD+9iJ+6GjUZiTp00jZfNbNI5529SQf
 AZ2tou90EfN9b4eul/EQckrEk+vEKHcsPPgyDu2V/bhELZsr9eyDEP6ZYv9fqy1ake7qAzpf0DZ
 arJxCLBOXRiwnyUIGMY8yy+8pgY0oVFukCTImEqkoDtjQjEfShGRnAidqDAC26vHF6/sS5XHwyc
 8YptFeMPfrD/3fF7GykSgi0k87+Ew7HD+BNVL4TZfQKavCbdAuBe2J9TvaI+RZnHESFud4XIy18
 nbuKFBlBrBxstFY86b92pq0v7aoltRM3FEyebQyoqeJ+WtllOW4KZ7KDDTbDwLbov6OVwFFm0+z
 ZqM0sfB7dfcIDsWlqJw==
X-Authority-Analysis: v=2.4 cv=O4oJeh9W c=1 sm=1 tr=0 ts=6a3e9ad9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=wYGpMCW26V-xmeov4-8A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: tufLdRJug4S5FFeJ3tvYkGcxMzwEwMdT
X-Proofpoint-GUID: tufLdRJug4S5FFeJ3tvYkGcxMzwEwMdT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260128

On 6/18/26 11:06 AM, Praveen Talari wrote:
> The Qualcomm automotive SA8255p SoC relies on firmware to configure
> platform resources, including clocks, interconnects and TLMM.
> The driver requests resources operations over SCMI using power
> and performance protocols.
> 
> The SCMI power protocol enables or disables resources like clocks,
> interconnect paths, and TLMM (GPIOs) using runtime PM framework APIs,
> such as resume/suspend, to control power states(on/off).
> 
> The SCMI performance protocol manages SPI frequency, with each
> frequency rate represented by a performance level. The driver uses
> geni_se_set_perf_opp() API to request the desired frequency rate.
> 
> As part of geni_se_set_perf_opp(), the OPP for the requested frequency
> is obtained using dev_pm_opp_find_freq_floor() and the performance
> level is set using dev_pm_opp_set_opp().
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
