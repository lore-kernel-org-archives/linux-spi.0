Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E58A3BB13D
	for <linux-spi@vger.kernel.org>; Fri, 26 Jun 2026 15:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488075; cv=none; b=O71EDWnE+/u4FA2HJe7PAkMYR1SpEpol6NMC2WhKpoTUvCNeJUv54BneIiFTi+cew8IE0b6BaCgPIdWAdQiVgKFEeXT7Vx1hjSxQYjm6dZFjkhv1nfDdiiOfn21t3WKNiNPMvx/1jDf+qpfeb1drcIL+dzV70m975gSaBaNPGao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488075; c=relaxed/simple;
	bh=uycrAyaNRqPC1wT03GAKc8SD5LIJHNc3+Z03A8sdBHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fM8WKA2Tga8SIcLYR0tIqD4n6J+66FEEMrVhYJsKWzBt8QKCWgieOhPgMx0/iuHC/464KIUd4EGG1PcjkjF3CpoB2UF3R96QngqAyDD3bRvGzGsbGQ0ABpwgjX8KfXoK5RHUHk/15iHl/NuhPireRh5cDoKAC8tYaGo2EVijN+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JdtYaAnt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GYI1glJr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JdtYaAnt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GYI1glJr"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65QF3pQw1194534
	for <linux-spi@vger.kernel.org>; Fri, 26 Jun 2026 15:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CWeBwIab1i2IzhQduB2JbzOKce381YUPIvSMgEmg3JA=; b=JdtYaAnt+IQ2zkHa
	xbYaoXybk5idkMsh8AJKfDK1H1dgHo78sEDOyWi99zboNChKkNhXOpdhJJPXW4n3
	MCEDwJ5dsunN1SebLajsZoa7j5v3/Rig++djXlcL332tu/qE3aOj87Qfd9gACbv8
	bVvIMTi2vvCSKblgHaEwfCJQAxizheRh4e8MGTVp3cF9xrLGYFmTlKkqVkLrpkQI
	TZuqIxMgmPs1yZr+m8b1gD/+qqaN0LWLbCG3OZ9RueP1RtaRCICprKXExt2YXWBr
	VtVe3hh3H4brlfpcKzZkJ5o9+M3ObQFhrrnlXvIcAGo7MOqPjfsRD1KzRI9mXwSo
	cgAW1g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1asjc53c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 26 Jun 2026 15:34:33 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-517647fbff1so2504951cf.2
        for <linux-spi@vger.kernel.org>; Fri, 26 Jun 2026 08:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782488073; x=1783092873; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CWeBwIab1i2IzhQduB2JbzOKce381YUPIvSMgEmg3JA=;
        b=GYI1glJr/ONXthAWlo01gyiz/CitvfWgR+K3ondbX8ICaO8vU3cUVs2tWk0EuDAM8U
         KhgVO9bdMwQxZy1MDbuVXWONgdHSE3scb6uoHiG5h7v67PEZJQzEouVg2h9JghSdPpzV
         V7s4tlZzkKyUjsZcp8IXdgLHkxUY7Wo8mbW23hj3bAvak6MbYA4EKHYwEhPDM1yn+JaD
         wmBcjnJVHzX6uNJXT5SgwYBh1A8NisY1PVjWtZMUx+wkR/22DO1AtW3l9RmfPHqZ/n5R
         o4777g9E7s2LnWuTsrHukNpJ+dtNsv80drDkvIxep8ocWetoc/1AI7l5c/A86RW4o2ol
         SMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782488073; x=1783092873;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CWeBwIab1i2IzhQduB2JbzOKce381YUPIvSMgEmg3JA=;
        b=mCbBwbfH4RBN90oEP3NZheSg4RIKU3nEdEHrAV4HIwby2wQtGZB6D1OmHtM63ZyJSV
         QDqK9N2DfzzSkiwYBKGWqSbrfAUbwHmZulVBmIZ3fc4uX5Ls8LFrKv8gvPGg6gRnlpE4
         EivBGtzjcbfwu6IAXuRgeOYQ1O621F535Kv+o2VqGIJKD2SevhsI1zPGflhNTEhQgjYP
         m4zeFHRqwYTGS52pbUUdnxCYYEvCPY6r2v1r4upeYUmlxXe4Kj++rDgeo1N5XfOl+HhZ
         EzFkrj5/0djpUYaNMGAE+L3tDxphbOIxQ5N2qIU3hN5OitMwpf5fQyFWRgy56IycvaaW
         exug==
X-Forwarded-Encrypted: i=1; AFNElJ8eis2F4/gf6j1Fldh48L9udfW35paOCeMbTciSAD5nx3NexGtXNSfFDA0GgzVBbOalYeCjbCuAgwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtDLEh1dwzrtlw3qoV/bZH5icNDX6UjBP4RKDmFZrp9lu0Tkco
	qGQt5Twoe9HBumGnWN7/OHxtIYxi/BTpPZGjs6V+lj6kzFQsCL15dLH448nI+wG8Fl4wntSNonq
	uddynCArttFamrnnrxXLI6ZILlc8k6QJj1ThMOqyYaBJPfufuXxhDs89tHjoMZuU=
X-Gm-Gg: AfdE7cm9I7Ta47Yy6AE0DDs4vOJxkiAjWwc9FhTzfFoUWh2hPRTkArM7NWuJyQX6x9J
	wVwVRAXVh0yK6hamfjk96BgeLwtF5JX/AxoBueEPtl3BltvQiyKzF2iZCgjWfZYRn9iusrjeiiQ
	a6o+gvRQsewBvHREmLAdMSbB4jgKmNjsLk6wW3YuQJkso40LOYkmOpprbnaEtgxdGbMiQlEnDxX
	dkx2NB4h4o551TWr2Tk7Cl7dO9rKZJC1QgwLS9JaGh+wjloSdXyGrFwj2+vw4Aa5/Xka/1AFW95
	Yrl7G8n7A+0nj6B4oFA8RZvX9dnno2cr2ulZr3b79mKAnbbb9kiXWQ8uzmLI20swelduhOenTFT
	lonmF9SVViLzMXYLhP72WCHvSIRfMISMXKJU=
X-Received: by 2002:a05:622a:11d2:b0:509:2a92:8088 with SMTP id d75a77b69052e-51a726e0126mr68689161cf.1.1782488072513;
        Fri, 26 Jun 2026 08:34:32 -0700 (PDT)
X-Received: by 2002:a05:622a:11d2:b0:509:2a92:8088 with SMTP id d75a77b69052e-51a726e0126mr68688601cf.1.1782488071782;
        Fri, 26 Jun 2026 08:34:31 -0700 (PDT)
Received: from [192.168.120.170] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbba8b61sm341289566b.4.2026.06.26.08.34.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 08:34:31 -0700 (PDT)
Message-ID: <c22f82e1-65a8-4472-924d-91908f4d6104@oss.qualcomm.com>
Date: Fri, 26 Jun 2026 17:34:28 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] spi: qcom-geni: Add property to force GSI mode
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Pengyu Luo <mitltlatltl@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260614083424.464132-1-mitltlatltl@gmail.com>
 <20260614083424.464132-2-mitltlatltl@gmail.com>
 <qwbda435on6rhsbf5o4jqijakanjmnmswnc6g6qsubuqbyvbok@fuoclv6u7tq5>
 <CAH2e8h5Swn2mWoz+t_nrSw1=hQttwi1Hx=dg=cd9S3QRnHjpSQ@mail.gmail.com>
 <3451facc-4a2e-43bf-ba13-944488bce437@oss.qualcomm.com>
 <14491fd8-f785-4404-878b-5764bb8fd593@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <14491fd8-f785-4404-878b-5764bb8fd593@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TO11jVla c=1 sm=1 tr=0 ts=6a3e9c09 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=KdbZC8JMYa_JGPUaySMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 6ZQU2t_EsTNROLa1-_PJfi58JVe2RNpt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDEyOSBTYWx0ZWRfX/EeIjZbvs2W3
 okbaO8wkLekLpgNo6DcQwkTIO9n0v0OrHdYNCCSf71EWBi+Xu1flbYnecIPjvu4/YYYxt0AAMku
 GgRKoDo+f+Th9NbbQtvQNq2cSjPHvcE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDEyOSBTYWx0ZWRfX8DRQicNATrJ0
 Sj0hXQQl58LA465yCrdAshINmciuQJhXdvpUaxZDQ+4nNvS56mKzXfbfhG8ZZaADGcMXXGlPagx
 aIIzSZDzbRBwJsKI5RayGv20+caLYSmp45mM8XaPqdJQhxTTyBlZE418cu4WYyCf1Ti5m1BFcML
 Fi2+J+3TZNPY6J1gGJjwcz1BY6I3c+P4NYwaa9kSMhoZ+HnBIzKGhLSA8tot/IrelzY4QqlpMC/
 bIReKvTFZ1m5RtGI2tXcNA2Nxjf+DdFEEasulvdCoBI8sPms5xcTUpxOPectmmNiLDLurcYco56
 PMR3pU37OG/xdIkWBb9z7/7YxtNDJ/b5KXWm/PbO+Owhn1Q4MHPE76qB13G55mHUMipyWy2aNRe
 80sIpYx9ndIrKxCvTDMPuxTC+Du+FT8y5hJdst+uol7g5d+ey+259hTAUMaV4hCizIfwiVpxsJi
 GYUDPqHOVbswhgZBJdg==
X-Proofpoint-GUID: 6ZQU2t_EsTNROLa1-_PJfi58JVe2RNpt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260129

On 6/25/26 11:06 AM, Mukesh Savaliya wrote:
> Hi Konrad, sorry for late response.
> 
> On 6/15/2026 5:12 PM, Konrad Dybcio wrote:
>> On 6/15/26 6:25 AM, Pengyu Luo wrote:
>>> On Mon, Jun 15, 2026 at 5:18 AM Dmitry Baryshkov
>>> <dmitry.baryshkov@oss.qualcomm.com> wrote:
>>>>
>>>> On Sun, Jun 14, 2026 at 04:34:24PM +0800, Pengyu Luo wrote:
>>>>> Some devices (such as gaokun3) do not disable FIFO mode, causing the
>>>>> driver to fallback to FIFO mode by default. However, these platforms
>>>>> also support GSI mode, which is highly preferred for certain
>>>>> peripherals like SPI touchscreens to improve performance.
>>>>>
>>>>> Introduce the "qcom,force-gsi-mode" device property to hint and force
>>>>> the controller into GSI mode during initialization.
>>>>
>>>> Ideally, this should be decided by the SPI controller based on the
>>>> requirements. Another option would be to prefer GSI for all transfers if
>>>> it is available, ignoring the FIFO even if it is not disabled.
>>>>
>>>
>>> I have read reviews. Can we check if the compatible
>>> "qcom,sm6350-gpi-dma" is in DT? If the gpi dma controller is
>>> presented, then we enable GSI mode.
>>
>>
>> This hunk is very odd:
>>
>> /*
>>   * in case of failure to get gpi dma channel, we can still do the
>>   * FIFO mode, so fallthrough
>>   */
>> dev_warn(mas->dev, "FIFO mode disabled, but couldn't get DMA, fall back to FIFO mode\n");
>>
>> In my understanding, GSI DMA mode is always preferable. +Mukesh, do
>> you have any insights?
>>
> GSI mode is preferable but if for some reason it fails, we try to continue with the FIFO mode. Just fallback mechanism.

So, would making GSI the default and FIFO the fallback option
sound good?

Konrad

