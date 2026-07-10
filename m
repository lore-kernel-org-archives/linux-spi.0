Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA903F6C39
	for <linux-spi@vger.kernel.org>; Fri, 10 Jul 2026 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783676629; cv=none; b=rNwuGfgwCkbCGmjN/fwnTHzy16u/JPD7Bj2aVhWuPCp4ugODOK7dNzDVxZT/lUoDHABeA5dTfc8+jyOffrmSdQK0b2qOy6HxuX09N9HkGgIMuW7D9Boko0h0GJHxpPbYSSEvf34/s/ilPF8xqSXiPu/aD4Fjfl0IIskm9Tbo7RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783676629; c=relaxed/simple;
	bh=DNEj/bYxVRNoGmGDSfuPj+SgpTbOc/y+W9R3xVCwfPI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iysz4kvRCDuMlioouQqbro8zMhE0M4m61i2khOU67TlbstGM0xuO3w4iTGRnKz7Mp1J/JH3yux2k8tBBv7ky4IDidIdNzrncggFOq3O1U881cwctZVbwSK8wMQ0jdJULwYDuQVF6Gp57z7TbK8iEaGZX63X7Ueu4+KVdbIIHvMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FKv35ZI+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WCgwOpMD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FKv35ZI+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WCgwOpMD"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7dm7M4156841
	for <linux-spi@vger.kernel.org>; Fri, 10 Jul 2026 09:43:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YDRs4cZXDmmoZvoqPlGbupiGeT5hQWumLyoKKSvxvvo=; b=FKv35ZI+yER7mhFf
	0G9MVvzDZC3HF3DlWssBkB1aS+VdD1ZOnb13dmcTnUCOEVnWi4B/KiiwQ8sZdHbo
	N0adpdcoNVv4g61+jtfpLXwAF5kGIRhe0fdlF9o8K+AIvutsjxcBBxdapKIvsqBC
	qVijZ+/VN7w9d9ho6yygWyNzoE8t3WSJg0gxw40+ccBvwyOb9CMqO8u3Ot8forAz
	e/zDRyx5Msp11zlzOeGOSkhRKgQDgkV7XA5+bQ53raqJbOXxLyiD520dH1yVNFRM
	rCf2l8Rl4gesAhiqU3H3aUKEuNth8jFi3T8kG1QLe45n1ZPVBzJVivHUXx6RmJLC
	FtRhNg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fahv8jpc3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 10 Jul 2026 09:43:44 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dad28e86eso727308a91.0
        for <linux-spi@vger.kernel.org>; Fri, 10 Jul 2026 02:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783676624; x=1784281424; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YDRs4cZXDmmoZvoqPlGbupiGeT5hQWumLyoKKSvxvvo=;
        b=WCgwOpMDZV9Wve0IGQ3qvbB8Qe2hrifXa7MVie+v+T74L3KPNxiV5kZDzV2mymOZPv
         3l4R7lH3n6S32saoHI8eGn+gbIjSVEaeNb5mLBr32Phf6CvwicbRlZna/5OP4dmAHFAB
         qHIZfXckBMvaxJf+qdKVUW5fKEUZh8hmfMUhwMfKyqDkUA4Mx7l3ycKvfQ5JGio0H3JY
         DitoJT8JXeVLdst2IZ0xGQWfNVLwCg0swVPYrDU7j0IHifDKIgHzKqftNlvV+gYPCZSF
         rU0z00V5I1XfHoztnxwCCwutDTkG7YuoW6jyRO3zHv6BCyf5RPHaifTRUptOFZeHqDHJ
         1hwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783676624; x=1784281424;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YDRs4cZXDmmoZvoqPlGbupiGeT5hQWumLyoKKSvxvvo=;
        b=LV85B2XHFjFa2xFMQcVQ0JW5Ht2E22KnYAjkORt5netRnE0lRL0fN2qvzgfp//vgNY
         9GM78G/wmmVJmDgugofUZteleXMIs8Xppb3RV5Ong80nV+aTPz26m8bV93tQRzvvG3Sm
         zon6qmAOVSYqD9VtRG11zB7xgcWm9R7k6kcZKHy5/kyQfMTaaHjZIvZE4VL4aGOrnDcw
         Sk0VcLoQV9A3+VK0DuCxb5egL/rsyNW9v20LDGxalPD5eV/8iS1hOUsb5gUKiq3uG10s
         nNGNE1SLC/W8k0iGeEsmlP4HseV+ozORlUW0u0ceKzSViVXYK3iIUbFc4jnBEZozNoJE
         QSTA==
X-Forwarded-Encrypted: i=1; AHgh+Ro9HYPlmf4TOaoEvjT3MPbosZy45TwmQJE7DV2AhRd7+blrNr9EQ+zr2vc0FVqv8UfE6tGPwbPBKzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN2aesjBTX9akP6BcwUCMW1Q6gnSrb4x0htavfyMSzHjXyRFOT
	0/obY3ojO1lB5BbOSc5CvhMdwSAnaJflxfAcU+2gvxQLLAuISJKtKJlyWW3iZH2DNSc5L4wUJ5g
	M3fYGloS79tcpXzbH/F6GGkAup12+bMW2y67cFnlSBCLEMWCDjtsr6iFYU2sKaDI=
X-Gm-Gg: AfdE7clguUOWY5liyzs6QXgKlmR81oMf3/VD0kozzOxsf0/fh2kS9Jb8vSBN4HON1XD
	PqvOZzPZxi95o/X/LbL4woF+VbEA+c/FIWywn3W5d4LxFEgQ6/CVoD2rhxq+U9UYYUxE0WkrPAQ
	5mMklztoH9hdHSB8FGSB/IIXN+sArp8BWZhH7f6wbEAS8ACFTnG8AiikbN6ND6iVxBgEV4r74zE
	KH5I7job1zOAfKFdylB6YxklqmhTsDoHYZYp8XEJ/mPGN++V3EMt/g//hOUjFy/f/oPR1qortUF
	rDiJ5kmVMgDo+/n4iKK6bXN/eI2xULbi3wuCCdcxWrWrzu9BpA9MVew3z2khfGE3rBLZqlr6Nye
	gjbrO2hQz5y+eDG4uZoINA0gO5ZoXWrvaZoSTVQa6n6E=
X-Received: by 2002:a17:90b:580b:b0:387:e0db:3faa with SMTP id 98e67ed59e1d1-3894239bee8mr10959536a91.35.1783676624202;
        Fri, 10 Jul 2026 02:43:44 -0700 (PDT)
X-Received: by 2002:a17:90b:580b:b0:387:e0db:3faa with SMTP id 98e67ed59e1d1-3894239bee8mr10959500a91.35.1783676623644;
        Fri, 10 Jul 2026 02:43:43 -0700 (PDT)
Received: from [10.92.212.146] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-313b0240570sm5176800eec.28.2026.07.10.02.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2026 02:43:43 -0700 (PDT)
Message-ID: <a9f320e0-6a72-4e93-a57f-675fbf5d51d3@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 15:13:33 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] spi: qcom-geni: Fix missing error check on
 pm_runtime_get_sync()
To: Mark Brown <broonie@kernel.org>
Cc: Dilip Kota <dkota@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>, bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Douglas Anderson
 <dianders@chromium.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev
References: <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-0-92feb5a7b926@oss.qualcomm.com>
 <20260706-fix_sticky_-einval_after_pm_runtime_api_failure-v3-2-92feb5a7b926@oss.qualcomm.com>
 <2fe34b3c-11cf-417e-9440-75a5d6e3f4d7@sirena.org.uk>
 <0e52adba-dff2-4cc3-a13b-758c8d92e60e@oss.qualcomm.com>
 <5a1dd2b7-6e26-4806-ba71-175b195137d6@sirena.org.uk>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <5a1dd2b7-6e26-4806-ba71-175b195137d6@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: fduqRx0aqWnIRVcZw082319HQs7BOf_p
X-Proofpoint-ORIG-GUID: fduqRx0aqWnIRVcZw082319HQs7BOf_p
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5NSBTYWx0ZWRfX/CRSZbDsvKj0
 0U0CYuZYEFtkHlHDnciceADoP2os3lK9u6YzBMs/TjDlxWfIowXlC4bpsJydT3//9i/UWxL7ycg
 diwUjWrsMxE3ElgPOfOIZo1jBhcPG+8=
X-Authority-Analysis: v=2.4 cv=funsol4f c=1 sm=1 tr=0 ts=6a50bed0 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=h6hYde8dkmUs3SIWvWcA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5NSBTYWx0ZWRfX0sh5CsGPogQs
 3ej+Sop/qY9DJk/K3kcfmR9H6pbvmuesmmiUZ6pRnTYuOZRpUfudNtiucoaebAmFWTmqdhSgI9L
 Ee8dLPYvaCZU+q68BFUne0azafmFI7jqgrhz2runZQhfy0fRg9pNt8/LZssYpe3k08CJmDPWTHq
 UTxxKLpKZGW4QBBSfxO0MJVVnGBWINTxpKpBa3MzFNwe/SaC0WZ6qzEUF2PUJZxGp2J5b1/CumV
 eIlx8N9FWnkBnHlBpZpc0W9+r7Lha0VM7MNLAa4Ds5pzsx3P/lZVAJUn7y7jCT8om81TdP6Yow8
 4YZD5rKABzQTnlwrXF5hRjrIgBo3UtUJLgxSLg3eBtWHG0eQX4cnxng8c/LPnKCU+k+9x5Z8VwM
 boctxXFBzkbUn43tGUGK7onAgOIqS2etvh2j+G9gVmwoZsNy9fFB1Y0SHkwBMeVNJcc12yRBfwM
 72cMQpzwsLrzoaqBN+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100095

Hi Mark,

On 10-07-2026 14:53, Mark Brown wrote:
> On Fri, Jul 10, 2026 at 09:41:26AM +0530, Praveen Talari wrote:
>> On 09-07-2026 23:59, Mark Brown wrote:
>>>>    static unsigned int geni_byte_per_fifo_word(struct spi_geni_master *mas)
>>> The above breaks the build due to removing the closing brace for the
>>> function:
>> Its my bad. It appears this was inadvertently removed in v3, although there
>> were no issues up to v2.
>> Please let me know if you can add it while picking up this change, or if you
>> would prefer that I send a v4 with the update included.
> Please send a version that builds.

Sure, will send latest version.

Thanks,

Praveen Talari

