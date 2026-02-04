Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DF5339A8
	for <linux-spi@vger.kernel.org>; Wed,  4 Feb 2026 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770223316; cv=none; b=DGa2KjNb7Rf0sUb2cvd8Tu1BWn11V5sxcJUsl4+0zTTjMfapM1WV9Pu3CT8lS/ZOOXyNZthOYZP+vXj+wgHvzksMWnporBwAiEFKsWL0bD/Ja7ZiW3FiaO8M+bpluGheenFkLhk7zfH6wsfb0ZqHM5qcMA9FfrEhhyrg++7dg/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770223316; c=relaxed/simple;
	bh=acltMfFzPryyJq9qI9VcgQBaYlyC8ZuSebWFzC5CLlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PlnOQOwicDaPp+DXUk+QA+m5+a+lkM8HMp/Bl+diiuNi/S773d/EJZVsmQq1g+SNRSqKsv44jWqxHdIWjX8id9yM1IIJ5AeABcRZDd8cDVOY1bhgZipAuWbhu24JqXHVrquBMCuBET8uSwT8w/xKF6gdz2kFd5a5mOw4JkzHXmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=In0EgCdD; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CeIYtcTA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="In0EgCdD";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CeIYtcTA"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614CIL30898820
	for <linux-spi@vger.kernel.org>; Wed, 4 Feb 2026 16:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xy1P3uXgNOlvPZcotzDc6j0P5vBv6F9/PLCO+QEz1fI=; b=In0EgCdDHjkmwQXr
	B9KfmjveLsOfGsEf8EgFsxbUt3PghvbYIi54L+t3mIaghKj9AMgeRB2bnWKZuSNc
	rvHMCJu4lezoBM1eWkoF7B4mdNdBnHRU9QmV1wzziWLSV3ssvOr/G17GRqIUom5K
	h5Bs5+nS509zi5y9npGlJQq3YmxCb6/gSg3qd+tovJsNuoTeeii9NUwDw7BYAZ2x
	/RWC3qZoo66GHxdb9ue04Vslz0SUPyKPpQKNyJeBMktj13fvb7frlD3gKMhWo54c
	JW5g/mmqeYl4fRdYkuTvsgeL8+utNFLpK1FWyzTnfusP3lv9+tZWnelZan/zR/jE
	R4b/LQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c445wh58u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 04 Feb 2026 16:41:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8ca3952cbb9so28441985a.1
        for <linux-spi@vger.kernel.org>; Wed, 04 Feb 2026 08:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770223314; x=1770828114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xy1P3uXgNOlvPZcotzDc6j0P5vBv6F9/PLCO+QEz1fI=;
        b=CeIYtcTAvaGQ5aAHyMe9CkhmVSG3iCV8VHoLUI16XuWfSwpGAVlGSJrsLtVQT5c01K
         Hf+sp+Fc4CLEk3J00Y+J2SxDoaW3F7coi+XfjPgOCuth1sBIGNjhG7HBZYctiAsM8jOe
         otyJzy2604hbrCfx+GJo6utnEzHTKj5w8d0FuV+wKbpeQ2bgYzNIOeWjN5VndLTuM3iq
         T5gnuFq3AL4c+/nUx/gBwqfLtMYcAMY9cGTAihcRiEqGB0V1VcP62B5Kri3lG5Tp+Io5
         6uJ6Xj2liDQa1yYy7yEAiIc/+1KIFZ1XERJH+U0Mqjgqk3UG4cENsdf5pyPsWNGwEOOJ
         f7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770223314; x=1770828114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xy1P3uXgNOlvPZcotzDc6j0P5vBv6F9/PLCO+QEz1fI=;
        b=aodn3nj2MlzhTZVdlcfCRamKDp5AHzzHqyIIukF0pgPdZDGj2Nk5yXLDo4XuIfpSID
         ZhgkRa1WsZsCIi+rCxQRyh+IoHwfl1xhD+Ly1QXRYCFLcLGurPRiBU+0Q6+WzSmZQr6z
         XA+/Kayt6LpYVRam4xKShQGIeQ/chlfg14OidYgbQG3zi6TDwse3HZDBFHhQAPEsH13e
         DSRVq0ttxtTYN4qe/xNU/oieDEfKf/GhZpM2ZybywPNhrnboiVTnimI9qVsIH9vNsrzq
         pc3g84/QohDW8h608seJYWLDYybJAuvRTzpgzVinNZi10nwSmZYiDqLHxvhyxwglkUHj
         4Q1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHtbAAGJRcNHEkx+loeFU3tSA3ibbIL+f6YddjP4pCN6HrArQVKsk2SOp0YGJ/XXPHs7igybsmpNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMP9Zrc0tEw8f0CiQgTIbdfFSc5pxqXnklMi1kS4CH/qSwnuU/
	lnHjuyFVrp7I/CKpfz+PxSNTEgA8LG61HUb6UY4dDQ/S4lfQ6ukudHXepv6QhuOd378JQ07uIuq
	rAmkvI/ftaq8TpSSNmc6WD9BaWEvAoWYitJ51NYTr4+uky7WQx+5QHnVfe3QM/1s=
X-Gm-Gg: AZuq6aJHhTP4vh2gqQLQ5Nx2Lv9VhlN2C03X/Ybl/r4F6CYbrCIiV8UFLUc5nBlB3Ar
	uYWaG6W1GNCeG1XiQHX2DJsrRJ4tR7cij0GLZk3wxVh7bRhsrn+QqCI/7uDIhhBZU79Pef/t6eN
	5XBI/R5dlq/8vcC/kpqdNa+B6kbr2AX4xR9kIDHWMN66MpXzNNADku3WGrl+8X6jZpu6wL5q6e4
	tNb+aT2+o8uH62S1iYzO3GRe4ehymgj3U7lw6jVQLECBtp4R/B21e9P9BCvEXOiJ6r5kJB4KuN5
	s+bYYgiND9vaf5GGDHdw8rxJFqmgQGqZM8cC7IGR5u7mJRqKu5UbVp5bCvFn2qRFZI4/3B2iMOj
	dPU0/zlKeKdIVqs55xl2u5S+hEAmz/DXjeuEtGlDJXXOeTO/urigJzffaiCBXeWq7Dlo=
X-Received: by 2002:a05:620a:1aa5:b0:8c5:3892:a554 with SMTP id af79cd13be357-8ca2f83ce18mr346469685a.3.1770223313893;
        Wed, 04 Feb 2026 08:41:53 -0800 (PST)
X-Received: by 2002:a05:620a:1aa5:b0:8c5:3892:a554 with SMTP id af79cd13be357-8ca2f83ce18mr346467385a.3.1770223313416;
        Wed, 04 Feb 2026 08:41:53 -0800 (PST)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8e9fd10f2asm138204266b.23.2026.02.04.08.41.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Feb 2026 08:41:49 -0800 (PST)
Message-ID: <68908c06-390e-4717-bab2-708de7f5cec4@oss.qualcomm.com>
Date: Wed, 4 Feb 2026 17:41:46 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] spi: geni-qcom: Add target abort support
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        quic_vtanuku@quicinc.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260204162854.1206323-1-praveen.talari@oss.qualcomm.com>
 <20260204162854.1206323-5-praveen.talari@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260204162854.1206323-5-praveen.talari@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDEyNiBTYWx0ZWRfXzg0cWin+oE3c
 K63tZgwfYQp3oD2DEPIlvOQG2lRNyl1bmtrNFKzsioNtoo3mHcKXPbQyXPkolXHk6qRrMPBNmcn
 6GFlLmQJgfXvUcfqNwZxEZonCTnYdnqY9Hg3ts2XIinaR83nqLvLZ6BaaECwfea4ipCMhfhc3be
 21xsqT8J9g1UEkt5gjkQLdTajVZTGWS2XssI1vWyCihERnFNCF/mIjufQALQpe1hcunMVzdfVtL
 GnUcRAltdNJSGrPR4GdBZ3uiw78bKEJTLo7Hi9J60I2E84RYuAWvvSHbQTOjZPmRfZeEalyTCtM
 d8j5ZBk84/mJTRFG8C/JTHPuAJm7xsEFHJqRTsWJ5IvxpJ4oqmoJvNh3liEUsgE5lryhFhnIvqH
 loG3NTLi1Kqy1n0IhcHuesbpRpUHpKLl1s8DLbjEVD6pW36mZ1VybN29ZbENkOYltda3N6gCNoH
 Jq5nVB6VfYnS1yFSssQ==
X-Proofpoint-ORIG-GUID: 7Re5_liWM0XuD2fdmljKcanU0rIMeHD4
X-Authority-Analysis: v=2.4 cv=GvhPO01C c=1 sm=1 tr=0 ts=698376d2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=KiRDxWFFE5j6wAypeYgA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 7Re5_liWM0XuD2fdmljKcanU0rIMeHD4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_06,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602040126

On 2/4/26 5:28 PM, Praveen Talari wrote:
> SPI target mode currently lacks a mechanism to gracefully abort ongoing
> transfers when the client or core needs to cancel active transactions.
> 
> Implement spi_geni_target_abort() to handle aborting SPI target
> operations when the client and core want to cancel ongoing transfers.
> This provides a mechanism for graceful termination of active SPI
> transactions in target mode.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---


> v1->v2
> - Removed unused param from time out handlers.
> ---
>  drivers/spi/spi-geni-qcom.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index 5077dc041e3a..43ce47f2454c 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -1003,6 +1003,17 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +static int spi_geni_target_abort(struct spi_controller *spi)
> +{
> +	if (!spi->cur_msg)
> +		return 0;
> +
> +	handle_se_timeout(spi);
> +	spi_finalize_current_transfer(spi);
> +
> +	return 0;
> +}
> +
>  static int spi_geni_probe(struct platform_device *pdev)
>  {
>  	int ret, irq;
> @@ -1076,6 +1087,9 @@ static int spi_geni_probe(struct platform_device *pdev)
>  	init_completion(&mas->rx_reset_done);
>  	spin_lock_init(&mas->lock);
>  
> +	if (spi->target)
> +		spi->target_abort = spi_geni_target_abort;

The same check is made in core:

spi_target_abort()
-> spi_controller_is_target()

So I'm assuming the intention was to allow assigning the func pointer
indiscriminately. Other drivers seem to do it both ways.

Mark, any specific preference?

Konrad
