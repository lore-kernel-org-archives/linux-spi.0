Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0DA3148B6
	for <linux-spi@vger.kernel.org>; Wed, 28 Jan 2026 16:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769617708; cv=none; b=S8yomAcZdue38VmqiT9wdoH50WywhSXxhOAWeZJ/st7mw/Oh68G3rDgQ98KvJqjbCVLgd8c3j7UHoJL26D2ZNU0s6qcD3Zvv94fL3BjoAzBOVo/LPX7WShJ2Ma/OSHfc2R43rEvbok0A3BphfpCfHuYrGyLV8qAJBSwnMn5pvd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769617708; c=relaxed/simple;
	bh=ig3ngrFA4mAHXJcNkY0wk6vaVPcE0rMwCYUvC6IztUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EROc4u2oDvZ2BJlKxqAY959qJipJpX01sYJOJqBQKV5IdvNuD1w/Mx9juOTaZwVArluf2yuv+aj8LCfQTGEl2kDUngP7Zaf2TIamfzWit42DgVBvdP7A4DaF6TN8uDLwukc/I13rcCXuCfvEeUIxrhRZCW5VWDYQJLiDWwtjlFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Muz6DEl1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cYT5wfZv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Muz6DEl1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cYT5wfZv"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SFerEh4008468
	for <linux-spi@vger.kernel.org>; Wed, 28 Jan 2026 16:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XknSPNViZAXd0IPLbcmvwfJ3XSfTBpfSowx8Yw0ymXs=; b=Muz6DEl1M54rU/B+
	tI9R+h8ezE8pq34jYdCJKiqxUlGJ2LI2iU3VwOv1dwZkhe7Ew1eL1ay12hPUxsfY
	LD+IitptweyPz2TWiEPeM/BZW0lPvwEbnOC+0cvIkCjWoxWsv3odXwo5CmxFUaa4
	bTp5mj2CNskZ9gCp3ANNIhBse5IeK81dw6uGkt49Xq8s9Y8QfHZYaKUaW3IWgPrC
	78MKjrUwnqqwDM+X7wgNFZ6TRBekSFkzxdUvJPGw8lcViMPAyfSfriQjX0p2ZpEv
	UbBNcNXe5QQt/tPc7uwgiZvDMCQD0kvx5Tx8veRN28+2X9UOd2iKZltv81FtS1iX
	K9ODNg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4by1jx4cak-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 28 Jan 2026 16:28:26 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8232bde979bso1897b3a.0
        for <linux-spi@vger.kernel.org>; Wed, 28 Jan 2026 08:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769617706; x=1770222506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XknSPNViZAXd0IPLbcmvwfJ3XSfTBpfSowx8Yw0ymXs=;
        b=cYT5wfZvy8GmOFAEIfz/HDsqZ/2ANHwAVDer01FKFQOp7olshpJBSfgd8Acflnww9z
         ekt2IImnNiBeuiicbYO9rBCABJVmeHieOSg8IpcGsHiHPqRN4zM3NbL0QrCfS1axyi8O
         hvP8eYx1dxUh2wgs8X4PIBc4C3vJfbJUqrb6xkXbUIO4MDQvDEvWosLtSlsB+hz/Yn8o
         gHcvr5os63JquZyO3uAFEoUlEAJ11yooYqBllhXTxw1es6mF0C5vmuGIUzdnNDzULJl8
         Fa4OXQ8ZbtBxK+OPI4L1ZKYdF/Ih1rb/x6S2sPWfpVTEQiJ+yEmSAYeUJARbXLeADQmu
         fiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769617706; x=1770222506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XknSPNViZAXd0IPLbcmvwfJ3XSfTBpfSowx8Yw0ymXs=;
        b=aFylA1WdgAL+G8Zt2ZRFcuQJ+YY4vrdiz95ABXxnc/fDYn2MrvmgWIcL+x/w32mPpz
         b/G5+nSFtiHwvEgcplty+cPUiJ1kNtn+UZhC78h4xbNKjXtzrnDtUMJQcHLadgCwttNz
         JpuB1QCSYgGVumHAKyZJJmpLwomqT5x7f6m3Yd4OwvTXWp9/kbSeGeKzJ0opOSp4T5PT
         gCCSA1kjGcz8UerELJZFc+M8M1ZQSXjcR9DboOp8zWgTyLMfxk5sEUy7gjF1qrtkjsZ/
         clIeMIo1oiQHE6ATN+mxEr4JzIz9FGDmfOlHyy33uACYm3SqIKm/4ubrXY+b6RMa7NMs
         J4Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXJtotiIeXQn0Tz4DCbuBJ1gNZSW++zc8rCOTiQqpjuvxYeD3RpdHqGn7IlvTw3lV3ajdryfL661tE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzl2jVvEaoEFmmfRGaSHIDLMdfqw3ZuPo6d+heRY2FhVjAn7q1
	RPqHniLOHZd6A8CRTDuOxU8TIAx3yjkf1r0axZLaceeIp5KxemOTy6tVyUqU90IUjR88Py+RASt
	M+ayHo66KUMMDDVmLdg/XyNrqV4OQYBjw0awa0Xz9m/L5CUrokFKpUY2rbkz2zmgX6CerUbo=
X-Gm-Gg: AZuq6aLGWXG0C2GJsDfFYXZaaMjcnteSUHyLl3itsI/YGpqaT/7vydCW7MTN7zccP/s
	KLVDDqAl/9k+/A2NUsMahy32nFqrCJK7vmsNCC9TAjWMBGM0vQlQalQeeSmwt0KZ3WUVT2CxK1p
	Dw30BTBtazkg9m3L4+1FlnKTkGeN5STGEttJ8Rgi3D+poGmqUThaXGwLzuYu9CO0k7dW3OIWhoQ
	R/p1v5VqjtBDv7u0nCE3PQwGXe6phsb1jH6r6VgswL26AnO3xw40/LFVV/2E42WeSpFyzTfFX8w
	H7OPnRM7PlGP2e6md3jiDo7Z81w0kjCnGQk2uIH65TUVkRFjJqwLyQwg5KlHOmMFhSAOo60jPJN
	K4FCpeoATZtTeWSLUElri7uQhueGZXDIoPKFd37vp+A==
X-Received: by 2002:a05:6a00:908a:b0:821:844c:5a2c with SMTP id d2e1a72fcca58-8236918034bmr6186831b3a.28.1769617705796;
        Wed, 28 Jan 2026 08:28:25 -0800 (PST)
X-Received: by 2002:a05:6a00:908a:b0:821:844c:5a2c with SMTP id d2e1a72fcca58-8236918034bmr6186795b3a.28.1769617705203;
        Wed, 28 Jan 2026 08:28:25 -0800 (PST)
Received: from [192.168.1.2] ([49.204.110.251])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfcaadsm3282553b3a.37.2026.01.28.08.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jan 2026 08:28:24 -0800 (PST)
Message-ID: <700e3ce3-776f-4ee7-86e2-40608deffc0d@oss.qualcomm.com>
Date: Wed, 28 Jan 2026 21:58:19 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] spi: geni-qcom: Add target abort support
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com
Cc: prasad.sodagudi@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        quic_vtanuku@quicinc.com, aniket.randive@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260122151008.2149252-1-praveen.talari@oss.qualcomm.com>
 <20260122151008.2149252-4-praveen.talari@oss.qualcomm.com>
 <64961e27-e316-47d1-8ab4-c4868754adb6@oss.qualcomm.com>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <64961e27-e316-47d1-8ab4-c4868754adb6@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iMqGPQDttHcM8yPJXZn2c8ize266eKp_
X-Authority-Analysis: v=2.4 cv=duPWylg4 c=1 sm=1 tr=0 ts=697a392a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=hmzEZbfuJy6/QR5cQt8XuQ==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=UawHs-3MIjIE-ZuvvMEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDEzNiBTYWx0ZWRfX/PCuUAg5Ytj9
 4BAJsmaKQWI0tEumJBnE91cWZpsx//6F405lRr/pWzRsndfD9Qc/qI25+w7Og40Y3SwK95RdxeL
 yjR1giVDwN+t2uWou8JsgvuFkzI0FgAiVT9kevuoX7z6zVAMMftgECAYN8OrDshMkHfk4UDB6uO
 ODUrtmbhpBWFKkKSP+TiWzHckPqSC3EzthXriLejr6wDPWJQp9gIaIAwtYY7TmAeUdPXeLTx8iH
 KRABN3WutQyI2OmeoLyv3Ze1mKcKge4+u7/7ecihgWWlgqqpET44e/k0fRrd7U68vE50iqNCAF5
 BW9eCGAOShRLbQoRnmWdbr5+lF7MOrPEs46tsHKCuEgON/TGiGPRNWjeO/Heqe1J/9C11UCkkGz
 XE/UGHw6EincvBAs5EJx23WZNwiNWbFIyU0o+CvNflE9/UFQd6wYUpNEut2P+R2+HUJP79RJotj
 zJzoMuPlqRQYT+TVVmQ==
X-Proofpoint-GUID: iMqGPQDttHcM8yPJXZn2c8ize266eKp_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_03,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601280136

Hi Konrad

On 1/27/2026 6:51 PM, Konrad Dybcio wrote:
> On 1/22/26 4:10 PM, Praveen Talari wrote:
>> SPI target mode currently lacks a mechanism to gracefully abort ongoing
>> transfers when the client or core needs to cancel active transactions.
>>
>> Implement spi_geni_target_abort() to handle aborting SPI target
>> operations when the client and core want to cancel ongoing transfers.
>> This provides a mechanism for graceful termination of active SPI
>> transactions in target mode.
>>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
>>   drivers/spi/spi-geni-qcom.c | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
>> index e5320e2fb834..231fd31de048 100644
>> --- a/drivers/spi/spi-geni-qcom.c
>> +++ b/drivers/spi/spi-geni-qcom.c
>> @@ -1009,6 +1009,17 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
>>   	return IRQ_HANDLED;
>>   }
>>   
>> +static int spi_geni_target_abort(struct spi_controller *spi)
>> +{
>> +	if (!spi->cur_msg)
>> +		return 0;
>> +
>> +	handle_se_timeout(spi, spi->cur_msg);
> 
> I can't help but notice this function never even dereferences this
> argument

Yes, you’re correct. Since the argument is never dereferenced, it is 
safe to pass either cur_msg or NULL here.

Thank,
Praveen

> 
> Konrad

