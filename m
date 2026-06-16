Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE3E2DAFCC
	for <linux-spi@vger.kernel.org>; Tue, 16 Jun 2026 13:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615921; cv=none; b=HDIvEjEpUAJrK0rQveswoRN554uqnRt2aPX7fmWQrcI2yBqzMgI8z4PyZvKK0jS5Q/C+KkyCezXhIIGOR34eKNLQlfZnVsgrBv3wS8qnQHqX2G8Tp+VCgUDwxBeaokd/GEyzFrLgIvLoFAvTQELEmP9C31UO2OVMN/fJYVNxBu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615921; c=relaxed/simple;
	bh=9HKmJxmZbh93QuguriSz9qxa57OuUO38rdnI+Tie/HE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KzrKRommmvsRRZ6arwI+byh8NzmMiFlaybpTIzlYLVgYMPPWZDqiKVN75ZutuunkoIl2idyXLAuBkEMxb/Yw4pW4rk1gvlpHmwcHau3FsQc2Ra9riXRWKtrhsdNzgDjxHNosWaOqltWd9H8zqdoo6yzILehflfdjpLrETJ0yXEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G0/g/S1F; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d1ws/Hsl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G0/g/S1F";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d1ws/Hsl"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GA9Vra2894202
	for <linux-spi@vger.kernel.org>; Tue, 16 Jun 2026 13:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9r9d00/B2qPIrDcuZ6MLi2lkTJhfEfUMswMZ94qwOYo=; b=G0/g/S1F3RkQ2tG2
	nw8qT2t0cucXgZWclNl3UHINwKevRrmD4TavQdkQiwAoIxXJjhM2FzE0oWd+FS1Y
	7FCEwE6K1f8B7UV0L2IhNvMhvaVgSDBgGDYMnAwYSBUgk5EGqFbGlMiAm/QOsIM1
	IggCqDKuBO5enz2+gkwjuuRLB28My7fI0A2NI0WlPzjDthg9u7496ydS4u8Pistd
	CObDyhABaGph0GqLu6fieH0RBLtbp8opSLsVCNrQxU3crLO72R6R6naZa5S7Y4Mn
	StxInZZsM9/ooqgPev5zKOkOGnCEsrcaoTJLiynw/tBpnNVNfgRR9OwHD9/xZQ7w
	tB6bdA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu253heb6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 16 Jun 2026 13:18:39 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-915976b2dffso34677085a.3
        for <linux-spi@vger.kernel.org>; Tue, 16 Jun 2026 06:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781615919; x=1782220719; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9r9d00/B2qPIrDcuZ6MLi2lkTJhfEfUMswMZ94qwOYo=;
        b=d1ws/HsljIVmpx38xkw/y/5RbFQNujtRffm1Gd8jx7HtEU9fPcIlS+nLNgyCK0kMNH
         L2XK171qBHpHx0pGN3DjVfCTu9bQysgU2RHEw771VGX8SLmkghnW90myFXzqxJqyxXcv
         HG78eejYieKUON61JqC1aMu9xmq4qlFb511kXXzoGVONuBw5LiUm1OTtVg2esStmaiqT
         0Cg+Eb1poCuKszneOveGkWH3p9NvwRfOp2lt2FhpbwPggBAmg2y9EWr7dzS3cLz1MzJp
         zFEk91z3RRWOhB6pGGwnH85LienID9oyue7ZK023sxk6MR/JPaOZWqWMyapyeZZdgyNz
         1FPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781615919; x=1782220719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9r9d00/B2qPIrDcuZ6MLi2lkTJhfEfUMswMZ94qwOYo=;
        b=A7055jFpv6uH4U/u/GsNL0MkuMdAyhdNJGHH6YUdL5BxC3bXYeJxBMh8/H9bKmTo7J
         LdhQBoXTwu56qexaWoDiRyCNinnOJSyITHQUNBOsQwqUHCZXnlVvlPpx9rCJ/cedDCtg
         S6NvblOIAtOWvcNjJyzZYB+LZooWsZuSb7fXPNbadIpSlW+MexCAitnfIHlu1BzKydG7
         RYBFSdPcfP4vklbIpEEpo9C+BPIwfJXDRpM2xAWMmdikuO98HbVrq9VPGmOZOBka0rC9
         6PeeI80I39lOQ2laWcfS0nlfWMuGswX2XOqTSxDNMpvomSPieyPMLwXXPMy6c3lCoU9r
         ifoQ==
X-Forwarded-Encrypted: i=1; AFNElJ8N3CCl0lrUZLuZ4gcjMUzdmKftpV6fo+Ty72nct6rWAGhAzbKen3Fig/ELiVeuv/78bb0sX4zajuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxCp8b3iABXWwrUFxdkdYeFD3kxmxH28xhtUBSzzozYrVAGGgs
	1oSCruU9ZceUFdvy/IF34pqNIZ5VTZb6N2ovB2qimWa4FAYg4Qwk3+SMPYH+5YZnfRZHR30lm0T
	/9hFx3ODryhs5lSfoNbEB+GSrqYto63AgHez7H8heltwWssAdOoTs5oSFxPqNGP4=
X-Gm-Gg: Acq92OFyXpttBgUhz4sNdWzEV7qmy43JizvuFwplpZYjkPvt8l7KoOpe2b53tTUlq9N
	wf1c2s2bFQbrgLE/F3daIiRqV+8z2lYqbvLub/jisk7OiiiwBBB3NO7yPQ1bdByhlP/v68eao78
	LijmunCrPm3V6+XIXCQGy2RDE5UmYwVDOlHQ8gBohiqBVSzo5ONhzsUfQF0g+LW90iPr1DulH7q
	IGD9k/oyTkYtKxyZ/AwOlV2TaaTyl5hcgULhBzmnvJfhqMWvnI/0F/Uswsv+5sZf72IJEzcKwBT
	vbHfOdUymqV6mcp4EGRe8lWSt+ZTT6aUcbOnVof4iowOl9EaBSnb8cWmNFZqmPQS4exezuvhQT+
	JlpA5/JFWDo7ZY2UflQxr0O8JFNaekMQ5YGV6Bhn3v1fsxg==
X-Received: by 2002:a05:620a:2729:b0:911:dfb8:37c9 with SMTP id af79cd13be357-9161bc7409cmr382851185a.3.1781615918694;
        Tue, 16 Jun 2026 06:18:38 -0700 (PDT)
X-Received: by 2002:a05:620a:2729:b0:911:dfb8:37c9 with SMTP id af79cd13be357-9161bc7409cmr382846085a.3.1781615918102;
        Tue, 16 Jun 2026 06:18:38 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e16a0fasm3532627e87.20.2026.06.16.06.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 06:18:37 -0700 (PDT)
Message-ID: <e6dd7006-bdec-4669-acbe-2c06e87cc781@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 15:18:34 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq5210: Add QPIC SPI NAND
 controller support
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        sadre Alam <quic_mdalam@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260514-ipq5210-nand-v1-0-cbdd7492e826@oss.qualcomm.com>
 <20260514-ipq5210-nand-v1-2-cbdd7492e826@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260514-ipq5210-nand-v1-2-cbdd7492e826@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: wBIWBJwrQmH8oFO3SagrwrDg0HGZguJ9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEzNSBTYWx0ZWRfX83rxcUVfPquY
 CnBei3aWYJ55CAl1YmfJEJHE2a1/IbHqevNFakmsf6zwSpkmIN0163JIFlakopLDCH7t3mQ5L9/
 RxIoGWDTm8CLclHPFom019XIC1jBZ0g=
X-Authority-Analysis: v=2.4 cv=WNdPmHsR c=1 sm=1 tr=0 ts=6a314d2f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Ju4C-FNr2R-pDinXp-kA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEzNSBTYWx0ZWRfXyu8Nw1p2jrsx
 oqSXMS4Uo36g59NvaUTwAAKkCfEXe8T/LC3Lns9ek6QfdfmXnfaU6/hSPtuGJtIzGd57kqg3og4
 msq+67GDq2NUGqmKH5qrg7yZZbTiY/tKevD1C9jjo+cGSJ3x+SDK0dcx7bzmVqn7gL6M1bTTdeb
 46zHFRXUbsQLKXuFDCfY/biudfICXlOLsmjVbKvCvU6GlAteORLC9wy3BiIZyMbJC8aqnVYyn4Y
 Ql+nB64BvP2jSaB1kiSMjuB4TMYJCMUI3DVjbx+/eUrUlQJEIuNLJkvjFDXQ5U6pR1PQQTHNmvv
 Heg+xcBxrYacMTOmUZiNYQQ8PMJjDNtjB2fYNroBsWnlquyLSPnLRipPCikKhwrtxRdIsRHe48j
 6+lQ7PGG62q7t2bPr6vxfq6xLoJmXthyTINICRziSHOzv2QFnuqFmSNXLc55KNyhi2k5ZwxZiM7
 QV7pa6e/Wlp/2sQHq+g==
X-Proofpoint-ORIG-GUID: wBIWBJwrQmH8oFO3SagrwrDg0HGZguJ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160135

On 5/14/26 8:45 AM, Varadarajan Narayanan wrote:
> Add device tree nodes for QPIC SPI NAND flash controller support on
> ipq5210 SoC.
> 
> The ipq5210 SoC includes a QPIC controller that supports SPI NAND flash
> devices with hardware ECC capabilities and DMA support through BAM (Bus
> Access Manager).
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5210-rdp504.dts | 42 +++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/ipq5210.dtsi       | 29 ++++++++++++++++++++

Please align with your colleague's submission for similar platforms:

https://lore.kernel.org/linux-arm-msm/20260306113940.1654304-3-quic_mdalam@quicinc.com/

->

- separate commit for SoC and board
- is the BAM host v1.7.0 or v1.7.4?
- style: clock/dma-names, 1 entry per line, please

Konrad
