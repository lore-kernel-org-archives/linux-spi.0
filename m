Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E433905E6
	for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 05:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786513347; cv=none; b=TuxUeI+1juCNDIpUSKpfKHpj7nHbDrzK1c/fQxPL1XqR7YmOORfGUN5LID0CnnAgFs0n5eVvPeaC8QmAZxpSCXEsSJ5kdS4scaIlkDnls9AF6dfJD7s8nAc5B2sPVXmWHbgyz+OGnmIzrNm21+UMj9E4tuMygqy7P3ZxcEtIu/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786513347; c=relaxed/simple;
	bh=TJmIbi/bPbRsy1xUNDAat8Ug/Mq8nuNMjnCqm1a5qhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aE862qYf2HnglHIdlVexm8IKNgIUqa1xzAgWnKW9j7NDdYKVPiEzFnXF3jpO/GXXrU79i6Mu6SBgpMMztds5PyPKkBnYL20Dp9sp74F+rZmYtlZMEKwqzzYNIS2MJJiZPoGJlZsS9IMVR6zJTd/vPIqkJxFJZnAoO/FNftex50g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FJ123BgX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MnWLg8W5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FJ123BgX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MnWLg8W5"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C4U4M51521389
	for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 05:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LbC8YcgiRzyEWYo3Cz0Po5tJVDEpDrhaAQQ2DhHxGdc=; b=FJ123BgXaniXyG2V
	0tG2Dm0BSHHLERZZCz4VpHRCtxg499vglsky7yTX7ER0x2mmpgElVY0ckB6ueRMC
	Zwgr1qw/WOEE4zx4MM+kyzp6UrGsuHMOueg0ErqfIhKGwDWwxlPLw4SqKUG3rk6V
	PbfLV7K0gc9EJc3/Z/KgzV+xNU5PeaPlpQdTQKtI47r9sfE9BrcQDsRButNeHWyj
	RBWQ5lg1aW0Uads8wxyzaF2CQ28yOCmDzZQ9Fv2++G/B6C1CGjQorVoxlBz4W7mK
	71r7odKeImrVXlVkK4VVhdsIKu3eYdBJts7FOcEgORNaGdddypFpsBJbI0lNUG9j
	ZDmqlg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0hfw08ut-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 12 Aug 2026 05:42:24 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-392cf18db8eso854156a91.3
        for <linux-spi@vger.kernel.org>; Tue, 11 Aug 2026 22:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786513343; x=1787118143; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LbC8YcgiRzyEWYo3Cz0Po5tJVDEpDrhaAQQ2DhHxGdc=;
        b=MnWLg8W5csOKCJJzJ8vT0o29WlBudHC/9wM2MNWk4LbBDe+LI/LDAa23gZGykYQ1Vc
         Ryda//vi5JmZmImmjVCFqhHDHnNRWNj3T2NdM8lyhRbLVFwXLSRtzaYT+PZaYt9bQ7lV
         3wGA1TE5ch6OjQso6qfMMvhMtkpicxqIVZG/6+4/U+UaF3VUz5jqoIRT54xHl8Nq1sdC
         JJJgFzl64pF5xnKlp7RUK7q2+JVOgcqVRFSk6qfDDB85XXxYWb6r6/5jJPvnkxHTS+VD
         aZZJw3DndC+2rbA37HXRGlsHyA2v5iVQusWwvaBv2DvunuGIxsDOsbrb/lWvxj7kXgEO
         Hn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786513343; x=1787118143;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LbC8YcgiRzyEWYo3Cz0Po5tJVDEpDrhaAQQ2DhHxGdc=;
        b=Zt6rxj6B7QkB2mrP9+qhOOu0/IivcXjtkCbBvpZdhgNWz0xLe/cp12UBMe608bkSF4
         BcnDCuxc8cp3Iuyq/QhieO9D4ph64QUSD3QehRhVE8gHToMDpzaJdCXPjDxA/WfWJnvp
         swtAuOMSWvOsET3pYhv5KexHCHzw63zxGqRSn3/YtcYENFNtYUnf9n0SNf78zqvxnTex
         SHonSkegOloNcTrEtEy2QvZAD1vE2yf3qh8RkKXjMDjIukc5/pvYSdDlZUx82DYGw25T
         Fc00+i1DV46Uc3bmkAr3KEtgu11QUadcpLcSKNb3UrzXbDVrYXIalOmRYlmLLYSvn/BI
         YcsA==
X-Forwarded-Encrypted: i=1; AHgh+RqbzwohrjqOLDqy5YsucOGujk1NG0qrVpF/S26UKyKpGsr+YbFoiqsvn3DYxn+hhYhPx1J0hVpgy2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQOVgl4hvw8SOSQz4fg3F9gVU/o5ipwNRqBjnPhlWKRKYJw4a9
	UFFDQ/nh0gekGLNX5QEXDhxd8oLOEPJk0scVoKQg+04TLw6pQvbH2QJzGS11nyA2IrClJxVYkmQ
	a0sASLEX5cUOR2lHQFmSeUri1MwVZnWCNLft74EPXX14gSWAeOMEewzkrL7/Q34I=
X-Gm-Gg: AR+sD12pyGv/stQE8uR5YAvNVOczzJkikjoBfHQV5vPnHaMFRFg7HlodmQtEjaUdqsd
	I8VzNEozya4BqPjHZB0Pi3xZ0P0eBUj8lfb0TJfpwW6wV3JfMeC4h2HAf60hubzVCnUZxc9wg9p
	UdvwxcEmomkMttZpTjevNYF8fj9GophjTjY5RNiBFyQFAiWR+NsoG4E26KHcSHXOlh8JeAkQW7y
	+1frvETmvS0xUZ6FNS00lDAaiIhwFYMAPrwSEYG2zOUYizMMLblovp9ZjprIG56i/ePYCIb2Bmv
	EfnebUxQbgmyTgGc7DTQXUB8KRMD4aKRl3zkYGvrSZQ9CrzV1j0sj4IyhxFlB0fmylb97sykISB
	CEjPLl43uoGy8XpAMHy/ccJzbCHPf7Curew==
X-Received: by 2002:a17:90b:17cd:b0:38e:6a30:4bbc with SMTP id 98e67ed59e1d1-393017fd780mr2505171a91.21.1786513343104;
        Tue, 11 Aug 2026 22:42:23 -0700 (PDT)
X-Received: by 2002:a17:90b:17cd:b0:38e:6a30:4bbc with SMTP id 98e67ed59e1d1-393017fd780mr2505137a91.21.1786513342679;
        Tue, 11 Aug 2026 22:42:22 -0700 (PDT)
Received: from [10.217.219.92] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f933f5e3sm2130026a91.3.2026.08.11.22.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 22:42:22 -0700 (PDT)
Message-ID: <6d56d5e6-3a4e-4f27-9337-9a9b79f16804@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 11:12:18 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spi: qcom-geni: Add shutdown callback to quiesce
 hardware on reboot
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, chandana.chiluveru@oss.qualcomm.com
References: <20260805-add-shutdown-and-panic-notifier-for-spi-v1-0-b5db170d491e@oss.qualcomm.com>
 <20260805-add-shutdown-and-panic-notifier-for-spi-v1-1-b5db170d491e@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260805-add-shutdown-and-panic-notifier-for-spi-v1-1-b5db170d491e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA0MyBTYWx0ZWRfX4a0fxhtH1XI2
 Q6N9sucifif/CeDgpHrGuPgYiav0H+Xo0rmRtfi+3iZRsSLRindwa5usKXj7j8lEhwQqJLfuchK
 3yHnNaXm7q9dzWCl+ETYH9JgzD/3whc=
X-Proofpoint-GUID: J7HSY3ylBNclyehIoewrgMaWdEgttELX
X-Authority-Analysis: v=2.4 cv=fpDsol4f c=1 sm=1 tr=0 ts=6a7c07c0 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ay6fHbYERNCo5qgovOYA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: J7HSY3ylBNclyehIoewrgMaWdEgttELX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA0MyBTYWx0ZWRfX1QAM3F9fkavr
 +R45ddkkLLzxJ9+5+PG7Dgr8fkH69BqyXs2fjtnhmQ+TKEH9vV6bQuz09mDjrt92NICNwN3eEMy
 gCrA9xni1lueC4mleulHZ0DBa4/PGznpEQshM4S4np+sn5WMwnr0jiakH34Y1wIZ1tHfrJ2IRx8
 01zML8WrewC/rz4wVNNrQrtU0mbbj63VrxO7DmHWEzJyfu1Iy95y6Gg9duwPxJjpjBTQhvbuYFV
 m76e6ohlG9xkdNA637WIiI2MvcpLVJL+Y9WbIUc5vRk2mgEPaQ+MnrBUizKlQZgRiRZzu3RAFTa
 QcusvxeuD1AZWjVfCSI8j2gyln20VeXbcpZAl6glRPT6ivoTLh/CtFzssJ/7PzLFP11JT8bvGkU
 k9qiUKm0N5Z4B4SvssCX3S1vh5+WWUm120GrGxpr3mbddpYUEhaNdJhkQwz+D3x8glthUtD1sMk
 bGbN8tqC3e46KTIEQHA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120043



On 8/5/2026 4:12 PM, Praveen Talari wrote:
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

Reviewed-by : Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
