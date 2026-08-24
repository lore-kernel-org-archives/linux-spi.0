Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB6740587A
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 11:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569669; cv=none; b=jgvY8ILZ6epzDhdnjDoJhdf48ilLuC3slTxV/B5WiULZEqe21geq7STcMN0o23jm5b12K3zkzouMaib3+twI1M5L6JYBdV4BR3Ij6N93Kc/WCyOZPq1LH70hyK3/eJHxeQ9kCjI2edCILFWEZRLK7aafQixUsIT11vDUnakkmJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569669; c=relaxed/simple;
	bh=OSns+uTIs22s3YlcDW6QPFVIFw1QF1ErNeeSa5lcm1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gt5v6m51XT9u8178m/vewuD8RjimVjuOuPJFGvCJXZ+Umdt2FrSD8AYcu8ur9h7HR7Jnmq9uN6EWOMDhYwVKB7FTtiqV8O2tezj7SEZ9+dbvkE1IMRQ6VrJM/0UpoZp5piAwyo+ZF2iJJoOnb2dnBFx3uy6kihaQpnLd0J0EZTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ojum985C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LBYo7+e1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ojum985C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LBYo7+e1"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O99dSi2572113
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 11:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jRpGpu4L7njGKrZAm4LPVjfYmC7MPX8emmTGwksOl+Y=; b=ojum985CHaucqlo3
	csKOLbyg3UklvxJSS2AUhhWHKKTk5umUiaArXncU5E6Wd5hyUg88tL+lWSoj8Eyn
	KcqqBo8LpnUOqOmCWH3sBqvhX0zNZhR/Oum1DDFtstGKJWoD+UiluJzPf/jjB0PP
	BvTNqvFhGBhK2xszeFaqu/hJcplAyVt3VqRNKNE/xR6OfL0+ogwFjGretAJVRvOW
	wrf6sNoQxW2tF467JKk+uR/y7ArtojnURrqSigiDroxhv2eQNjATjdyC3YlJ3OX6
	/WFrN99pfWYB6NL9JOLHfHhWtc6xrZTcd0qtc6DtkiczJuBb/z363+ITm13aIhq+
	nNROAg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8bdr24jj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 11:07:46 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-848662cd2a1so3534207b3a.2
        for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 04:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787569665; x=1788174465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jRpGpu4L7njGKrZAm4LPVjfYmC7MPX8emmTGwksOl+Y=;
        b=LBYo7+e1T/JwmD5drW1ExyMgUi6lpbBe/wlQkTsa3qipx4Z5VU76BIAZwb0Js3tjIO
         nmIEQ9QiujweRPFlfnliOg/GZE8EqbTB5UGS11FfKca0QFSK9uTh1XSZnrutjq7IbYU6
         Elem6DMz8uQWRWpmiusBCM9EyTUMLzLI8eIUliR3cmm4Oi+xkZoV1KzGP7ADDcm6SAkn
         26uGD1wV5bPn4jbKw0k8lwfi/ydpiJkHcTOEcEvcB7Stf6bM0fBp+NRItXJD0Vt8CmM8
         2lVgwdFPWrshci5My0eGGIZLv0+qxVO6p+VwClROJz9HIzdYXBabW93+/1iKT1P1v1YD
         B/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787569665; x=1788174465;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jRpGpu4L7njGKrZAm4LPVjfYmC7MPX8emmTGwksOl+Y=;
        b=PqCR9pcHSVoS/mtWRaFzUtUUW2vKuLHd1DAPnUYFaMjrqiR/sAxyZ4hsh037P5Fqt/
         ulQHcZ8+MMtDAU60JTKXPZymb8hBwXhJY+1QO9138NHLKD3IKAuA3uPrr1D86E/zd0Un
         mjggLw9/3XfTF+2Y2kebnv3xytUihNv9/PUfynBGRlNCECCAM6aaUKuimH2Eowd0JUyb
         lchMrPH7zDCl9KIQPYC0T6/TT70hPbJyIJgIieGv+TZ5ZbuXj7R4aZLbZIudDsBCsHtW
         asKY834ITQrBnxIJoi25p3vDeUkLdgs0xsEzNGCNc+nZwtzprhLnSWPEnqjTOZ1G661Z
         OhxQ==
X-Forwarded-Encrypted: i=1; AHgh+RoDFmOptavigjiqvSEg30PtrOfagMTrEDy2A2vDPVRFWXgatjD9Zeo+YhvWKXfUf2ZWdhrF3lEasTM=@vger.kernel.org
X-Gm-Message-State: AFuF++n0HSrgqXTOZA1mIA3aDiWDyHgUHwtB/EaUu731BTrgGdVxiTee
	mwwsyhZP5lIBmd52WrZG6a72VipuIF4wS/PxqNy8FGNpUK5kIDzi62LoY9p/eizayIPAg/k9wvz
	8wfAHxc+CoAwQdYLLkalh39+CjuMJsV8hhS+H0K2QKMcnVLtcu2HlE0n5+WpjVJU=
X-Gm-Gg: AR+sD122XKtY2DiKayLFkXo0o5Xs85eY2tddsnqjE0JuSayHErbb+EmwDzQaito8CSV
	SFJEzg0GLVSJbW4RwZSIvYHZ4yp0zHWE4GkrsO/nTMQGkIZ+y9gCYpyIU+32JspOoCfXiRx5b3A
	ODQWTP1YL1NhvCRQjfS1ylCSxTbqziuTfZacmfbB2vrMguQVKUwYrBhj050G093pfm9flOtykBw
	K6Y8o3qBP4cSbcEnuyu412dQ6Ho2jFBDNu48j0Wlvtk/k1d6DdBFPkgtkKbesmH5f7Qoma586W/
	SV4j8aPKPNG87UDUWLJ1GY5PvHlyB+jG/zP+bYE91T7R903r7FiU8rc9GmQucCEUVwKaGBZOcQx
	99KPeVpWCwu67gcIcIkZ6mn7R+GYxzeJ9q9k=
X-Received: by 2002:a05:6a00:4145:b0:847:9315:fb8b with SMTP id d2e1a72fcca58-851f9a9f0bamr43921519b3a.6.1787569665305;
        Mon, 24 Aug 2026 04:07:45 -0700 (PDT)
X-Received: by 2002:a05:6a00:4145:b0:847:9315:fb8b with SMTP id d2e1a72fcca58-851f9a9f0bamr43921428b3a.6.1787569664916;
        Mon, 24 Aug 2026 04:07:44 -0700 (PDT)
Received: from [10.217.218.158] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520eed88f8sm1864508b3a.10.2026.08.24.04.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 04:07:44 -0700 (PDT)
Message-ID: <a165c890-16d6-4d64-ba59-fe14435e0a7e@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 16:37:37 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] soc: qcom: geni-se: Add helper to set SE clock rate
 via OPP
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-3-61171ab1cdce@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-3-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA5MyBTYWx0ZWRfX9Hikgy2QQbpt
 nmegAiLLco12FUJqCF/zKhkluKkbSZH02p9qVMYxwOnOLqPvVzqp0s7tg5KbB4msd3cVA+xWcvJ
 TPM+e2Wcub+lbqbKO+8NDsWVqcDVL3KM5Nihgf/G7Kf2EAIWPiB+b4n3F1ytaCFXM1ccljPGver
 jpBsjckBWK4WDKLoWKMNbAk5O1yZ4AxR1N1nmurDend+7Vn1k8B7sg6dG26GXi6dG4duDpNueDU
 pOO+vvxNCnidGwteiwFIvH75T0DjRAD5cPpM9GbPGiX9xS2nAeNOsUgI3DwiDnpAC03vWh/b+Rq
 BIyIABHyRNKVB4upfGNmUKZzMrfnq4p4rIg9NyZXA6c3z6zhL3XqaxGDrtm3o9m6MhWPDZ7uwq3
 Z6v8fMGFw8vCnAJmA9qnGP0SNFtecBmKyJPcK84xo2BDFajbINMznRlACMnbQMqVD0C5M6jGb2O
 OxnSu8kr7M0/YmAtzWQ==
X-Proofpoint-GUID: 7G9VEe7lZ53oWbxLV4iaC0_uM8DYdVcm
X-Proofpoint-ORIG-GUID: 7G9VEe7lZ53oWbxLV4iaC0_uM8DYdVcm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA5MyBTYWx0ZWRfX08IEwysxJxA4
 WKW1s19+GwE9H2oaiSbursHMa37TmY/DGpcSPjb+XbmWJk6oa+1jbUwlrNSNxt4zgE4v8RUrKd/
 roYwLqL6VgsLSSAFuhIHVSFnSq6MCL0=
X-Authority-Analysis: v=2.4 cv=W8cIkxWk c=1 sm=1 tr=0 ts=6a8c2602 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=9aiwZt7zaXvVnErAyWsA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240093



On 8/5/2026 1:27 AM, Praveen Talari wrote:
> GENI protocol drivers need a common way to scale the SE source clock
> through the OPP framework. However, the device that owns the OPP table
> differs depending on how the SE resources are managed. For Linux clock
> managed platforms, the OPP table is associated with the SE device,
> whereas on firmware-managed platforms it is associated with the
> performance power-domain device. This requires protocol drivers to be
> aware of the underlying resource management model when requesting
> frequency changes.
> 
> Introduce geni_se_set_rate(), a common helper that abstracts this
> difference and applies the requested frequency through the appropriate
> device. The helper automatically selects the performance-domain device
> when power domains are attached and falls back to the SE device
> otherwise.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
Acked-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
