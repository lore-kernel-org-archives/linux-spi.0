Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368750;
	b=0qO8EBpt2DwCy5xsaXsKunANfStuFf67hTx0U/r9SUtUaStqwX0I0wIAZW7JpJjIT7L8
	 uivhd2en9Nawr9uz2K8R/yUdEHq4QgaAXfW7PcdeKj/9oyObfzmUqJh1Y+kV3DKCapMvA
	 y8V+Q5uFvu9dECb64HUhRC65OPawcfHgy0Fr/YwWglXOF+F9uiKV0EiYx98gCpP0iwauU
	 XDiCjnHCyp/reGxXvY4q/Agl2zebCfsG56MHcuQ6XTzeHl09F1avBlgITHRKKAmiOdIeg
	 G3WsQld0hLL/FLgOgckKTMxF7kFFdaYCzAyc8MhYGNRpwIQvTbTWtRZOCSykjuVZmQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368750;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=LTlv+L2o+ahLzJI1GsFG74mV78r8zqw3baE9fGpkQVY=;
	b=DtyHMxu/e4xV9Rg5m1VyPC0Fe5q8Ehw/9P+yEuutTox958pufOD+VH+e1HSieWc5qn4h
	 euuSyH54SOFS1bgKvWjiUspd9Q/lKiFg0XLirlCBwwxy2+0diJhD8vY0fuTe1+ZE/j/tO
	 jEE2WLjHfkdnDFBYOM6sprUwaco+6SPTHEOtmm4650p0g4vx23PetMoGQcrtBAybCbSbI
	 H5M7O8RVCVAEwPC9HfpM94joPGIcn/PyHlSNMgL6U9VwAQNqWHn/wPxQ6nbKvDTbLrUve
	 tyNsB+WxgA41J30UKqEo0DF9VTVkpcjjHZK2an+zmVFMgGkyMJc8YSjw+n93zD9Jiaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HlDwZ3KO;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FncZsuYW;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E908606A333
	for <linux-spi@vger.kernel.org>; Fri, 30 Oct 2026 13:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E908606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HlDwZ3KO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FncZsuYW
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UDn7wT2409226
	for <linux-spi@vger.kernel.org>; Fri, 30 Oct 2026 13:59:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LTlv+L2o+ahLzJI1GsFG74mV78r8zqw3baE9fGpkQVY=; b=HlDwZ3KOkdTPzGNO
	jok7HtwaaL/VhEXI9VX8+t7EhGByaWgNGAuCqjl+1NxLxFDkuFO8J21qU2p9IrMW
	8fhX5vy2CjE7hT6y4AJ5VEKcgBNA4RDbOfBB9jblPgbxke38E1l+PQUMNKMASf1w
	Fl42YIk72iNoDVOGX96ktdJYeE5EN2dGgDQNkYNzenOeFq/fQ6SBW5kkNJsI1Wuv
	DibsI6lI4aL7QYdIeKqrYEIxVF8KVBnz+JpR0n0nBlUfIXBs5WdNTVWr7T7XkS3Q
	UFFLOAkmVnPPLR4/ruKUX6OPqfC+aANWOGUI9vh32PZ1rqDPX8bHIwlOoOZFibk1
	r2LUhA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6p3d3w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 30 Oct 2026 13:59:08 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a05c820ecbso975293b3a.0
        for <linux-spi@vger.kernel.org>; Fri, 30 Oct 2026 06:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793368744; x=1793973544; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LTlv+L2o+ahLzJI1GsFG74mV78r8zqw3baE9fGpkQVY=;
        b=FncZsuYWmaEcChOpkMxfqC88o8kfaTx+Eng5k/s/DvDJJWPOkBLO+1J5Z7HnnV5yDH
         Rz0dkZZN1uzmeEbVaP5cbyLwYrcQrOT3obqxpk8xYjWbkXR72bhs1ML2S6Oj9ImWl3By
         V/JpChRYPTOjWGgDu4noF05akraS4YoaawZcWFwzCpMrcdBORw19vWoCkQBc9WqjAqRE
         iXQw2Mdzt6U2EE3EGt1pRbtq9tmZmhFW3Rx86ccWgPldlBn4bn+4JmlCm4JhhiAbs6ft
         K7HUN/tgMztzB6CxCUPDBFW3I583NwEBcX5k2WktHixu17KsSNJrni6J2/Ctzt3HfkSD
         O62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793368744; x=1793973544;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LTlv+L2o+ahLzJI1GsFG74mV78r8zqw3baE9fGpkQVY=;
        b=Oa3AyDGYRqr/14Dxsa+bS5LtnTGznxN77rnp5/C+zlDZ2sOitEbJHbZrVe1PfJ5MWM
         mkqmqsLIxdlWT+EiW5d+MtJz28NtdieC9tVmhQMFvOB6HhD7KAVU3wuYgEkDajsiIisA
         kZZ5M5lB13EcW3MVTB/x42chn4+XgMvf8Mzl2M+7uZiqZoolc71cB7NxNykWatyyZ4OO
         9gBibViyFtZ/SIpMyalP70TqsfSl5X5ncKSBSk3EKhWECIU4BXQj7APFnniEVa7/63LB
         Gc5IEk130BkSMC1/J2DenUs91oitB0WcN5Neeq49tLUQMePoop6VwpkhK+57eTYPM/9v
         UXZA==
X-Forwarded-Encrypted: i=1; AKwUvByTrpG8hl4e1PEmV7A5B3xHG0xNCdRZCGqBCvoh/bJHoVJ095yE9I1cjlcKjAAvM1Zy2HOAw9JEO0o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5Zhv4yHHDWTwQ1M5Kw8c/V6Vd0uupv0FOGpIfRv0pYnhn5Dao
	th/GbC0zZ9BzB6BcNX1APdoZW3EcogAEsS9kABA7tipQVPTXJa4PSSPfH4KOA6t12/D6uL59ECE
	gdHYKGBQax/rrZBrdG1fS6B/SdrDf4O3FhAznqofSwFoQlayeLVg/8Nk1hY9++0I=
X-Gm-Gg: AYBFou0ETgVvraf8s4tWZv8ij+qsSywNhKSA6VZIdcYIk/D7Iw+dTrhJbIM07iKwVN9
	8NsQKIlXFtUCvFFpNFYPIzuEkC16qcfJUZdVt5/QrrhRrqy44CPVgMytUOK0IZXoS68ZoqI50pj
	RmEMXU/MGLz6NfEl8/E5J+Ye5wM3yAYc4HKP1md6SqxsE55o6jZc9z9QntO0RCmF6Iae02ADX89
	AHurBnArfnLpvA94YV2rTWbTENSQ0ds3tAOcpVfoKHAtIQ8uqA5/kvg991V17UEwMMp4vNrd5lN
	hPvlZ/cBS4TXD96bdAI8WVSCfGiLi3iH7L9RgIfnEER6NI/dGQ5Z0gXjdtn5fGImfBHlbWstwfU
	WsUz+RSAnVBH4/Xu/FEKJ/igljn09GB4CZnmuHjS9VIzlZXH7M2TtOS1bb8q7gCUMMlGPY7IYiC
	qUZ+4=
X-Received: by 2002:a05:6a00:1783:b0:89e:37b1:b81e with SMTP id d2e1a72fcca58-8a9bea5c399mr2307953b3a.31.1793368744454;
        Fri, 30 Oct 2026 06:59:04 -0700 (PDT)
X-Received: by 2002:a05:6a00:1783:b0:89e:37b1:b81e with SMTP id d2e1a72fcca58-8a9bea5c399mr2307921b3a.31.1793368743970;
        Fri, 30 Oct 2026 06:59:03 -0700 (PDT)
Received: from [10.218.50.86] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad7801a53sm12882b3a.2.2026.10.30.06.59.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 06:59:03 -0700 (PDT)
Message-ID: <53640a9c-395f-4faf-bbac-20c47013cec4@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 19:28:57 +0530
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
Subject: Re: [PATCH] dt-bindings: spi: qcom,spi-geni-qcom: Document QSPI
 support
To: Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261030-qspi_dt_binding-v1-1-5249111cf870@oss.qualcomm.com>
 <f71369ca-5963-41c7-9103-dd39a7369e38@kernel.org>
Content-Language: en-US
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
In-Reply-To: <f71369ca-5963-41c7-9103-dd39a7369e38@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NCBTYWx0ZWRfX69oGSnQv2NQM
 5rWIlGUQkvul0iaUarZhFp1esCHnsbU3nwdtCngkbH2+Z7Z07kUAmXVZnnRzBMepLukDrHPqet3
 O3SjKl8jz/bIq7dIy+2j9y/r9Gqfr/32uXoMWtjEI2B6nmImOIw4fA/kv4N4leVxUYlNcJYsvZZ
 97fjX6OTKnfxRh+d+OgQ+I1ze0XDX4LimmHOuPND+UQ00StOBIKPZn1Uue7tmGx0GORLu/gPBgj
 alGzRNGPekJTMkViaVBxxY6EzcmycJBzC24RusfCk6LQDFbhuvUEqiFmqQM/Hua4P784AwThU0V
 Sy/hm/EpQL+9zIQvJSc5ZlGxQ7sLJxJgIHWua+UilO3PUro+PHvfT4WT3ICUgsnvqbF+Q4fsBpy
 4gawdixDP8nbcXqSwHHAfbUHaiiUTOKoqsCQBGizATInI6yGFMPoEW7mzwsmv5cYcIwUAuJrS1F
 BISG1lS6N5/JXqURYrA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NCBTYWx0ZWRfX+t4xecoXQpLH
 OBtCu72DYPzpXb17gDFHbe8tWR8tISHpP/b0HoKZ6SbM1plsC1TG8J2VCWtETlsXCelgtRLJY8Z
 WpfeRt6HuufckbHUYKGVf3PhTGp/TF8=
X-Proofpoint-ORIG-GUID: P-0sfHRoOZu9oJ1hmzDNbo6AimsAW2ND
X-Proofpoint-GUID: P-0sfHRoOZu9oJ1hmzDNbo6AimsAW2ND
X-Authority-Analysis: v=2.4 cv=TL3Q2Fla c=1 sm=1 tr=0 ts=6ae4a2ac cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=O4LJdId_ek-TerMgtbYA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300054



On 10/30/2026 7:06 PM, Krzysztof Kozlowski wrote:
> On 30/10/2026 14:30, Jyothi Kumar Seerapu wrote:
>> Add the "qcom,geni-qspi" compatible to identify GENI Serial Engine
>> instances configured for QSPI operation.
>>
>> The compatible also allows the driver to select the appropriate protocol
>> firmware when the Serial Engine is unconfigured (GENI_SE_INVALID_PROTO),
>> distinguishing between SPI and QSPI firmware.
>>
>> Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
> 
> Where is any user of this? You speak about driver, but there is no driver.
> 
Thanks for the review. This patch only adds the QSPI binding change. The 
corresponding driver changes to add QSPI support will be submitted in an 
upcoming separate patch.
  > Best regards,
> Krzysztof

