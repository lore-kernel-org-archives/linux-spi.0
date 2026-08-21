Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E753AE6E2
	for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2026 10:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787308193; cv=none; b=idZSAy8pLLOoaaHdz/HtP5L58pZDgyevolyaVHZ2CAvE5zKgClwBPY2fAXTIPxdMwz32z9/qQq29tMwpaPxxGTVY8jiuFZR5Fx8M+5o9Gsnn5aW052UF5SP2wHCZQeQV7JyWdBN6vxvVbpFNx6tVvZI1rcxKIEyrlwJrHXP/4+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787308193; c=relaxed/simple;
	bh=jqJbIT8uCM0WhGAmh71pctotEY+llW3uBMh1MAgPEiQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E4R2hrMIyUHtcp1oeSOnulhj1k4Ddz64RGn1zKCgD76+W0xYjt1/+UVQxS4zz/rEN35GnAa5pJxIzIilylXyksa5M4NIcC37/iuK2cqih3+3v2XQxllOJZeN2he5hdh/VonfRr6gLWrhqbA2iDIzYEgiAjhdI8236SgsEhs8jDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DvEWP2mL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hm8sRrix; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DvEWP2mL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hm8sRrix"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L9LxpT789841
	for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2026 10:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JO6YRmpq07MH0lIZTUDHAW9kDXr8U21Wos3VNJO2lg8=; b=DvEWP2mLRXmAfuSR
	FDvsB5+cQlAxK5NGmW6yS+0h9c46joqOjxVHYZZlpZls9HeaTVibWab3nhxCjkW8
	we1eVA8PKiP0R8/qbdU9/HI+zTPBjspGDxDfOJYfV53IRv3cNFF1fkYGXdHkS2at
	0aRtmgzAE6fCfHQp6JgdrPWeVVWxtGpKIOiCNdNYgndliFLBJx8TycxpOjDm31qi
	J583o2PwBfg8Eko+R0iPiC5PPwE7vzvNMk0Bt01ggI0jZfrYSIF0WDt7Blq8vtpL
	/k5jJfZjo0b13NF3N2V3D8wpcE/lXE5DozvCFmTkfuWQTsmUKYfRIlGZJB63rBX/
	Twgz6Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6ebusg84-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2026 10:29:42 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cfc52ddc55so14316875ad.3
        for <linux-spi@vger.kernel.org>; Fri, 21 Aug 2026 03:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787308181; x=1787912981; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JO6YRmpq07MH0lIZTUDHAW9kDXr8U21Wos3VNJO2lg8=;
        b=Hm8sRrixa9CPeYhyNFENnuwx82ambdYiABW9Wutqbp720cAYF9cN4XzKcTgiQ2Twy1
         +9MSr2KO7K6daHBIEaWwZkNTGg2nSYXy4lB/EoHgkoTJTGT+s0oUmOVMOIM8O7EMFsCi
         ekC42vZPWZrx+EI5nNWm0Yd92TWPzBP92TPZwhOH4blJh/y1DRfxJ7BjwH8g1tvLMV4p
         povW9ROea7UdRPR/MzFiHVQVujpWNyMhwSRsfslaamW1JrJNC/9AS3L/F5/BtdtqKNsZ
         pAJvE4XE1hBFgXQwL2DHUR2lUnUtKvOnUIShtckYlN/NtKbJIX/hLqU19XtSVEkvBGFI
         vN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787308181; x=1787912981;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JO6YRmpq07MH0lIZTUDHAW9kDXr8U21Wos3VNJO2lg8=;
        b=fiRBbDH1ilpYu8usImTCPe1XkR6sdo6ULAIMvIKZ4S8VOuRNPoMT4kUQQ3RYXjeRer
         VABcaDo1eyKWIBisrH3VCBRrBwwuGhEnBQTQqn30olaPiK0l/0odQKt4VzxEXP6NR49z
         R1yLth+8jc4AjwmeWQd3ATCJBzYB5pIFyAIdOZ/MPZUfMBongXHlJEZ4AzUtra+lvtdd
         1LxxyHoDV7uQzCp79RzumcnxDA/7VT44aRN0Wiyy98l3b6I1ngvuEPOhSWNJuHBlBYER
         nG0bnufIMRQf2y3ShSWwU5AGDwHGOQ5DoxfmDNwqiFBAR1/KScGrHP+1RncFQdWRyJ/o
         GV1w==
X-Forwarded-Encrypted: i=1; AHgh+RpvI8nSdPF+905U/n/yxQ7uTzdS8X3yILShFvBPIYHev40n6YKFIqc+wm3+RwXwLXKX7qBboj6cC5c=@vger.kernel.org
X-Gm-Message-State: AFuF++k0RwbY/OJ5xeUanUTtr8m7qlebbI0r5OjPkq/54mgArPaq2xED
	0P7t4fOun2XyrhKhJh5NecHl32+Y765E+p2UoSVUVtJi3RuobX/YwXIkYgJhAmVLZeFRapQz7Om
	MgbKsdiheIir3juh60Syu234h67aPrN0h5MrbVT9kdZjBaGNhUD5z/FEZF2ewoBo=
X-Gm-Gg: AR+sD10hsQD0caGniz4EFa6urO/GS+Qs+nvN7iligMtzqThhE92uFFxWKPfJNMZJVnl
	OrU0/jV8LKt7//m1nayYs0XgsGdWe/RqLAShy6jgC5lEm+4CPpYtsRb+9uZ4hmi9ExGdG1Yky6Y
	n5tk4P15Hity6v7LgfZ5n6XlzP7SUrdZtdd3OhhHuV5GH6H53Ad/b1r3h3elTKjhfFoqbbPCBoS
	S04wrRQATyWJU+vU7fiBLZFeS17VcaLA6+PLfbDNxwyyKYx8Jax5Jf6Hsd+zpHhEhRCVDmN5joZ
	lB1p7P4B+XnFAH0OQii1aaWANnnc7uet206VyqAbPEH8cr2XKlbnbAF2EByXWD1ioXtPRMoUN8T
	rN8kqkm76C2VjPlbZWwK087zEKEiWSkU=
X-Received: by 2002:a17:902:e943:b0:2d2:da8e:9017 with SMTP id d9443c01a7336-2d64af5096bmr106267405ad.8.1787308181199;
        Fri, 21 Aug 2026 03:29:41 -0700 (PDT)
X-Received: by 2002:a17:902:e943:b0:2d2:da8e:9017 with SMTP id d9443c01a7336-2d64af5096bmr106265635ad.8.1787308180345;
        Fri, 21 Aug 2026 03:29:40 -0700 (PDT)
Received: from [10.218.50.86] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d62e36edbbsm16688925ad.39.2026.08.21.03.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 03:29:39 -0700 (PDT)
Message-ID: <d1dc6098-65a7-45da-a8eb-109e42f5f178@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 15:59:35 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] spi: qcom-geni: Add shutdown callback to quiesce
 hardware on reboot
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Mark Brown <broonie@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        chandana.chiluveru@oss.qualcomm.com
References: <20260818-add-shutdown-and-panic-notifier-for-spi-v3-0-8b62c4bc2d21@oss.qualcomm.com>
 <20260818-add-shutdown-and-panic-notifier-for-spi-v3-1-8b62c4bc2d21@oss.qualcomm.com>
Content-Language: en-US
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
In-Reply-To: <20260818-add-shutdown-and-panic-notifier-for-spi-v3-1-8b62c4bc2d21@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ON5FG-qG3Yq9hcgUlTMYH0Y1VyPyNWdY
X-Proofpoint-ORIG-GUID: ON5FG-qG3Yq9hcgUlTMYH0Y1VyPyNWdY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA3OCBTYWx0ZWRfX/gign9DY02zn
 +OslpYXE+eWGbSoK9IQVXRs4NATEh3W4DiwXlhS3KR1GJLFqjX4CJ4djwtExZB7wVLJX7sImYSk
 DAe0mVXBvEeIIess2lbgyS49/ZBJF68=
X-Authority-Analysis: v=2.4 cv=QJlYgALL c=1 sm=1 tr=0 ts=6a882896 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=KuuzSyX4S4X_r4w0K_YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA3OCBTYWx0ZWRfXzmheFkExedV6
 CdYBHa138C1rMp3QcDCKDSYTF+BmWczry210GkAG0h5HeFt/sALb0kmsW5RztiRkbWnxbpUjZam
 07hnYJjmWi5PyCK3vWKRv8m7CAeCSn8rENHN7fBtnLfwdZ0omaexD5wtrXicW8hV5MY77sM5vj3
 qvg1GLMWhBbuzwMJAITEy2rrF91U/tkunGCBVbTlY3FR9Y8wKkUhjDj1lfgG+ZnExcmxX9bGQyE
 eRSWKquTp8K/d3LaPa2+KYmhTkwP3wvm+76d/01eiw3YfXwnbNEG2oiNnF8xi0FrIQkL6g1SfaJ
 z638jd0dSZ9DFCtQdGpQWBaloQlZk1nMXW6yVMwzpTSP9ap2/svATHhPaqEPEe8PfyuyNnckIP4
 AKcJE0va8+gCMx/f/cBB6UG/54gjCYjR+JpiE7RsRGOKB1LD/3gRAvwC+RBXrgKnKGlK5Igrgef
 qu6AElS9rS9L+rFjp8g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_03,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210078



On 8/18/2026 6:58 PM, Praveen Talari wrote:
> During system reboot, an active SPI transfer can leave the GENI Serial
> Engine in an indeterminate state. On VM-based platforms, if a DMA
> transfer is in progress when the VM is shut down, the SMMU can raise
> context faults as the DMA engine continues to access IOVAs that have
> already been invalidated during VM teardown.
> 
> Add a shutdown callback to suspend the SPI controller and abort any
> in-progress transfer, ensuring the DMA engine is idle and all IOVA
> mappings are retired before the system resets.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
>   drivers/spi/spi-geni-qcom.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 6c57f8309a3b..c65c1788325d 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -1066,6 +1066,13 @@ static int spi_geni_target_abort(struct spi_controller *spi)
>   	return 0;
>   }
>   
> +static void spi_geni_shutdown(struct platform_device *pdev)
> +{
> +	struct spi_controller *spi = platform_get_drvdata(pdev);
> +
> +	spi_controller_suspend(spi);
Hi Praveen,

Don't we also need to power off the SE resources here (e.g. via 
pm_runtime_force_suspend(), like spi_geni_suspend() does)? As-is, 
spi_controller_suspend() only stops the message queue — it doesn't 
quiesce the hardware/clocks.

Thanks,
JyothiKumar
> +}
> +
>   static int spi_geni_probe(struct platform_device *pdev)
>   {
>   	int ret, irq;
> @@ -1241,7 +1248,8 @@ static const struct of_device_id spi_geni_dt_match[] = {
>   MODULE_DEVICE_TABLE(of, spi_geni_dt_match);
>   
>   static struct platform_driver spi_geni_driver = {
> -	.probe  = spi_geni_probe,
> +	.probe    = spi_geni_probe,
> +	.shutdown = spi_geni_shutdown,
>   	.driver = {
>   		.name = "geni_spi",
>   		.pm = pm_ptr(&spi_geni_pm_ops),
> 

