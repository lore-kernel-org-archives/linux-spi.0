Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D3529BDB1
	for <linux-spi@vger.kernel.org>; Thu,  7 May 2026 03:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778124492; cv=none; b=BP4AkwXPX2Rn10ZRMMfEWeGItEDB3lg/IJpfsCUQ6eeH2aMrB84Mi/jDnxtrygMgLUBLw7J2Q8O+veth6f/rvdBf/uPzl04vHLwSQnBYSN/Zx/VFOxVgwxtD5uQ8fUJjNzbAeDgpPk2uco/yMhFUyLpjN36fcBm/UPYGFgUs++E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778124492; c=relaxed/simple;
	bh=Xcj3OienWhKhCQV8lmue847Tozpcy05sx3/myZShVB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFbOoTkcjf/BQk4T3tVqp49SHGP5LMrDvikoBDrePP89/nWOB/XeHv1teHIjyIKi6FdqTlTV7ROFy1J7PtZYNM2NpYXWBAnhs8UtALuYr51XmBkfZFjcppOyDCXYoO9kI3wHP3W0AGvV+k078wcEeuXXv5nwrLhOhbHN0lwTXHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=itHj9n0C; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZwggcVmY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="itHj9n0C";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZwggcVmY"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6472Pv9S1987488
	for <linux-spi@vger.kernel.org>; Thu, 7 May 2026 03:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z+iK/VRqnXrENHqyoaUBW011Aa4rY5QCI7A6FztKWHU=; b=itHj9n0Cx1WI3fer
	0pz8ZDyx1jTqy5wiSbwB768nFhmGVjCrsJgcDcO9eelzqZ8uRrtD1vvyYBWlzmtT
	tcneewSnlJKk48pf2tZ0uP/dAp3IjszhqQL0Vmp7o2d3e1AJp4ItqM7DZGoDD/yk
	cb/bCahhLoGa3L21QkB3MdVypwH4cwTlp1p5oofB1o6FAvxBk0nI5YuJhfEKovwK
	qu7tO3ds64JaTGUFrJp+pzlZJKoc9y6DbiWz/Jx1zOqNIoeRV+bAJa6TRTrvPO/a
	rf5YOPLWGFa0Dbc858XcSRLCoHzH0+PoA5TdQ/erS4BhQunzJ/BvVs4XiK07b6LD
	gX95DA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e03gp3fgy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 07 May 2026 03:28:10 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2f485961555so1932194eec.1
        for <linux-spi@vger.kernel.org>; Wed, 06 May 2026 20:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778124489; x=1778729289; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z+iK/VRqnXrENHqyoaUBW011Aa4rY5QCI7A6FztKWHU=;
        b=ZwggcVmYDL9Gs34S014iAeDaWsbxU5rCq2WQTTsaiKuo+eHliaEslM4AyQDytDjI9A
         vWRGFXhAOfhZXb3IZzwLtCxMw62fpLx6UumKk+6V6C2hqVMGOMDGUFCEZH0yUhvplHMN
         olWPBfW6ShaRZ2uWoD6ti5wzk1v/iqIVKWY8IT/i/OYSB6c7cCOdPBELItbA8DIn0Tui
         WOgAaFxmW0HDUX9usrB4NtaYcqi0ZqaaHt5iQsxQDClp6jF9AFOXrdaNGPhoKV6jDR4I
         uS89pyf02iAr2cvbf0JetPLsgFo9ACW5qciVSlfqOsy2FVbK8gyIRiLbrbfe+LZ3erZU
         DmRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778124489; x=1778729289;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+iK/VRqnXrENHqyoaUBW011Aa4rY5QCI7A6FztKWHU=;
        b=DFmTz39CCz75j6OFdkdCmqaP/DymPqA47qglY3Wug3bRlpMZrYkX2OjjGL3lgY4yC2
         wkBe0Il9mwtW15ofa3h65P/2yOJ0prYloiVCAnfWdUj1FXCrs0UbsdfilZz6z6PJUBd+
         4SaOYmUOBCCT+WWLIusDpNwWoKY2D2dJAHfsxs6FJHfvP+L9TCZVO6jODahKJPwv0B8U
         eD9zqMCVM3O4x55QUgwk3/Sn3DkrrmmKLH055lQymBoHpnsBkqWFIIWUd1XD/nuizDuC
         4ATqFWCqYcEmxjZno3Kr8C9QZc6S6J7cWcfF1ORbBM8mUnlLsELd8lCGDGymXMdXNQ/M
         mQMA==
X-Forwarded-Encrypted: i=1; AFNElJ9qhorKC26L5oFWhnqwpWrAHJDSTBHaACXrY+JUY107tJHooP3xzorREoMkdqslsMzsIuziFQ0oa4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaCHvlepuvVLI3rUOvmrbREgjGKbtxXVDIipNbXOZw+3P07nC2
	28uYwTK1DF+v0Kn/qTbohXG7szsFxvOB3+Au+Wn02573yrKuNrR+jeR8nJM6t/AFbuj6PPHJb0d
	pjY023iV6qRwcAbBgcUsHrJZXi81Kk7XcGZL7hVglxz+RhZPxiRyCjWyGRdkGxrY=
X-Gm-Gg: AeBDieuDUaXR7N9shk7aOLR6K8vCr/m2GxYOlx4EKDr/ifzEj+fnzYoHD8rdbBoQXdg
	tzCdkydbE6Egiv+izgHfjyV0k3e6Gc/izABZGu6JcbT7UZbQwzWuu0e9e+NiVZNM8JQTxjsSpq8
	sFqBjF0JCY+dSLRMbZyPUsmqupXSvTryfAKZUB7SzIkO7/SjylH0NKuSH3PW38wmlZjkDdSRaJr
	Ow325L84/YcG0wXV7roOeZBW9vSsPTHgaI2cumOZflNJ/dvGF0Uf10seJHxBHTSpoUtuRLZD7Tv
	yHXjMc7vEeXyxI0t3HwZDGGoGkGcIDLJDQ4ME54PVimxLxYF3/MLGdzB5wbFCKDlTtX9si4gGFB
	+22DM1D27he3jRorscKXlmDDyd/F1YAWIcaq/PDvLkQVroHQUvoyVuxPaHG63uSM=
X-Received: by 2002:a05:7300:7255:b0:2d4:aa5a:391c with SMTP id 5a478bee46e88-2f54869a41bmr3245333eec.12.1778124489123;
        Wed, 06 May 2026 20:28:09 -0700 (PDT)
X-Received: by 2002:a05:7300:7255:b0:2d4:aa5a:391c with SMTP id 5a478bee46e88-2f54869a41bmr3245319eec.12.1778124488482;
        Wed, 06 May 2026 20:28:08 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56f88f89csm6086152eec.15.2026.05.06.20.28.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 20:28:08 -0700 (PDT)
Message-ID: <e4651363-7c1c-4ae0-a97b-b64841424c83@oss.qualcomm.com>
Date: Thu, 7 May 2026 08:58:02 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] spi: qcom-geni: trace: Add trace events for
 Qualcomm GENI SPI
To: Mark Brown <broonie@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        MukeshKumarSavaliyamukesh.savaliya@oss.qualcomm.com,
        AniketRandiveaniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260506-add-tracepoints-for-qcom-geni-spi-v1-0-c957cfe712d1@oss.qualcomm.com>
 <20260506-add-tracepoints-for-qcom-geni-spi-v1-1-c957cfe712d1@oss.qualcomm.com>
 <afvkiT50ZUEXZ-YO@sirena.co.uk>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <afvkiT50ZUEXZ-YO@sirena.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDAzMCBTYWx0ZWRfX2XdIgxiv+6xX
 x0mPgdLU2uVRZQ6KsXPlH72OLcshkQoq2Lr1XanjgYq4J7/ZWpNKUztuSqpdIEWbVCAyU5Tjvev
 qvWx+3/ktozHidpdH0EF7V0Lm5mnc6RwZmURL/ZW7mZUjP8aKRy4KRq/J9YKH1tqKPxmksfHxf8
 DvtHlKots1heb3d/ASgNmHnwH3dDCke8bBoN/hh6DCCVgZaJuXmGIoY9uMDj59g0zYd0domlDwS
 sSFyBHoyEwRbgtrHDYraUnX4VU8EVzgAyVJeCFuPgvjZAuFQbVdV4Pt4RpkxGJmimfRNLN6BMZt
 sVDVU5xwf/a8u5IwKT0bn+GilvL5txlAjDwQsGWH1a7Aw/LY1jyoPo+GvESAELu/sLwxQ0fc9w9
 vx09sDLgNl6w7/A5v7RBvDpeCVx6yceD4b+eXV3VQOPmyBsQPbZr77N9hRLbx4k7PmNbaSzUk2G
 EJLQlXfoKVcnxhYOFLA==
X-Proofpoint-ORIG-GUID: DY3uKvyIy1chZC2czHl3KRhqDLjfQuIa
X-Proofpoint-GUID: DY3uKvyIy1chZC2czHl3KRhqDLjfQuIa
X-Authority-Analysis: v=2.4 cv=W8wIkxWk c=1 sm=1 tr=0 ts=69fc06ca cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=RmYZSZXQ8PJLqAOd_dgA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070030

Hi Mark,

On 07-05-2026 06:32, Mark Brown wrote:
> On Wed, May 06, 2026 at 10:59:42PM +0530, Praveen Talari wrote:
>> Add tracepoint support to the Qualcomm GENI SPI driver to provide
>> runtime visibility into driver behavior without requiring invasive debug
>> patches.
>> +TRACE_EVENT(geni_spi_tx_data,
>> +TRACE_EVENT(geni_spi_rx_data,
> At least these feel like they really should be generic events, there
> hopefully isn't anything driver specific about them.

Initially implemented as a generic event; however, splitting into 
separate TX and RX events may be more appropriate.

Which approach would you prefer?


Thanks,

Praveen Talari

