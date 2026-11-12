Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490462;
	b=u2LtIXVHquDmlo3/5iFZ/iUABJlhRKVaNxCKu5nb0z70+CBAL61wjf+shjBmFMHe0nd0
	 B5+ADyL9oSO3GKPt+MYwy8rV07xrmjIqz1+MmwhoqRp4SZpvRbvUbdg2W4rxx9lNOIzAj
	 /X+H9tUWYkeGRLib0KyBnP79VQKR0XKzt2qrFcf6cV6zmTere9SO2TlSr1utZN30KqYaj
	 sVA33VkZWQykB9u7No4qd8J0NuOCuFl7ILgS1GvyF2GLzq32bw7NfaVER9IUqhgPCLPuZ
	 I7V/O/WD4MOdECeE1RKl8c35EYOMXGceR7t5Rf4N1+GmuFo+FZNaNYyfeYNWZfDHAbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490462;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=MS0b8nEt88g1wfp0LivrvP9tCkFoNKaIyooh0vFsgK4=;
	b=nZwcgtIsOLaJdmMGYxkm2NNyCIHO3fYApY9I2ZCtcEY20Q26+qNhnddLbzS6PeobMA8Q
	 nUdMdyWprvaFIZLGDCo+nbp6g0ZkVfhDipY7g6oU8Ojc1AucXikEir0rSBLDz0Btv1GEO
	 N4zSb1Qxriryg08D6nLJUSIQab4udJX3LAOU4eFe+Ahy1uM7A5LQwF+Mga2qbPmdLb5Rn
	 YwCNc50voLwIHmrZw3DkqMTwgjGy6aoU1UeBLM1Ugz3khY6o0sSOYzexPXA9Pd/dGc71E
	 E1kAN62/SRmjZBFcKZx7zjkasfE3zkMqYawUpaYwbafuwj6cnVO3V+RYyR2g3EXK+xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hHsGRD7C;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I5jfqXnb;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E6E606A323
	for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 13:34:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22E6E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hHsGRD7C;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=I5jfqXnb
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACB80xC3893075
	for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 13:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MS0b8nEt88g1wfp0LivrvP9tCkFoNKaIyooh0vFsgK4=; b=hHsGRD7CIheVre2s
	LWP8gjwXgsLt5YhSb8KdPblO0CHJxMoTwEJlliXeohBUyt9bGYvN5fGTChs5iPiS
	6azkvQnMhe7LRyYNcqCZmOhbrLctwwy8iaqRXher5tl5L3Sp4z7bOY4+ar1fBG89
	C3sz4TXbCcUpd4Rnv88Nlc9boMpjcLGZ33AJbW5oYafE0HD2Z2ojpNlFJKQCLXyJ
	MSRib5HXQa7yqSUWkuGy6kyEYnTX9Fg5BE1sAtHEU9KwaWLPba1IM8pUvNJt/SBP
	m5f0x0MZD2RAp5ztCgoj+cN2tcxAA1YwbYVnrw9HmcE4ojEfJh6RHXJwdui7UsBF
	Xjg4kA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6re1sfc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 13:34:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-943e8ff02d0so485350585a.2
        for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 05:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794490460; x=1795095260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MS0b8nEt88g1wfp0LivrvP9tCkFoNKaIyooh0vFsgK4=;
        b=I5jfqXnbAu+K5yIZKbvly4xkMmcd+toykRbvoCSRapj5x7z51HZTGvchLU7DY5JlYn
         GO027vlJ2p/OF99J42MLzJjegyOw51yxnm5hlK60NZ5/ROyoJ5shI23iM5QI3oxYzm34
         CBBlNQxGVu+vzj+oHHpemo68g65fIjyV/mfi0/tQVc/KAjN3yBeAWyl8fiQDFIa3iCz2
         pa23+/oy9mxsUk2UrKhJ9ewCwz64MuGmWxKkak6DdjoxWsa4POTORGJ6XQg/vSsx36L9
         AFtXhBkse29ziyqrk1Ps9KVBDP1EnJ4Aa59GG1T1l8C92qRNGfP9Qcl3DN89zpYm+F31
         BfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794490460; x=1795095260;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MS0b8nEt88g1wfp0LivrvP9tCkFoNKaIyooh0vFsgK4=;
        b=cCqTg8SSjJA/nwD07KrRWgbLcy+DApmWAx+mr+bwGidW+5K2CzcvtVrzwY4K00r/T2
         4hG9B1vpNlWG3ibnMLQ3/vz5Y3MICMGdcAxsso5gmz+Cvffq/TcAynNz4MWbg90YVcHK
         L92kxW0x1wuWPr5AdO6zE2+SzadGvhrYK/Fsi6IhwTyqnP2Bib2zde5ZqSxiydGxvgNw
         I8SPWuZhk4IpwvL2DwUpnyIgn98uF/P1M+ekN1lZv+JgnrtJXTq2i8FSQRG5KUMoce6N
         PMes42CxUFFtAwoczk9Rm13s61nsXNQbyGkwwBSW3xP0AUteFGT5krs3nE0mCdTzNtiq
         z94g==
X-Forwarded-Encrypted: i=1; AL+hErGVRJStMmmtURwtJ41gT6885G7a73bz0OgyZnICBHP4U6QImf/P+Cg2ip9dmgC09oizwRjAgpEXUYs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/L2B3YwocSo8A1JzdN3LGVr6pkEcXe35ianinbyQZVXj7wyzLF
	SMAFZDrb3c2f8XX3bJMInQDMfhA7Rf2eFgzOKIBytLpGSllRvZRL5QLobieVmGZuzIAIHJRt/nB
	hFrwGvoN5qglRxyH/BeBApoHhM2u0zgMiDCMnPnBjAPYHt6+E9gahMBIfauWRTlA=
X-Gm-Gg: AYBFou3OynBs4S+PUU9vC5Mul6sg80LCnoUfeNMWGkD1MdX5Nwe0XpbZJixK6XUwJd7
	xu5C2QNyfD2fMY7PGRnW/9G22fsg8kjErqsO0e8+74G6nln0QaTC4ErQG/qUd0FGe1FJYeaIDOZ
	pbO5pTBAC17d67ETCeACSO2N4UPuZ0JeR1ozquuDeu7eFCFF3ir6S+it7k/fyO+RYVFhT7lIGMJ
	AJDT+txRwR3DGeqJ6xBuwFOoPdmAYnnbXEY+5eV9eksLB6mdFkVBCPUzUC9BqAHeqAwMunvGZoM
	m62/LLimwFCXj9LDNSufHXPaVk3LFgjBG21kUgfE+PY2gYfFNlhSPc6iT0Yvh4D3vOEdLrFXM79
	qKhcVjSSF+lYHHO3jTDRdF0osYbTmEk++qr0/I+InzBxQ8JXCbux2UYUvP+QMso28lKN6EcH2zl
	/jnCEWm73na0TWjlwlxcE9s9MOz7Nh7GgIB89LqC2IysgxVaUVhcKeAZRDQHzuHmbRaJunsVnUQ
	BoL9fNRJi4iYbBrUu0xtRztEPEmzBQbsP2l68vuWeo6
X-Received: by 2002:a05:620a:a01b:b0:948:d833:1bee with SMTP id af79cd13be357-948d83321camr607632985a.3.1794490460268;
        Thu, 12 Nov 2026 05:34:20 -0800 (PST)
X-Received: by 2002:a05:620a:a01b:b0:948:d833:1bee with SMTP id af79cd13be357-948d83321camr607626985a.3.1794490459701;
        Thu, 12 Nov 2026 05:34:19 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a67ab93sm341707766b.77.2026.11.12.05.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 05:34:18 -0800 (PST)
Message-ID: <f55dddf1-d745-471a-8001-8f9e5768d97d@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 14:34:17 +0100
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
Subject: Re: [PATCH] ASoC: soc-core: start rtd->num_components at zero
To: Mark Brown <broonie@kernel.org>, Dennis Gilmore <dennis@ausil.us>,
        kees@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, gustavoars@kernel.org,
        linux-sound@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
        nuno.sa@analog.com, dlechner@baylibre.com, linux-spi@vger.kernel.org,
        miriam.rachel.korenblit@intel.com, linux-wireless@vger.kernel.org
References: <20261112025252.71375-1-dennis@ausil.us>
 <179448342405.66517.5463730214277229760.b4-review@b4>
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
Content-Language: en-US, nl
In-Reply-To: <179448342405.66517.5463730214277229760.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: yVaZsbOV2FWnOe2H7KVOFn7r3zyFlfAR
X-Proofpoint-GUID: yVaZsbOV2FWnOe2H7KVOFn7r3zyFlfAR
X-Authority-Analysis: v=2.4 cv=NJhAaE6g c=1 sm=1 tr=0 ts=6af5c05d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=dp6IbyjqBwS_WhlRAgoA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1MyBTYWx0ZWRfX3y99p8Lw3rDT
 H5rxiF+IaOi77/1eQKuiPCjq6MNrHjyBDd131wqjX3zNbyhCa+FgBnssBF8sCVPdBZIZkowonCL
 z8OyUv4QqIqxTeQowLbzxlJmQsImrRs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1MyBTYWx0ZWRfXxg54EmdBuY4n
 tYhOg9O+LPN5q/PCLRbUTPMLsySjxDSyO0xc4BFm08glvkLB4e2N6JCNsotkv4YNd2hSgyDdyiA
 dA98nYMwzBhJLFvVBzs7gIcy6w7WRF+qMjnqpHNqzWSxxqA/FKqK7M5Cw2JqTVIvdUuIsFeYmFE
 vb21Day3n14zB1+RySYNTaYr2hxx5U52XlZT1BXnybkJRfGUGFM2ujF/Q3v2+fKU/86TR8kvbFn
 HsNu9MQ3OVUzscq/3SrqULM/wgx7dA8MtMy/JX25SDYMoXIUC632hBzvmj8pNx1VP+NXxR2q2Xv
 SFGih1eCOjiyUWvEsRNnxTquwnSp7V6+fag4QCLJrU9Td5oacQ4jCB8GxB5RdyF7N+6gVxy3J6O
 9mthbUCxyMoF4xbHXodDnq+oaNXUCjWlhqQQYMzDXS/hrHZqu3eKzCIdlrgtcIuarjt6qhlAgFc
 w0izmzBcdMrTzJAIf7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 clxscore=1011
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120053

Hi Mark,

I was about to send a regression bug report for 7.4-rc2 but I first
checked the list to see if a fix was already available and I'm happy
to report that this fixes things for me:

Tested-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

On 12-Nov-26 12:37, Mark Brown wrote:
>> Since the conversion to devm_kzalloc_flex(), the allocator sets the
>> __counted_by() counter num_components to the allocated length
>> (num_cpus + num_codecs + num_platforms). This only happens when the
>> compiler supports __builtin_counted_by_ref() (GCC 16 here). With
>> older compilers the counter stays zero, as before.
> 
> This doesn't apply against current code, I think this is an issue that
> was already fixed.  Please check and resend if it's still needed.

This applies cleanly on 7.4-rc2 and fixes a regression breaking
audio on a lot of different devices there.

If some form of this is already in ASoC-next, then that needs to be
send to Linux as a fix ASAP.

Regards,

Hans

p.s.

@Kees, have you seen Dennis' remark about the same problem with
devm_kzalloc_flex() changing the semantics with the num-components
counter now no longer being initialized to zero in at least 2 other
places? :

"""
Kees, the same pattern (a *_flex() allocation followed by code that uses
the counter as a fill index starting from zero) looks to be present in
two places converted by 69050f8d6d07 ("treewide: Replace kmalloc with
kmalloc_obj for non-scalar types"). I have only read the code for these.
I have no hardware for either and have not reproduced them, so please
treat them as possible issues rather than confirmed bugs:

 - drivers/spi/spi-axi-spi-engine.c: spi_engine_optimize_message()
   allocates p with kzalloc_flex(*p, instructions, p_dry.length + 1),
   which presets p->length, and spi_engine_compile_message() then
   appends with p->length++ through spi_engine_program_add_cmd().

 - drivers/net/wireless/intel/iwlwifi/mld/d3.c:
   iwl_mld_process_netdetect_res() allocates netdetect_info with
   kzalloc_flex(..., matches, n_matches), presetting n_matches, and
   iwl_mld_set_netdetect_info() stores at matches[n_matches] and then
   increments it. The per-match kzalloc_flex(..., channels, n_channels)
   has the same issue with match->n_channels.
"""


