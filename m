Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F3D37F8A1
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776678694; cv=none; b=M9e9SvWJq8zVuaYMqFEEfLw4N9UKJN6rZZ1FnuYd89yD//mpDcOLIh8Yddks3Uu9m4ccQMcQsLbI0HfHUdNd42VL8FkTdZX/fGURBKSLVkQkDPbu+b74/yNPahhQcAJ3tGQUqFCMjkhzWeeHtMUtrTRS2lpj2+mjT81KWgfDYwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776678694; c=relaxed/simple;
	bh=M3JrCCNYq/LsQQXow9xyNwFjb3Bny+ZEYI9GFCKwa4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7TpBkjjlECwhMmDbi+dMMnEPxebN8fd7yvk90+/OWaqmO9BbTklLkOBKec8f7EtnqUmJ9fK0dFo0nJUKRXOr+C9N+LXUCOVF9VFY2Bvuyd6oyIMKQjSGzIhuW6PJWregbNCAZTmqcg3sWJVc2TRHPzAbN3BMu6zAtWbbeo5oWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TyCV0cQ0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OvZNrNhl; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TyCV0cQ0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OvZNrNhl"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K97Btx2755689
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 09:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2oCc4X5gfbIoFNXE8Bk9ftZY5NhIpmxBruq4adzXl6o=; b=TyCV0cQ0p7JR9Jdm
	lRMzYXbDDJRO8q51VJtAauzJd32hveMutEZSNQBJtXkYljOVEsJy9RwVV3t8S7+0
	awB9nXONzDtSc6PlfRFj/6VP+DbtsCwJKyh5a1+2vuN/xe1kCpH5cuO2gI786nuV
	+8DqG2AXJxRSKch7f4fKIZBTYZvsj6asRKzAy6ngQkZo/Y5MKfIDZ+HQWfVXoQCA
	HXXlO/IP/RPQsV66fZs5RSLvbbNhLFZkr/IXIUZoWoRV6ipOLTSvItTRKhyBxVIp
	/fDAgTroik9LQ/szwnVsmpyHpKa3kP/rdjkVlLrIb3YW5W9IzJ3T3yGc9P9UCWmz
	+hK3fg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnh7xg5qf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 09:51:31 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d8c183c2eso28464951cf.0
        for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 02:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776678690; x=1777283490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2oCc4X5gfbIoFNXE8Bk9ftZY5NhIpmxBruq4adzXl6o=;
        b=OvZNrNhlcTQuQaAylnU5He2AR7qa/dEMGWOe3xpm2TjBbXh/UpJtmN3cqV+0fglIbi
         OPxOvNh2o6I85IExRngrejdzAXXKyON++LjkXk/UduV9Hq/1bOUNvxU8OmcFWdGkv6zz
         GFc0bwKfUgCV/XQz6DokYW+LS6PBGaKtZtaJv8DtMiU2OrRjlrekHFPY1jvilj+GH2AW
         dPl3vgU+lyuQtCPNFHoHS4kpRePqJ5XoNLDRx4bVzPf1r6WtdSUEab+EE7CCMdbLt366
         IWPk605/brIH3XMRgzOgSkxf4+oNTpNRddUP45fXbCZC+t9immqhU4ise14Pv9wmWBVs
         Q5bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776678690; x=1777283490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2oCc4X5gfbIoFNXE8Bk9ftZY5NhIpmxBruq4adzXl6o=;
        b=mWCk4B4k2e2TkM5vJgu75jQUAKPIrF97kbBeqZ7n3+8B/WYzFdPgJd2HQsRdtlGBXV
         OvFwlSghVLKvO36G2XyHTzr4A3TAtK5kXaq0jeoYsW7Ah9YbJoOPeFzIhO4TxWQG/AJB
         HUEmCFhYEJ4NzUEivveoPr5CJF6PZ52Q2WxvxG8KxFVnzsHTu834Q0E+lyzHhdkjF/Ke
         2FaGbAIqZ4Z43v3h3nMsXIxy33WyXGOs1mMtuvdgSAoFBHcDk6gLgPL5rrOJT5ghOTp4
         lZ6HyKSMKr89PiIwnZat9CjDqFyfBTduY/O8su2H9OH2TLMUXOKl2NmBfdNP9Gb4Q0Jg
         w0yA==
X-Forwarded-Encrypted: i=1; AFNElJ+9OZVvcj6OEi416UsFbJDln/Cgk+yKcE+PTF6bMBDZqR3HB/SVsHHx2VKEtiFkZg/tKwSqEvTps5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY/0JV6czcH03y5mw+Ix7p+MvFJrNSAe5bArBeieY8PguOhJQa
	36dBwLpcc6bzuv+oMzIhOYJEV8YCkcKLEjRynT8dHfLV5ph6tU3R2KWZlcvFGmaESWKProfABTS
	NKRUhTK1agEuRlrIGcsXeWIZ+lgoKGDcb5gOLUIAQjU4vvzfGl5k/7/PxiG9ry4A=
X-Gm-Gg: AeBDiessiDzi00GPY1T5KegBBn1oIBhbiFR4F9O31mYeJi1+oV8DAJEYXw0c3GDGykQ
	outuiKnuBEGd5InJXqMb6jnF3ov0DE3vgQYD34Lgto/Gy/h2n/8L+haAhgET+8f1TrdTs3ChmtM
	1dUinq7tS1xX1NV2s71FCgXEMX+dJ34M1qlKASv9fftLEzJ55gUXFMbMqhjB+Dd0LpeGMZLKPHB
	Kw7UFnlnCZyxUv1DjIucwoabsyphnxaa3D6PcCeBqPy1m/aB2+4Oqgjk61zFdTlitgC8hsJ29lv
	j+VXY8hFoFgpmGLwuBm9dc0ABoMk3gkBP/bqMJYo25gZyE1dWhldhhqD8oVUCxlD0906y2NEeqd
	xPk2qsOxf6ylLbMlmWCm2iojl2D1Rmt1FJt2e86W9UtH4jdUOo/FBnTuQjkNvhyzHHRZYk/67QG
	0GY166YsZhcR3+7w==
X-Received: by 2002:a05:622a:4cce:b0:509:2b5a:808 with SMTP id d75a77b69052e-50e3683910cmr118259481cf.2.1776678690273;
        Mon, 20 Apr 2026 02:51:30 -0700 (PDT)
X-Received: by 2002:a05:622a:4cce:b0:509:2b5a:808 with SMTP id d75a77b69052e-50e3683910cmr118259211cf.2.1776678689761;
        Mon, 20 Apr 2026 02:51:29 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba451211091sm348953866b.5.2026.04.20.02.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2026 02:51:28 -0700 (PDT)
Message-ID: <5b4b68df-593c-41b4-a0af-4a59b10faee0@oss.qualcomm.com>
Date: Mon, 20 Apr 2026 11:51:26 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] spi: qcom-qspi: Fix incomplete error handling in
 runtime PM
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260420-spi-nor-v3-0-7de325a29010@oss.qualcomm.com>
 <20260420-spi-nor-v3-2-7de325a29010@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260420-spi-nor-v3-2-7de325a29010@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA5NSBTYWx0ZWRfX/h4NoLf454Fv
 jfoEVMIQETkOFd3aRsLQUV7XQvXFlIb11+S48MX3QjBeePz9wntxik8y3caKHaQBvfB0bVBLLjz
 bEfcdXxwZJs72S+/bwlXPWhKQnjHxGO1lM0b4oGpBzUbdiieuazEDv8otUjKBpK44B3bXQ+g/Xa
 /i9oTY5PpN7Vc4cpxEycinZcSTPvrkPWxXj3NnrcKJ/4TzfDWQ/F24rLMn9BwKVQeILvGkHKM0g
 PKlpC7wLAOq9HhhMt0FVxeU3u+dv4+ZY7AmJDzIkXYfGyzhmd2yHFRTgm0gf6CFFjFNu0j0HeTJ
 3ygrUTooWeHoYCA67R7W/ontDccpBrDRjHgj1BzW2oX6Tf9S43715FyBcOfYQcztu8tdipt2s94
 HrRMMp8OQB9iaGDxhRVeVNmUFOf89fI5OptQi+ck/dqjv0IKCUM6JsWft3O+byMY7KsCzzBm2Nq
 85AenpdJjxe59T+G0Kw==
X-Authority-Analysis: v=2.4 cv=BPmDalQG c=1 sm=1 tr=0 ts=69e5f723 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=SDBIUcquJ5ihQ-it0pQA:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=zZCYzV9kfG8A:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 5tRoM2ws1d87qj8qJ7RvW49Uo6c142Ge
X-Proofpoint-GUID: 5tRoM2ws1d87qj8qJ7RvW49Uo6c142Ge
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200095

On 4/20/26 8:12 AM, Viken Dadhaniya wrote:
> The runtime PM functions had incomplete error handling that could leave the
> system in an inconsistent state. If any operation failed midway through
> suspend or resume, some resources would be left in the wrong state while
> others were already changed, leading to potential clock/power imbalances.
> 
> Reorder the suspend/resume sequences to avoid brownout risk by ensuring the
> performance state is set appropriately before clocks are enabled and clocks
> are disabled before dropping the performance state.
> 
> Fix by adding proper error checking for all operations and using goto-based
> cleanup to ensure all successfully acquired resources are properly released
> on any error.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
