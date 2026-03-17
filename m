Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45F43F54B8
	for <linux-spi@vger.kernel.org>; Tue, 17 Mar 2026 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766374; cv=none; b=U1K5zs1nzTcio6GqlDayvuuHjYjLDm7Bpt44dOrdhX6F6m4bDQeE1Nqo8HK33vxjl1eseV4IMWn47ZDc6vT4jUCGWucmn5GG7yD3nFNn2UAV2Xv3HnogTBHkVNEdtIDKYnZD5+/1vJ+gH4rKegjEQe/W2eGeHrP45u4TaMXH34o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766374; c=relaxed/simple;
	bh=r2Hw40NGEMTfoadqeBLj/N1ipaflVfm8NH//Hp2YOw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FTtxrWad4bF3wKO8/1sLYBBHYvifYqwmt4H7TpscSutkJ8MmiMrQHPhKht9vCkJyy4H3DG49tCXkNoF/DffnqBWe3TeKe5DbOHb6Wd2+fOUffi2gFgzEo/ot7d1SsjF54fSd32sSWYNPNXu2bx/9Uz2I3IthbI2MlObw325Exx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mPW1207T; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=R4zevFxT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mPW1207T";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="R4zevFxT"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HD4wQ6668921
	for <linux-spi@vger.kernel.org>; Tue, 17 Mar 2026 16:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cEg5ym3EcEaTOyPG+2ZqhgfUUahdgeNstTiMv0Dd3rg=; b=mPW1207TfUddTigg
	Sbu8/lAYVMayKWH0wclGUgS7WmBBZx/gBBsn4PJNzlzIVG3ycVLgVK7//XokS+1D
	4sMN7X6XkeIpPha84qurr3wY1buixc1YTyQ6jlhietz5roq1bjgZrmja2inangTe
	G3Z5W3Ak28BJYPow6CjOeuFZjon8v28D8JevPUcbu3U22mIjbIBIhiiBcbD6LajQ
	qkxg0BLWCM/dji3j1E8IvNHcy/0nDj+Il2SS1GFOYcC6Xv0ACtGrWe7Y8nd9SjTd
	mFphK58dybTnxVWNeezFVm2678MVLHPpOI1nhcF3CT7Ugsog/CI7bspWJ3QJ/6xd
	A67cyg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cy7he0w8y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 17 Mar 2026 16:52:51 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5090f7cee3eso35547441cf.1
        for <linux-spi@vger.kernel.org>; Tue, 17 Mar 2026 09:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773766371; x=1774371171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cEg5ym3EcEaTOyPG+2ZqhgfUUahdgeNstTiMv0Dd3rg=;
        b=R4zevFxTcHm2btrEQtsjCHBMnsRDajvZ8TZVt+K1PJkOpCnuIAAOXUfLtoneqmrhMS
         Qfl8ef6oEchUic/Sd4TD9fSEPP+lOEMi0AMLQOClHhvZsOBDmoMHxllCcqjk3dUq2xXj
         ofRgpy5hHvta2bfSN1Vh2UQ0Ao+McoIdC0vFetIQbJxy7kWxMChlA3jDiVhXkqZAJoTE
         rni00hsdt5hTGKar8EGP3E8g35LysvX9JBxB4Lv4vWjprxA+P0CFF6f6eJNLzTrdNSmR
         wYUAsmnGCwUFw4GtMHbA9S95HykOj2f/XXehRaWs0llr46l1RWTisYKyixKmETWgo4rl
         6eMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773766371; x=1774371171;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEg5ym3EcEaTOyPG+2ZqhgfUUahdgeNstTiMv0Dd3rg=;
        b=BqfHDaLBT0J/cOcHrpFmeHnVX9ixp45WyLB3ZHHoAlrsSDLCknZUlsU25zUrwnCbit
         Jkmqat1cZ+WPZTHwH75B47kk8Ws4lFg6M++UeggLGnjtreN3kz+GIwVkDHwfkVhn2od7
         by84bjh/OYSl5jrF9pD2H5VR57Pj0Pv5UAFxxzE9iC0IH8C/NvmFvPXlldrSqwixB5ap
         QFNg87uTINtmNyY2cqSE++FqZuajNNtLwbptodgUSjVLNzq6QywmW2MnEGbqb71Vqwvm
         cj9WnTQQCei5MZ6g69JXP+qiLCsIgSoh2ykvuPhz+qJdrUsh+Rps/erBSfROZI44UrkZ
         UXZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeVbKY5VLa0usFK9MVpqfe+lghRL95i6tqmJ6FwBdfdm4RkrKEpUtdrde2ozNwnc+U0qcTYzQ/xIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YznZa7Da6+0nBZo3LtsweVHV6L9mWLfjBfcNT+BhSXM4gLkXaqW
	pmuA71OiXQhU1pUdnaSJLTlzpa7de+8SJXcUiKRGb0m7w2fK3+1JzX4HXPyEkcU5oPqOeKBd+PW
	+Yt1oS0oE4rZBiZuIKBQTYQskcqhWgDzFbU7aAJm73UNVMHG4pf8Yqet0v2LeT1c=
X-Gm-Gg: ATEYQzx1mXMJAFVdBBGKwbP9UBlMp6dfKCIj7RDQAI+huiudswvHsDLKQ/0e79RL3YS
	v2oL0eit62ms8hsHm1fSm9SmX2hkBKDgZUnSVmc+70O6MB4dBWdy6kQmW9wGHt/rtiVydbYJALK
	Xl1R0R/N29tbYUrQX3b7bly0PF0TV7iB4wLxJ2+pMbvWgkJCrCnuCLgfgNHRWMCAvcTyBw+19iN
	dNRRuBLNJXqcf2ZdwGJt3UYNYTd+MNBhBpE9lKakt1XmFbqN964SlaIqI8hMOoCVntPH2JHsOAa
	MTexS3Rb7VtlK+b9U5WdNLIkf1Fk+4lR1HVAWItl1Fx0Faik+YfhKbvzidLY9HoN3bx2E1YHm6B
	JGG8lJbnu67y9F2Fr1+MuUYMOhKPZ9pvaSoK6KO/awoiN/clLQC3HTvdZIDeCgg3I23yJIbBiOT
	txd5E=
X-Received: by 2002:a05:622a:1650:b0:501:46db:6b2b with SMTP id d75a77b69052e-50957e7256dmr203659931cf.9.1773766371100;
        Tue, 17 Mar 2026 09:52:51 -0700 (PDT)
X-Received: by 2002:a05:622a:1650:b0:501:46db:6b2b with SMTP id d75a77b69052e-50957e7256dmr203659571cf.9.1773766370439;
        Tue, 17 Mar 2026 09:52:50 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38bd517e0fesm616401fa.14.2026.03.17.09.52.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 09:52:49 -0700 (PDT)
Message-ID: <1481817e-6661-48ef-8e1f-707fb168f264@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 17:52:46 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] spi: geni-qcom: Check DMA interrupts early in ISR
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.andersson@oss.qualcomm.com,
        mukesh.savaliya@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260313-spi-geni-qcom-fix-dma-irq-handling-v1-1-0bd122589e02@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260313-spi-geni-qcom-fix-dma-irq-handling-v1-1-0bd122589e02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 4fpDHrOEBgGAnOFXnCtCeYidGoG05b-u
X-Proofpoint-ORIG-GUID: 4fpDHrOEBgGAnOFXnCtCeYidGoG05b-u
X-Authority-Analysis: v=2.4 cv=QsVTHFyd c=1 sm=1 tr=0 ts=69b986e3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=7N2lBykIQV5UtMlc5SIA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE0OSBTYWx0ZWRfXzukVao2ItNJu
 lRp12EFPP0ULBsSRAEF1UZc4r0uVMqOX0uYKb/BCtrHBjU3XJVWGjwpNvOhHz19Lkfg5HQSjwxY
 Wm2AUg1nn8OQ64Xo9oxKjqdiq9Fuq5GFjI4gA2b1bppGQLJuO/lGL1k6RldWwfOoTFYbnTKNF5x
 eOhKXP1sn+DR+HoKtjSXRKjeVZPGLP+yGnXUUYpPVM/cSnq22o8IW32ERPVwFkjbeKJOnXcN6f9
 RwPOgqp43Oop0dX+OHnovpIAdtirL27zTlRenq+iX67bDJH86soxf3oO+PMWPAv8beymgUiwcGz
 VPq9IJUKBWPjjbCRu7wwXrypT/0C47Kzcbl2pnb2ta+r0AaL46MilhiXic0xUVP4zuw1WMdXpzE
 ulwqauk51v8Px+waq/DXpStzCNO648I1V0yjUKn0eZ5hYzUxk0843Hnkp8pX6el+B/UriEr01nA
 dcp0auqZcJCv8X/3kSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_03,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170149

On 3/13/26 5:19 PM, Praveen Talari wrote:
> The current interrupt handler only checks the GENI main IRQ status
> (m_irq) before deciding to return IRQ_NONE. This can lead to spurious
> IRQ_NONE returns when DMA interrupts are pending but m_irq is zero.
> 
> Move the DMA TX/RX status register reads to the beginning of the ISR,
> right after reading m_irq. Update the early return condition to check
> all three status registers (m_irq, dma_tx_status, dma_rx_status) before
> returning IRQ_NONE.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
