Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DC330F95C
	for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 19:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787167936; cv=none; b=tawCOXi3O2Zn+5WDwSLPtsNkG3F0Z9AGFJCc9o8JYrS6q2XLLbE7k0eNEoSfv4LWF6PQNtXKenPl1P0yQaV5BUUuZMnD0RvW6vNVeg4teYLvqDxevojzhvQxvyxL5D0IiojgCQL+RW3vi550BfwzizJ7V2AuCQEwnvYNqY4FNAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787167936; c=relaxed/simple;
	bh=SBSyjmnWu1n9LAqvatiRuMvNqWlIwoZUcRDTxxgTpls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WDtjkYn2aZspZmDPfQy+JSdR+abN9sWu0PMQGcoDHuUr1XovFkVRnFvaw1T6RH/q2en/fjnY6Q8TUVO7siskJhOVKW3sjjNWvh4xfcAtYkDOHiT5JQtaJS4P1tE8KN/U4+p13uoHiXjAhHc5Jzg6pTaq6SGK+vOJisgtJFhDHpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I6cwVX6L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VcfFnI0R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I6cwVX6L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VcfFnI0R"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JHqNEu923035
	for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 19:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8MeEX1ADqXj+R9Unp2Zz/zfrEDHKASiO/sxNbzyCrE0=; b=I6cwVX6LmC5JGOB2
	tb1Dtx8GfuBLCZdbKIGCRniSp7zOD4rzyGhAtgZMdgr0oo7Ft/HINy6rGtHa9LAM
	Xsz8w05D0Ti7JwXgoNj+9bDM6uT4MAbENafXQMRyK46DSEP7/rJ4Jj+x8Z6EZVoK
	hi+p9vm4vvkmfScLhUZ5l9vXpen8bbDG48uCDhUmUdfRx9kogjf/HwDFfAHOK1cT
	sRHqnFa63aN8uLzMk/KJWxxh33UiPW/FZ2MDHGlGl84SZG4Zyh5ZEXhhOaVho16E
	BfHUe5SKdJtpgAj0W+1xXjJpbNJ3arM4e9Tf2z47azSyol0E9ZbXP7+IXwZNfox+
	OC2RTg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5es59bmu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 19:32:14 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cea6a46766so20982175ad.0
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 12:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787167933; x=1787772733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8MeEX1ADqXj+R9Unp2Zz/zfrEDHKASiO/sxNbzyCrE0=;
        b=VcfFnI0RhheCDK7ijZUf1fmAfF1oeAb+c1tx3BPCNaLhjzhfS9lJk95RDYw3pjMsFF
         UdXC2zzmD0cpNHiKWnFHJs/D3fhQEdbBRbLst4mQ9TgzJnZFix5fzimkoosbzNb11fB4
         8/Bupm7/ZEEbaHVQnZJNyNCxe5z8khbW66pvlPLGwdZBE0zwtRK5RRP6i5UUeO9emrR2
         47RYRaDs/tdiyavlTevkxh5A8+P6BMLRTQwXirZCmtY4AXhxNObb5tEhXqkFpC5Z4Isn
         ePMfw43Pu6/+9Oc5C2yV6p5fv4nvl7yIv28p2k2Fgoh11auC5oWBf/PoHsJKA9IhyE5E
         Bydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787167933; x=1787772733;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8MeEX1ADqXj+R9Unp2Zz/zfrEDHKASiO/sxNbzyCrE0=;
        b=ZIXNRbM+WNgALjIBDpnPlvgsC3xZDQHTGFrXjHtvp8jlnT3AjknLjn0G2vQYv9/J1b
         N1gWJEiI4fxkofU9iXDsXS6KzTYI/eC3RKoxrV/CpBhJPe4kmocW6Dtez9cz4mID52uU
         cHH+ZlFSFfqoLdYy+94F3jWIdebd+se5JR9bNgZ/gmgFdHJxg+xymiLIubWMlRa5Ujgz
         vN1zHnKMh58z/hzOTt542bvlR8L3ReBqU/f/VJCNAtM638HMs1izBc1SuFBsBrsJZot2
         LHVsZqTjQFKmpM7BNzriBeTPIdHCkSlOm8EQ57ZhjKT8k5/CYBSAWVvLQbwIVISrJ4J+
         dBvA==
X-Forwarded-Encrypted: i=1; AHgh+RprZyvVRNk9g0Cprd3j8W0cqdqQSToWGy6jwU7B9PcUYnfhN7F0DdO13hS+e+G/RKCrbZpeLhccbNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvnxbLASM+lbEvKgYzK7rKBW5xkMK5QlBFvPY4gQI9G/d+JIzj
	1hepirwAhBdmk5z3vHDIDDSgQ0/sH36uw6s62ACoFUx6lRBNa8CE+d+QlB4cfWYQ1HUHBcMQN08
	aTOptQFR/oHWyeGX8ktWWUjJlKaLIZMhfUFCuwZ29Xnq3ncQzIM2ELwa5IshZI5E=
X-Gm-Gg: AR+sD13ZA/I8mrAy3AHHIdFX0prooZPNEMZ9lONwOMPdTQFQseJeQ7Eg76ZBzvMKYKF
	B9ZcaBpjlJPH89kBleIYOOBkTF2BlysVla1Gq0tYUqSJxKn1XpD2Y/CpUTUK0FLjjNHCFp5aPOy
	kVIRhr7Tj7jJPAlseHuVw/Wc2DyHGwTTGwDCvx83XPpvkwBp0qqvTbpIjYfF/hzRiDZycYn4YAx
	NRnETCH4b+bNqDubUEdQIOxHjP2Qgslm0GhhHOby8ePFX6yEim+O3c/pjZzDNSOxXQRPd69s9Ho
	YC8qVMs44Vp2p4BAnE0J+IHyPXc4EiHJB2KmjZ7vqEf/q4FRpaJOqzB/OEoodboMKNVr9tBW3Ec
	IaxhtD8JO/Csa8+0OBOZ74YViE3tqfPt9akc=
X-Received: by 2002:a05:6a21:6da8:b0:3c3:7ac4:dac0 with SMTP id adf61e73a8af0-3cd011b6517mr12158853637.13.1787167933069;
        Wed, 19 Aug 2026 12:32:13 -0700 (PDT)
X-Received: by 2002:a05:6a21:6da8:b0:3c3:7ac4:dac0 with SMTP id adf61e73a8af0-3cd011b6517mr12158786637.13.1787167932597;
        Wed, 19 Aug 2026 12:32:12 -0700 (PDT)
Received: from [192.168.1.5] ([106.222.232.233])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf1a1de1sm9919127eec.31.2026.08.19.12.32.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 12:32:12 -0700 (PDT)
Message-ID: <54e4fa7b-9a95-4871-94f9-65ac55688f7b@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 01:02:07 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] spi: qcom-geni: Add panic notifier to cancel and
 reset DMA during panic
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, chandana.chiluveru@oss.qualcomm.com
References: <20260818-add-shutdown-and-panic-notifier-for-spi-v3-0-8b62c4bc2d21@oss.qualcomm.com>
 <20260818-add-shutdown-and-panic-notifier-for-spi-v3-2-8b62c4bc2d21@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260818-add-shutdown-and-panic-notifier-for-spi-v3-2-8b62c4bc2d21@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: SwaagMemH3GpOmyYeqKlkpWppTXZWBLi
X-Proofpoint-GUID: SwaagMemH3GpOmyYeqKlkpWppTXZWBLi
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDE1MSBTYWx0ZWRfXxmZ6kul3PbI1
 KvfyL6aO9pfJQeNLWWeFvu9hYb+G3sYk5EpyXVzTaQ5dRbbPRmKJvkqCM7bv/m81ixwwhCpu+Yz
 TRJEUS3GaWBaAoi6zCJ4uOcXCOzxLGA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDE1MSBTYWx0ZWRfXwPY79qJJRllp
 LDH2W4f3aVg9psQ8Aa/3o0fTTjIGF/dup/fRPTS0D6p5bTetqtxUHawQlc9b1Pvw+jByp1gi270
 GKzDcDoDbPZrMvBWfiwjrvwT/F0bgYsUiBXMq4vUIkQ5iP6pFc9D3HgWqwU+fQ5R8yeHtnSZm5B
 4ECIVLKbiVJli+98VKJ7fj3h7+sVKkOoOxb9j7bFpXWReLWqKKt8hQ6281c6YcEhnirKAfU4/vr
 gmNMWBUld6YXfVtO9RdUmr/X7BTdmhCbZjFyQnSUCqbdAoitmzXKr21oe5XfDmJrhpY+xHNieNb
 N21OgziEVnhJJs/bWRpBk5vWIwULMdzHZrB9aY6dZnpeO0ondAcOMzUTU2Vj0ij41BQ6tTjTCQu
 ZqhvhqdzQCfgvbpL3wOFFjmGL9D62807aCGt/m1XGOlr3XxKp5FvpoyjsQM7Qpejjz3sMDXV3gl
 j2hOiYag03xBjxnMWIA==
X-Authority-Analysis: v=2.4 cv=Oc+oyBTY c=1 sm=1 tr=0 ts=6a8604be cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=5XCNgjhq8C3qGxAi4A93cA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=0pvDCryYY5rQeRNKz3IA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_05,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190151



On 8/18/2026 6:58 PM, Praveen Talari wrote:
[...]

> +static int spi_geni_panic_notifier(struct notifier_block *nb,
> +				   unsigned long action, void *data)
> +{
> +	struct spi_geni_master *mas = container_of(nb, struct spi_geni_master, panic_nb);
> +	struct spi_controller *spi = dev_get_drvdata(mas->dev);
> +	struct geni_se *se = &mas->se;
> +	u32 val;
> +
> +	if (!pm_runtime_active(mas->dev))

Not completely sure, but why not NOTIFY_DONE ? we haven't handled 
anything here.

> +		return NOTIFY_OK;
> +
> +	if (mas->cur_xfer_mode == GENI_GPI_DMA) {
> +		dmaengine_terminate_async(mas->tx);
> +		dmaengine_terminate_async(mas->rx);
> +		return NOTIFY_OK;
> +	}
> +
> +	if (!(readl_relaxed(se->base + SE_GENI_STATUS) & M_GENI_CMD_ACTIVE))
Shouldn't this be under FIFO mode check  ? As i can see SE DMA mode and 
GPI mode conditions present but not for FIFO.

> +		return NOTIFY_OK;
> +
> +	if (!spi->target) {
> +		geni_se_cancel_m_cmd(se);
> +		if (!readl_poll_timeout_atomic(se->base + SE_GENI_M_IRQ_STATUS, val,
> +					       val & M_CMD_CANCEL_EN, 10, 50000)) {
> +			writel_relaxed(M_CMD_CANCEL_EN, se->base + SE_GENI_M_IRQ_CLEAR);
> +			return NOTIFY_OK;
> +		}
> +	}
> +
> +	geni_se_abort_m_cmd(se);

why abort is done directly for target device and not for master ?
shouldn't be combined with cancel failure ?
> +	if (!readl_poll_timeout_atomic(se->base + SE_GENI_M_IRQ_STATUS, val,
> +				       val & M_CMD_ABORT_EN, 10, 50000))
> +		writel_relaxed(M_CMD_ABORT_EN, se->base + SE_GENI_M_IRQ_CLEAR);
> +
> +	if (mas->cur_xfer_mode == GENI_SE_DMA) {
> +		writel_relaxed(1, se->base + SE_DMA_TX_FSM_RST);
> +		readl_poll_timeout_atomic(se->base + SE_DMA_TX_IRQ_STAT, val,
> +					  val & TX_RESET_DONE, 10, 50000);
> +		writel_relaxed(val, se->base + SE_DMA_TX_IRQ_CLR);
> +
> +		writel_relaxed(1, se->base + SE_DMA_RX_FSM_RST);
> +		readl_poll_timeout_atomic(se->base + SE_DMA_RX_IRQ_STAT, val,
> +					  val & RX_RESET_DONE, 10, 50000);
May be good to declar macro for 10usec and 50msec ? Multiple places it's 
being used.> +		writel_relaxed(val, se->base + SE_DMA_RX_IRQ_CLR);
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +[...]
