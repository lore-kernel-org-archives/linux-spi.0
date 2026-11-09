Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208222;
	b=jDV/UJ+8rWTO4sD1Yrmrn3/JaqgpcYjERUxN+HpKPHgvCcJ2rH7ejRLeVdmsO6pECZ29
	 Ng7WApWCckRIn9Kts2y53lrWzUl/sBehToRMHboEDZj2DKj8FLuYsalP0XyrnPaUkmxSi
	 Pf4mPVkku8Crszg35XNJtC9RStnilQeA3SVLRa6gE+tthpFSr79aeti7OOYUGuvniPj4J
	 1eVT3Xq9gFmuOo5t6PiBCL5+eQ1j80VgSyLJPdQqIkFY6N/bEN+9ZC9gxRRJFMsAqJ34X
	 hLAgpkOIpPVnV9d3o9PWz6pT1xyFgfojbnzRG+zRM93JGxeiN6rokRcjZd/ANNXEUxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208222;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=np7bEj6m0lRUiyUr1l1RlC0cc90sTu683s4JN4gPYMU=;
	b=BoHtz2BD/43rMTI+Z/d7WbOh9tLVM9vK3TprXaQDP7utM1ia5aTn7iYnl8SRpHllbH5Q
	 qq4N5ed3Y35Z1pxYV1zPRvC0DJDuHIloFsd1ngn62fVtNAKS6YzqTP6Oua0E+NnigzqTQ
	 ajQbrS+mrRQ0I2lT5bGvEBHXsZLapBCWnYwdoo/eKoifDlHJQA2QuiKoC7hwkmlabCXTB
	 hB30G6RpUvKDXFwlgZ151cQ7uiaVIWzGavjWV1uNtZwimxaicyLkw1Z5NAE9X5ri1H4xU
	 yH1sHEC1YMdWnRi1TU4RNXAgxUrOcwhzxc4jC9RBoY4oIrrSc0W30XHLtIoNb/y0WMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ejBy6W1k;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gGIcPeD4;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9257D606A335
	for <linux-spi@vger.kernel.org>; Mon,  9 Nov 2026 07:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9257D606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ejBy6W1k;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gGIcPeD4
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A96AUng2540653
	for <linux-spi@vger.kernel.org>; Mon, 9 Nov 2026 07:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	np7bEj6m0lRUiyUr1l1RlC0cc90sTu683s4JN4gPYMU=; b=ejBy6W1kN3yns1U2
	17zJeRDHK4VWzF15HXswJ5WLq+++LvoYsgJZz45PV2ySKkNzW12sgxZAdZkZb7vk
	FiGzT9m0wxaQw9Yq6Vpn9THhsAaZnBxkS43MFA2hqsbW+n0Ri+ojzPQOKDILzzhP
	474tX/AZztr6UGYNcFnmuKFK/hKBn6XV/CqLMgZgG2oswRkw0zlchhrxZFKPIihv
	PBaqkzVUQSjJe/Q3D6cTwrRC88OPOytzqKbeg+rBWJ06mDMm+RhxxLjh27/7nhOF
	+X5GK5luwYrkpBaGAeLNZYtrXvOJvFUbOIa+/Hpfj4J2Ayio0ZtAWA81JI/zZuN4
	ML5Tyg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsvc6n4ey-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 09 Nov 2026 07:10:10 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-36cec75d8caso765084eec.0
        for <linux-spi@vger.kernel.org>; Sun, 08 Nov 2026 23:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794208210; x=1794813010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=np7bEj6m0lRUiyUr1l1RlC0cc90sTu683s4JN4gPYMU=;
        b=gGIcPeD4+YT3mxAvVzH1WR+UR1gtJZuBkSGwlwYkIn1tZWNt4bC0+wZz3bh7znik4T
         chdgs/bvEkwBPwZU0aXP6DhDSYXIB5L0sCot7XcJCLmmMLimhMV5vxU6c8h9xcZ8xX4M
         Ne4n1BAr7oQ/zJQ1GEo2hX81UhyLaPUpTlUo7HHuXOG2rz197sDc62kSymZYA0NarDf8
         qspTrBIMl50tbJ3U7cPvm4lWhb/JRMCn1DvWw9evQAzLWX4D1HnuHLOUxNasdvOrDZYg
         sQ8znDHAghb2Up2ktRT6wzti+puqNXXo2VrIm1KD3KPifVvsDW6j4dNhVzgTR31vQgQS
         /72A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794208210; x=1794813010;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=np7bEj6m0lRUiyUr1l1RlC0cc90sTu683s4JN4gPYMU=;
        b=vJoCv/VcKlmGtok/zRiGL77eXY1wg7ifdhsQv37Z9JBRy1QTyHYsmS95KnNXKBf+fp
         hswJ8McXvjE9AVgBP3Vntjs51+0fwN+qv9em+YWDPWL2FpBRb8Dxog9w5WMeichbkmL6
         zL/rWmagrZzCQeO2/MH7iW9D6ei51yiO7A8zrEfOj2a3xruXJqg8LT+ySwwId5wXAK5E
         YXqGho9JRloU/bkjuI73VwgCokRNhlp8jOdYwmnLvLSmTcXodt1dmvqT/iQ3XOL/GLbM
         a9pChDawX8BwUR2BbQyiq+QpVFfgpH/boxrGHeMR/c1/sOFvEXza9YkTm/lrct9TKE3G
         mvXg==
X-Forwarded-Encrypted: i=1; AL+hErFVm/1njSZ5ILzi4LlzSW61DLey9zxbufKOYxcIeirR7TaKsbvVT2BCdUgImwunsGqDR4UW7yBUYlM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+nUOyAuHMLqyv0MGaXvJTSDRmvEtpm8xx2A21W3w5rx7pxI6p+
	3v7ZLyXP0VFXH1tt4kPXIPlzUnq14a8QJwx8exuhGx8fpHkNASLU0u4LW6aUMotFCTzSwvpYa1u
	uQOOYEyy4ju7LqzhkmF1Le1mpLnYRQmfqB/J0H0f+NSAx6oTpfbT9dBnqtsHYNWg=
X-Gm-Gg: AYBFou3seo7poBmcwx7ApyZcrBrwsYQkrb01TfqwYz6RRKipqej5PqZKQ+mwJ/Xpv6F
	5Mvu5Kafxghiy0ha6Srtl6P7OcN496ktIRVFVfwZCd77Wqa5cRDrsy6ApCCUZhi5V5wtP6QAOOq
	oPRZLuCDPWr7X8e5xp09EB8sPRsDdcVc6oHZJj+em0ZiOZb2Fw4FB7UZR6caikZdEOm8Cy4ps9d
	7esujsMB0Uuai8GqTP7lZPMcn2doR4j65w8OU8XbeFGoNb5Y/okW03b1xYTxcTjvHu5iqNuFHki
	kGzHtpE8AsRCyRxDcxxvvA5QtsaZLvlA5WKH6LpJga7ylfoKGkX5gWHzVRCfTbYbvXCjuWNtnt6
	fxNd73FhB04ZrtHAEKY163mipFEbtz8C9lf13/hN4IVQ9j8OKrtd55olZNdm3ci9b4ognHuJ5I3
	xD9w==
X-Received: by 2002:a05:7301:4b0d:b0:36d:bcd7:2347 with SMTP id 5a478bee46e88-370f6115d79mr10704002eec.4.1794208209554;
        Sun, 08 Nov 2026 23:10:09 -0800 (PST)
X-Received: by 2002:a05:7301:4b0d:b0:36d:bcd7:2347 with SMTP id 5a478bee46e88-370f6115d79mr10703958eec.4.1794208208772;
        Sun, 08 Nov 2026 23:10:08 -0800 (PST)
Received: from [10.218.50.86] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372660f385bsm11423638eec.20.2026.11.08.23.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Nov 2026 23:10:08 -0800 (PST)
Message-ID: <20300428-94fb-4ae1-8096-e6851f5483a1@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 12:40:02 +0530
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
Subject: Re: [PATCH 0/6] spi: qcom-geni: Add QSPI support over GPI DMA
To: Mark Brown <broonie@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
References: <20261106-qspi_upstream_series-v1-0-21f43042dd60@oss.qualcomm.com>
 <179415109036.3711751.6859082995940422062.b4-review@b4>
Content-Language: en-US
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
In-Reply-To: <179415109036.3711751.6859082995940422062.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAyOCBTYWx0ZWRfX4g2bRlCjrSwI
 sd6VocNiRInGFIMGUL/vZ3QwKe0njATegw+swBIPS8khWOpF9GuuUjksqHqdAKC+rIpT/zDnVTU
 NZnrAPavyx4Q75LKns4Fw9e40P1yPoFHO7XsykWuZO2s4IYoMRQNs3MwJ4TZPPDJdYDyzvoSjEI
 OKONAARP3KwGLa6ts1U32ond7jkJ2J/+iCT53wSwC6Q9BSMD/w4kNBQMkQPSap3bAVZ0I6GeSV1
 7dS53pYDDO01cKGudRokXGzgRXR3yD0SbXV5jZhHpS7eeZVE22n58ZhZaegv0IGtbc0DsX2awyc
 vXt9RtGjSAAfBJSEMugF4eRrBl8gGVvIp2Akum27owYqaTXk58bJrrb7JXANXhZtkkAS0MRs6KT
 CYp/8NiAYsxpA5DV1lJyplXIH+oeyc5EHIFKx5Hd9RoArUEW7qg/ppDkMDgri7XBqLh2/zvSIme
 8AveEdjhAu66DwiglyA==
X-Authority-Analysis: v=2.4 cv=WOjqzXsR c=1 sm=1 tr=0 ts=6af171d2 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=r2-LxIRbSL4R5ck5jzsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAyOCBTYWx0ZWRfX4FxZMGASBnoO
 eKcXfUeyEbjhYuI3MeGcIVRnm1VqVCzu06pTKMxgrSCsFuH6uB5Y8geH8not70mI6sdlg5F6Jow
 JE2vOEbhbrXvJUSaOzlb+CP/UcDJGQ0=
X-Proofpoint-ORIG-GUID: xROZTPH1uN2bGwm09hWP7jsyY17NAMtf
X-Proofpoint-GUID: xROZTPH1uN2bGwm09hWP7jsyY17NAMtf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090028



On 11/8/2026 8:48 PM, Mark Brown wrote:
>> This series adds QSPI support to the Qualcomm GENI SPI driver using
>> GPI DMA. It supports single, dual and quad SDR transfers in controller
>> mode.
> 
> This doesn't apply against current code, please check and resend.
Hi Mark,
Thanks for pointing this out. The series was based on a slightly older 
linux-next snapshot. I’ll rebase it onto the current SPI for next 
branch, check for any missing dependencies, and resend the series as v2.

Thanks,
JyothiKumar>
>> ---
>> base-commit: 7079a12d7506b07fb53b54a664bfad5fa9b16d70
>> change-id: 20261021-qspi_upstream_series-850249e432f5
> 
> That's a random -next commit...
> 

