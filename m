Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F75B354AF8
	for <linux-spi@vger.kernel.org>; Tue, 27 Jan 2026 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769519883; cv=none; b=EChQbN94amwQvjvHvLPuhovgUgBVUX2KwiD5/ugMu9zHVuLEDAoLI+J3oMiuTwZSvEcVVzhEXwnRbq0V54vUqxhqiwwhWDtvhDnNPSmmRvOspYdZ9flXC3DUUIq2JinMcNCSEGZOO+wc0sr52iTQVV+mphgzRAn6UN0Z9wzLPb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769519883; c=relaxed/simple;
	bh=pGtnGT8A1TVacwwxJ86NDJW/wMTUqelm6JB4YcI4gPA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XwRUp5NkkzWLhuyGGG13ZHPkbWPGfGF5rRaGE3NFuvGEh27aDF+CjolRGkhz6HVtfiAvmoVqk+s2Pl214OlCFrLLPN5RW8wzhmse3m+Juov0sBWM+WkeVwmkMHHVd3go+r/yRXNB2PotWESyd2Byduqx88n92JNpm7jk6X/fXzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=op6jeCMg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CfxAAfWA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="op6jeCMg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CfxAAfWA"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60R9qZBQ171364
	for <linux-spi@vger.kernel.org>; Tue, 27 Jan 2026 13:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cB5Jv9LhX5CgJ04FwzVNVe2bLC+6nt2HoYA7wH/vv4U=; b=op6jeCMgoFDLw6KG
	+E0uKgpR/6ZPhESe2nU9FGBrPwLg22l9Nav8gsjAPQfb2VDzhWs3MqD4Hkimk1eG
	h4kF+HkM4D5RkYeRJBLFq7vAeLdIofTGw8yL1/TdHDP+Q1sO3BFB53jddosc896+
	sFEpgiYiblazn983LvFRkakat0wBWh1PtJacACJkAP8pPvYMbWVcX9x5jiHmWVEz
	GrNNfyve/AXfqFoPRd+eselIZRGjtVnsHcdR0BR+dEo1Wk71KlIfnJIOcWr/Az75
	pCwD0vAUElIkC7R3aRw1V0nbpZgL0jUERdUNvv41VgKjX85X7j0n5tQ5emJ9JcBN
	BFNfGg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bxf3a2wt2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 27 Jan 2026 13:18:01 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-894662cba4fso16478476d6.2
        for <linux-spi@vger.kernel.org>; Tue, 27 Jan 2026 05:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769519881; x=1770124681; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cB5Jv9LhX5CgJ04FwzVNVe2bLC+6nt2HoYA7wH/vv4U=;
        b=CfxAAfWAFKgpkdqNnBFTDpbp+RBT6mG6GllYClM0Gwe4zK507H45/kIrFWEhiuwqwN
         XRAbFqEQTXqwlhympmT54cDJ5NmJ5osaQqav2BohZe0s5+j2W7vuB3IiVHe7A7z2tjFC
         wE0/x7Oze1E513mh9D5ghquU5htwAdq7+LVdqKEw/yb7c4bGC7Y3J3rLfdxA1uV3X2Hd
         JWt8nmtYfmpQjOjqQMlj6U5GpNA9Y5SYcwJuxiaTUzAu+UJ67ErLFteF5X5vnOLrpqMT
         1txe6p6MbDvuH7xGQmDh0ZZ+9EeCbA3SHyb9kuHG0iLsnpRMrtmyBuBVJk9g863Od1Kl
         inVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769519881; x=1770124681;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cB5Jv9LhX5CgJ04FwzVNVe2bLC+6nt2HoYA7wH/vv4U=;
        b=gLR6SYRSe5FcVykBiskEVQ8BB40VadM1+pJBoBuh+AZqlHIq95xW/rIqT/VGmaHx25
         hSvEa5uuC2j4dpnOEWXaWSb70H4ima7OgmhGbCFhL0kk5ulSo3zx6Sz2zjRB9D/iHor7
         RIEmx5eTQGX0ZqYMPlwy4vM1XvcdWDpN5inee3Q0dwv716+TnVl6+OxPowpC8CNwPsaX
         j9JBhox6jKUw7pAIIUWtgiBeu4oncbtkEAsrlZNbBDIWMAKlD65ODgSpkNRjc+tFh+aL
         sVqCzEgxfITJwovA21kbKb0xsDroM5GgDYpWnAnxNLDt0/Vuh0WtoNMRFW1NNGu+J9KF
         FY0A==
X-Forwarded-Encrypted: i=1; AJvYcCU16fbCcY4zYCVIFu9IQylbq9j93kvMBpeAOGRojz1kzQBHHq1H8YEC3w3VvHYJ9V3iSD3wTo84iTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQVOc/OwPU8qIo+Gzs8xNGq1OtICcXlu/CSad4UZ0oQr+Yx4Od
	CtcXOq6mTtHUSVFh9oO0khY5gcHP7AoWDySsBlJoS4Ypb5gA9HiviPfPTd8AsQxQ4ZIAtVYv/Cm
	mtx6BIEPADTTcE4Yalz16RwGOoRfequYnCR2OV3yDBE9syiemoQnNtA67XzXqDkKCXlbLifI=
X-Gm-Gg: AZuq6aKNzWp0GIhlNfKPiUGkOGrZWmfzyn8kpwBFW+TiiEjwf0WmvNglyNu3m+uicjH
	9suyiBte+BuSJ+k1MYPfclMKFcbEvG6dXDAoewihBxGXXwAejMj7J82bNo3oMfEnOT4EyF8a2Lu
	kGWwh48JDTbh1p0pevdDMFn5QguXv3ivk4ARTqaiNYdtnFdgoCG5MoUBxbnIxx1j19yrLZoTR4/
	cLDwktGzJVM+HsTgItlDaw7sQXxqgXgJeiGY2bNvY4MHEyiuE1v80newrx1psexeDMx1zpH7MG7
	0ODSq3MwFV7gza/EBnNyF+pgbp/CmZ4ts6iJJ2hqcHNiJlWk7+hbSquXxUprYXxR+1uCo2sH5i/
	LK7hKeI2h9RFJ8dnWbp2T6f71O6f1J7nDp2hr866AyRrSNeXLX2jvQ5K4V9RH3NmN8UM=
X-Received: by 2002:a05:620a:3199:b0:8be:6733:92b1 with SMTP id af79cd13be357-8c70b7414f1mr146437085a.0.1769519880692;
        Tue, 27 Jan 2026 05:18:00 -0800 (PST)
X-Received: by 2002:a05:620a:3199:b0:8be:6733:92b1 with SMTP id af79cd13be357-8c70b7414f1mr146434185a.0.1769519880195;
        Tue, 27 Jan 2026 05:18:00 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6584b92b5e3sm6297978a12.22.2026.01.27.05.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jan 2026 05:17:58 -0800 (PST)
Message-ID: <9d9d4d3d-42bf-4f4a-99d3-19df73f89c30@oss.qualcomm.com>
Date: Tue, 27 Jan 2026 14:17:56 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] spi: geni-qcom: Fix abort sequence execution for
 serial engine errors
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        quic_vtanuku@quicinc.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260122151008.2149252-1-praveen.talari@oss.qualcomm.com>
 <20260122151008.2149252-3-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260122151008.2149252-3-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEwOSBTYWx0ZWRfX4B0RAci8vhUl
 fiOJLGOzPi2DSRcJ2JJmZIeb6p2DqKLV5r/a755FqE2UcPLd4bc6B17w54ps4oE6LJ+8s/3jbl7
 u/XIMB5+SHiTviW/aB97uNydWN2eY0Y3REPgVwFgK76kbCWLnPNnZePHe27DhaED85OrpArf/3n
 mNPeF/UsSu7++xqSCdClEbyT3RSRWhr2smjsvZydR8pFsQWCn0smJiYbZjFLUTB6WdIsWfxLvGi
 2Wg75J9bx6//7wFOuTOAlNuri5w2zH1Ak+btLCtKQvJP78Js8nf2mdGrOvS04z+3nHe9HmCQ1oS
 x38Qsg0c0oaetsG7Jz+OM1sNj5SBFEBfiPVHPd2BTbblw2Z1L4wX7irKDF4h4dx8nXtBa0ePl7A
 2n7/LMe3VFR2c2fCltqo8tVjAFOM/+xnEJmiGruf8DDW/uB1BstU0wqf3ISm8rdaQGTkt8h5wD0
 esr45VB3gd+1ZFPFTkg==
X-Proofpoint-ORIG-GUID: OeUuY-asZJ6HafBSV4MGKMgH7n0vmMKi
X-Proofpoint-GUID: OeUuY-asZJ6HafBSV4MGKMgH7n0vmMKi
X-Authority-Analysis: v=2.4 cv=a6k9NESF c=1 sm=1 tr=0 ts=6978bb09 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=2ADkXApKhB2aXO0F1dwA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_02,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601270109

On 1/22/26 4:10 PM, Praveen Talari wrote:
> The driver currently skips the abort sequence for target mode when serial
> engine errors occur. This leads to improper error recovery as the serial
> engine may remain in an undefined state without proper cleanup, potentially
> causing subsequent operations to fail or behave unpredictably.
> 
> Fix this by ensuring the abort sequence and DMA reset always execute during
> error recovery, as both are required for proper serial engine error
> handling.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>  drivers/spi/spi-geni-qcom.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index f5d05025b196..e5320e2fb834 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -167,7 +167,7 @@ static void handle_se_timeout(struct spi_controller *spi,
>  		 * doesn`t support CMD Cancel sequnece
>  		 */
>  		spin_unlock_irq(&mas->lock);
> -		goto reset_if_dma;
> +		goto abort;
>  	}
>  
>  	reinit_completion(&mas->cancel_done);
> @@ -178,6 +178,7 @@ static void handle_se_timeout(struct spi_controller *spi,
>  	if (time_left)
>  		goto reset_if_dma;
>  
> +abort:
>  	spin_lock_irq(&mas->lock);

Now that the jump is just 5 LoC, you can dispose of the goto and change it
to an if-statement

Konrad
