Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8076C30DECC
	for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 06:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786517920; cv=none; b=f54bWZ3WW2SAHNbeqzkm+OjuuCBE8y4DRGdQjaOy5qq1J/IrF+Wc2kYwupctCNQ12788CemvN8uikuY3h1/QmcSbuRVRy0Y0RtzijBca2q63/bLNgrKKnrFVuAXXUvN21VEcP+kSWaj0mNanTIgnQaiQuCrVSfLRB/pqMB5Bx2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786517920; c=relaxed/simple;
	bh=Gd7g9+WBJaMupWdChk+ZOSr7l2BJlZhFGSvUDw3FDp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cEFZ8oeBDYjDIgZ4HSzeLm1hRw3YZ0pk/FGesW0usKL2RBSBaHXde99csPIDCAgHcx51D2HfE6cm8dedN0ibh2wahXPPiy67Fnoqwb1xa/N3hcB+a3TL5B/BrCH4VViaMPfXo7wLAYOdC6yJT0VEPuNRQipkTdpu4FAMwx5vGuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q1sNzDbV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JBPvpEJv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q1sNzDbV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JBPvpEJv"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C62EoT2992730
	for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 06:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eoWQNmzdMYFpvKQY9KEgGN7hqNjJGc5YN/IZJKFeWxY=; b=Q1sNzDbVpF3+KFyl
	58FlpFLdlRjAH/5dYPXCZ1NYG2+F+hekOA7Q7oJylgeN3YUhew3ZA3FVzUiH+5qK
	pa8iXkc19AWujB3IURifJ18KaYuXVZWl5YakTQhSnsp162mxRrtYSnFuBf6Bfe8P
	hXZFijh3ILg17+UPTj8n4RFSwkbEsoYgEDZwxhXYjeSGLL/ISX/Deokzxh8CvPKI
	yQloxhtMOvyfAIpkJvlKuTIVpTprwpEv4p7Ne+0r6sEe1LmAeVotsjyEK8cmXB8l
	Doivkx3wUbRCG9GRXvHf4bugUM5Q+kJlt/sAtIOAzSwkrf+6WdJLX0rcFD3/EqPH
	pHXJ5g==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049dkx23-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 06:58:38 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-388b404eaa4so1077292a91.0
        for <linux-spi@vger.kernel.org>; Tue, 11 Aug 2026 23:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786517918; x=1787122718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eoWQNmzdMYFpvKQY9KEgGN7hqNjJGc5YN/IZJKFeWxY=;
        b=JBPvpEJvgU4Oqb9mmKaLL3fsE2N6zlw+l1W3Z9TJ5OUeyINNeC7ot2FFHjCVokWJDq
         qB1zXQ9rl0gONh6kpd5MnjZxheWVKpuoAlB/oW8uBvyceHV3a4Y33zwUjKMbpOVGR2RL
         B/SmN4j79ZTCFa5pxiAF5GdioVeOcfTuaw4XMnnAoyoFZBl2wlmGA6KcSFmybZNHjkjG
         nboKG1Gata3+Amy1SWoUK6uV+5RtZt1xvqafrPqALwStVuiw0AFSTKH3AQ227u1PJf+6
         DtAmQBtof7NEDqNIzks/seua3B4DQw7ktep/lK+VwekEohzFbo/UPcoYiZahOHZpDQ1N
         rO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786517918; x=1787122718;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eoWQNmzdMYFpvKQY9KEgGN7hqNjJGc5YN/IZJKFeWxY=;
        b=S1pZy9kVtE+/WTFcvqY53gqb1jdra+fKTap9FfWU0+HWcFby3BvpAmxngPujXYSNDb
         7E+gkwyzferi8MVWhbGlRAQqKaoidLwl+mVFXvFSu1/RamIkR9YHpSTuYjsxXNgP0rad
         x8/hpAZziSjxx2dkJew7WCPUT+Xw+0C4XC/scMIzl3wzPZZbU3D7nbqBNCs10PoPFPw9
         vOizQIvhGqzQMMFq/CIX0U0T9val7vqT4rGmFaRGSDu5LYcnofn7EAlYUJ3L4QwQRJyG
         6k1I2OcgE3U5MPLM3WS6UatPsIDcQN1j5ECW3WpfQCZFyHHKXaSot72rMwwUrzE3vHY0
         5PUQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp5O5RBbaFX3pohrH0sv22PVl3NVeabcXosu/Kr5P8RUf6pkuwmWtAsGVsgs+kEpDuAwEd25mhsW1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxj8Gf0E8eZLJVJqnNU7LcuQQo2D8vCZPh1Gon3W5j+3SXZ+mC
	K9dduVKl1b9VychJzQ1xZhzOwxIEsC0amfZjcpNjTYZde2jl7xYn5aWT0hU0A0O4TghNOK5Asx2
	s2w8a92m6RiEd7xXqh0L+gRLb8O3tFOZe5TuWO0QkQr1YYax840KBfqZpsxg91ng=
X-Gm-Gg: AR+sD10W4krYlk65RskqAzUYIrlPT5shFQYOI3Fat0oGRndiX52rl4LL9UriMwCYDpD
	g+OZr0bugC3S0zK7YVEhDdJDQEa4xpi8bsvobfwC9LhIoUdfCpjiDWIxDRnWPcCW/nHSZFHftJD
	s5/+1REV6XG+nQbKgbp7vdEJQrVChjbUM+Cc7v6vMvcKrKOFfef5eULRvjICSDDq35ioBCDCwD5
	ua+wlZS32tEVheg/XniEkphgrMojpN81VLSydQxCVLjRzGByfPa90TkrUNK6eN4WzaCX1LyZOVv
	YxuQO1S5AHpkNWGENUvlozyI2/nhln3vPCV5v06tjtNnMgOZZVsEsMfAvw4Uy3x3ruL3CDKS6Xs
	txa2eot1imsO3AopC+vaHNdirXoPDJVyQKA==
X-Received: by 2002:a17:90b:28cf:b0:37f:bfa2:1887 with SMTP id 98e67ed59e1d1-393012af827mr3137286a91.8.1786517918070;
        Tue, 11 Aug 2026 23:58:38 -0700 (PDT)
X-Received: by 2002:a17:90b:28cf:b0:37f:bfa2:1887 with SMTP id 98e67ed59e1d1-393012af827mr3137220a91.8.1786517917524;
        Tue, 11 Aug 2026 23:58:37 -0700 (PDT)
Received: from [10.217.219.92] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f94d30b9sm2391336a91.13.2026.08.11.23.58.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 23:58:37 -0700 (PDT)
Message-ID: <61eb40e1-1eae-45a3-af65-62eaaf27edc4@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 12:28:29 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] pmdomain: arm: Fix -EINVAL from
 scmi_pd_set_perf_state() on state 0
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
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-1-61171ab1cdce@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-1-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfX6FZDnrfjLb2E
 gSG868jXb79NNv54OZbJkVB/qe3hsEPtn6xKqnYdRsyWbShjDySD+SF2b0F6i7Nt6+XyoFG1Adt
 7Hv+UnRCjHT0aeuIt+ZF1Snn+xZO9yk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfX7ij5lcC/fGSg
 MtM1Nx7vCdbhl9zgw7Td/T6+dybVU/b6enAow6B1FkqnljwAzNz0Tzh1Ots6SOBto2evvWe0hnd
 LHRvmbSE+9v8eYy/hdD4T9h1hLpvIv5VnSEf7+sYtZyftOZgwuPxkcw119mNTSXPXjT14/m/E4c
 48NCIgWq5lVUF7x198qGxskQ5CDe3OEzseINQQl53RW6U0D9p3elLVkkN6QMfWycirgs+e/MT/Y
 uKWjrf+1YZU0AlRG7wha+IcfMdnCeS3HY6WUprTE8xd5veH6+0MnQaYKdA9FN04SJXH6oqSgkU3
 +0bWhfY1/TsBvzwikjVNMc3NBxUoH/GAu+A+pw0HaQYJ4k3h48WXIgdKE5B9gOb656z1wtNpGT2
 FTo91V9zl6X9Xi2bOXSWl8puNjeZq40/qw1DYcICOkCS+ZLOchqeb1o88EqaJKLp+U8a2LvZPZW
 URIHS5yJ/nVpgZ32axg==
X-Proofpoint-GUID: QIIrucBRt8VydS0Tx4BBaw4BkznjitxB
X-Authority-Analysis: v=2.4 cv=CbA4Irrl c=1 sm=1 tr=0 ts=6a7c199e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=dS1doENrTls30Ym8nGUA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: QIIrucBRt8VydS0Tx4BBaw4BkznjitxB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120054



On 8/5/2026 1:27 AM, Praveen Talari wrote:
> Currently, scmi_pd_set_perf_state() treats a performance state of 0 as
> invalid and returns -EINVAL. As a result, devices attached to SCMI
> performance domains can report failures when relinquishing their
> performance vote.
> 
> The OPP framework use performance state 0 to indicate that no performance
> vote is required. For example, dev_pm_opp_set_rate(dev, 0) is commonly
> used (by firmware or linux)  when a device is runtime suspended.
> 
> A zero performance state does not require any SCMI performance request
> to be sent. Treat it as a no-op and return success instead of reporting
> an error.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

Acked-by : Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
