Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB6533D4F2
	for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 07:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786520208; cv=none; b=QF7pTNuJDUHQSHFFY4Z/fPn0pnmJDtHM45/JWa6eLeR/jh0NctN/srd6wJbtmLQ4IaV5phab7SCb+AU22A/tIbBYSN8WjVAQTPhIG3uLPM9K0ONoyuRFYM74jYMJuuQzcaztTqO91bWEcKHkPWjdPmTn5s5drXW1tv666InWaY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786520208; c=relaxed/simple;
	bh=Hn67GR+gO5Esig7XtQGNEiHvrdUGoUdeHXneZMlfYRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kv/L82rHYpKZOSrvI4OzOdVGdozHShs4fa2K0S+HcYbbWon2R/cAZCJ5Y2v4j3kUHQhZBg2TRco8vj1grnP9bug9X5Uvo2BFvbh4JK4yqhqOERgm+BpUd7j3exsRpru3BWkTwLNAq8GalvVtF4gHHeFtdJWcY2Z17244qNtb05U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DUT6U5LF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V5aj7xxI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DUT6U5LF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V5aj7xxI"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C62OUW2872356
	for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 07:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NiIIs1N5jSm/s2IraoPfNeMV7WyhxZUx7PoQm7T9cbc=; b=DUT6U5LF+ORWHPgL
	7A5td5L/EjOH8p5NfbokYu8RsMKY33NfTAxUJ2dQtUiQS2PYGYMFtcwLFGQ0RhAW
	2s/AE0vc+NDkEPsKAfG7qWeyazG9/FoFvPWQJVznO85jF2K1nQQ7AS3XMz77sghP
	YKKRZVoh+BdtBdGfTfBp0MDAlueYM59rI2IKupHHwqrZBh5w0y+TillzsXrqa5l1
	9kh8YY5CZ/3sqcHD7KDtcCXuj1zL3AFBVkwpo/HkctruQhvQFfgTKR8TicTp1sWL
	FzZ9vua5JnOpHLzgo/7Dc/ms+JMC3+77Uml+D3cFHfrbfgk6FltE5+RT/HeoWhwQ
	JDJXbg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hj1gqak-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 07:36:45 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbedb8673ceso533699a12.0
        for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 00:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786520205; x=1787125005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NiIIs1N5jSm/s2IraoPfNeMV7WyhxZUx7PoQm7T9cbc=;
        b=V5aj7xxIGb24dsIzjhBnFqzUfp2Kb9WEFqp7aaZfnDP2SyrIHFxtY8+50hqg7QrwkA
         jEaMQXBq+j0YaY1m/0XpsQCyKhvMxKJyHvpr5mg1P09N2Tmok70RKtqbQu7ltlo6D9ib
         TQZjFt4p5cJTzpG21K2FztoYyHeAG+ld1ejuc/l2ZbDIOmKEmDv4E4ra0eFoIjfzLHqK
         POJOkJQ16lfdVnYdVd1GOPX3fy9GtXjuI2xOUHTohUSb/ethHCPrAOfw5tloMVGsWZRx
         jHxOQzknr0B5TemGz+2og8cE5F9dpDXX9aoJE28dXYLl5lxfA9w91RYwx8DlirS/kiOi
         A4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786520205; x=1787125005;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NiIIs1N5jSm/s2IraoPfNeMV7WyhxZUx7PoQm7T9cbc=;
        b=MAUnbV++9PKmA8tantH0N/PzEQLsiYNsueBtRY+ZKSCd4R8z14+apGEWZbYBU/57FO
         XkHI7s0Nf6Ai36QRLd9k9n9H2EgM+OykLUBPzm95j65s//PfbdecBVai4LVnHTuIc3W8
         ZCrRpodgqe9rjEXph4oZhn5oDKUE2+EERLpkQm4m1495EgilnVNGgI+jpfxo7ar4PMqD
         dQRHSfJrqIJKYWbg+ShDjJEQC5HcJkt3UUfkJe3YHuKMAxay/3n869JOZtNkEMHszWpK
         ewa8Axjoz0deKUmP8RYIamNHHXCuWfG24BrZVPHi6ECZQIkF+twEHK6zCnasVwVaDOrZ
         H+8Q==
X-Forwarded-Encrypted: i=1; AHgh+Rrz1yAcD5M31iS7PPeJiO76NEKSHDggEkeguwPCgqftS7iBDyuGsDmmPvhyqbB7Y8OyEPBXCCwN2Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5kAVxQih9JmIMQw5WLbIp+OJoKbKAXA3VS5s+xdEtyLH28hRW
	YQqSg0di7U3g6AEWqzMrsu/v5SBBzRjJ9l8jXeJXTHx0Mvka5zC9Ihu9rqKqqv1h1IRCY2iVul+
	+n5efe3znLfYMgQTqEh4pA55NqsZWM0LP+8RT6yKzl6hZmAl85XBUQLCdSzD6yr0=
X-Gm-Gg: AR+sD13zY4cwmnF9gtYNmbkp4FwIzNajbDx3Pg/pv+AJencZiLhJEoR5dR5JAv6R2GF
	0r1grFzRjFph2AExjwQWUg++3xWn+YFAan8oTtYIxN0ltS8iWl7fxt3kHka/QzsozyIBR54Q6DI
	vW/FbQKOoRaqcnpUuA6kRzi0pczRPAgEPhlAVsg2Sz/aezOYSq189OiFZ8dBNrZgZQXz5W06ehZ
	Pzp8I7mWxh/pHPvB5HIm1YtRTgktlMsr9T2i2TqmgQwLtPh/K0r2OYN8aSdtpkVFC8V96Hl9UiW
	kiShwbp3kqpUANyF36JSl/V0WUoBcKj75kklK3aWujPvzxSxywbyYTf3Thcfox+hSX0fcgtDh/0
	GHiQX12HybzTwlCDlxZIisYucVsJQd547cw==
X-Received: by 2002:a17:90b:3948:b0:383:f52b:d616 with SMTP id 98e67ed59e1d1-393014fa36emr3195033a91.10.1786520204572;
        Wed, 12 Aug 2026 00:36:44 -0700 (PDT)
X-Received: by 2002:a17:90b:3948:b0:383:f52b:d616 with SMTP id 98e67ed59e1d1-393014fa36emr3194989a91.10.1786520204012;
        Wed, 12 Aug 2026 00:36:44 -0700 (PDT)
Received: from [10.217.219.92] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f9675e32sm829428a91.0.2026.08.12.00.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 00:36:43 -0700 (PDT)
Message-ID: <2c036793-23b3-48d4-834f-9daf8000b2d5@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 13:06:36 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] soc: qcom: geni-se: Populate clk_perf_tbl with SE
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
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-2-61171ab1cdce@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-2-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: BGLCb9hRNohEae1EH1UpzFlxuIlEiJfD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA2MCBTYWx0ZWRfX7LkmBrUXTa20
 nOKH/+Cq5Vl+g9K6lVduutDPmin1Xez74Jk66NYt7tQg3lPonWby/LEt2HNFhccJWmY1R7VydE6
 04KhB+sxy5/N6q0GNa81rx0HTwoOTjgILUwAoPC+YWP9UuetaUk1eURrpSRMwKiehryR8DdYTon
 doo5guwnM6fnF6hovwN4jsHFwoK1ulhL0fz/jcvYICo7sLGI6MCQKODwL7rmeCuiAuxkkJ5o4zz
 hzZVzKElE9KS8pYSY6arC/FzPZr3KCHzyllK2lD3+vXnMZ0stD+/b5Vs0MH8vo9fogWP+qAas8u
 di5GZGmcCtwTXX37wV59Y4abiymizRSEFkwV4q0zue++FQasNH1wL1N0O5WNDo+MXS6FGbGVo4e
 OS1e7OZKTnH1dvrqTTwJuviUnOFr8VU1zS+T3vbqqdYctr6F2oSNBf7cjZR7TuZDvgBt2Vm4uae
 YYrhuJGRO7HbRyfJKCw==
X-Authority-Analysis: v=2.4 cv=K6ES2SWI c=1 sm=1 tr=0 ts=6a7c228d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ddSnBWzqd8mu_d83chYA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: BGLCb9hRNohEae1EH1UpzFlxuIlEiJfD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA2MCBTYWx0ZWRfX/WpG9+npRSwO
 o3Rjl8QS3ZiegVVgtUz6K4hgjDIYlBJTJaiRD5/pJag5CtWNHIMtuLGTpvD6G4mQDMsjv4sx4xz
 Ft+IUi4P84EaRTsSRxcqeGKiOHQfq2g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120060



On 8/5/2026 1:27 AM, Praveen Talari wrote:
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
Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
