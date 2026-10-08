Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB2737E5FD
	for <linux-spi@vger.kernel.org>; Thu,  8 Oct 2026 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791488742; cv=none; b=kWKTM6u6KqeqLbDvsQa0hZ3HsrUBmoBD0irZT4H91mQhqCoR1EPP17D0Z898S/2TnRjQQl3dyLM7G5naBApimMK5aPALq5LMZ66wEHTVcs0WxJhgNNJmikl2q0CZHDgH+bUFT2SzLb4Scx3iOMoHf34XNRDV6hc5p4xNDgeMVQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791488742; c=relaxed/simple;
	bh=SiXKJG2PO/AmoGF7S8/huQmSfsdK7b1//FbyQBx6Qu8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N+q/89ZWT9D/uu9HOd2WGE/RVsIPoaEmOIAxkEBhaqVllj8ffc2OHNK5NfD/3SASeMsm4h9lR/gr1FUzznfaFGZSf9ZPgv+g+lPzvxwJS0Bagjy4u/K20+4eDKbbVCQlEZfmEQjXSEDhwQu5VM2MJ7NGnhDNIGdYr3UJYW/Riio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jfD1vmY5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Do7lx9PT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jfD1vmY5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Do7lx9PT"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698HVeOn3197376
	for <linux-spi@vger.kernel.org>; Thu, 8 Oct 2026 19:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jb2QYRx23fNHLxJQ4komYZKPnagAt7gtPXM7krNr7DE=; b=jfD1vmY56ONHOBmP
	X6r+b5uQuumr4j3GXxzT9masxHagH4dB/UtE8UKFF4Hb2CWaW/ZPEhdj3fB8YDEJ
	hXuEhvOqYSux4hKQaCGyFrjimPTax5zA5XG0whEo91qQw3xC4vm6wM2HYLstMZmy
	R+lELEbP8pufCors9y3dVEdJwXoOGgkuo7soUvdSa3pQ+34r92oR3rZpyFyOTaA5
	Wj98cnRktpmBxBwaI1pmAhYD06mnoEg+ZxgMeqNDG8K80gHSiPRvazv1NszL9Xm7
	TbA6+WSZ4Hj0HlGxNAxiEgONywIMp/d00DYwMDx9zHSzbAXHluwYzUYv+W9wgFhh
	nvhdRA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fmqrfnk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 08 Oct 2026 19:45:40 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3515d2fc5ebso8824954eec.1
        for <linux-spi@vger.kernel.org>; Thu, 08 Oct 2026 12:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791488739; x=1792093539; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jb2QYRx23fNHLxJQ4komYZKPnagAt7gtPXM7krNr7DE=;
        b=Do7lx9PT4eQMy1r6P3P0rq/ybRyrXn1pbwOjztFBZrrjtkK8BnPIlztsDG4udQt4oD
         +zDvjsGNICCIuXXHSkV/DrX9a9hwRXpXBcBnlKDkbwnCrZsJkos6TQxU8o8nonQsT86z
         L7yx94SMN47yvXnow2jHw4zPEZakiXDlD7UhxU3S4dfJInodmEFvvdlww5xBg7AAekT6
         U6isEJ2ZldAWWNCJBFzuZGWKKyJqCDmaJP6BpqqiX/7m2K60R3TI6ZEJvVmtoiyXyjlv
         36fXho401oMUJZ0vD61K9PaPojQIG5PVw2kA/Bwf4hzpu0D8UF40LSXEjlYl7epu1LEk
         33Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791488739; x=1792093539;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jb2QYRx23fNHLxJQ4komYZKPnagAt7gtPXM7krNr7DE=;
        b=ZFOobA1p3W1K7Os7BChT8icOMO32lD2Q8AEQ9tdd/cdxmt8zkYhWqbB/lAfCXQwe++
         QZlNsNPOAvFn2OKxRD27o8yW3BlY9m6pLT0awkcGPm/ISX0bvLgqoQBFUAPUAiB4X+Nw
         FKVaXA2tldOz82xLOJF1l3P6iyWdFoNlEaaRwGpV+qTtcIGZPEaUYaiwqa/Qi4HYxnHP
         09vgIdalAqS2MQJXPdjIJ7Oew1R1AuN8Xn1GHjEfrV+YCsAI042xxKt74Rcq9FyVrosg
         YI56Kzn4yT+TMYdOPwL2HYpbgLw6t6E6hC40ECHqPTRmxumfpAxYSMqWkk9HZYvNBGI+
         ZsyA==
X-Forwarded-Encrypted: i=1; AKwUvBx80wK5JvseI9Be+8IJmbxP11hPQyLEF2Bq+fG70QWDsQM1/w025C16pMWQ5owpjLNfpvdZKJbpxNg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLlfqVEAmklfiOK/I5nYBiBnG/vGuUnVEtEV+EA0u3XtedzfnS9
	lIepILN+BWT5Au47TQk8HaTQYkMy5G0QDy016nnPjV/GgGBj8cSdzlgrkdF7vNoJsucolDxOIy8
	nsa+2JN7SEPFo/YDsgfwMEujhvarNg9e1o001M/AmtcyiVXEDoW4hFUInCyHezS8=
X-Gm-Gg: AYBFou1eJhFSKVytd75OJzUZEOKdcSukP3pghOZEdqJbWFK9S/3CpFOoUEMncUgvzWb
	uOMmFc2ghBQZQmjU9PLxEKSCW0P19rc4ZM3qJYX99BLZuBJxogQ8lNRKJUGOHfoNxsXv6pB722w
	t53mAT0G5JGAC3pIbbmFBTQMhfKSK528E99MC77GB0esHy3upJYwpi6wzLVTyHCH/aRi3GS3ni8
	NRIhw//S8v51rOfvA0sUu9AEA7luu5SCyj17eNzvB9d94zO/H5/J/EQoU4P+ud2i4RpfbY4eLbZ
	fTF+/wjL51C+wUsFjmEkAMDCk4VZJafU7Yi5d0wwQtY+gU1M9SwvF5YgUb75drArkMR/+DaJn4P
	04mFSAScz7IJWtL2uxjnF0mpwmOGdrEdtlg==
X-Received: by 2002:a05:7301:5414:b0:352:2e10:10c3 with SMTP id 5a478bee46e88-3535f43829cmr468307eec.36.1791488738880;
        Thu, 08 Oct 2026 12:45:38 -0700 (PDT)
X-Received: by 2002:a05:7301:5414:b0:352:2e10:10c3 with SMTP id 5a478bee46e88-3535f43829cmr468256eec.36.1791488738093;
        Thu, 08 Oct 2026 12:45:38 -0700 (PDT)
Received: from [192.168.1.2] ([106.222.229.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca1b556sm277985eec.9.2026.10.08.12.45.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2026 12:45:37 -0700 (PDT)
Message-ID: <dbc848a0-c963-4715-a3c1-7c669142d28d@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 01:15:29 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] spi: qcom-geni: Use geni_se_set_rate() for setting
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
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-6-091697dbeb02@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-6-091697dbeb02@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA3OCBTYWx0ZWRfXyh9RawbtSqUJ
 doOqg4rTkVdMArLg7Z9eHktWRG3vUwcGt0Ci8+nCEynf5MiW2PtoFdQVUXWKDHAflrjFYBVHH9n
 Apd+PmDT32DkTw4i3fXZdgPhdrF2N+w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA3OCBTYWx0ZWRfX0l1JrdnMu62v
 3BWySCk3bxDI4wRZGUPcsTYjOANhJKZHNnZSZTZUqKa1NlZMFZYWnKQraTMjBGIjfPVcoMNfeLf
 l45zn1SfeQAiLCgQV95VVkU5wPMRUbpPWr1ueWDCH8CkRIHIbXkMyRrjKLMgUMo15thb445ix64
 mv8UX+HPfG2rFRcZY9zxppymS1W2P6e73JwSNMx7sgCL+G268rIQxUkvWCOFYygn/hfBXtdaxXQ
 Mh0/Y85v+aR4WCHBDZjafTYmMSXStTsXFvY32WTSzzTZK2oIHRc6Zio08Uqoa/6YFLpi3kW+oyc
 77dsQe/JdDIgoxE8WTBVTk/meSfX7tF3eHPT0bIqR/2DFUnmAPIXnB/FVEcgNYOybzEwLPo0PEe
 Wm6MOXg7FKS3rLWQnQgPF30x1924aStH6XWV+OccE/VPnADLHOXx8j85hl/R/i78zWZzN4tkNQ7
 Pfpvxya9QKofaWYl9VA==
X-Proofpoint-GUID: mzPpCo5swdrgrLhDiMhFmn6wGvzD55mB
X-Proofpoint-ORIG-GUID: mzPpCo5swdrgrLhDiMhFmn6wGvzD55mB
X-Authority-Analysis: v=2.4 cv=IqCL47/g c=1 sm=1 tr=0 ts=6ac7f2e4 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=soJen2uxB0ky/kNk6TDY8g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ld924GHQG9e8gPgwT3gA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_06,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1011 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080078



On 8/27/2026 11:29 PM, Praveen Talari wrote:
> On the SA8255P platform there is no Linux clock handler for the SE
> source clock, so the driver has no way to look up the source clock
> index and divider needed to fill the GSI CONFIG0 TRE for a requested
> transfer frequency. To work around this, firmware instead exposes the
> SE HW supported source clock frequencies as OPPs on the perf domain
> device.
> 
> geni_se_domain_attach() now populates clk_perf_tbl from
> the performance-domain OPP table, allowing firmware-managed
> platforms to use geni_se_clk_freq_match().
> 
> Use geni_se_set_rate() instead of dev_pm_opp_set_rate()
> so clock programming is handled centrally by the GENI core,
> independent of the underlying clock-control mechanism.
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>

