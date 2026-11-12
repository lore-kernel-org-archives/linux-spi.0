Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490355;
	b=eMkpXJEwGxaV6M+Gw1sUk6ijpu9RcNMPByf1Og0OviAUx0Tra84K0s4W1w1thaZXrRZh
	 rlLbPXCDqiz6OoEEqmHtHjOQTR9hm7gqHAOlDT24+MJuR58m48ToEilEjYy2Y4DXEfntx
	 9WCGI/LBdR8XOts3Uv7x4wV+hscXM16eWwVtXUe2enNuMeWi5vM3y9wlATzILUNvZMXuf
	 +SbrNHZ5MXEDAGlL61tJEbKya68DIOf6O2i9qQSfxKfxdT8Cipr1/0EM9f66DxKCJeKjy
	 mn1PsHKWRHodRpmqAqjmIGvoecsMUmtJNZ2GBbduKjBrh7slhXOU3W3iunIOWModwIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490355;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=L9yXVJlvnIi0O3A1aADezHuY7eDDpasAZKPrrDv5azE=;
	b=D7NG5onUQIvkWierhr3bXkB8hKynII6qaycVqnfQU9sg7dFojSI3XMBU4q0g3Xq7/1KJ
	 RQyPsIeHi3A4fL/wolYx7NQFf10YpUPofCSa01TEGqbJC4AmXrqR5o6wOQJvsRRol3N+t
	 YAXSNyFTedOQFMW4qyxnjdKygOA0yzjtzYAXiHYJfsE2xY05kE3L6TjZHfIZe3vgeUbTT
	 unQCOt5NeZFkKYbTBCjzNs6mGVKpHATArEuI5aImtdNnZhrHXHdd9GdHE+Jw12/BH4u1b
	 gW0KLIH/zr4o62fnRgYMFmmPHvMUDZ8QanLVyAWpZ0K0yHO88w552E8ko+L5CQZbK6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H6RvHYjN;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L5X6P+jh;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173F4606A330
	for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 13:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 173F4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H6RvHYjN;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L5X6P+jh
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACBHQgq3893759
	for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 13:32:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	L9yXVJlvnIi0O3A1aADezHuY7eDDpasAZKPrrDv5azE=; b=H6RvHYjNNjqOJOAi
	M4V6IlTSok0SApN/vq7rMc9JX615Ss4MbGhL5Hwrp8L9+CmiyJWMimzuAQ9ZLNhf
	mugRDTOTe6gQZTn34iVxh3Cg2g1BkNo790ZpN8ePlPZzUOq1IfmTIGV2POF/5dUX
	R+Ki7rRFpIFo4eCWbyPK7hpBp/Nh5hv5xLUKIC4aDpYXrimZo3rIroK8ByHilqS+
	UXNN+kR9MBE5rRIAkSIPNWzIbtvc4krm/uuFJk8OUb1/rAeMgcGiZwXL3n6GEOnj
	IuHVqT3BSaawMNEPcJB/6foUELfmvcGOwNq+BMCrfKQ39KWT8lyBZ52iYu+EhfpA
	/EMonA==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hw6re1s7p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 13:32:33 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5ecc172164aso3167226e0c.1
        for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 05:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794490353; x=1795095153; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L9yXVJlvnIi0O3A1aADezHuY7eDDpasAZKPrrDv5azE=;
        b=L5X6P+jhJ1RKuVyG85YpHcptVAQtIU0esAwNJmsdXPUKFNdSedOw4BaIrpEkhkCLR4
         0MggITV2x3OWGouZnvMnOMQBMPwLja2jq1DSVGAAtvNs/X6UGWFLR5t/Zcjf6choEzPO
         T5hTQwRsn8azfeqqedN7IrfXKZUJpxPFxqJHmJ3ro1uUPZrciu7gyVdGkFMNUBg7CijU
         eArnNw3+UhzY63rFtXn2/gkiZaQMfwvrjA5YZkUMrpVwpwpgG9IgXMG8kO1Hbj5E9V0h
         J1nALUKDozoylV1HY1Ru34bxX34I+lr2pOuSq4mRyv/sAuTwA6NFcuAEkCsnPysK7bGm
         0Nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794490353; x=1795095153;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L9yXVJlvnIi0O3A1aADezHuY7eDDpasAZKPrrDv5azE=;
        b=UMGFNMB/PHDQL4fpJbPUjcFPLQvSD4a7rhz6XRhXxYocmHpmLlP4hpmRP7ewKp6pzd
         MCdcMwzBlPvREHsIz/QIQCX12FdMqBgP7tyiTATxMItiM2Md7CRPIHDBKgs1SrrBR0Fg
         vd0ICLhS8XsbI7yxXFUJ+9q2s3DuDlxMybZdgQIvKZlrtUzTK090xFVxnVwiMa4XO0Ir
         bRNs8J+RTExoj8QgMZrecgktGZw0qk4ZQoA3kdxCwxEG0bFAF9R5l1Ei+AAD8xBmz9o6
         bRxcIbmhT5HVe4+93zFZZYEEtI8KfZO/avYLdhyGLLyebJUTAFY6C+9eyy3P6ZAIDDYT
         RGAw==
X-Forwarded-Encrypted: i=1; AL+hErEQHxrbnUkxxOMi2UeVi5JrWDhRc+caU4a6Vwvsl8JbK+x7Wwp0GeodVZclDfvPlSbFq981CK1Ql74=@vger.kernel.org
X-Gm-Message-State: APuU4Z8JTtE5mYps5lubtfVJTHe1RjNW2TrqVHYiomk05OrE9G0YJDhZ
	NVijxCN03jUFkEefswMU7ZaXeIXYd3Kg8+3lIRIHH+ITpx/WwDu4njUDZAjiP5g14eaaOgaJ6Fb
	k8ZctBUUZ6U9DpSibARSVdW5ofRJ26nLPo4GsaxQB21StSjVn/9wclxlXqtTd+1g=
X-Gm-Gg: AYBFou0ZFvqCZbjnqsS+LrM7iIsS4sMB//xN7Zj1+84YFd7J6APlIlzXhRQt1wTv6GZ
	2pYbNb7ZlRcXN68IYQhpdPpdBtOhxFF4uO/+1wv9oQ+UJ3jxG/bT9XvjnuAM1FzLZQN8vOJfFCa
	z01QVq8lkP/5cec5mj87nFVgtG23rZL5B1Bx94yGbGeLXT1ageKMM0HuINjwYmguc4vGi55hgKR
	B+9rPTxmYzs+sZby4X4J36qjM8IsqeO6i1BWJgpvhGJEVCqZS7Ig8csdUQtGs3dx2tSKzTJFNFn
	AQ92wVxxLJJt6BC0NRrLrnkPeoldBcSIvKyOu1wsvtA0hZfX3xcp7h9/OXQG6+1jZ0kuuhyFkJo
	7uC6QBzsxqzJhjDN10JOOrKkF+WodnCahfsP9j7RtVeoShxsi57LGkayRWgeekWtQ8C+ZV/x9N0
	xNzSaYGeXIcZojIICjp8K2tw776ifWTDw5OK2fPzF+O4H2rDC3nmBZQ4okvgfpmQjuaKqntkppg
	9OrO/JA/pmYxu/efi76joY68fr0dWUcMe8LRPQZ2MGL
X-Received: by 2002:a05:6122:e153:b0:5ec:5f1b:f725 with SMTP id 71dfb90a1353d-5ee1c4862d1mr2361232e0c.23.1794490352695;
        Thu, 12 Nov 2026 05:32:32 -0800 (PST)
X-Received: by 2002:a05:6122:e153:b0:5ec:5f1b:f725 with SMTP id 71dfb90a1353d-5ee1c4862d1mr2361193e0c.23.1794490352219;
        Thu, 12 Nov 2026 05:32:32 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c504a6a4195sm339950666b.86.2026.11.12.05.32.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 05:32:31 -0800 (PST)
Message-ID: <6876daaa-1e9e-4f69-855f-53dfb2b8a7ee@oss.qualcomm.com>
Date: Thu, 12 Nov 2026 14:32:30 +0100
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
X-Proofpoint-ORIG-GUID: jPiSA4_Xzr0wP3y9xwNW6c560Mq509IA
X-Proofpoint-GUID: jPiSA4_Xzr0wP3y9xwNW6c560Mq509IA
X-Authority-Analysis: v=2.4 cv=NJhAaE6g c=1 sm=1 tr=0 ts=6af5bff1 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=_62txuixjVeDG2zLGvAA:9 a=QEXdDO2ut3YA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1MyBTYWx0ZWRfX+y063hRVchxG
 hBER56S5SAJnaOhGqMPL6b7bRzkhdrqNmCBjK2UdvGvjaXYopLzfsovmDYCrqwrbIpxACzi/W8T
 m8njuhvt+3GV5GA5H0Zgnh8OCr+4xxg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1MyBTYWx0ZWRfX7mEwAT4LARwQ
 1B99GN8F+CPEWtBO/B7IBDt584d0ArYtlfDa+pFtoCYoOfK0zKj70QDkATVHkG/YPnr98YrRTUo
 ZO1dVtup62GkWi4dG3+EHguF0bTthm7QqsW1Ds01HP+abDDgvpFsMqMrPS+lAuQZ9pDoMu8KEOB
 n3XLUwEiiqWNwLIRiX9daO3FHF9woEq6kckyzMz3CIFYWIerKu4PC1Q3oEcx7U72LMP4B0Mfg43
 N7I1fhzURDRexQzZevV45SSDWdtbqxo9OUj4AAynPtGNZ1cHqhDQkUyKAM2tpkoN4U6Et59PAkG
 sctx9O5f6s91ZaraSX392nLqn+VNwu1pPRkygISrYkSE6D21hjdm1F8TwBy+Yy6XeAwOh+g+OX5
 8grS6jJWPXAWaNScCobYCdl10uk8mNbvOaQlnGB7JBzIpaQ37cA27R55H9Ftraz4GUfd1WPo4Da
 XKygEiD2+tfQvLYvaqQ==
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

Also the patch looks good to me:

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



@Kees, have you seen Dennis' remark about the

