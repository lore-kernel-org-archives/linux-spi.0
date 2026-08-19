Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E5B4078E2
	for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 18:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787165225; cv=none; b=RZMntlOtON7OMvhrLMyrr3SHrosEjiIj+pwath0UyxOfrBtoS90b5NkPwnBWvmIuzJUpfx06JEhLmTPET35lmT4ESzwBFOVXp5EqE1td8C6V49EWQyJXhn5DGT8cY0od0BGLza5hKi9zwN0Qy4tKvkPmIAI9pL0jYN91gefenus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787165225; c=relaxed/simple;
	bh=pVSU6gHUpkTMnxWNpZUmMtCp2mdCd6zb30kwIPKQQzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UAB7G8ND3zkbWk6roIqHb/WtP1wQjlK2ly2Feki1zYgziCUSbWXN76WbTg2GXcjEh9IUoB7mATaf+Gh3EnECLN7AFaZfwjiLLr/T7Hj9/QUKYg0s0bF73TF5YzJehBjTZ7cdPCS9mlhvTz2MC83zHlirmC9g9GUcqNI98eqLRNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n70I7o8U; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dypJNx6X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n70I7o8U";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dypJNx6X"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JHpn2G2061998
	for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 18:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6Yc/Yaq/1tNvDQT+aiXe5wGFwh7/kV4QkVEEgF1RaT4=; b=n70I7o8UQD5AnaJa
	W1Z7vz3BbmerZRR4gLtKA2zGdLBfHavc12wstK2qv0i6dmBU3GROF12/HaCZYZIJ
	bGmykFQJKHj6j0yHYFVXyAb8OWWtQU+91ZS5sdZGRriTVCe/qr/KNUlr2yZqGJU2
	AOdu9ug27otBy8pvEny9AagZysY44794HBENF0l7YQ0FTsa3aZ/RpqceqrbM2u7v
	L1sxCgvCc/ETkokknIvyoKO08Sq80F46QCcx/WD27z5C8LQAkS9S/F4m0ZaH7Vhv
	QZ0D0+thkjNbOrRU4PS5UwdWZ76IuR4V0r/9KSTk4NB7l7maCNp9nz+nRO9oIHwR
	is1vcw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5e83sb28-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 18:47:03 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc86a9ef97so24772425ad.3
        for <linux-spi@vger.kernel.org>; Wed, 19 Aug 2026 11:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787165223; x=1787770023; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Yc/Yaq/1tNvDQT+aiXe5wGFwh7/kV4QkVEEgF1RaT4=;
        b=dypJNx6XNyDHGM8wBDSyh6PQ7b32KL4fJxD05YtnuXRcw2jp+jbgY5RKSRjaSqdXvZ
         xL/u9fa60dpruSIW+PerMx+9K80vexRzPj+rwEc4ufZd+3kvZQUp3nKck/ScM6N+6CGQ
         SrSI43SwsfbrAXvpjUMFzc+xl70wJLKa5cZzD/fJk0581TtFKAK66JAxCMh6+emSOXgz
         xI/miYEicMrnlF+h4C2rbcGvdlelvDjurb21rBTAQAIJnuFx/YdK6g9+ufAk+VUYsz0V
         VSsAR8Y83ZectEXfGsAlBgTGXUQOnsB3cVdGqPpx+LwZuNMplLgCkQLGsrmPFf7j2K0E
         kmnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787165223; x=1787770023;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Yc/Yaq/1tNvDQT+aiXe5wGFwh7/kV4QkVEEgF1RaT4=;
        b=pGgNlgn8lf2CKehUVMx3vr8GHyPo1FkAR/S4O2dAEAS8OnTwui+QhGBk0KRYZVJRM0
         N64KBkH75LLBRYhwj45dCeiVKSoq8V0y+mBc4k0CWoxOOYWdGy6q6EN8kCs7EUEvQnjW
         upFZuhgsgCjx41RdgKAkofBAGx816AMXFL+4Yz4MzGtZiIzG45xnSOp9FcNw8Zh4G0yn
         9IWCA5iashzSBWjxBXGC+n4QRyz0nzyqZzxisT6qb5BZfEfdsIFrtGVD4yS168evp7Sn
         eilPn+qesrC+5rXK8B8psv/jK4rhQBWA3Om3FauCs4oC5wb9mXIVIPj6L1waK4DtZHFv
         0mAA==
X-Forwarded-Encrypted: i=1; AHgh+RpZCbZPgZoB5v+oZ6ikD8xdZd39dVs2CEYqBR7wCILI3xR0+XnIDQr+2xOJOJwQBH1ROAVZlnOZ6Nk=@vger.kernel.org
X-Gm-Message-State: AFuF++koLX2izcGD+vAoFAQRMZG4hZiNCWoj2DC2+QyJpIGLnffku17c
	+0OImcELFXf4gVgyTURsFBNO5uaysPzudi/q4kJrqEbqq9EglS3mbwtA1dKq8dQyIrtEcWop0UX
	zBSZfC4yxNvCprWrWveqyWVh54s87/Ftb1Vv00qCRusx4KODRWIKG+Y+/6BG/uM4=
X-Gm-Gg: AR+sD12Do2+qL0VN5yY+SI5khcsaJXaFoPzIz1CDfAAeYCGQzhqjjj6r2FldDvFHwWg
	bgq469RXcWUI/rNmNH7EkV3xW7I8tKT/RLTQxCLRTedau73l0CiW1tCAX5p/3HTAPUvbrZLZhl9
	n7+PlLunZq761EthacoWyE83QPYMN00Mh7iREzFdkvbYGuIBIchYcZ1N5jPz8p8WhwVRGLO9nVg
	sxuFjcyv0NOx5A/OgW+5KgDC49Wp2BaDuSKu1CFx34yAvoaCyv4mNkiCd04wS8RNqvvKOkmByYn
	PStYuMegNOVuY1z/5neSCGEgbLWInJOcYuTrf/fa+fhLRD22DvDRm5ENSsC/z+L91yYSNjhDSo8
	5ybtCdpACpfNw0fz64KLoYobiCxWxD5VMPQA=
X-Received: by 2002:a17:903:b83:b0:2ca:e5c:7fcf with SMTP id d9443c01a7336-2d5fd5eaca9mr129476655ad.3.1787165222733;
        Wed, 19 Aug 2026 11:47:02 -0700 (PDT)
X-Received: by 2002:a17:903:b83:b0:2ca:e5c:7fcf with SMTP id d9443c01a7336-2d5fd5eaca9mr129476035ad.3.1787165222348;
        Wed, 19 Aug 2026 11:47:02 -0700 (PDT)
Received: from [192.168.1.5] ([106.222.232.233])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bf173b02sm9094410eec.27.2026.08.19.11.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 11:47:01 -0700 (PDT)
Message-ID: <d85712aa-4296-4890-9db5-143a004d6eec@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 00:16:57 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] spi: qcom-geni: Add shutdown callback to quiesce
 hardware on reboot
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        konrad.dybcio@oss.qualcomm.com, Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, chandana.chiluveru@oss.qualcomm.com
References: <20260818-add-shutdown-and-panic-notifier-for-spi-v3-0-8b62c4bc2d21@oss.qualcomm.com>
 <20260818-add-shutdown-and-panic-notifier-for-spi-v3-1-8b62c4bc2d21@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260818-add-shutdown-and-panic-notifier-for-spi-v3-1-8b62c4bc2d21@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDE0NSBTYWx0ZWRfX94ncnd6BwPJA
 PWaGGq+B+VEVadk3Kmj5LZlREeW5yUWK7gUEERYrXSnaFWWehEAUIhJO4R1CMtnmzjMMbgZzYHU
 wkbSnFZMNzCQWQ3vHUe2c40kkkDZCOs=
X-Proofpoint-GUID: 9JMosOJL4bJIb-uv0QOPkyUKaEUl6qAU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDE0NSBTYWx0ZWRfXxbLyf62zAjzR
 opV3J1WBdjMqwfcXGr1wpLcmfwZ4T5YFG4KU4odYAdnF39TNTGIqf2NBTEk9xY3VIsh/iiFk9lB
 LeKwBL6YhAzXMiTvnoC3bc7O4g8Vluc9U/3l/aSUELNIoB8nGUVvVAkJnXl1gk3AiHec3y2RVCH
 614k2qJg3K+pK4V9zSf0EF438gWNMvJsFTrBIMM+EHd1dmKNLKyS4qShuph5c4b/Oirf3y/VJsb
 C2M07WXtfjf8BiaXeTFQIQtcsKrolyK+hQM6+fnAyXVqoNlu2DCsUj8pNyFVGfNIqXN/ipVbMyc
 45D7zACiILBxxzxlpa3Q5VRDXLwlIJ/4XvkJvlWGTn3lDxPoeOoG4IYyz0E7RjbKM6a5aWnggtv
 rc9Vtg1gLm1r2/+4j+tRy1wHm79OrE5zWS+rq3Xh0nYF8UNAmpZ0Kc5jNoFxBwfq+2QWKjLE5Wn
 IqvGcB5c9KegMD8Fa5A==
X-Authority-Analysis: v=2.4 cv=cvmrVV4i c=1 sm=1 tr=0 ts=6a85fa27 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=5XCNgjhq8C3qGxAi4A93cA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=ay6fHbYERNCo5qgovOYA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: 9JMosOJL4bJIb-uv0QOPkyUKaEUl6qAU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_05,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190145



On 8/18/2026 6:58 PM, Praveen Talari wrote:
> During system reboot, an active SPI transfer can leave the GENI Serial
> Engine in an indeterminate state. On VM-based platforms, if a DMA
> transfer is in progress when the VM is shut down, the SMMU can raise
> context faults as the DMA engine continues to access IOVAs that have
> already been invalidated during VM teardown.
> 
> Add a shutdown callback to suspend the SPI controller and abort any
> in-progress transfer, ensuring the DMA engine is idle and all IOVA
> mappings are retired before the system resets.
> 
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
