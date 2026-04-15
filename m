Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AA833DED1
	for <linux-spi@vger.kernel.org>; Wed, 15 Apr 2026 09:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246556; cv=none; b=fF6cY9H2xWXUIUmOFogygbkScUBQ1qPIosye1ZvnIcANG4ggtK6ouHwogA1g7rGZElcdGNHX8IMFeoVvIc5sj3Lbzn8eE1N35CS9e/98Lb1Y6ZaScVayn7d38vlw/7kvCY9wePoNlHJ+aEWQiIUd5TASNKTQxWV0rBh1EFAPVCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246556; c=relaxed/simple;
	bh=QKpaqkhXVhw3e6dha4xFZ1hNG1rBhcfaP4RE9kuyYqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BL31Sdc9jv14QeHnhOd43Houb6s22GC63L4fNVEW8YBg7ruTDoFDojQf3hGG8eSAvVBPQ9MfezFQUb041L08qFgeiI0+wSTro0PM07FKSNKXZU2XdXPi0u/T9EJ3WR8iXfmDfbol9hW9U41rgDEr4GKf1BfPVdGLe5U12+M/g20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WcfNbZNy; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hUf/V0A7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WcfNbZNy";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hUf/V0A7"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F8NmKK2972580
	for <linux-spi@vger.kernel.org>; Wed, 15 Apr 2026 09:49:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KIzUYLQ0tR1nBOwCy/qt9ww/9VJu8w749s+dTlb0dVA=; b=WcfNbZNymh6KGA6R
	1kojeyZJ6XrqR+3UUXo6qMnCEgE/DZXEiVOL3AgFUxlL6cEWdzAYCvEd9CHVefbk
	FV/w0+6QYPqfuwXkMzCtM2p2RSi1fR136ZSV+Gv+mzGJxH+1r+xgldY5sXlSyA4F
	rfh2AzlRGLFL6UMC0V7A8aCxF6Pz2paHRwadfcrDt4x3fMPNppfHUnLd0eQWnqRh
	iVJSUW/3Jk15gpRhhIvbjy8qBPRfHOgaz2n7GRIQDgrBVNfLCRWfhhtFZyr+HKl2
	F2K8g3E6rgE72G0UdCd1y5qpDUz8GkuuiJYcyxiFFBvAiK9z46hW84M+xu3wH+HQ
	GSRg7w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dj74g89dk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Wed, 15 Apr 2026 09:49:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8d45ebdbc9fso140783685a.1
        for <linux-spi@vger.kernel.org>; Wed, 15 Apr 2026 02:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776246552; x=1776851352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KIzUYLQ0tR1nBOwCy/qt9ww/9VJu8w749s+dTlb0dVA=;
        b=hUf/V0A7utTUW3U+e/FoRwfUpMrrL49zs7r1JFIeI6uVO6OCs8RDwkTi7fH67tIkGj
         JPosl+DrhQAQLi2riSiWyrWLW5V8k3WsFqHbxhBplZSmTD5Cad2GmqwuWXwaiYDuyRFe
         KBIjX7uAjhPKKG1QVXT3kxObdGnhMcS9xwY1sv2OhoirQNJve8QR9joT/Zol3Ox1fQkU
         qlI7sz03o4HHhQLjyujC7THcxiDxgZDo72EeUBPYeZYOfnQ4conhsv/GO8Ev14grRgO5
         7yF5TVguuEkpG9SRzG+LXlscM5lYyzxfmVv3cgJOX9l8M5vF+F4y4/meF6H1QYe+ky1H
         BreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776246552; x=1776851352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KIzUYLQ0tR1nBOwCy/qt9ww/9VJu8w749s+dTlb0dVA=;
        b=GQq4Bukeq2BDsn91mxYEjP8ph5/khWQG04DoBYJyfTfgOl2tMTMS6wfsxWnMDO6MDI
         JzTspdCitVSyoO2DA9I7j8D//wScBrO+ythoK9mpvqnHcwvmE6x9/tGEcIBzdft1CgjD
         qBJDWPPAlxdE8oIeAB8roq1ReBS2F6Tkz8NU1WKvBBR+/960QTGObxXdN/o3tIPtHKpE
         2fVIb57YDzOcRCSKE96xC73kd7RoZu0UWbmHNoo1tpFa1w42/SBSs+9Xa9ilnz1BERLm
         2Ul6bVqTgBtxu5+TI0QQ9EeMm7g36ijQ7Aav5s6N67YgwTiKibw247CqKuucsPFXJcbx
         I/kg==
X-Forwarded-Encrypted: i=1; AFNElJ/Zmvp2dO0KEu93QwQtIZl5F8MUk8PrPPOw4fs85EFmfo1k27KQC/qJBMK2tI83N+e35f+HbNE3fpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2/FEq/2Ocp66cpL+F59wOYFo6gXPpHGM/I9h7VaBsiP7ZhjMD
	82VcUEyXdrQr00lPnNAGT6Mmp3+Cm7IpV7EPh4js4FHH+1miQhv/eqhGvA3uv0EFddlQ94HkaAs
	5Ju8d+qbBrW4Xf83r06nlvs0jQ3WSGD0dVcFavSqc2RJN51qRIYhpTNG2lK/QzzQ=
X-Gm-Gg: AeBDietbzsf9k/hxuWxqkDqoGwVtYi6EYJ9btdv4vtkEGknGXdgM3xo1wD5wlCcFx64
	Om5NNHHwUPaSxb31ewcstaO6qpIaY9Kae9CduygOqB9SPy6yD2+kzRol/AZz3R1Ms0agdhSUpbw
	2sH3hOufQlOpY2EfKPt7zAt8jk0VW3swCfMq0yQxTJ+csbkLk61NR97qo9GuFb8MP+uw7UDtIe2
	HynqGex9ZMyD54D5kYacqUHKx+jmjqiCTVaOsm93sPF/7XdEYMrfscMeBWu8G1vP35RuInXO1To
	oSua4RUGsK0wNn5Wt4ZlwPzZiPyT5i01sNqnR4qJB4dacvF0kI7T3Qoe9qBE2DQ13D2ld1aMWCd
	gTlCEjWl7vMJJJ+gqZCd6kFAJWezdfmcL5TkMaKa/Qen35V+LNMadXsqG0Y61eFF4r2bu6ywtjy
	qhtULATR400OY30Q==
X-Received: by 2002:a05:620a:4511:b0:8cf:df37:4f6c with SMTP id af79cd13be357-8e4cbead971mr170718985a.5.1776246552260;
        Wed, 15 Apr 2026 02:49:12 -0700 (PDT)
X-Received: by 2002:a05:620a:4511:b0:8cf:df37:4f6c with SMTP id af79cd13be357-8e4cbead971mr170717185a.5.1776246551857;
        Wed, 15 Apr 2026 02:49:11 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67237d79258sm283300a12.4.2026.04.15.02.49.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Apr 2026 02:49:11 -0700 (PDT)
Message-ID: <e89cca9b-e67b-4d5a-aecd-6c2001d079ac@oss.qualcomm.com>
Date: Wed, 15 Apr 2026 11:49:07 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] arm64: dts: qcom: talos: Add QSPI support
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260414-spi-nor-v2-0-bcca40de4b5f@oss.qualcomm.com>
 <20260414-spi-nor-v2-4-bcca40de4b5f@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260414-spi-nor-v2-4-bcca40de4b5f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDA4OSBTYWx0ZWRfXwAe/RdlFaTdD
 Z0xVXcvBbHJQoETMI2z8rU7OEqfBFq/W14fwLAx8Or2HmN9Z58NNIS9GSkWwGKxtmK8wlDxXuNN
 tJxXnhY7kwjPCZAE9jvSGZqOKn0SEXGa9F7oB9VsOvQWgJNtOK/YFrYY+EyjLO/soUxhka4WeG5
 HlZu3hr1We8g7Qz825TLxVzY54hnqnwe29xJQwj227MWztPFfsxC0b3NjRDrtV4pZoN6A2Cnsg5
 CibWTeBjZAzel8xPt5nwL3EV8PW9AwID1KiHTkJRLkRvQs5tmuLcX9vvFTMeKJ0KfK6V6zRKWEA
 ejVb/1SIHxth7UBQwrhw3qgZLvNXfcQPqlJ53xlvJv/U4rnCGAQnEQlyr2ynwU3uRUNA8pMNGU0
 lMEVXm9UOq5TbN84U+JJ9p+ljONJFooD4O/gr4l+4e32vSe0w676P1/9+We3bas+64XqPWENt4+
 BUXTR8Y0FLq6tzx4tzw==
X-Proofpoint-ORIG-GUID: 8psCPRQr70t8GufWtxkq1b14HjyrUESd
X-Authority-Analysis: v=2.4 cv=ZIfnX37b c=1 sm=1 tr=0 ts=69df5f18 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=mL5Sac-3cE_IzsZij1IA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: 8psCPRQr70t8GufWtxkq1b14HjyrUESd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150089

On 4/14/26 7:08 PM, Viken Dadhaniya wrote:
> The Talos (QCS615) platform includes a QSPI controller used for accessing
> external flash storage. Add the QSPI OPP table, TLMM pinmux entries, and
> the QSPI controller node to enable support for this hardware.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---

[...]

> +			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
> +					 &config_noc SLAVE_QSPI QCOM_ICC_TAG_ACTIVE_ONLY>,
> +					<&aggre1_noc MASTER_QSPI QCOM_ICC_TAG_ACTIVE_ONLY
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ACTIVE_ONLY>;

The qspi-memory path _must_ be TAG_ALWAYS, since APSS may collapse
at any time (which could drop the vote in the ACTIVE_ONLY case), and
a DMA operation may still be ongoing

Konrad
