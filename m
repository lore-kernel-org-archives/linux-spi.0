Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13B333D4F0
	for <linux-spi@vger.kernel.org>; Wed, 15 Apr 2026 09:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246561; cv=none; b=i3DN9NVFiR75198TN9FUX6zX37RrgyO6xlMefuaHo2YgryJh/D7/7fKgWEs18TDMkaVTLvP+TbJs1AXMj1mNusrCulHwtx5AAXPKteQgt3EiTwJ5WcAITCsmeEB9vW7nbCHivGVVwa9IVWRwaduSooN2YFk1D+gqhUwAdfIJSdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246561; c=relaxed/simple;
	bh=VjI90jTJy7c24pG9mgRV72x07WaVDTTHNH8S60OnBmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QE80mWOiqradCKtdPQiO+uyZAXtt5LTWC1GPdYbdq3DnZ/jnGYUJec+f0JaDZa9TIa4LRTepB8yHb6ov0425zJ2aiLzLMg2JfruHyU5KzjFYuOoWFE8Wsyl2IEqxlgem8J3zy77aOWD2PaDpinWrcYpIDWpYkQ6B5mpca294DXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aCenT5RS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=P4c7U1Qo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aCenT5RS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="P4c7U1Qo"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F9gOgJ3126648
	for <linux-spi@vger.kernel.org>; Wed, 15 Apr 2026 09:49:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZYt2Uabi9jAwssBsgdcXl+OwB3F3m9yhbypqelBA+YA=; b=aCenT5RSm5G1gWWo
	0CuexFXnlNyy7IALcMQ7AACcCOb1bz2z5HEvXu3q419Ez3l+RJOLQdaKlSeHoZNT
	Y7Y1nuQg4oqSGatmzZD1b4F8/DmD5vcsQWiPJeunsNECPWEiZXwY/UAW+4BoKfrk
	dsoupuKyIbvpqLzGvKxhbFUkoF+j6aQiCpJxFlnSyEpzt/dWYKxcnkh5getc18H4
	fwEpyIdWpCxWgcLbhj7TmyBCIjSIZWvUzqMfYfX+uK555ffiovV97GuC7/8TaxCh
	RgBDORtn42hZVM+OWgKkOah2TAqJdJj1YD1A9pJ/OKnWFT0lzH3pzwihR44VIM5M
	nmoTSA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dht56tqfr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 15 Apr 2026 09:49:19 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8d63aeaaedaso167059585a.2
        for <linux-spi@vger.kernel.org>; Wed, 15 Apr 2026 02:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776246559; x=1776851359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZYt2Uabi9jAwssBsgdcXl+OwB3F3m9yhbypqelBA+YA=;
        b=P4c7U1QolsO//ma1athwmhe6WsaGUzR1BHUubZS1rikp61YTfHjnRjyx6WqwUtGIBb
         AvRQeFkvgwkRu6s8P5YhV7oZfkuHbswn2YoXD1v4eRh9D8ng/e1lHmC9eKKSYY5tb4m/
         bfmOLMzemeTElT9SW20Q5gDvKdv0DFFvTcHAiUkZ+gu82ULCWivZjBO+6CQSOE+LA9pa
         kK+w/ZW9BURQZkKdYwpydpxVyrUA4JxnNu7bin+H/Sfe8l78fLCMJT8hOZd4jke3kd9Q
         YWGBTofW+gqnrVTZxJcAHVDXrPnnEXTc23Qhrr4W7At7utJMY8PScEtPae2ar/zUmQpQ
         qqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776246559; x=1776851359;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZYt2Uabi9jAwssBsgdcXl+OwB3F3m9yhbypqelBA+YA=;
        b=s6EVBS7zaGuXEvLv6Q+vTaNI7MhU2ypJhTOdu5UJ80mN9FtBaFvUqIHCA08n4h6zl/
         x0MBw7SvMr06as1I+rHYpkcTnYb8tqbB9yO7Nrl5FTxkrmczT1ZtHoVpZmg8dDRp3Rt7
         wOJl2Z+yEB3xvIKP90SS2C1gh7kInbmrVUBDTctI8wfGgzUVHaOBhyFOPyKF8qI/PbMw
         L/d+BrW9zgv+aTZdekqu9LSUNQOmX3W/yq3+J382L/TdDV1Jy/RFJngcMR/mvwWTHLpZ
         Sb9DWU0RpKgqODqHUdu5uEKUamTO8fIds8Vl2arzFlCCn9grz/l3gSm0pSBxfePFw0fi
         d4dg==
X-Forwarded-Encrypted: i=1; AFNElJ9KF8RblUR/6PptunX/46lHaQfGbtJLQKQ2LuoEBGL/Ss0BSJETLEOCNNmtNV8XACsUXbqePpgXOp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUo4Qtg5IghOX0HkyP4UpeqZMV66cxCEQRQRumA1tkuFhzX2A6
	1GRZu9FK1a7sSic0Z+p8T38vWmqxvGK2raoXNR+Zk9vQSpxyvXIs3GpunYIXXg7drZdSkjWVseG
	lOpZAzyv87utWSOJSMTbj4GAYrtdgWiL93otS7z8MRSltwI3cg5OmFj36dtmZbDE=
X-Gm-Gg: AeBDievOFrFaApiXQWPVuDmplWJ8Gnzs5ZrMQMGBCHLJS1maqrNeN5BYFiBiHi4pawL
	msaA0OY/QCSmIjQvrjUstkB6mov3C3Z1KkTSwohf+XricIgHVQoKjFFHcXVdorAyAVQP7p/gDtt
	NUnI324/MOgAhyQrClmv1DXOFLbGVQxo85CfUJ80axGrGvBYUOCjxYqhr5FIHH9EfdEsHXMLUVg
	oqn7ONzDjbAXv9gyzifsuBAKtNvK7daEvKoK3KT9vuPlCgARFvr3qpAy8kFB01RpcPoRK+m2kwI
	K/5yS8sClJKCZodp7fmwabKwreJCxJ2+c+oHrBSAbu6MzLnE+54GKt2YC2scIamRojh/HCoYOX9
	LZNRUEja8/u2w5kRNOMZFds4rKJTqIbEvGttvNJ5kgSfUTs/YD8NqfSPWTrRN2o8XZvptOa1xdc
	paWhQR+meuDwAkwg==
X-Received: by 2002:a05:622a:24c:b0:50d:aae1:7078 with SMTP id d75a77b69052e-50e1a5dbbd6mr15378471cf.1.1776246558999;
        Wed, 15 Apr 2026 02:49:18 -0700 (PDT)
X-Received: by 2002:a05:622a:24c:b0:50d:aae1:7078 with SMTP id d75a77b69052e-50e1a5dbbd6mr15378361cf.1.1776246558476;
        Wed, 15 Apr 2026 02:49:18 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67237d79258sm283300a12.4.2026.04.15.02.49.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 02:49:17 -0700 (PDT)
Message-ID: <dbe4a4d8-4a3a-4e69-843c-ea0b55a4ef1b@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 11:49:15 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] arm64: dts: qcom: qcs615-ride: enable QSPI and NOR
 flash
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260414-spi-nor-v2-0-bcca40de4b5f@oss.qualcomm.com>
 <20260414-spi-nor-v2-5-bcca40de4b5f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260414-spi-nor-v2-5-bcca40de4b5f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=LuiiDHdc c=1 sm=1 tr=0 ts=69df5f1f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=WZ9FainDxlOnS1l-YVMA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA4OSBTYWx0ZWRfX+L57E5t1fM0/
 aYn7VzxrqBnMF8VpOUqyGxo3+55X9GgsyTSF/QHPDtKyDfTGkMs9Obyg+H9mdL1iBrqZVtMqzcF
 xYS9MCN8pvETuuIk+pB381gs1B7warxqCEzVAH9Tz5YVMMrj3SkMXO2pL0j1NZ5Mah1jX/PjbHi
 UsUXjPPSSGmDvqqLOk9CSgZTbKDNMuOyE/h9v/r7s81DUCDRUDQM27UHha44wGtcdgXkJAI6/Qa
 w8ASh3z75uFj/SvpEWJQb3gWuEKHnIegQ5anXRsg4lsZIu3lD0hq+Y9X98XEXZwU7gynK8csnaI
 Ok+G9YIQyQBUs95N8qI2Vya0hIQxPfDDQaHs7WN+UJhBD9eOVqiuUFiF7jcLCroC108JI51Rg4k
 p5v6Q4K4uGV0hClXcllzYnk4ODhh+pLh38xxLdvorkijbAG+tnh7z6V2YH2k307++aeDL4S61s6
 +pkvek3LTbU5Wr+Dwdg==
X-Proofpoint-ORIG-GUID: lDjeMSow4r6na5S2iCssSHa8vDaxK7sE
X-Proofpoint-GUID: lDjeMSow4r6na5S2iCssSHa8vDaxK7sE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150089

On 4/14/26 7:08 PM, Viken Dadhaniya wrote:
> The QCS615 Ride board has a SPI-NOR flash connected to the QSPI controller
> on CS0. Enable the QSPI controller and add the corresponding SPI-NOR flash
> node to allow the system to access it.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
