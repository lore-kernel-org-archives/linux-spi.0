Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E0D56E042
	for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792003831; cv=none; b=KJKi+VjA9x3hhgA9aRcjGjsNNV4EeYHL/7TlQbw6knaWKO5cck+DW/yPTO83SuhVCdn4Z++sdxhrAUtSvU1KEg5sHj4AtT8W47PQ3L4jWeqfyUEmKK2PZMyQDxywFDr4t32k0HxoZFG5EHMBk0htVCtolvUpJ7szuRr7bN4Aj90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792003831; c=relaxed/simple;
	bh=7ah7jUqQtUDrn4PSNymda/Iqm5p7zMRB4PxJ+OtxpWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XljxNE273XXxKS61SegY8EF1mHDNsd/Inn8v92GIpF5WxSkYbEfH782E2hIMJ64su+bCn7MSKDKJ6iMsQExciWRb/jXv0jX/WqKeJ1G50uHBMjKJtOOzcCjnkAKyVYLUpbZCPmbwmudSP+OipTm1e4Tn2QMHhxZ+yRZaRwlGrpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hLw7FgaY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CDlyxjpb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hLw7FgaY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CDlyxjpb"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EEb08f905401
	for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 18:50:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QmKAgT+BMROb7bsj9FpwRJzAdtcudV6UZcveycRYTO8=; b=hLw7FgaYpyNo6zxN
	l8UvMhOCymTJmyoS3bWMjr5HzJVHGUDmM15PoeZw62rTAv7lAWVn+4w/Hn5g1+4X
	/m3XN9322dQYzH9LtDo5PYG58tsWg3pKe4CtmZEZalzj1aiYPrgalBB9KeuhcMVa
	BjmDS62vTj3Cuh3fTXBp0SJqfQjY8d1DAXX/AKNu1k1YrIaTOed3GbTA2OUWXI0b
	5Q0OHU11f0kfDr+XCUAoOHBPuYcu2vtzh4LNNBYJz1WtBvllA9e5EVxr1BQsDWjP
	ON1rFDnOcHjgSE319n24TVY1oL3h6wsAC8z3P7FyoemA7Qxus3vGzHqRDohxXyc1
	mVfA8g==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha42p34dt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 18:50:26 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1383723dfddso2385823c88.0
        for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 11:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792003826; x=1792608626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QmKAgT+BMROb7bsj9FpwRJzAdtcudV6UZcveycRYTO8=;
        b=CDlyxjpbo4zfV8DHanOTSiS05l5uhhmSw4x4HmEeO6jd7EnFjH6mgXE2HrctTZPbN/
         e8SsLNqVy5gBLbCh8DDpE2cV2mKYOfynhO9ia0RmoigQIVmBmzTeXl8VlHSrOUaL/Q8D
         +8A4zRPmQG8Pf4ld8OM53/7MlXZVp+4xyVDCOkP/KUtUGwneUTlao2Wmmhu3bIrqzHhj
         f0jsb3cOXldJbgracQEGeGqDTjoNaSXmIOoDu+vUVW2RsRVxtIMUL56l7CQkOdYBQx5R
         RMrNGxQh3iwFWy4o10BdUzuBQZ9l3OUV5h55liOhAjqM+6YQQ3WWyGTd9p35OQbEWn09
         werg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792003826; x=1792608626;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QmKAgT+BMROb7bsj9FpwRJzAdtcudV6UZcveycRYTO8=;
        b=1Y5sgkEXVkzOKfkFXRhUfBCuNTL6PZ6c8d72RaE3RM85lVUf8XDmzafaLRTBr6UF4+
         blVPNBAOIdn781fplO+GOknZWp1APN5f0bO1uK3WafGZQkpGI8U3z/aZble6An7aP9PT
         FlE+Wy7meGUOnJJ4HAQng07X7VpALLxKjLOKvioNz64UVOOiJwf/mWIZ8ttHvgPlAhBr
         k2Ir/w1nRVLWt6JFVfk6yEqbUhHKjqHqkxwJwZqUNbQBdM1R5396B2ZcxY8tCXb0fK5L
         i0yHLiMeDLmHrKRFJ7EkOwhgYVW9l61gJdN1SKJdL20ItUYE6aCNL25v/mq9HTgBx6Rv
         pHeg==
X-Forwarded-Encrypted: i=1; AKwUvBzECZFSKtKoj90x2ox4cflZU8bq6U/ctxhBklChyvk6jk/9GkfIVDQLHYZVLHrgrqLgXaRoF9iji2c=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGU1Dj6611AM/w1wXge/ild05Bqt1j/H0aEvtLLKkIFPtNLNk0
	26Vny+t/G+KTbrRWcfztDlv3Tv7sROf6A7gdgtA0/ck/PggMDT7okrjFLa0cK54ExDD5mnBUL5t
	doMsombGDcxF5k6JGAvZ4lJGOT/z39xSPKNRcWLA2Y0wdRl/lvlTgIc3UD6pZUTI=
X-Gm-Gg: AYBFou1UnPft5ahRwOzvpbjN18l5pN7E11xhNpz24dWRuYKY/PxaSZiV1M/zbbBvqrZ
	cuqSxD+shnkYH9MX8GhdLjSbpgOpA4f02jVh+Ow2IWFZntWjLH9N86R2143GG5HWjtnM9Ax08AB
	caaQ2FaL89eWwmpdGehN43oqDjTKZ97cNBe1drjzQbGYt6pMqBqtvcrDiSBxhnsJkqqJGwQCrvK
	33k23cwivwJC3L0Zt2lcz90Z9JJikGDXJOjtznzDI/YF7bSxnRXJfhKrvKSvRsfTg6omOkA+nZF
	qNYXAFrwcsac6AogH4MTiMrkazGElgDSUh1MIKrIXorI/HbGi7VTd/byES7K1I1ja2xjM0HVfpi
	jqW7W58GwdegkUShBfjLdZIB1oAHqt9Il
X-Received: by 2002:a05:7022:1582:b0:143:298e:913d with SMTP id a92af1059eb24-16a63b2edc7mr32561290c88.47.1792003825541;
        Wed, 14 Oct 2026 11:50:25 -0700 (PDT)
X-Received: by 2002:a05:7022:1582:b0:143:298e:913d with SMTP id a92af1059eb24-16a63b2edc7mr32561225c88.47.1792003824748;
        Wed, 14 Oct 2026 11:50:24 -0700 (PDT)
Received: from [192.168.1.2] ([106.222.235.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a442956asm62519780c88.16.2026.10.14.11.50.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 11:50:23 -0700 (PDT)
Message-ID: <16d94994-ff80-405c-ad98-ccefe4f951d6@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 00:20:14 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] i2c: qcom-geni: Use geni_se_set_rate() for setting
 source clock frequency
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
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-9-091697dbeb02@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-9-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3NSBTYWx0ZWRfXybz8AoowHG01
 EOkLPl1zHlgupBakEl6nqvMSjl0lCOCpqCTuHkXOwKjY9bCOlMP9RCzRGo67FYEIpBLnXx594iB
 lTTFspdWSANeFwoZsKXsdN7tvy0WSkA=
X-Proofpoint-ORIG-GUID: QTTvg1pcdVk57RuIX4BWPjvfdU9FzM6O
X-Authority-Analysis: v=2.4 cv=aeb0Dhot c=1 sm=1 tr=0 ts=6acfcef2 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=N5Y/PXOiYxOVLBGg3HvMCg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=UheTk5Niw0niUJ_rJrEA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3NSBTYWx0ZWRfX6+dhW0Gty2wA
 EHmB1HVmQntv2bFrzLnzEqWMeaeHDrBLc8NocNYdB75Pym8VVZR3gnPpkgq4/vgj2tHR8KyP/Ky
 rhtV2QMSFaW2GF3kUHr0NZAzL2igHWGg9monxxFz3XUCRETWO8WetPXA+laCmRAj61p66FAAkb/
 2bUNGThxc+s/wSu7sExPoJAnuua+c2lijvSAbFPlx54U7/qyiJn1QdhsD6Mq5IM9tlm68zw0p9R
 XVQJ9AXV8K6XV3oEQnuWpmN39HrlGBzqETv/21O7E5k/JR6MuAMMPrJD7f6v9iRmTDpfIqeTv3Q
 gq6m0fCxe2Gdv9bss3Sa/H281o8mgs/mjIYsezA0CoAt5OpBVzHQcxAqHZ7wpvAcP8o6YH0tVxR
 ztkgcgK6Jz8E2/hR9Edqk79masUtG3jCokv/FVt3td12tW1iJt5MZ/8FoMU0QtlLVQeX7rRRUcR
 MreKMMH5yxiMnd5C4fg==
X-Proofpoint-GUID: QTTvg1pcdVk57RuIX4BWPjvfdU9FzM6O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140075



On 8/27/2026 11:29 PM, Praveen Talari wrote:
> GENI resource management may be handled either through the Linux clock
> framework or a firmware-managed performance domain. Source clock
> programming currently depends on platform-specific callbacks.
> 
> Use geni_se_set_rate() for source clock programming and perform the
> source clock configuration from qcom_geni_i2c_conf(), allowing the GENI
> core to abstract the underlying resource-management mechanism from the
> I2C driver. This removes the need for platform-specific rate-setting
> callbacks and enables a common code path across all GENI I2C platforms.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
