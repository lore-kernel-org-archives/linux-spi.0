Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792671746;
	b=GUk59OdYXlHIzPhKekF2VD2fp4oddPgrw7NssWVBJViHwJ5kNdorBYok9dUo7OjdyALu
	 5k8leBd8YdKNezryBXI3nePvO4i55z2vnafpYempt3eXZ8f/P7Zs7XfTLOdbAt3k83TrY
	 tsH+IDpQpZNyQuAjXb51OTiaouuDnIJLl4TCcq8NTfNhuNUpIQCCOW7fvwZgfggc1F1/c
	 idwDRTC6uJuXz4TpQ/V9H/qWZVePyQeFVmNpmwZBFOIRb4hr9V0caNR/uECOsG48X4XeG
	 H77u9Mb1DwXoHvCtgvX8Ixh0ANfLaoflmWuMmXWhRpUrnDSgAXrHpB7aWyAWsdw2PZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792671746;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jMMBwaLsIajhBzJwHlXR4BwgAy9WFdwK3Pip2rL08qc=;
	b=p1pt26hPi/kBBkDETy8nMnpduudlrVr13VOvDGC+SnT2LimIzF6NFEPn+CbE5uv5PaKT
	 grS5qhAOfOwOB7nS8KHKdtbVIRl9BvaPtFKzlXXIH5h4dPcB5PK7cd0yKIuxkKMZJnc3j
	 jPTMvNB1qfCRQPvv6l5heUNdmiLPvyIOzaVKXoeqFEGO6UumY1c6I95D+XiFVIHIxoFru
	 InTjVmgp4BklGC/cFucM/DQzecmEap9stIr50Brm6yWuyJijlJXhZ0fYdZfXERm+bTuUH
	 viX5DMXdnIcMOQw5w80D+yO+GO7YlcHUh6OROnTdp6FCC3t1guwE87DbqW+nenzQiSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b7FjuHri;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C6zvZYVD;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB73606A321
	for <linux-spi@vger.kernel.org>; Thu, 22 Oct 2026 12:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAB73606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=b7FjuHri;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C6zvZYVD
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MA029W2574416
	for <linux-spi@vger.kernel.org>; Thu, 22 Oct 2026 12:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jMMBwaLsIajhBzJwHlXR4BwgAy9WFdwK3Pip2rL08qc=; b=b7FjuHriWyJcQF6b
	oVxgz8d4XnoXFI7faQANh+GAqlf1hwx2KqrTuYLjyW5FpjEwS2L/kimmAc3pa4AB
	CT4m7ayULxWWZG3q3wZbrPIeLAHicmVkjguUeG7SFxAspd6FWvaKxbVB3HurC8OK
	fcUz/yF/RvrJD4lPFSo6JhfOzG2b4VNvQPZIQxfZkBQgvZJephazPUFFGQ73TqiJ
	R5iVVRCTGKIlJJQdCgbkZ6MEHpNZ0Go3fRbWPJuCci5ZvlhXGO52remI9hyptRID
	m9aiYahu2KCq3Fmjs91IJukRzfggloF1DzztroxWsu6nIhC08nEbKX1fDlEAVsCH
	olWzmg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93ak6kf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 22 Oct 2026 12:22:24 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ea63087d79so8532895ad.3
        for <linux-spi@vger.kernel.org>; Thu, 22 Oct 2026 05:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792671744; x=1793276544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jMMBwaLsIajhBzJwHlXR4BwgAy9WFdwK3Pip2rL08qc=;
        b=C6zvZYVDvsQzlkSCBnbfBSEinTQ5aqEOrZNT674hCUTK3Z05R+AH6DP0WTc4lrKLzq
         +pHyQwZQfA89UHm81BY5XebO+yKhsStKDNo/bb/r5ijlIw08rB48z7jdfSphizItJbq6
         f+H3UlJilQPQOOB4erv+ZTLSQCR5y3vZw7ipABz59FsDCLTHvPj8c+5v8jl/hTBVBbow
         Yy724azzBS6hhZ09zZa6IW0tE2c72VLgTx89YOy4SEyBu4Faoz692cMJMWFMC08uJdZt
         TP9FEUjo7ZFUeowAtZmVF3OFihn7b+/hpHpgojpxauF2sHALP64B2pKOLNPSZe+NLo7e
         +n1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792671744; x=1793276544;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jMMBwaLsIajhBzJwHlXR4BwgAy9WFdwK3Pip2rL08qc=;
        b=imc3Kr5IhNZiwPeo51okPAYXugeT1dOSFrD33zRJXOCsoJFXC2r4bbcG7WcTPYAqJV
         BProQemR081yaKOAuAbnLEOwLYrEP+4v/K421J56RwI/HuhR6qg/VYZkVPyoL4oaBxCm
         rNCcteXWuBqrsrrtxRLdZfVirY9PdJigwKoY9a/lb0b+E6b8QvSQzFJJxG32Kw18+bz2
         ZY4bzjVUFp9dWKTROjhW7MlLAkmxQUcfDxAhgPFS7xSfxzLFOcWGReMlby+sw/N9DiUE
         FuW8cXarOrIhreNUKP5o5wgUYGc8jUVPpzA7ryZCh278KJ5C3m/gL6mYWLnFnLS1LR6j
         cYkA==
X-Forwarded-Encrypted: i=1; AKwUvBwzmWAAXQUoDbdBRkIObop8lqSoaP2KWFouCgtBzvHPLJGtF4uKLRv84Y9uiBDPovclZjbobJ6c91s=@vger.kernel.org
X-Gm-Message-State: AFq9FYJlBs6en8W88PmH6fXyd7nrFQjnR27uoQzbtk+ucmqA9g81lDiz
	Z6P84mE2AvynIsLGxdUyJrMGnhU7zUoUpldF/Y+xo6VLZdc+C5Qw8FqxbIcO0LXW30oRTh8LBFu
	T19OaRVfpHvuo8a3e6QOihgQgMaUbinVs9JasTrXIhcByTB3tg5dNYdiiZNzZZ5o=
X-Gm-Gg: AYBFou0vJMXzKV8+iKN6d4KnhlcJ4QhkdJkjb0t+9mPjrCAD2xki+Vzn/eYxRlFSBJg
	A1s3OU/Vizif7lnvGCUazKY+qnM1SM5YlVs+M8SA8C1V43akHWPPbO/q3yqtpnv2vgyUWYSvrv3
	RMnO4c4vWMSpLEjWf5jIqWkPnxwExGLqq5rT0r2b16kEVSWG9IK+SQ6J7Ym7NfLv705ddcQBXuH
	5QebA5/zmlFeq0BsKkp3NDv1YGb2TRiR9gv/NRgvr3VIPuJfm+YPoNvizMF0Dp0Bp6ewtymQH4i
	8jjTK2T0gQj1mO5BIKeD+H9rH0agZ+fyAvjemss3OMmrqNne0RMZy4lmMK43EobOad/oJA9OaWA
	a+yKKulc0U1+oXzcdq7qKjkG01r2TJYx46g==
X-Received: by 2002:a17:902:e844:b0:2e9:514b:7a73 with SMTP id d9443c01a7336-2ea43fa9f19mr45591745ad.48.1792671744006;
        Thu, 22 Oct 2026 05:22:24 -0700 (PDT)
X-Received: by 2002:a17:902:e844:b0:2e9:514b:7a73 with SMTP id d9443c01a7336-2ea43fa9f19mr45591515ad.48.1792671743527;
        Thu, 22 Oct 2026 05:22:23 -0700 (PDT)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b412756sm23642595ad.24.2026.10.22.05.22.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 05:22:22 -0700 (PDT)
Message-ID: <5dfd7245-c2c0-4468-95ed-6bb8a385da98@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 17:52:15 +0530
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
Subject: Re: [PATCH v3 1/8] soc: qcom: geni-se: Populate clk_perf_tbl with SE
 source clock frequencies from perf OPP table
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
References: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-0-5da1096243c9@oss.qualcomm.com>
 <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-1-5da1096243c9@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20261015-derive_clk_perf_tbl_from_perf_domain_opp_table-v3-1-5da1096243c9@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lylsdQ6wzv46n4_CU23yvZruHcLRjRxR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0OSBTYWx0ZWRfX4u6q06VqBxFo
 hsUTiRj4E/+vBAt/FeUoSjshpJQku2kliBeQec4Sr6KMBT44VtFcl+KBVevcT201fz/I47zi6rK
 fnxD5FV4qH9DGQAjDB9wNMGpB7oKpyc=
X-Proofpoint-ORIG-GUID: lylsdQ6wzv46n4_CU23yvZruHcLRjRxR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0OSBTYWx0ZWRfX4w7vnjt8WmVZ
 3DOJsMAVv+7xxDQ2207L/GK5keuiD9571LX80GtpeHsyREj3WBvEbOzltM2KFcQN51P9++ZYwCt
 6mde6TUaOhyL13YuYstY/lxLkKiJVR11jkBajATgsC7yicbBK4t8EDxCePT9HEdRBm7x/+TvxOt
 wl4YgfE+e54XvA5XlYV4ec2S8MFex9npdWbtFlweGoHJcNPvpyDNcWhzdXNYJQ3p+fVfx7pU2cJ
 KfzKxsoi+b/r8Af/f6epyrilBL7TvxGvy+U/7jbdjsO1NGFeV6UMMv61atCnpxSWs2WhKyYqbnL
 7NgnE94ohAjOXbrXWOe64Vnk9tZLTQIvf5Uo8mdJlAwbvOPtIYnsecs4eYaRbraeJKbITvwgWmJ
 w2jRUWEAwBazjSndJPtYoowF7z0r1NEh4MbeFiHLY9LVXdGVLPII5cjRPI/PRrpCEZdvvumhMDv
 bG5bdIs+9dD2BpsfpbA==
X-Authority-Analysis: v=2.4 cv=dOszC+Zb c=1 sm=1 tr=0 ts=6ada0000 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=ddSnBWzqd8mu_d83chYA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220049



On 10/15/2026 6:28 PM, Praveen Talari wrote:
> Currently, on the SA8255P platform, protocol drivers attached via
> geni_se_domain_attach() treat each OPP on the perf domain as directly
> corresponding to a protocol value such as a baudrate or requested
> frequency, and simply request that OPP via
> geni_se_set_perf_level()/geni_se_set_perf_opp(). This does not allow
> computing a source clock and divider combination for a protocol
> requested frequency, unlike the Linux clock managed path which derives
> this from se->clk_perf_tbl via geni_se_clk_freq_match(), and then
> applies the matched source clock frequency with dev_pm_opp_set_rate().
> 
> Change this by treating the OPP table exposed on the perf domain
> device as representing the actual SE HW supported source clock
> frequencies, the same role clk_perf_tbl plays for the Linux clock
> managed path. Populate se->clk_perf_tbl and se->num_clk_levels by
> iterating over this OPP table in geni_se_domain_attach(), so that
> protocol drivers on the firmware managed (SA8255P) path can also use
> geni_se_clk_freq_match() to pick the closest supported source clock
> frequency and calculate the required divider, and apply it with
> dev_pm_opp_set_rate() the same way as it is done for the Linux clock
> managed path, instead of relying on a direct frequency/baudrate-to-
> perf-level mapping.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---

Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
