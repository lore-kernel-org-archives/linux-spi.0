Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D80397B1C
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787662702; cv=none; b=HHSchL8ETBNPsh7blw6cYW+pV5Y+xlc6S/zWFazPSQuAWKRHCnSiu8gekX+gr6ol4xUCY9PU5c+bw1Bj3H/M1BBYFGf/q3FwA2lInDgxucxCUoe/qZVbJeCXZD6ldTvY1gq0RNCv+3kJjPcIaB/3Bfv3RK46i9v2TG0gShrZxmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787662702; c=relaxed/simple;
	bh=7lrzW3e9+VzyOzJ+S098R/p2dFVHXPOXBuZx2rcpeyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZKDAUCAmi+VaIg2acToqZZdMtBGWlg2+bo7jsjQyuZAl3BmTBqh0glXwt/ipk4gbWDyz4tFRkQx++sHyeb+XTYhtbyBwL7Z7DBumw/67PNq3M2DghsjdeTQt0/75eogZsYY/+nC6EpcSn9d9bfFPf58x43kzqkRZxTdTa1PWo6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mGAfDb7m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RX8P30XA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mGAfDb7m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RX8P30XA"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PAuxQo1152968
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 12:58:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G3ifIdPdT99rwneLSkbnF3VT5njC7knW/MddlD9ny2s=; b=mGAfDb7mOADjtpDo
	RBPniUWqvV6pIO0mDRcbfNN5bTRHFUmfheDRIHRROJJkeBdWj/I8n4yDB/arSwW1
	4SoVmtz4JMoMBNh1+vhnzmkGDVH07p/tHv4po57FoC7yYo69bmdXE/OJeFnJbksX
	+4Rw/KwIXQwt8bwCdyk1GXPAM7YB2+AcM/CW+S4k1IpVxq5Y5macXYSPecRKX38s
	fKTBzkDXDWbNL6cPyJyypPLz9bV2TLqVncGCeuk9uz5QmLlutvFKtQdwzoBr+n1F
	wWp7g9XO0k5sUaNYXU0Wye3Dp4c/JjmqCBRWtefIEwt7HGsSJvfIs3rfIQnRdjrg
	zQcU2Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g93nat056-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 12:58:20 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so7160347a91.1
        for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 05:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787662700; x=1788267500; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G3ifIdPdT99rwneLSkbnF3VT5njC7knW/MddlD9ny2s=;
        b=RX8P30XAXk8C9qtsYaPQEDN9yvOCQGhzjXIpca3P+jDh4VUT5sqXIzQB/pmqpjdlp9
         tT2wQz9gpr8HRFteqaUC3W+KzwemLaVedEgKSDoqBAJb+9iaHYnPTKRK/BzQ2HnAIJIe
         +UtQmK4iR6TONh7SstC1LXbWL2Jde976GMde6Uxu/5oQngahkMmFnvSBv9jrqD8IyhQr
         4u3rKYnzERgHG/OpWFiSMfxdz5PdZvFl0AvtkBz1vf0GxEJOqkL3Jx9oDcLAakpQpqPe
         rJK0W0pYT3vLcreFQ6LrVGl+ZIACk4DJussQpzuDPqlMIDeo5y3WcBLcx+hLoHQ1W4kJ
         HN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787662700; x=1788267500;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G3ifIdPdT99rwneLSkbnF3VT5njC7knW/MddlD9ny2s=;
        b=VmREQhdwURWbSsG10XpZ1JJpuxRaAb6aMy/HJWCA4UM3J41ERkX54ScGU5qJG1SVvU
         zEYNENmj8UJbQ3vRs1MmhMf6udaBayXHxFWuN3hoatNzNz8DmcE9p7ikkk1p2K8NAdnp
         6Ze0pksbct1pWGHrDup41X1qafyfuipnVPMrKIMCFooGuzP8v7i0X3DnqsKqQcBVjNvd
         3DJmBRvlAHVoncJAgK3J6IW1EMnIGFP1XfkerGl0r60azrRmoZac45JAW27RNURLgDL6
         JwPNW3ZWN0fWaSdW3LUfuCVW5aq1bM/S9HsCWQ7keMAUkfSrrLI1HbQnGMyiHl4J4jGg
         jhHQ==
X-Forwarded-Encrypted: i=1; AHgh+Ron2zztc4NtPSewqxWZBFwt8lQNUGg0XF5bOYVQIklH6MJOdaPlOdbaaIomV/b4XAgr//CcQBQ9r2A=@vger.kernel.org
X-Gm-Message-State: AFuF++lrzQg78f/mnEGi9b/Iaugi9pvo8paVR5JwmE47rH7FRK2mqj7r
	/gCmgWTn4FwE96SmPQnkFf82VnLrIJfpWc8KAZY3TdDLnMX6yc8aJR65ZX1r6X+c357jwp+wooE
	sD2oySyessKay4pqJnJMT7QWjIwGu8UxU5ychovOKqCQ3y0OEBLPlMJWbn1pmBPqlbAvK9uQ=
X-Gm-Gg: AR+sD13Xc3zn9kZxlORDBpPMqn43KafNdZFYKncOmmsgGuvGbt86UjRRrmfplpkvSrP
	YYR2r+Byx0AJwCKr35j6ooI4TbQpZRrgDHszZ8bN8Krpaf1c+sHVY3MD552iqR+aOaA2QtoLjvr
	9+/lnUUUhCQENjg1Wb0mLOaqIFI+eaWgCdkQOa0+SBbHU0crSksrHqgqvmGBQOnUfBuvXCpjSkP
	kHp7+s8gwdCT7vBBc7uI1VG2pZrCI7NChaHF9/Cr5njHFSMXMkOA6ZayJQylJ2bQdoS3z90NUdZ
	7XrTst92CCKcPgIVXwW3iLXWGr2b+2+d/gFpMTnsXd4oL6CVw2Qgg2H5cFZHwZ+F4QM20ACu1/2
	d+UQfC2iMZ/5alPlGwCOxCOou5Tko+VDJeP4=
X-Received: by 2002:a17:90b:4c81:b0:380:f85c:94b4 with SMTP id 98e67ed59e1d1-396463e4314mr11898990a91.7.1787662699792;
        Tue, 25 Aug 2026 05:58:19 -0700 (PDT)
X-Received: by 2002:a17:90b:4c81:b0:380:f85c:94b4 with SMTP id 98e67ed59e1d1-396463e4314mr11898862a91.7.1787662699236;
        Tue, 25 Aug 2026 05:58:19 -0700 (PDT)
Received: from [10.217.218.158] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396420aa1c2sm1125110a91.0.2026.08.25.05.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 05:58:18 -0700 (PDT)
Message-ID: <545f5ba3-6d6f-4652-9fce-262eed393a73@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 18:28:14 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: qcom-geni: rename setup_fifo_params() to
 setup_spi_params() and make it void
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260824-spi-qcom-geni-cleanup-setup-fifo-params-v1-1-bdf98ae62953@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260824-spi-qcom-geni-cleanup-setup-fifo-params-v1-1-bdf98ae62953@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDExMCBTYWx0ZWRfX8NJygVUmMGnT
 K2qlJ35PD4nCEISJ9dqlRfhJZ8obbtgNxqByZQsywOIIc2+bqXYpSCaPnJh75PBJj1eyX5EVdtY
 PkG7bRbFym1hkjpoTDtSvYcAicAQFfY=
X-Proofpoint-ORIG-GUID: SOj54LfSYyS_113HXUq11reRWWVl5irA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDExMCBTYWx0ZWRfX0/7PUPJKfmhC
 qn/nm59nXJ8g9FfiJbHWYNrbU7ACvEY2d5JcIKMNAmZAyok0wf+Eo8GkpFnJFe8SCgk0eNyL6Ld
 zDcwAulbD7HXoOrIkqlBlqaKdabuZohgbCzUyuRJiO4OeiWDQTjm99wmQPcP+xHoc3ABDcneB8K
 Qf9385BTD24JRkKh1uiBfjYK6SCY8GjT1Abgkcch933mX0u1+WZ4G9CCkkujjWu3CFDVoGA+Ntv
 C/jIqa06Lm6A7UV8cX4TM5eLa0/UOgVzIo5ejGuVhFNhvj0fCwe/nx1LRtsejRoc0mokoGxKBob
 RQmioxLSgkl81RyC+wPr8jSFEXVgENY7SZOou0Pt//GBaRY5hNRS7wpr7vHwq/O57kInK7/tEqW
 2UOJT7Pe9SBavaGW2V6rH5zhPldzQ7eziU8D+awd4xHU59mO3gdUx7v8ibPBL1qU9SPZgYPOIGL
 ApQb9P4jmSRMwqBJIlA==
X-Proofpoint-GUID: SOj54LfSYyS_113HXUq11reRWWVl5irA
X-Authority-Analysis: v=2.4 cv=W74IkxWk c=1 sm=1 tr=0 ts=6a8d916c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=pkmFLQsO-xIKxrFyL9MA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250110



On 8/24/2026 3:43 PM, Viken Dadhaniya wrote:
> The function always returned 0 and had no error paths, so change its
> return type to void. Drop the now-dead ret variable and error check
> in spi_geni_prepare_message().
> 
> setup_fifo_params() is called for both GENI_SE_FIFO and GENI_SE_DMA
> modes, so the "fifo" in the name is misleading. Rename it to
> setup_spi_params() to better reflect its purpose of configuring SPI
> mode parameters (CS, CPHA, CPOL, loopback, LSB-first).
> 
> No functional change.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
