Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7866848BD56
	for <linux-spi@vger.kernel.org>; Thu,  6 Aug 2026 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786040275; cv=none; b=bir51gnc3XtgTbwh1CYzkknVWELk2RrqYMUoduDBUoS/N2QZTSBjg0ODrwysQdzsNDRYcS0plhF0m35Lxz3wjt/pO5JaR82PCVEmwKhb6q8ASPeW3y0idjtTdh9VW+jAbnrNfZIyFRcd3cFzjI1/pbipIYttiq26kStK4kcbJvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786040275; c=relaxed/simple;
	bh=XyHQVGmrLWTjFYPZtM3QIQVJy0S1AV8IITairKJRPd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s1NCijewtrP6h1WvpuXSRAXqE3WY912R1FlFb198PTUCMHogKJTiqo/wCeBVAlBXvSK6QA9c8vHtofQ6iGyWraPY/AN75WdAWN7e2+zxTM+M4SVzinhq52o56o5D+/CzsWn+uQq+m0arWzQU7p2sx0nzd0v5rZQx2FZD548iHGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B4Vs6gmy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QoM9nHg3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B4Vs6gmy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QoM9nHg3"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676IHdtd3908905
	for <linux-spi@vger.kernel.org>; Thu, 6 Aug 2026 18:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XyHQVGmrLWTjFYPZtM3QIQVJy0S1AV8IITairKJRPd0=; b=B4Vs6gmyszXWhDyo
	42wZtGktWpa2GNtixSrBQ6U/kDgiSeJr+3rFL+Fnp0MuJwVlyKBT7or9uJCEzUjQ
	SU71wM6xJVuWAsix0eRA+7cGvVYY/KNkKnLi2zaVpWAAuRn6bsKTR5y920Dw2JUr
	b9bOi1M3kxvuYnB5MjmcOobDtThtNHbMHZ4ei4y69GKjW+wjeg2kgjMw6JWRfLb6
	L0MqPdlVv/7gzmNjtUbA2ONSRyrmrqQWlWjO2NZt3gxd1Tb/Zq0fFvmySa/zcDgK
	SHPzXAc9N6PdylVPyei/TjyMTH3fbLXimsbGI9mIZCVhBFpX6aRKPiEM52tLnfYk
	+Hhm+A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6r82sc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 06 Aug 2026 18:17:53 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e22137fb3so3385673a91.0
        for <linux-spi@vger.kernel.org>; Thu, 06 Aug 2026 11:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786040273; x=1786645073; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XyHQVGmrLWTjFYPZtM3QIQVJy0S1AV8IITairKJRPd0=;
        b=QoM9nHg31lkAVcXMErr54Ys8CmPNI9JnpzscoKMtNDznefYR+5RzKMfAF9nPj7kyP2
         XpSIeQHySri3QUgf+fZfpUGeM5fkWpg28Bxz0XNFmEm265XC+HL5uKzzJggEKxDwto6k
         0aH8Th+4M7UdkUG3x4TBLw8ITSSHXPirnKxu297AEwKbe0+Hmni85k7bR1xFDMUDCtqY
         v0z8FOqZGTYPo1fa+SCrPa41ZX0okX/qzrMl3JyHw3nkNrVhIh6fpb+DEgF8VlDwM3q0
         eWP0g2YVFVv5Bi/DXW/DUWbu+CR7C+pm8tG3boGQXkTGV/KGb5K8gCYKB61x+IqHFksE
         knWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786040273; x=1786645073;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XyHQVGmrLWTjFYPZtM3QIQVJy0S1AV8IITairKJRPd0=;
        b=Gox2ym8fFEUWx1QCv19/7CUA6o0MdgzECtjKxDjLW7OwbBhILStzZp1H9l62UNvyDy
         Ia8VhsiRzpGYICjBYLiqnV90yy/X1i09CPUos+xpvvthpKeYZhrKBIvGNoHicAQ8vWbr
         FD4ZVsKTXuk0016s35S9DnNNUYU+61CSVN7MYknM5lXPikLbrXPJmLcGodpjV4xKBDqH
         +nIcsRQaQYU5ELVhmNHBkrlHi/lZaXuCx5HlMJ3uFnpY0LB/SxCFPyn/4agzlwWKkKzh
         Spul7IHgF9SdPbr13zPkdvo9QLyafy79ltn4mnq+mEi+INuD1YjcVC59AmbbIWyXzCdr
         C6Yg==
X-Forwarded-Encrypted: i=1; AHgh+RrZqJIT6AhytxPUh68IP6DsFDviBQ8oSD9qp52je7eBcw3VOGqYp9gXoWlQRSfGv2wPbDBgT88s7DY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEzWSGi+jjhZT1viP4c4bqMiyaeYiWMH+XQFodeCx+1zqPX3h3
	GXljIlvaUp9s0yWAZLkE0papUfiKKqkvA7K7AcGT+iYxvC9/yPxVWxkoZBDdSt9XUHoEK9Eo2SO
	6SN9cSU6rYvNAY4fWX5AZM8aK6DnkpbLJaBaJGGALv6C5HOQpXhr8rcHc9vemjvE=
X-Gm-Gg: AR+sD12oerRuRbsJu27uza0n+HyxuqIYl4wl8XDMk+gSDpw4onj+VN3a6kIFbSCfhsx
	m8AHF0urUPTG9Bpcttc9L9NCR0jrmOraj/+heP93hVHNt2VpRI61TT6Ds2AI5E2+17lK56V+I8H
	mIuAMvnq0aQeXdZlQcFy4kRb3pcZKxVSzBQTg4erFA+o3wn22o3+R+Gs32tbF05zTbnvvic5+PC
	/z0fVRFEKpL3OG3r1V6RVFVfGpGPBuXL1Z4sQU3FFBaxoTmGR76ubkwQGSSWWv+9iqJn9rXbtGj
	qbGX9R1UxYmbjQzyRk6eQ3Bmi+gSx2FQPK07uEtuXLJVQA00irAlW1A5E+2IS2cvyrnbSubNWH8
	3TFpKz6BdX6Rj3wZ07mSuDMbnEL2vPSFL
X-Received: by 2002:a17:90b:3a8d:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-3903c5b9f70mr14946531a91.13.1786040272895;
        Thu, 06 Aug 2026 11:17:52 -0700 (PDT)
X-Received: by 2002:a17:90b:3a8d:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-3903c5b9f70mr14946468a91.13.1786040272307;
        Thu, 06 Aug 2026 11:17:52 -0700 (PDT)
Received: from [192.168.0.7] ([49.204.111.196])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141009ab943sm368899c88.7.2026.08.06.11.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 11:17:51 -0700 (PDT)
Message-ID: <3594bbdd-e457-4a88-9e37-7acf0f3d87d2@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 23:47:46 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: spi: qcom-geni: Document device-gpios
 property
To: Mark Brown <broonie@kernel.org>
Cc: konrad.dybcio@oss.qualcomm.com, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        chandana.chiluveru@oss.qualcomm.com,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260806-use_gpio_to_notify_master_of_spi_target_activity-v1-0-c363a9b5df69@oss.qualcomm.com>
 <20260806-use_gpio_to_notify_master_of_spi_target_activity-v1-1-c363a9b5df69@oss.qualcomm.com>
 <57719877-b8d8-4df0-acce-2c4faf5a5899@sirena.org.uk>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <57719877-b8d8-4df0-acce-2c4faf5a5899@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE0MiBTYWx0ZWRfXzT5UB8xCJrQV
 c+vhNGj+RiTGuNdUCzYHus5K4R0jD4VXCxdluVC/9yfoMtLUY+QbL7HQd3YDumB3ZtdMIiy6xHd
 NeKL3U+27/uXEU4N+20+8yykYV1BcRVhdhYjkjlLGmVlajGi5jL/ukfYYPg6QOHFyJP1Dc6vp/1
 hXo7wnTx3IoXVvRQgmzVvzwsSdx0jfiPpUHo1i9d/qMlXvPHGlKQnZfXZ+hEHa7oZDhXLAVaAJ3
 8pcCrLRWt516DG8aON+L84DL780y23m941ZCQC1Kq8TwVrjEmWZzWFBCJcPHW/dCBdPAULprTeW
 HNncaoZAM9pIuAgRFEqZ2nUMPfQ389oPJEtEtPc52QKmoXbEG+DaXdlrX/wMvboLzMym9WfGrXG
 Iec5Vpo4eLivdRcFDGlEtLbB17I4MxFWJ6U71NAAziMYVnvWBWH1aw68VqbZVaRYoitsBWnhUbP
 U+W8fLTLSxjneqHciDA==
X-Authority-Analysis: v=2.4 cv=HPXz0Itv c=1 sm=1 tr=0 ts=6a74cfd1 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=7DW+zsgf7PPjz/i6iZMG3g==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pBl_9jDRoQriJyM8ii4A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: Qkd0QxR_qbJEcMehWi7G7BJmMrtn-iC3
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE0MiBTYWx0ZWRfX1ht5xavScUqI
 Bt3FjbarKPm6wJ+nc1HHzPJIzN5qioqG+RBr7ZI117xYt77OxTXhelrIKuiicfaxFoFnItGBs0M
 JO+8I0qolEvzcVtLtEJQTys8ZmwRJg4=
X-Proofpoint-GUID: Qkd0QxR_qbJEcMehWi7G7BJmMrtn-iC3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060142

Hi Mark,

On 06-08-2026 23:05, Mark Brown wrote:
> On Thu, Aug 06, 2026 at 03:43:44PM +0530, Praveen Talari wrote:
>> When operating in SPI target (slave) mode, the GENI SPI controller can
>> use an external GPIO to notify the SPI master about the target's
>> active state.
>> Document the optional device-gpios property for the qcom,spi-geni-qcom
>> and qcom,sa8255p-geni-spi bindings, restricted to spi-slave nodes.
> This seems a lot like the ready-gpios property we have for some other
> drivers?
Yes, you're right. The intention was the same when I added this property.

Would you prefer that I use the ready-gpios property instead?

