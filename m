Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20F937F00B
	for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2026 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782378397; cv=none; b=RQYfvdhPMtWyopLVM+WZiO16kMmQ5JSFRYwqI9I/fu1ap8Oxkn2J6IO52ODzs384hyCodjpSfhU7alIkH730W82UZTCh5dvleN17/hsKD+kuz8nbX20kINekB4UIXsvGPtzsih4MwZXHsTlbE/9H84aO4xvxM/ngbqMHU8RlJ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782378397; c=relaxed/simple;
	bh=pp9eaPjv9rnptr1WI20Uc/j6CcRHM7bBBfaRB0Z2w1Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qn0NXGIZHU8Vqe5ublS2FevVjyHk3wRJ1o4E6zpfSfmsOrMXX4M8bmChXsfhE26Fa2JmFkFwlFJNu3tyei3EbDyGq8GyHJZb+/OTYwAkEx01sTiYa75kljFlwH8+ItOyckQsCY5p6n5N4ENHoVwSt2XTfaA78A5jDpKFxrOIn3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VHSS0zPK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M1b5kJyh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VHSS0zPK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M1b5kJyh"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65P8pbpV1345906
	for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2026 09:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yoIbfyB4RGrkSHBFMdH6jDJeDEis0v3MRca0wSXz5S4=; b=VHSS0zPKAZ5zHAO7
	ZIgPyJNV9RROWn6xI9xkYojFGHCr+CYAvDwq3DwDbnE6mzB4K3fnJpdJsjPx30f5
	Mm7ne3afzR3iq3QzfVgc9LuZ6nAIqmGUTIM1NYlJ6lznQmy2SvAIx1KgLG1Pi2HR
	5cwj8dUH/l6z4FpBTCqrha/Q3eTTOQDkR1lF9gENtaQZryP09B/+5l5+kc3SsNnX
	GMIR1xlV7rD51ARgKtGnNfLYwYo0AEnG8dh+/Q8feKVEQFcnKhHgTb7P8wePJxUZ
	BhQQBQ16qH5bwsxFOWefyKZv5ofFN8waXO9m1hVTfFD0s66KFG8IPCoDSH6sfzww
	xG0BPg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0nv7jje8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2026 09:06:35 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8421f5d76aaso1548002b3a.2
        for <linux-spi@vger.kernel.org>; Thu, 25 Jun 2026 02:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782378395; x=1782983195; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yoIbfyB4RGrkSHBFMdH6jDJeDEis0v3MRca0wSXz5S4=;
        b=M1b5kJyhpRf6EX0DOudPriv2rO90mwPfBQEeCfXo/g466R3td9n+cx74kNCTqAJq6q
         JV7Q1EskNQkXvye3S6VFSSBKA7jux7//irkO3Upu4/MuGP8FTScDJeffdU5yBIjHU3Bl
         7vjmhfLt5n0fi4E4BlTdgwv+iB3CZTUwDSz7K4ALDttNuPVig78wBrXivUN0s9PRn7KL
         Ff2FET7fhNYNCwWY7PLO4u/1664Lfa4ZD2t26ErR5k7bAQBIJgp5RhzxnaKmbsuW49jx
         IcAfdVK/ggKxJYH0c7dRR/2oDmdZ3RA9dO8gn+UIF1KpJL1t7648c0fiCbFaZgYvhl/0
         rVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782378395; x=1782983195;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yoIbfyB4RGrkSHBFMdH6jDJeDEis0v3MRca0wSXz5S4=;
        b=I2davklZ9WRGJGFqtgPdI7eTtoziQxsBIfRiWM9etHYdqYBde/zk+6Ydmun07UDsbR
         GB76JdOs2RI8AfwnhAFXvvaHbkLK4/Hj5m/8wXBA6HikSaK05c4/beRKa/13L8X6bkEs
         8X6hrDtwPulVgOd3VZm9KI0IrbMmK+Xc6PdBgv8+fUIV0uaTuAmog+83giiDNH1ZuGGf
         GcqFEwq/feU9pLQDC9X5z6sv0XR/sBzB/I+Aa1GrX2F9Fx0ZqKm7YhTc1u+4rdjO7NDG
         dd/haon/P9WsbXtHW1bUtrjCYXlq7GXCRMRfICC5ST/+1aCkqImsJdjmKfV4EU36xShg
         oxww==
X-Forwarded-Encrypted: i=1; AHgh+Rq+4bC0QS3rpLLyAiFdThSB3v4uvsUqDmvrADsgjXYXQQrPPhuL/q9vxhCJjg0CW32idQnrJ3wOnEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHwvwA07p8LptBmtUFtIxluW3VNtn/eO75Dpxb8068G+YYZEs1
	y27HeF62lE0w+N9Q631OiLh2I6T2ZelfC+xi9JM5qRFwwdp7bADIlpEfvusgFzx1yEUGV2eCLw9
	bKVmk/SS8shZvB0DfLNIJl4xIatGq7d16ieE1bZOVMYtFLf0RtXx4hWagfySjqGs=
X-Gm-Gg: AfdE7cnpYHtkgLvBl43lSLCFw3van75nrAbWR+wkI4FndXwTDlw71tCxG1SwWchSKEp
	fBMaU1Qqnuaoe0vQAGS08pRHoWd2I+bo1a8Z1NDH9UzV4Ds3TtVimG8r+Gcyti/mFuuai6lAx2r
	ZtKfFK54WpXbaQn54JX2g1xhkcvXSswbDIUzjYbB3RvZqdwLhU787m1EBGtYJWoUy0Yve6SWYHn
	0lbN6JFBbnkwGNT1ELQ7rORL346FantdFIdvHlut4UbDs0kugYhERTp3e3s+i0vHpJdhSgqXPfU
	DzO+eN553bgiYGnpKMD0V0qPFvrBmU5yOlqOciUq+AssWULxpAcRKnSWL6/6aQ6g50q4KWiY/5c
	M7AZ+9r3uInHJJaZN8fJQpX80zTH/8RkJfF2rJ/b24ZDw
X-Received: by 2002:a05:6a00:744d:b0:845:b3ca:2cac with SMTP id d2e1a72fcca58-845b3ca316emr1705380b3a.2.1782378392071;
        Thu, 25 Jun 2026 02:06:32 -0700 (PDT)
X-Received: by 2002:a05:6a00:744d:b0:845:b3ca:2cac with SMTP id d2e1a72fcca58-845b3ca316emr1705352b3a.2.1782378391573;
        Thu, 25 Jun 2026 02:06:31 -0700 (PDT)
Received: from [10.217.219.87] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a40d1b0fsm4240804b3a.28.2026.06.25.02.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 02:06:30 -0700 (PDT)
Message-ID: <14491fd8-f785-4404-878b-5764bb8fd593@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 14:36:28 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] spi: qcom-geni: Add property to force GSI mode
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <3451facc-4a2e-43bf-ba13-944488bce437@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA3NyBTYWx0ZWRfX+gzMYK7bgdJz
 pG5GvDOtEP5TQUCkxw0M6SmJLah7MiQ3sqxs6Gmsd9t/3W7hWHbtteIlf01jxAxwQk28LJQopFR
 OaOuyOSpHEsBcfIN2t9oW61XZ7/WbVw=
X-Authority-Analysis: v=2.4 cv=RJiD2Yi+ c=1 sm=1 tr=0 ts=6a3cef9b cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=hIrod8inOkKnRalxuPoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: ipVHDbDp8SDFpjLm-SKcJ9gBr4tJ-EPM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA3NyBTYWx0ZWRfX532Q6z4vmnz7
 Eo4j+cdfMZMaZuwov/YCn0mkYxKAYuGJtyLsVmDCLIK3nOp8JXKGJ7kCyIEs2/Qp/PC7gKmpp7X
 Lc6F5LhFg7o8Gpf0wWm0zEDW8Okfnd3WjjbUmSr/hGy3txuACdFKs9FlvsXhs1cfYWccMIbz79T
 2FRlP42EBDD4jTCGqBg8m5Ee+oTTzoCLLEqKT+2xvrHJrnnztKw3AZYQoEZWz7OwPik/xCuzmjt
 IONJ5niY427TSPUh2xMmSMRMAR3AImtbC2A8Io0lCnItM61O5GRydG/owtnaJZ0g5Zm7IhuoQc1
 GRyckCNQTZZLbCIG69ezqg5PoBJAZlPDQU0BqHiQSdCZtIv4qRfLAIJ+rCC4ld+1kLFBPy4dbi6
 FyxYpt/TaV1bKFfKm1IdTU6b1+C+mxZR5jAVkKcE+LSD7P5clT6TNysU2eywqK1npzoNhD6JrER
 Jj0snPMDBPjP8adicTA==
X-Proofpoint-GUID: ipVHDbDp8SDFpjLm-SKcJ9gBr4tJ-EPM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250077

Hi Konrad, sorry for late response.

On 6/15/2026 5:12 PM, Konrad Dybcio wrote:
> On 6/15/26 6:25 AM, Pengyu Luo wrote:
>> On Mon, Jun 15, 2026 at 5:18 AM Dmitry Baryshkov
>> <dmitry.baryshkov@oss.qualcomm.com> wrote:
>>>
>>> On Sun, Jun 14, 2026 at 04:34:24PM +0800, Pengyu Luo wrote:
>>>> Some devices (such as gaokun3) do not disable FIFO mode, causing the
>>>> driver to fallback to FIFO mode by default. However, these platforms
>>>> also support GSI mode, which is highly preferred for certain
>>>> peripherals like SPI touchscreens to improve performance.
>>>>
>>>> Introduce the "qcom,force-gsi-mode" device property to hint and force
>>>> the controller into GSI mode during initialization.
>>>
>>> Ideally, this should be decided by the SPI controller based on the
>>> requirements. Another option would be to prefer GSI for all transfers if
>>> it is available, ignoring the FIFO even if it is not disabled.
>>>
>>
>> I have read reviews. Can we check if the compatible
>> "qcom,sm6350-gpi-dma" is in DT? If the gpi dma controller is
>> presented, then we enable GSI mode.
> 
> 
> This hunk is very odd:
> 
> /*
>   * in case of failure to get gpi dma channel, we can still do the
>   * FIFO mode, so fallthrough
>   */
> dev_warn(mas->dev, "FIFO mode disabled, but couldn't get DMA, fall back to FIFO mode\n");
> 
> In my understanding, GSI DMA mode is always preferable. +Mukesh, do
> you have any insights?
> 
GSI mode is preferable but if for some reason it fails, we try to 
continue with the FIFO mode. Just fallback mechanism.
> Konrad

