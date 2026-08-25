Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C5441C2E4
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 13:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663556; cv=none; b=l1R+HlFej6iWEXkkpVVU8+OHjurl+ikKAm3H1rfci9kDD1PuhbTro5tcpK4JzUl1R91ttHtLuhXlnmRNmMmgl0cKYzPMpOPBRb7Leq3YmfIUBYLhoahoPXmiSGhV8N0zRAMy/XkHuBaQ+AakrSInNaOvjEAL2NLITkLicv63EUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663556; c=relaxed/simple;
	bh=5vSoQjlM+zxdMgIz8Dol2JEbHZmwoaaMs/VLIvAbY28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZzb9tZn5KBSTHTJJrY5NXgiFBCdNbUedCINltAasD5Byeku25Lbf0cyJeJUMBRR6AI8k3gZ2V0pQAhCn/En+OUGLe7Vyr0ZXGR+uVvrutu9nMCN7zLgH1/E5QfIT+Gw52JWZZ2CxQeLOIyxnodmycOi4IizvQm1ETJE1K3eI6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ih3upoVv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QPGiDw5W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ih3upoVv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QPGiDw5W"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67PAvAIe679674
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 13:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wEk50R8qPbR/0VyfuOs/yn87UGRyRMpG1iyvWD2oRYY=; b=ih3upoVvWO7rwhOt
	pW0zfvOZnbOJj1RV6iSkTKQ66LmQyRmQH+OMAlTk0/eFOGjcZUz2nmXOnZOojX1e
	gHGKUtr9u0PAngik3UhDSyFasPB+lhxzq5et+Cq4sqc2VckLqLmEaBnelrK/igW4
	MUKZq4PXWjIg+5e6ZXcCauLt0JlmFYvjX2e5lfTYGfu57/OCoR3RDIubf7OVxE9f
	ug+Xe0EFxF9jPU2dlRn2lX1CW6OHVwAVynVNtg9/Jphp0IbOzvLuUixsPX5fX7jO
	eWNy1Si71YX7hsJuRqgVfDcJpjEy9BnBOfRmXDk3iwBhKR9iaFzYZrOQXa7sLx9L
	vJnj/w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g93xxt0pa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 13:12:24 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-934963b2bc0so456819485a.3
        for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 06:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787663540; x=1788268340; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wEk50R8qPbR/0VyfuOs/yn87UGRyRMpG1iyvWD2oRYY=;
        b=QPGiDw5WID17iXBiB7qrWFPAsqvSLpnCL6PYEQSygC70Q+Dbn9dZF1eABD22thKibZ
         ClWRJi7OTPgSz6h8l0Y2H98rPiYu1M/GvVbPo96B6IouLo6QfgLzuDy/t3ETBeOm7etz
         aIPO8mrDavJSaOihe5KXsESvTNNWeS/WU3TeELsNmI/1VJbcGEDLFtSajw10WaLqCdp+
         bRXKoG2kVLSmVm6iJXPi9Okkh34rsZflhhxjTwDx057un9oZtxirSNrQ+BHC6W4Nj0d0
         apyEvxzZSGMlmB+LZE6z8ELGs1FNbUfQ5H9Ohkp1DpPs/h1LbCugC6inUmUzan7qt/M5
         jYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787663540; x=1788268340;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wEk50R8qPbR/0VyfuOs/yn87UGRyRMpG1iyvWD2oRYY=;
        b=tM7DibfZCLT54oXe4hRlwowappTgr0qu/CyHKc0UeMSAcr8JCas7zSR8EmNCm7i7+J
         5l13wNhMm/oFPgJBkomXieUoLYCUwbZ9ZmZg75ym/nny5IivfbFWlb00Kggh43Ebvmbu
         OVPFLw4TALQWkRBLU3XFkInS+e0sAMXoZB0+D3SFmOl4LT2kSWMMEpRqWYMDnZk8oEd1
         y4WVJBkeCiej3fRlEyAgp4NEA75+eaBxktrdo2/4XJs43UVGd0UufKlTKFfs7bVCvznd
         +4Wc4OZNMyRv3ZHggasiMObdE9IudQBqCOjCU70rYSQG2rI2FGYULBvBmXwE0RveEJnb
         2oiw==
X-Forwarded-Encrypted: i=1; AHgh+RqpkYAU99DqomdM0jPhlF4y0ucas4eK6A63r0EnhPMtYm6PQbHl/HdXPugO+Aei7ZL2+voFREWLotY=@vger.kernel.org
X-Gm-Message-State: AFuF++khETB3u354c/wmDGjh0CdbsRpdc3QK8VVUTjpe0sjlZwmMpek2
	+hFYeT0mPU9mxxowtB9dpTz/7vjBKzim2p317nYbDsZcdViV88KyJvyF0G0D0/YFuKzRrH/k97Z
	jJur3H7iv3EteO+iw4pi4e1MRrUPrSdeYxv975T7Kcle0P0+8Q5guBDr6hDpZ70Q=
X-Gm-Gg: AR+sD12rMGvJ3dj/sGisL89B6BFSrm8JdVCviUI7KeT3zXf4Rvwyszvw79xlKr+Faba
	i3gMEnKJairsfaRroCiOT0oET1TfF6tljGCawRBn2A3vpjuHTREL+6JcblDuwmZJ+YVzdERhH3f
	NPPAaFF2pYY7O2TOYouW7ZMM27OGBd3JstXEcjNCHg/7IW6lzt7v1W+SczErr9WpO3lkTbtkd/J
	caQXSieoYADYDN4F6iCp7+a0mF2dAVy2mzecXgqqOGxL2Ln/SCtK+P4J9TwvYeuy6L7amheulkH
	DLyaJ4s6pVzyU1/BAAoYuERjRVSrkAAa/N+L3lV+GS5ugNEuN+khRYUxAluOwgSS5GzhCR919A6
	UZ0yD5B1KqC6GwPepgwUW2VlhaFrABQ1B7U0=
X-Received: by 2002:a05:622a:e0c8:10b0:52e:a11:571e with SMTP id d75a77b69052e-52e0a1169f2mr162418881cf.11.1787663540319;
        Tue, 25 Aug 2026 06:12:20 -0700 (PDT)
X-Received: by 2002:a05:622a:e0c8:10b0:52e:a11:571e with SMTP id d75a77b69052e-52e0a1169f2mr162418021cf.11.1787663539783;
        Tue, 25 Aug 2026 06:12:19 -0700 (PDT)
Received: from [10.217.218.158] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9b69b7fsm11808333f8f.2.2026.08.25.06.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 06:12:15 -0700 (PDT)
Message-ID: <62ebdf78-85fd-4209-92fe-acda654a2e6f@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 18:42:09 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: qcom-geni: rename setup_fifo_params() to
 setup_spi_params() and make it void
To: Abel Vesa <abel.vesa@oss.qualcomm.com>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260824-spi-qcom-geni-cleanup-setup-fifo-params-v1-1-bdf98ae62953@oss.qualcomm.com>
 <8e4684d0-d130-4c75-8b28-11fd98fc4a29@oss.qualcomm.com>
 <lxif5gsyfq24aq3vsiing7xufwdmhllmn3gzdm4sqopz2ttele@myvffcz72jqq>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <lxif5gsyfq24aq3vsiing7xufwdmhllmn3gzdm4sqopz2ttele@myvffcz72jqq>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDExMiBTYWx0ZWRfX97UYV+s+SolS
 VQLV05Zf5+wobfKPa69+vWqo4PS/eA3ANMoFLMCONxOiGflS/apVBiJVRCV1pXVGXJ9uQwVmFgZ
 208XyvPabuWUxm+g3BRfDIAV631qjGY=
X-Authority-Analysis: v=2.4 cv=EOg2FVZC c=1 sm=1 tr=0 ts=6a8d94b8 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=O7rPFSPfsRJ4j1pAWDsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: nVxgXQdCCy5Xl8uCWVoFI3W35UOg3hrB
X-Proofpoint-ORIG-GUID: nVxgXQdCCy5Xl8uCWVoFI3W35UOg3hrB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDExMiBTYWx0ZWRfX7PCGxH9Agswa
 8jOu0zmfTqDsFXjNnMaoHYPfNNo5SboTvK9Oh8/ZiHXSrQ8KBT2fKvoWvmVB3z3Bdr4DMXVJtN7
 fNn7TIXBCmX9t8rIqhazLFRhzlohL1xeepdZfCbW3fg31O8PqqaujfJZccUPpOLkBVjkox7fxs1
 LqIIKaIPPww4b283D/eMskPzKopb8MPvYO7napihfKNtNLezJ2PRtWCjkhC5S28XSRN8aC4IVuf
 kjiVIXfgi0jzJCcYpxRxOS7OpD4eAKyxxoYmtJO9O5uL7W5ttU2F0SmR4X/H3MjtH196nXmsh33
 BclO59uy0voJbiEfCHNo1woZn89EI42nFLITRyd2M7qcKx+q2ihr9EAxhd1/BSTJ+YLPXJyviNQ
 AY4ru7q95GFaWZfJK88CX0q6+ZjuGLl1JO0VTTqfH3dkygB8qy32YBRBso7Ur/fQvfBQr2+xVFE
 1FNtvdCEC0XAVL2TymQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250112



On 8/25/2026 3:39 PM, Abel Vesa wrote:
> On 26-08-25 14:01:10, Mukesh Savaliya wrote:
>>
>>
>> On 8/24/2026 3:43 PM, Viken Dadhaniya wrote:
>>> The function always returned 0 and had no error paths, so change its
>>> return type to void. Drop the now-dead ret variable and error check
>>> in spi_geni_prepare_message().
>>>
>>> setup_fifo_params() is called for both GENI_SE_FIFO and GENI_SE_DMA
>>> modes, so the "fifo" in the name is misleading. Rename it to
>>> setup_spi_params() to better reflect its purpose of configuring SPI
>>> mode parameters (CS, CPHA, CPOL, loopback, LSB-first).
>>>
>>> No functional change.
>>>
>>> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
>>> ---Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
> 
> FYI, there is a chance these might not be picked up by b4, when
> applying.
> 
> Make sure when you reply with tags, they are actually part of the new
> message.

Thanks Abel for pointing this ! i realized line got mixed.
