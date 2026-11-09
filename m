Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235677;
	b=Qqq71LAPQDbhJJ+goclMmBlxX2azCDAjEX6sSxZZIvTuw6Cl0VW9OZ8fd08qfcWh2E4b
	 60lR9r+YPS5qXRnA5yHLbaoYZlwjHaXv067vvSulaJEDXpvwD3KJzTiSB/ebMKShuK4++
	 z0lp2BAMpvap2lQJ2zLexUZnntCcSGSbhSrTRIcJyMAuf9j4Qg9z9i/kO67fRFM07jonx
	 xvqPiWEnL30QnwzEmMXbW5nywNqmZBwcotC3iLTNTJDkAAR/aGQEuaH0jiN5THXowdZf9
	 2/QI8iSsCIxejDl6+xB+MITveW0oi6tKbTBWVUqEHfK3/a2B1GopPGcXYfG3+Ta3qcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235677;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=8S+tQBGffx4GavU3iQOwkuWydZ1DqkTiSiHsOGPzy7s=;
	b=jVzsGut6nzhvVi+Os4250LcaWc4yRmwAsAJvFGxaymQ078XqGc80d6lvbYul4ACgENvW
	 EnLBtQf8XWr7LEU6ZwI8hn8kstt2qzlZcftsPMI4TkcNzR0YNXJH1bpLmRhHTPV19aedD
	 1rNV5FWmTos4B429xrA2vFEdNERVQwaoaVOkJnpOWwbOS19me4ZrA9i/cfGiOgbiifmK7
	 u3/WOiMmX4nAVudSacDviIukAgcR3ZALhdxUrpj30avbt3bSesfyeFEuCFZl+xHb8o89V
	 DwAky08HIr0iBCt9wK2e82k6J4hHvLnxIYWb3b95D/Zq04g6OVq4ti1Y1yU5R6Vnysw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V+4ERrG5;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DdDGw81i;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F92606D801
	for <linux-spi@vger.kernel.org>; Mon,  9 Nov 2026 14:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66F92606D801
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V+4ERrG5;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DdDGw81i
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DFEA94025863
	for <linux-spi@vger.kernel.org>; Mon, 9 Nov 2026 14:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8S+tQBGffx4GavU3iQOwkuWydZ1DqkTiSiHsOGPzy7s=; b=V+4ERrG5i3T8g0Fd
	Is/6bobd+s8g0yAgT8c5rZRtQeeTMs+UNr/k0xVQZu5BNGkn07kkYc3GFwGBdtfz
	JLXYbROt5NleJlGxig3qsGMChILhk5Z4FCqqRbrIjzagCTEvdWQdFS/fFFk6WTFI
	uDzWWSpqUNF3Hw1uQD19qXqneF5LTVK/saAZEWmJvYq4kETLsY+77mpmi18JtOuv
	uvkrQ/fOKX9yLnC34jXUpzvfpbh7xR7hHNljYZc68x91gD5lrHhVpp0SNtUDceeX
	XjACTel0HmBAMWfM+WOOsyhq/wl+9SLTUdt/OC1t7YgQ7ofQTdZgLoEFYxi7cp5u
	fF9ibA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hua589e2y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 09 Nov 2026 14:47:56 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5ec78f43e7fso46237e0c.0
        for <linux-spi@vger.kernel.org>; Mon, 09 Nov 2026 06:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794235675; x=1794840475; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8S+tQBGffx4GavU3iQOwkuWydZ1DqkTiSiHsOGPzy7s=;
        b=DdDGw81idsDaSVqJdnLFw7iYk0LASCh6eDnLvNFODhpqbsOgT5XiqfP7hKQ/kK2+WP
         liUV43mHTt/nHfUgG0cAD4E3vmKr2mKLbFWZikdmH0uEwmYZUeWUVC0bYuegc/HZxJZm
         o0ZPV+zOceM2/xNDPTld/Ir5qz2FyMiEzln4LC1R7IRLWElWAqtzyRsB66UG2r1x+S3l
         A4yt6ZAe0FuVfNfME3lW3sTIR04nKgTDNwwivCcw/q292HHf71kwV9BuVleExMUtK6IE
         1dCBKJE/zgAXnOWyYK7z1YeMTNmnEcTCgHL973r43sBcIV/i2CoFC2XAf+dtuXETFFi+
         ckzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794235675; x=1794840475;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8S+tQBGffx4GavU3iQOwkuWydZ1DqkTiSiHsOGPzy7s=;
        b=ALbc1p6NYShEgk/Q6PjYcmfqyOAa9cin4qylApFhIl4lsFsvUI29H/M42hLQIZkpBs
         xjA7R22LnbAXO195lYIF3GsQnpV8bKOCSfeYmX+hpia9PK4HL/keVA4vAh8t6HasOhf+
         Oy/ifVCzc128onzToNAjGLZqzbXln+TcWPpRviDFyb5+fQ0f5ostbI0lk/uyjCYpKXVJ
         +sR+JH1cdWmAKI2EAXZxPtPrBA4o8wcVpjBi0kSVQG6r7DHd4gQRBJZwGJdAPHlyBOQA
         nKllR507luWfnLGEElwY/mBbQ/SC0Aam2c2nfGfOa6xIU0Ax1oYx3EOAeNe4k0Iwp13c
         bOTQ==
X-Forwarded-Encrypted: i=1; AL+hErFdphvNJktQRRc03DmOAjSMgeMnxLfCD8IkEmwsD1z8GNfUe5e3Z7NyesfgM2w6xd49zuYyXny/kc8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ak5sLevcWZ2cst9y9sA1ThvgzS0VGBUtLgZiJQAK9xUgQArk8
	Oar/enuPDs2DMb/awi8KvimM1juqnnkMrLxo13aXeGJqTgFaJbQRPGocqfx67qXclroyKce0yEH
	HFcoINMl9lE9nD0RZ9OW4s1SAagAwLdoTeEtrhSCGBGn4/Ygw0l4oxPcRGc6GiwY=
X-Gm-Gg: AYBFou36ZpLTrpNYsCslaqGzqpu8keMyk+z0UbzWnVxiP+qNJRJSpKdIRiTU8TD7TmG
	pXc8+yF1gH86r1kTFxKKLVASphbpaz2NC13xGuc8xrRW0aOpNUNNlGjHV+fku4lYQ/8nTPInLu4
	2lupVVdVTUd89KUfLuk1//FRyfJb/mIGeC4Lj4SsvKE8VCMwJ3qmyAy0HZ75qyRRsdszHM1nFF9
	tHtOzE1P/GoS+H1HBmOFVnZGtkSNKkheRrvBch6ZCZJs8ogCbZU9ujVeBmMfWOHyPW012L/W+57
	NC6U07UMwCkr4ZJC51hSCAI5JXwsiSi4tof8XY+GCx2FIAyVP9PWIWt9igugJ/jRmYZTjn/ZUw9
	Ya1B0TruQ2y/BzXicbFG2bJ+BATaaoK5omipyRwaO0NPxxypvou4xgJ4GFj9WlTQrzyZlcg==
X-Received: by 2002:a05:6122:62c6:b0:5e6:589b:eeec with SMTP id 71dfb90a1353d-5ece74072b6mr1736251e0c.5.1794235675597;
        Mon, 09 Nov 2026 06:47:55 -0800 (PST)
X-Received: by 2002:a05:6122:62c6:b0:5e6:589b:eeec with SMTP id 71dfb90a1353d-5ece74072b6mr1736221e0c.5.1794235675113;
        Mon, 09 Nov 2026 06:47:55 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d69f9384csm180195166b.13.2026.11.09.06.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 06:47:54 -0800 (PST)
Message-ID: <8015c245-5bdf-4088-bdce-7e81b3fa440e@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 15:47:52 +0100
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
Subject: Re: [PATCH 4/6] soc: qcom: geni-se: Define the QSPI firmware protocol
To: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20261106-qspi_upstream_series-v1-0-21f43042dd60@oss.qualcomm.com>
 <20261106-qspi_upstream_series-v1-4-21f43042dd60@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261106-qspi_upstream_series-v1-4-21f43042dd60@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1OCBTYWx0ZWRfX4fML/+SnHYgi
 cXCrck+63S6+SNciCs8XzYWFD9o7lyKK6cHTs94MGNbBqQaTdBWD5m5Ns8gHX7Pep6aRvmCIMsi
 f/BalRnMJwroCWlipx5+ERBZzoL+nRVLcgbijDfPejzLSK3aD7330XF6ZzOp41UCqIDTj2sxIDV
 PwJdK7BxsGp5W7MkrZhiaNi1Su0ecSFsURwDitnYqzCX8tt5eiz3RvZ/ryLkV8QePsF/8HsKCvk
 p46ENMGXogsWfdyOVV8aCQ83YhwqTOK6UVQ5Whchu7LJr/5Z+MY3uma5GHx6Z+7fyNukBQ6HgKq
 aQk+bNagcKgzvm4HsYQauBI/ZIFWUrZLnfzpxlWhCXKUUBf8MCxEUZh7MkhVnvlMIDUzIKIFdeE
 qNHfLVf92b91Ur5IRn1fVVHoyr/cbPsTJHAOcGt02SteeEGT+L3B64uFnfaeMGjpFdeUPEQW3Q4
 G5h7ggzd+WlmhAZWhFQ==
X-Proofpoint-ORIG-GUID: Ynz0cUkgub3-E8WrzVGB_EZ5-vS6uVEs
X-Proofpoint-GUID: Ynz0cUkgub3-E8WrzVGB_EZ5-vS6uVEs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1OCBTYWx0ZWRfX571u8pkanJap
 9Gyle9CGR1UDBcw/Ck4mlnnOxvEIGXZUJamXTqpEyUNsQmw7DBChonR8bpdwUwVJC8Gr0OQA62K
 BfDruFuASHWC2oL5ZR2+iUJ57E/l3z8=
X-Authority-Analysis: v=2.4 cv=C9V8WgP+ c=1 sm=1 tr=0 ts=6af1dd1c cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=AQxZ4Z-7SMcdX-UDKNcA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090058

On 11/6/26 4:01 PM, Jyothi Kumar Seerapu wrote:
> Add GENI_SE_QSPI with firmware protocol ID 9. The GENI SPI driver uses
> this value to request QSPI firmware and validate the protocol running
> on a serial engine.
> 
> Extend the firmware loader's protocol-name table to accept QSPI.
> Reject unused protocol IDs in the sparse table before looking up
> firmware.
> 
> Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> ---
>  drivers/soc/qcom/qcom-geni-se.c  | 7 +++++--
>  include/linux/soc/qcom/geni-se.h | 1 +
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
> index 873bfbd6b2b7..396f3d81d292 100644
> --- a/drivers/soc/qcom/qcom-geni-se.c
> +++ b/drivers/soc/qcom/qcom-geni-se.c
> @@ -122,7 +122,10 @@ struct geni_se_desc {
>  static const char * const icc_path_names[] = {"qup-core", "qup-config",
>  						"qup-memory"};
>  
> -static const char * const protocol_name[] = { "None", "SPI", "UART", "I2C", "I3C", "SPI SLAVE" };
> +static const char * const protocol_name[] = {
> +	"None", "SPI", "UART", "I2C", "I3C", "SPI SLAVE",
> +	[GENI_SE_QSPI] = "QSPI",
> +};

Please use designated initializers for all values here

Konrad
