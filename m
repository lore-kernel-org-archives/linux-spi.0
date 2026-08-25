Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0053E2750
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 08:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646527; cv=none; b=BOOlMqJSSOICOjH7lViFtg4ky6n0kaVYpMM0Vj6Qdv4jfxMcOeIXUwnBJ59nqOKg7I3a6dLogfd48DBmpBxU54/Mp9YhKJK/pS84OZVK/jpPlBeIQEgm1lK6gdYf4AUftYbX9iAvQ7egMkgw9heV7o/nKFp2JjVeqPlspYzvGaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646527; c=relaxed/simple;
	bh=M6+Z/n2sPEdxSkumdm4fpxZDeQlqm0ww7+RLX0T8tDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rSdQNEOboFukwhCo6jw+v7iRbeC/N7B+/0/nyc4l+qG0+vPd8GKmn2Hcx1jtrd3jiRBb4e70M5sAO945Hyt6+FQn/RkjrefRsW7g+bRIVb+Prr9isxFugEC632oUZ9hXUiIgEGyD8U0nHxw3WrOOHepsYepT1Rc5GT/pq/GC6N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hb9oUO/W; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TBXtRCwp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hb9oUO/W";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TBXtRCwp"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P88Sia1163469
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 08:28:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bYhkDV0y7XOpWdvVDzgGnrF9K75KOavFDUraFzDkeMs=; b=hb9oUO/W4rgIbipL
	mGFectRAfdZBqpJCcwpB1ofAMp8oW3JaDF/3oGnhjjRjyg2iyuqKO8sZObFeUYzW
	7XE0gnADDbK3HC628p4fbs6euvMI8a5pHQLTHFRdEUTtzDrjSyMl8nZt+7N17gNE
	a6Ag6K4qIJCWKEDkW55cbGE9Bb5mQN0xLyYxDpbZ3+xtMAicAQYhWwoBzYbBAnYd
	oJwJtB4UzeKUTFlm5AVzFHjTPEw4F5dMM/OUaIegUF5KBLFbnNTX6uozastRZTGS
	gnZWV3jfiwK+AQ9Q7JIXqTIyUAS/+mlc7135RIl7S8IhUUXRL+FzM+CQev6emWL5
	r1a6XQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8y5jhrny-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 08:28:44 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c07313be5so10607991cf.2
        for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 01:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787646524; x=1788251324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bYhkDV0y7XOpWdvVDzgGnrF9K75KOavFDUraFzDkeMs=;
        b=TBXtRCwpxmXRRev1Olbv/b/EPCsWPpbXDp82LD2cKU6aQD0fqrI2EsJ/dCLYiOu0am
         Ly+mxDvjYbEYJQzHhrVYwc2pr4wRi94Der/PHL1DahPMHN2BYKk9hft+FN/vapI88avV
         iYktJ5PT7XLqWQ5Ce1nVqjk+33mkwhDUx0rUJdyw1fZAEpJ6aZvsWKJrN9mhfRra3cvL
         NLZKN6FuSig3cPw3f0rpldS18vyoXpxOBXUV4Mvav0hIjHsxaUWoeSQe9pIUBrzPRJgU
         XuhVvRJBzVAGbTxoBB8ub9Q0SH7pNOdggjfYISndd0s4h4ZknlVkiDaVG95pUE1NPxEV
         4vcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787646524; x=1788251324;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bYhkDV0y7XOpWdvVDzgGnrF9K75KOavFDUraFzDkeMs=;
        b=nMxyOjacVXHWj3Kyz0WBipfRBigTLSU7qf+EHbGce6uUJ+jmS1xHRXQaqJSDitkSxk
         131deVLql45zlbic9Z83NekbAcqYASNYSrgwOxou9I1WadbT7H/SJmQssJzbp/UwwOd8
         i2rx03Vmz45f5xsixtHoNU9ZjkOERk7FUwfTzNYBXiZ834wtCQZ9YSoOINmC1/9mL8nU
         Ew2WqEiVsZKALZJctJJWXJyO8XSYsUCftU7Mj5CLA0HJd7jU2jKBPRbPFtzTbprOWceH
         Mp2k51qeLYjs2vbSkXiTMVrQhhaRlF8npLlUT8dpEeSdxFGEXUYaWD/CD9FwwLBetAy6
         teYQ==
X-Forwarded-Encrypted: i=1; AHgh+RrgT+bNDPgsiz3s+R002HxZuOOqCnj+e1WEfkR/OGK27QpTVm8DdGAOqIPQ6WCjZMwP0WRMeNhn118=@vger.kernel.org
X-Gm-Message-State: AFuF++lyFjaWYLDGxmQFt5HRgD8slz48yOlEnckH1E2vu/ieGpQr0pUl
	w2Cz1yyK9f9UI1ybh+5kBucLs+ILF9XQZcrZYb7gwqfpFbFnKI5OnjCYccc06/XeTEhL53Pe/mp
	YEmv+7J+MqL/SQ0TxfMFWJmY1/IxSvNH9YP3hZiVgmDnZi5tlnxbc2zsGHNTUs7Q=
X-Gm-Gg: AR+sD11SfEmd/m9P+9qeetGKorNw1WcpqdA1mvkUx0jNea+oxFJXzfMFy4IIZ52z87X
	sSYdXl7B/tC3HusME0cK03AAQos90Ey3kuhqODLo+mf6s1NpqmhrBXxnStWNFxFt35JYAnc75aX
	EHZXFURNyppyKoNrNwNox4iQ22HYtFmFROQdIbPiBDoD2Xs2RXABcIxpIHVEZTgKRfluDrGyLxu
	rTSmLMAudKdNT8ky56aZsR1dM4oUKjKg9IC0b/TxX3tUtiDFUHZnY0r7WTGM/KK+QX0Ig4n0j2Z
	9wPX6GUDiNay0iCjyNpm9eKHTTaP8BgZ7UlplI1EjucXlUuj9ViAIjM8ZadZUpgvPdPLcm8T6T/
	GKTcPD3RuiSb2I993cofBSwEo
X-Received: by 2002:ac8:5f50:0:b0:51b:f40b:2faf with SMTP id d75a77b69052e-52df5a35311mr225835461cf.4.1787646523832;
        Tue, 25 Aug 2026 01:28:43 -0700 (PDT)
X-Received: by 2002:ac8:5f50:0:b0:51b:f40b:2faf with SMTP id d75a77b69052e-52df5a35311mr225835341cf.4.1787646523448;
        Tue, 25 Aug 2026 01:28:43 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249629a901sm1820302366b.25.2026.08.25.01.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 01:28:42 -0700 (PDT)
Message-ID: <8d8f7742-fd4a-4605-a9b1-153ace9e14a4@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 10:28:41 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] serial: qcom-geni: Use geni_se_set_rate() for source
 clock configuration
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
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
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-4-61171ab1cdce@oss.qualcomm.com>
 <4e0d636a-7975-4711-8070-6f71957b754e@oss.qualcomm.com>
 <17735f83-fd07-4fad-97a3-727cfbeabbcb@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <17735f83-fd07-4fad-97a3-727cfbeabbcb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=O5QJeh9W c=1 sm=1 tr=0 ts=6a8d523c cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=CZKBZ6wm4gaK5Uy4Yf8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA3MSBTYWx0ZWRfX+BTN1hrHWZjV
 RsrQJSebM/HxUg56bqlVfTkg3NScau+n6+Zuh6N6ByzpS5PlxI/rK9Xj+p5Z1qVftFQoFcQ4j5I
 I85tj6vM2O8a2TUJwZOdJkL7Qs0vVsW8jVzwE48/nwirORYENpSt5/Y/JlZSrPquIwVTOT3DuaU
 5QzWjsYesoGUzcLQgOovtgPNS5xx93APfbQst4XKYdM87aFTHyBBGCRgzuBjQo10raJifIZC2BE
 m27/weEP6JUMZlo++5YOL4qNvemUsJLKM9A36svedzryEkY1mBMQrXrO3COaOBKgP00ac7kPKK8
 V7WlRdK7ixXIVv1WMDf0qsoQCx9M5w5dz1lCR9LZoCb8eYoMiJxusH0SF2zPDZnG+pB5OM2Z7wN
 aYOF//wKNGFjx28FEmjpQruxZtSbzy3+4RblVwTkqx/H3CDeH9mQg4MpqW6LfOSfPnMT97h5OMh
 REXD8TW4TRzP2R9qQVQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA3MSBTYWx0ZWRfX133kzV9c0dj2
 1zlOh5/ZoW9YwrNc8Yp/9b5fWknlEvtqSEirlhoATa4c2QQHMmfrbk9jwEONxBnc+9DzVvnQpS7
 5ocCE214rwWxau+ZmjAWwGWp9LjHrqo=
X-Proofpoint-GUID: YaG1vjnZn1BVNQa7BlTtC6HYwnYUTS_z
X-Proofpoint-ORIG-GUID: YaG1vjnZn1BVNQa7BlTtC6HYwnYUTS_z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250071

On 8/25/26 6:00 AM, Praveen Talari wrote:
> HI Konrad,
> 
> On 24-08-2026 20:35, Konrad Dybcio wrote:
>> On 8/4/26 9:57 PM, Praveen Talari wrote:
>>> The driver calls dev_pm_opp_set_rate() directly on uport->dev to apply
>>> the computed source clock frequency, and dispatches baud rate handling
>>> through a per-variant dev_data->set_rate() callback that either
>>> recalculates the clock divider (Linux clock managed path) or selects
>>> a performance level via geni_se_set_perf_level() (SA8255P firmware
>>> managed path).
>> [...]
>>
>>> +    geni_se_set_rate(&port->se, 0);
>> This ends up calling dev_pm_opp_set_rate(0) [i see this is an existing
>> bug in geni_se_resources_deactivate()], which removes the power vote,
>> but does nothing to the clock (neither set_rate nor disable_unprepare),
>> which will crash the platform
>>
>> Both of these calls (new and existing) should be removed. Clocks will
>> be disabled by geni_se_clks_off() in geni_se_resources_deactivate().
>>
>> Then, we should do dev_pm_set_opp(se->dev, NULL) *after* they are off
>> to remove any trailing OPP resources (i.e. icc votes defined in the OPP
>> table in our case)
> So, if I understand correctly, the expected sequence is:
> 
> 1. Disable the clocks.
> 
> 2. Remove the OPP/performance resources.

Yes, otherwise there is no guarantee that the clocks have sufficient
power for a given rate

Konrad
