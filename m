Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4248F3F4830
	for <linux-spi@vger.kernel.org>; Thu,  6 Aug 2026 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786040611; cv=none; b=VU0PCeh6KkwErZO+Q7zTu9/vcGy/Y8kSjgBmfIR/Sfzgpgn4wvpVpTFvttYhrh0z3nUu2Aj8d16fFk/4GIKedEegb+lVngIr3ZbCPBDnJuhLrE7HJhXQ99xMa6WS+pJASVYt3FJVMoheVfLaeWq4NpSxa7jYBC5IvlAWDcrSTxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786040611; c=relaxed/simple;
	bh=b/Sr1hbeibbvfZDxkSEa3bvTdm/2wnt7RBMqE4Qxw0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=grC0pB6dLG/q3fm64ld2A4f51KmW46790zXQreJEIF+urdj6qtq+7HQHq22eaQcC7kITn9YCyMtKKZ2Rx8R5GbaRrCH5uY0pQPATV6bK+WGIcbnl4AAhQjBwKbat9rVyrIsbxE9lFF+jlIscFd3pNFd0ppga9nNKOQh0mEC4R6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WDBkwkiL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GK/hhE18; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WDBkwkiL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GK/hhE18"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676IHvdX2476493
	for <linux-spi@vger.kernel.org>; Thu, 6 Aug 2026 18:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PVxFjJI2FGL2wgYbVDpiXGdE/1kLH289ltHpjPDSqJc=; b=WDBkwkiLnKHKNJaf
	YOIyAHjtUnGyaxGTXJbXfpQy5ZniKzR70WqY8EddlAAYnzobHvMyIzXu+OMUsX9w
	L2Xap9vKAaeqLslinur+nLP7O9fJW1Qrx6j1JD1bURF/EEesLdQojRgGj+09HDyT
	0lwpdWk/kkoDYblu6z1QMGL6j6N5bfnn9e69FqUNROfAeCxdkGzbKgJN695Fbnf5
	4Nb1U3AKDSC28sQo6jC+EIkgrN3FMrZT12s3wG9OM+u/u4Wbx6EreFqpmNPVeDuZ
	N+cl89PilL/gZ0O/+eJO9U5fOGse6nSgUCHpeBjIF35Pc0aEUlRwXXQQt/Q7zqKJ
	YDBdNw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6k03fx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 06 Aug 2026 18:23:29 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84859a64079so4347487b3a.3
        for <linux-spi@vger.kernel.org>; Thu, 06 Aug 2026 11:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786040608; x=1786645408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PVxFjJI2FGL2wgYbVDpiXGdE/1kLH289ltHpjPDSqJc=;
        b=GK/hhE18aC45eqL6LSKfA7zHjQ3fm0sMP2HPzjv/Sn7k7d1zQxr7q/cJw9n+kL0lSY
         AHpen7S88tbr2Voe6VJDSofsHMeVHugb1lb68tlYhuSxHsV67GsOrCw2TO63Dj6b3aeO
         C+Zf25aM4pr68SrBMi5aovbMJGe6LxxzjsmyOqaY6h54fond/bBqQZD8Ljl6HlxOsWdI
         g6wdGCksD7LLyga3qOxOWvsO4Z0iCpE2B1no6omJP4ORaLloyDmywWM9sKfQNCZIl5/P
         468QH5+dJD4rQopo8awJ4c/bRUerz/cQxltm6gUR9FLDr+teIsL2s/bBOW6rlkIjHyoI
         sgjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786040608; x=1786645408;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PVxFjJI2FGL2wgYbVDpiXGdE/1kLH289ltHpjPDSqJc=;
        b=codb1uW+Uch3Uov1e1KKhyODIV0Z2U850Sav8vijbxB7NbXRX/eBBezynbGZTeJAXA
         y4nuIFZvmfdTN+j0yATLPBhdSNgZYKaupZveaQQXPOtjrgWh+is6GdU6B7qoWJmbGs75
         Yb5kUjUkQ53gPPJegiOlE734dJ9x/UxbFOGE/0lOYH+XGUmYKtC3c/wiuc261B8OI6TX
         F/rUtys6/QaP5/Yqvf9snZq2NKXbJtKu3ThXumZK9z9yiTd4L1hMjuWod1zpOIyComjv
         ZoFBA4civVVuxFrdR4fBr02Y8Mwco6gHb42V6w12JB9o1eW8ek7KwVBThHUI0GQ0dnnV
         08uA==
X-Forwarded-Encrypted: i=1; AHgh+RpYmWMxaI2vw327y8dxOWMlHeB0aUCiT7rZrvIX6eZlPJtuaQupfPx4aavn5b5N1iNZOE3e9qmTrH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw97IZnSxaXKMeyOydLa0l8g+Vo+Wejf+eHr42Uu3Lc+CL89fMt
	5WrJNNAq4Rf7Im6tS7Nj1YJldf0xIqjykyHJVSzlSFB2C2AO165zeN7WQ1EMIAM5wzX8a9SGAgn
	07K7H51LeZbXPDGKi1f1dI6dU0XXlT2JUDdsj52YdWIojMJumTwO6D1CfQv6K0PI=
X-Gm-Gg: AR+sD12UD97sIgS89r6K3sSSeWbS0rFmqY5oNdE76dC1a+6v+yb0PwNi715m5p2oykC
	eZ17QPXQbNoW3LKB3mbYK6iUvsYHbGXqrWZRiOzWC7+Vz4FE2a00MKIkFpZaId3Q48NBm2j0qup
	Dx7lCPBHq3hpWhbFv2Aj+BnEWSPiPHBhdz2JNUQrjxqHTe8/SnO+1KGsQh2ZUKatQyOCQJ5mW33
	0+RuVaDVYTdyNb+vPppQaTS/hfXS6Ff77LB1ylqe0Jy3jOsrHZ7l4p5fNe7tJUmINMRxEP2of5I
	/16WR2V2URTUA99mjA8ccDUPktM+1ujXQ/mbZL35F3eS3dgFIRM8+Wp9rq5Qf486wBNI4YH4Cio
	HmHxEqUgddiSSci6d5zW/TI/KO1KFxOYn
X-Received: by 2002:a05:6300:6d83:20b0:3cb:9a16:b159 with SMTP id adf61e73a8af0-3cb9a16b43fmr9174299637.6.1786040608038;
        Thu, 06 Aug 2026 11:23:28 -0700 (PDT)
X-Received: by 2002:a05:6300:6d83:20b0:3cb:9a16:b159 with SMTP id adf61e73a8af0-3cb9a16b43fmr9174233637.6.1786040607520;
        Thu, 06 Aug 2026 11:23:27 -0700 (PDT)
Received: from [192.168.0.7] ([49.204.111.196])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315863b0bfesm30664455eec.3.2026.08.06.11.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 11:23:27 -0700 (PDT)
Message-ID: <48a0f889-7cec-4f8d-9cb1-9196eac4d53b@oss.qualcomm.com>
Date: Thu, 6 Aug 2026 23:53:21 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: spi: qcom-geni: Document device-gpios
 property
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: chandana.chiluveru@oss.qualcomm.com,
        Krzysztof Kozlowski
 <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260806-use_gpio_to_notify_master_of_spi_target_activity-v1-0-c363a9b5df69@oss.qualcomm.com>
 <20260806-use_gpio_to_notify_master_of_spi_target_activity-v1-1-c363a9b5df69@oss.qualcomm.com>
 <8cbd912e-0f50-4fa9-b534-7ce1a3c77d88@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <8cbd912e-0f50-4fa9-b534-7ce1a3c77d88@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RpX16imK c=1 sm=1 tr=0 ts=6a74d121 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=7DW+zsgf7PPjz/i6iZMG3g==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=BarMzL54zy4tqfeHTiAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: qrvZjL9_8t5zdzIJw9rY1ny2EhbmNsIO
X-Proofpoint-GUID: qrvZjL9_8t5zdzIJw9rY1ny2EhbmNsIO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE0NCBTYWx0ZWRfX15DdivDeXLj4
 Fl/B5VQYcVBsRTF6CFon8FnXncghy8PMS1F2OZmuGUQTQiL206PBU/DhPFQ37ypNqEKfv8Mv3IL
 ix8X29YvYxV46oMJYAbUCmDBO31ZiUvJIZ1O2dtTl2/WZkJeDcu0ccy4j3RhJvIb8E29vDJu0DI
 SHM25QuW7IIXKrgmv3kxkT+yo8ynZF97Fj9Lb25XcLiM2D9WMdC9SKBwlssmbWZrvEFJ1Mg7aaO
 rxxqQiFaOOLokZRL8sIn8Y2HYvG1J1nk4cNgLdZCijB7qW8ZuAjN+I0iuEV0iOg4AY4Gq5QCe67
 8JmR6hEPTzpp02kVt4sSBB4wbezjc2AdxRtaSL2W4AWGrqZMNOuCL566aNvZ5vaeR7fi0aOZisY
 AJoMvcQBHWUXLL+Zh6efe5CRn5gwhrWANEynnDPRuXrAQQsK6rxkp1T8iEVksC4joC9TUTjhwj4
 VPvz/yL7XhsN6jYPBvQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE0NCBTYWx0ZWRfX0oBblYdeR4cA
 VzpP75AjI5CEVDlAAYCed87PAtjyBIOf/TBEhiumVJWiMKlo1flh518lf4HaelYSMwWW6qbYfNa
 piH516G73pjVoBZCE1ztpvKTsxELbmI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060144

Hi Mukesh,

On 06-08-2026 23:45, Mukesh Savaliya wrote:
>
>
> On 8/6/2026 3:43 PM, Praveen Talari wrote:
>> When operating in SPI target (slave) mode, the GENI SPI controller can
>> use an external GPIO to notify the SPI master about the target's
>> active state.
>>
>
> Is this active state meaning target is in ready state to communicate 
> with master controller ?
Yes, you are right.
>
> When will it set this gpio ? can you describe little ?
I have already described the behaviour in the driver change.
Is additional explanation required in the DT binding as well?
>
>> Document the optional device-gpios property for the qcom,spi-geni-qcom
> seems bit generic name, it should describe the signal purpose, not the 
> device. Something like handshake-gpios OR ready-gpios ?
As mark pointed, there is already ready-gpios so i use this.
>> and qcom,sa8255p-geni-spi bindings, restricted to spi-slave nodes.
>>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
>> Documentation/devicetree/bindings/spi/qcom,sa8255p-geni-spi.yaml | 9 
>> +++++++++
>> Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml | 9 
>> +++++++++
>>   2 files changed, 18 insertions(+)
>
> [...]
