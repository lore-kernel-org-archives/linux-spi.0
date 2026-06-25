Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB52137DAC0
	for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2026 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782399556; cv=none; b=loFYagQItiGORf8dlbT2iVIg1y7idOAfTxbT3IZGdG4OG3XzyaZmNWVaRAgRTShwD5wlaYJo9eGgtvrVNETwpjeyTkyAvi9M9hyDzIzmSwgpOF2fqWW0rNyCxewUxh7Cii1yh3AJ02wacrHLMcG7f0lo/KAbwjXvl25iO37d30w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782399556; c=relaxed/simple;
	bh=gnMm3WQJlNpev15bu9mc3FCVKCZx764ic1J3kbbxV2o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uWSi0Sz7f6FVu8Y6pYhiFffbzmMgu1VZb9xcv6vsJ0/pAtt+bh9WNJm0RcGdEej8RFJkzr0ROsyV2m4ptEe+5Qc/KLnrb4iG3kHojmPjBCNYd9jT14w6dGYbZ7fV5wVIEjpe+ocOKh2jQba7nPnMi8GV4IRtz4Drr5OJhPmI0gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fwu5jO2E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DJQ22mPH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fwu5jO2E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DJQ22mPH"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P9k2Kx1921324
	for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2026 14:59:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ERj4hIVMm3C/NLlG3rHWWiNfE6LvOTwPFfl/UgwDkeQ=; b=fwu5jO2Ewdyqmzs/
	r1bI0rIr1HkRn0l9GKtU58hW0fYp9VAQv7qRv7dX7rCKkiVON6YwZoHBGn+HgFlC
	72TmiL/qE68IZ5dE7rfInI2fLNKYt/vZZskFUwGet1leYhsDs8mCGxx7coDJMDqS
	LIgRRx6BFU/cdlaQHMrC7VzTBlWFjnbVdXPck4Xf600rp/RYmVOGF0xgpW9K02sy
	380eU7J84BF3B+flAjocQM/8YKxk/KH7YOuqlPtubPmSi7DdGpKr+zJ3YuIiEyOV
	e1baaG9RIHmtMvKZWQjH766OEwBZnVYcAr8v5NBstoKYbJRr4S4tIE+oCTRr2I6e
	NVI6vw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0ueuarxq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2026 14:59:13 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-519e4aaec80so31775681cf.0
        for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2026 07:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782399553; x=1783004353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ERj4hIVMm3C/NLlG3rHWWiNfE6LvOTwPFfl/UgwDkeQ=;
        b=DJQ22mPHMnQsSshPTNx3GOoueG2livUiELTRZEoGWw6HLowOCalCEPaHuYiowlTu5o
         B9KjftlrwlSYiEXY1ZoDbyxIepCHgRzqrHlX1GwYT3m436xgWSztQKEauAtKxlrc921d
         2fJPbNQHEh5WLiTjGbMD5g1lcRxH3P7GMzr9g68ukTrjGgLChZe8tLHkTjwcZo5Lw7/Y
         fOII/wYayaKjTfHkFN612f6jQqAyEyPUnGnCRw8Y1DeGPAXV71mps22/9QmerOr1WaOC
         7gwNCH0nWBOa/oOc6Df7iWFGzCp9lW+vcK8ILnMIqm5C5luRhm4DmoH6ouFyQjsXDSjL
         qZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782399553; x=1783004353;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ERj4hIVMm3C/NLlG3rHWWiNfE6LvOTwPFfl/UgwDkeQ=;
        b=GtanBA1yUGILS6cZdRtiRmbJzZoWKLC+SMZWLCg3gN+zweYJN5Q7kPIQ27F7AZLzWG
         ryMb02dNwPabgfdV1GMKvwbc0FV8+FiO8VVHUdzmrdsVaKNf0FbOQQ3OgKqDVxEE1vsL
         0dWAVkNDOf2GYzpX7mD9QYbUWxvMwAJas9+QqGqliOH0GyywLu+Pr7WNx+yiObH5xYv0
         Lo1xMgcqq1NFh50b0cnHXUqcqexXna7FT7/asw0G44E0XEcLt84Cpnfnib3eemWg6N8t
         RbmJwwNxkruiB2s0tzy/HryplQs1KJ78LCOrFu+1SBKAmUbIkYzG8WEvMzPoDkiRdevf
         ru3w==
X-Forwarded-Encrypted: i=1; AFNElJ+BKuuEaJytsIZ30xu+T2YhnpiBG6EynVLIYzT/NhtMYRQi0uPCAy3nCrvaHk6xujT9ZqoMKJoJAzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxZsu4vFO2a3Lnx/qDN7Gw4uqAOeBQ1EJBEKPKDp92Y7Vn0N/Z
	XiEswQn055Q1xNADsI/VkALf79BKQMTkq6NkzgLSG59cnqVGO2MAIieBiRu1QW7pZoFxgpN2cx7
	qtky0pompPD0PxanPDG92vlEOz5Vk1t89THLcWga3KdB530lpWcghL5jopTN70GI=
X-Gm-Gg: AfdE7cnT6er1M+x8DV51GWIqrkZ0rPqI7RTwgSoIM9hdW4d7OqTXJ0ZAjLwhtrIGBSc
	W2ISvUmpETUQRPW+HfccJDYWTI8WdewtSLqytm3bfmWA8lBJ8KWe22CgxrzxkHHzcb7GGYMNb4e
	x0wtKZ+PhLyBdaojM5jPx81Og5+pjSa8IYBV5FBRQe4OocPlwtKwG50nyrGP4NmBjq2G0Cmprl3
	0FyD0QGJLmUtHz7BIG0rSh4sLJtN8VQU59WT6O9+cQo/8N98HhprTuFzW7c1lDRbqXOagegTYXt
	HFAhRrM3Jarbj1llmdJXGOD7BrfQhTLUxlI0CslRsV48w5IljrrrVJNpUwue9RqwwpyFNApb/mI
	gFMpeC7VU0AbEcFVWiXLDSiBc6IiBi4XBHm1tFP+l
X-Received: by 2002:ac8:7f51:0:b0:50e:6182:b4c with SMTP id d75a77b69052e-51a727b4fc7mr38548701cf.25.1782399553148;
        Thu, 25 Jun 2026 07:59:13 -0700 (PDT)
X-Received: by 2002:ac8:7f51:0:b0:50e:6182:b4c with SMTP id d75a77b69052e-51a727b4fc7mr38548191cf.25.1782399552655;
        Thu, 25 Jun 2026 07:59:12 -0700 (PDT)
Received: from [192.168.0.5] ([49.204.107.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a51ae8ee7sm73357791cf.24.2026.06.25.07.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 07:59:12 -0700 (PDT)
Message-ID: <4ceb69dd-4c4f-46b4-93d2-4e4c7bf0146b@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 20:29:05 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: core: Abort active target transfer on controller
 suspend
To: Mark Brown <broonie@kernel.org>
Cc: bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com
References: <20260625-abort_active_transfer_duirng_s2r-v1-1-7439e3585ad7@oss.qualcomm.com>
 <730c2055-b29f-419d-99f2-bc4df3b6a2f7@sirena.org.uk>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <730c2055-b29f-419d-99f2-bc4df3b6a2f7@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: tXYH4EMzulPj169ynkhl0uPELZd2XCQg
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyOCBTYWx0ZWRfX4ypIy7CHX5PW
 RbSbLA7TYurnvCCIO/TCcjxjAUQ1mUSXxb/8RfEGrGBaOyTLuhDIxD8DhJRMX9OUtjtsyMAq8YW
 /3nbb6nBS30EiZvmZ7uxd93I/HzV/IQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyOCBTYWx0ZWRfX/GZ1w/nVy/jb
 jpQ82gSyqI0GWhuKzvjwF14x2Ah0X6gfi7FSxJMEIeDfqi19RaUv1Ss720makdLyD6KrDWDxVM5
 x0Y1m5pDVLm3Z+hCxD+W1SXGatWYHfeMNWYNma9W+Je6OcuAMXQDy0Tl1sIt1JNTgsOwMYt7Rla
 8AJZxYBKPhUTQ3Z5ByHHvLjcsXBU/CkvcpCOFNOXwiBn2lFvqS+BgOUxOqfEMYc+vA+MBGhpHxk
 gtirhx9daaXigJWefUWS+MPa3oB5t2C3Mu9930cXuRUGStT/VOyyjmnd+sss1r5zrJYxX7+D0Qh
 9PYLCMJow+nPsTPRG8VqPrZjvGxoSBOqVQTifWnP+kleMeH+a4K8hG9yrJcxDibgO9ci4d7+kmR
 EmWzToWBHXJl25SfchpULIYxSt68a1XJMDPpoclQ7sTjGliHjXOqQXr0eWz5lHh2A/c+Dqc9cTV
 gK4yul62bCIETxnYTWA==
X-Authority-Analysis: v=2.4 cv=b/SCJNGx c=1 sm=1 tr=0 ts=6a3d4241 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=EzYcgOYpdvJVRNjdZ+O3HA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=0Ud4EHsjdzI14k2cJ-sA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: tXYH4EMzulPj169ynkhl0uPELZd2XCQg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 clxscore=1015 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250128

Hi Mark

On 25-06-2026 18:57, Mark Brown wrote:
> On Thu, Jun 25, 2026 at 11:09:35AM +0530, Praveen Talari wrote:
>> When an SPI controller operating in target mode has a transfer in
>> progress at the time of system suspend, the suspend path proceeds
>> without aborting the ongoing transfer. This can leave the hardware in
>> an inconsistent state, potentially causing the system to hang or fail
>> to resume cleanly.
>>
>> Fix this by invoking the controller's target_abort callback from
>> spi_controller_suspend() when the controller is in target mode and the
>> callback is registered. This ensures any active target transfer is
>> cleanly terminated before the controller is suspended.
>>   
>> +	if (spi_controller_is_target(ctlr) && ctlr->target_abort)
>> +		ctlr->target_abort(ctlr);
>> +
> We need to check for an active message here, drivers are going to
> assume there's an in progress operation to cancel - for example the
> pxa2xx driver unconditionally sets cur_msg->status during abort which is
> going to go badly without a cur_msg.
Yes, i got it. Our spi driver had that check in target_abort.

is it fine?

if (ctrl->cur_msg && spi_controller_is_target(ctlr) && ctlr->target_abort)


Thanks,

Praveen Talari




