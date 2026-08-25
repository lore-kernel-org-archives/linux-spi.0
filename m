Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9C53DD87A
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 08:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787645975; cv=none; b=SQhO1nS6hGX4NNg0xjPlWr6BBJsEMARNmoyrYnmNNBuvPdHlHsgkSczwOiL9RP11mjoS4jsob2JsX5XCQtRoUyjgUgM/oicEtmHWs2qG/+qa1iDgh5bsEn3zmEu/KEfXiUzB/5e2OS2lX34ZwC/gSBhB0wwsROqI202LZhX6fPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787645975; c=relaxed/simple;
	bh=Ot8jIiii0wOPLXsN9OFHxPtvh5gzgjm6lZFKpTOJH6Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewxbwClQXjaOqMKyuOTP/+mjFabzvdTMKrjRFXqd7vzvTbH5MCbn/FHVKlnoJFzTCrH+k+bxTItsXyMwL3otSaApnCU1GEs66MK6HiVO7nOnB0t1OI1nv+AZd2wmffgpSmIff4Of2iovt3R3mdBdTlbYwIs4/t11FHPpQMovYzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j7Rc8kjB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Xefx6oUr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j7Rc8kjB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xefx6oUr"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P88Sds1163459
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 08:19:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GT1LG3ESk4pX1L2+pv91ZrHz4OSnmnqI6wnpsuldA4I=; b=j7Rc8kjBAo5ttSFF
	a4Zv3pZeYdtIKXkG4JHEeDDKnKiKSSQj0wg7tyKNUIJu5LQSLwEGxOSxXslnk8PG
	h8ZLEiADGwfzm+T6fx6SqN4DEgTv/gr8h0+zJqklIrULq1JmTRJbkQkMbD3q2hhm
	malZb9VMsaNEC7RTMvZqtOh4so2ExbdzcQvGKOqhlUKbED0Y4Ka/b4bjedduCxI1
	csCE7XF3ccE/bAjDrVtzDfW2f/vSyGlUY3bwabmuG2leAIQjpQptjdpNGF3vKr5X
	KcfRz0oQlAUjRSZdqEsAvCdV2gKDwx7WQiLP6rfJAiiInS52/O7VW0qT2+F8ajEP
	RS1nMA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8y5jhq2q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 08:19:32 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84f7002f9afso3805747b3a.3
        for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 01:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787645971; x=1788250771; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GT1LG3ESk4pX1L2+pv91ZrHz4OSnmnqI6wnpsuldA4I=;
        b=Xefx6oUrGyKDffGOz5z/sKZ4LSXEXdhddzrjncq66QYUPJqB3TsXYztc3mF1ZyvFqs
         GvhLOgagZEHoSCwlErIrkflb5WL3tO7oCyBHM+cti1WTl6MhbIkCW6KkNl8KC0Fx7FjC
         mG5kt1Qw3Mzm2WeNT74nQiZihjgO6dD9aY4GqZQcMtcwax0z2T4AQv64Ddjo7skPkBel
         fzcHTF7mKJo/4FDaoKEQO6Rqr+zUZrc99GK9fKQEnCGYjjQ9ELd/Lno6dnIWWtbwq+26
         QwWUn7J8GAp82J+X79ob3/PxfmFZOBArBOh4KRTVvnkL1tRG4sHIko5QI6sC8Y76pgSb
         fsBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787645971; x=1788250771;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GT1LG3ESk4pX1L2+pv91ZrHz4OSnmnqI6wnpsuldA4I=;
        b=dTezN4Css9vu+Zl3BJxHsQUODLap+ekH+fbINJ5Pm91eNeiJDECB/UAj+Ff8M0f9bz
         KAQ/AlRgxPgjPazn+8jYsYPWPbJrlpgkgvZ/M3RA1D/qxG7X+zgpVsyXjDZ/vuzPqnNt
         8z2B2ONNxbzauYHzv9Mxv5SMxG2ZVI2BEXuPpF28aKPrUwmMuprXSXq3gB17auNInbCx
         DvhxNicvTUwOq5l1Zbso//bG29iJC5nEVcFZ/pENz53Go4oxJwveY0kt73H5PjfQFHCJ
         e4I7rzE3FY9QUO6YkTDL1Xx4+t0T9E131q+qFMoiRD5IXYGN7iXsYZxD4Up38mDEyM/S
         qD+g==
X-Forwarded-Encrypted: i=1; AHgh+RoyEXM4hnngeywZuLcAFL6hBxJQZOskGG6d1mY/DLzoltjqe9daNZeWECQnAidNdzOJT6Shb2/owu0=@vger.kernel.org
X-Gm-Message-State: AFuF++mV4hBg2LPNotyz/RNNi7Lgt88EQiwATLpD991u7B71dOUvcAQ5
	IVtnZcHlguu/lOZ7hPqekns2m71tDWliDmhlYt6gp99rmkwmIWWzY6s1Oy4YDtkKSiHmUPMCahx
	8Zqm6vr41oiuF2QoqUxQR61SEPCeN195DFjdqgcEfDjebBokt6JWIJnhZVvlPsG8=
X-Gm-Gg: AR+sD10bApSKXJ3GT5kaWrtCNd7p2YL1AzTcJ1lOgdR0pe4P1b67Hv4YUZmx4O22Ild
	DGM509i+qcFR/oONGxllHuo+/vyS5kT+/9EEqwhszkrAVEuRb/qAN9xlYW6ieAybojgnKtA+1Yl
	g1m8/BwQOV5gleGVNlCMZV/3yNkPt6WI5qKfqggA5/JxEw3yChFhMNB2LBd+/yq5wew48U7gNoG
	Y/ptoupCTBEwBGDxc4WoJfZ98VO8LnwaOlZu3iQ9SZ1RJ/RyMzzpxQgoPckpg24EeAS4suHu3vZ
	PxIaUEg70YOf/q3Hdkig8Cz29SCjHWVqcLvcY+nmWDwIgxJQO4v5FoveI+xNQsqb96FN7pLIXGv
	q3N9HLMuzvJD0tUiFEvz1YKWh2nLrivE=
X-Received: by 2002:a05:6a00:1ca8:b0:84c:1cd2:142b with SMTP id d2e1a72fcca58-8523c8f0862mr9113645b3a.9.1787645971599;
        Tue, 25 Aug 2026 01:19:31 -0700 (PDT)
X-Received: by 2002:a05:6a00:1ca8:b0:84c:1cd2:142b with SMTP id d2e1a72fcca58-8523c8f0862mr9113505b3a.9.1787645970964;
        Tue, 25 Aug 2026 01:19:30 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520f161701sm2725924b3a.53.2026.08.25.01.19.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 01:19:30 -0700 (PDT)
Message-ID: <956ad5fd-7710-4731-9796-b03dc21cb2a4@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 13:49:23 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] i2c: qcom-geni: Use geni_se_set_rate() for setting
 source clock frequency
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-7-61171ab1cdce@oss.qualcomm.com>
 <aca6afe7-4659-4359-b5c8-e19390a07f8a@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <aca6afe7-4659-4359-b5c8-e19390a07f8a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=O5QJeh9W c=1 sm=1 tr=0 ts=6a8d5014 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=QDFqMEhmg62cRBsMz60A:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA3MCBTYWx0ZWRfX4CQ7q6ufsZ1+
 hx8PaThQh7UfFmqrxVX5E7ez0VYhCQ9Jebd6L8NxrL/RQ8piOX+TGSGBIfH3vlkMNqe35+7IE3g
 3OJvcAFoWpavznvYxpGQD3+loKHTEj3ilBThIoIloUPcgl1aTUhXJLlJ8z98qeua+yVqY1RC9MS
 l2yyP512BMLg5AZEN9/x2tyCs8I72khiYuyILQrxDsm+Nm8mHjqUa/GSYMt3/b2ms7DXoiyKdwj
 YcCJyDhnmSgrcV7O1jBJbZpuGcmEdWPNNd0Ijbzhb6k3voxySE8lIyM7wXp6hDAYbTBD4I72+Sq
 48owEDrYCKetoQWyevjTlXnMN0dCIPImmmMUwE+UkmHo0EbjEseT1WaxU9Y9/Qa17KWNKHHdeat
 FQ3eoU50LTQ0ML9Mu2MRZ0Qw5K0W3q8TcfU81FfXcGM23JFGIRZR6AmZ5IsJXI1JfwZ9kaZ4bdj
 CTapAVUFqVe2Szu2BhA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA3MCBTYWx0ZWRfX64wJTo36Dhvo
 p73FsWWErVYsvIIOMnkhs/To3PuMngSEcgi7MjCcCrfd4osTMgmxUmqmS8R2wh+/te5Mny8JMyV
 KntvoyMsNsy292uSz5TgsXnmVju2sYc=
X-Proofpoint-GUID: LDAOp08y5e3cI_Nf-2uA5m1X8TBca1O8
X-Proofpoint-ORIG-GUID: LDAOp08y5e3cI_Nf-2uA5m1X8TBca1O8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250070

Hi Konrad,

Thank you for review.

On 24-08-2026 20:36, Konrad Dybcio wrote:
> On 8/4/26 9:57 PM, Praveen Talari wrote:
>> On the SA8255P platform there is no Linux clock handler for the SE source
>> clock; resources are instead managed by firmware via a genpd performance
>> domain. The I2C driver therefore relies on geni_se_set_rate() to apply the
>> fixed 19.2 MHz source clock frequency expected by the SCL divider and
>> counter values programmed by qcom_geni_i2c_conf().
> [...]
>
>> @@ -233,6 +233,10 @@ static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
>>   				 itr->clk_div, itr->t_high_cnt,
>>   				 itr->t_low_cnt, itr->t_cycle_cnt);
>>   
>> +	ret = geni_se_set_rate(&gi2c->se, 19200000);
>> +	if (ret)
>> +		return ret;
> This wasn't here before and the commit message only says something to the

Yes, it was not there earlier. I have added because of Fast-mode Plus (1 
MHz)

cannot achieve the required timings with the default 19.2 MHz source clock.

A higher source frequency (for example, 32.5 MHz or 37.5 MHz) is required,

along with the associated voltage/performance vote.


Thanks,

Praveen Talari


> amount of "it's necessary" - what's the difference?
>
> Konrad
