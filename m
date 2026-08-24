Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321A642CB00
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 15:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584023; cv=none; b=ZX0fXfa12aBsjMR4kzihbvjL8QdB+JgZOTyk7UHVMiB3QhXgPrlSHg4svJDpoH+baRngvQtT/1aB658MRgNqKT6LSEm3/PtrWdm+JJRk7hJ1+9YUh2W8E2mr7gb7GVR7xG9+KsuklRiqABdPpGRezu+lHcOp2MejsOIPHE4jLjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584023; c=relaxed/simple;
	bh=WsnfpTDfkMnaQf6HEL+ttL08frhpgTwPFvG7hASiU0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rRedqHBia4eatU8WzO/PFlh/WFoKRuQP5zlkQhQ51kXYeo6RgLAhuilNz0eVJ9kE8xDLm8pYKo4x0OPsALeNGCQKQNBCs2AC8cfSBJ80YiKKTina5wRQNtygW/3cje1U2AgcOoIbXc5pm7q3w/vclCJ56NKXGJ/Q2D0lKNO1xCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ateVbhtm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Gc/upujG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ateVbhtm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Gc/upujG"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OCuuVR4077887
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 15:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8G2ECsoTYtsyvfoNVIawmowBPsx5W3LlCQSF/qBNKBE=; b=ateVbhtm+14kvfjM
	DGoIJjbkOeNppgOxnkxhmXJ0kbvA+4O9h0ks0U2b0R3CsgH1wLql/YWPjzR4tWSA
	7TjtpvVg0AG4rj9E3PrwO/kqu6nsrBY98YB8aV0l3dHa5X8ylVaWqHvCPQksfTt+
	9lWerPMdhULTye/QlBOC9fGCDkNZlFlBZSYEWFE1EDVVhLm9NyjEeoeVKWJGQ6LJ
	wcgpbcIryQXmQ8iX8yQAmD+qPL2reEpsIzj3XOk83mZHUMlR0JscrwzHMXKzKTzs
	xsCp0SxIz1jyAPd9XQy+LGaae5TmSz8mgT78yrcbPagsJ57560vifAqFVrSVNGbN
	kWzALQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g88jpkfv4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 15:06:59 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-97752c2acb7so52100241.3
        for <linux-spi@vger.kernel.org>; Mon, 24 Aug 2026 08:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787584018; x=1788188818; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8G2ECsoTYtsyvfoNVIawmowBPsx5W3LlCQSF/qBNKBE=;
        b=Gc/upujGDOUYRfD5bn3XnKuj4By+4y6Jn4r5dYb85u08JZR7f8itr2LO+wB9XIBLjL
         yWTlVHA2h012PgmQaWeKdVl9ybAGpJL7eySgoMkeEUS30pxX2uaFQF3/wpzd/v8eQK7g
         9jMluDgM/IpZ6Cnkd+lB0f+Wk24ygdZcgB/vvhFby/H9Gz7GaORE2bVh4NlwHuXbvN8k
         A6pOtxfMidjSLAkuM+apj16ZZvrgRcwV5KJnnHspcKRXgOZ7Pw6GxE5GbX9ZL5WntISX
         5zdaCGqOEbuFreGH1cICdatIabZBgTbrfwfiHzf8sbF2zmNW/zb3YZraftvwGv+N3v5w
         3i7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787584018; x=1788188818;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8G2ECsoTYtsyvfoNVIawmowBPsx5W3LlCQSF/qBNKBE=;
        b=OSX/EMSvkOLapD5wwlNKvTg19unmzfKh5/B/q0FVI9KiBoecL7k0t/gHVbcRibJ2w1
         ps2WeEHq+xNvb0cxyrcTpkDXTLIGqNnPQUzA82i4KTz6Ld1iRN5xg1LqzCI/8admxhmr
         ImMGrXeI0sjtEBXb8cgUdE148/SJlcFjKRBTV91Nq8D4KglaWKxQZoX3GPwthET2du3v
         4eYuygXyPoTKsQwtEN/33wMB2x10KyV5d6yPLFGe4EETMDQoL47CcXrf582T8cUKmPPS
         SHY/IkPw9aujHIfUO468Ts20Yz+yH3qrSjgPQTb6bEYOdNo71k3xFBmlzIxwVSQjmekV
         Mckw==
X-Forwarded-Encrypted: i=1; AHgh+RpernK60c7pDh/I31LmkTNVDZs5HwQT0GroAcswB7xTXGYufzXDjUjmmQRneOoF3Irrl22mlqlS3rA=@vger.kernel.org
X-Gm-Message-State: AFuF++nIFjyO3CvFtykVV9HNa/n+Pqlx4hJf/faVEvIw3hoX4NVl5CzR
	9xtzCM5oaub8BiMT6cLhc6unmW5U/brFx6wX2T0NU6v0tJa/5b51njvI5zleGGVKgNUwIELhu7W
	kdu4jrVgmMTccAcyFszbkroDM4oRSbKmbRJ/4km20SiTH/pYFQUNMAUEA/b2ZWtA=
X-Gm-Gg: AR+sD13xLsx4d/Lb6v1+liB4Zkr+bIpcUojMuK8+u3ZUf5ROaOg/YzuBDwyTN0ueA5T
	4r01Dc2kNIbSMZD1BLneBlegR1y2X3BLF8y6xaT6VtPDIvYPLp2gSBm2zaxhtIAXwGFhwKnwpky
	gjumAdnW+v+9x1VK5963ob/8VZkrnbsMf+Y19WCr03ceJdQAqmaaBepqmiCy2t2OugEcr7gydaJ
	yPLAvD3/a4vgnU2ZGuKv/l1jx1FDBsOLgka7HH9W+oHWq8Mm8kzdVQAOTPL8IIXyISVDhQvgKOK
	//8Mh6oNijTiZMFWgzitkY/xVKR6HLkY+0CU0VEl2c6tvxWepK4CKD47mIo7k5MPw33Wl4UY6an
	1Sx+l52W77csLy4YOF0qjLq8l
X-Received: by 2002:a05:6102:6893:b0:6d1:8f7:18a5 with SMTP id ada2fe7eead31-77a6433632emr3704093137.1.1787584018217;
        Mon, 24 Aug 2026 08:06:58 -0700 (PDT)
X-Received: by 2002:a05:6102:6893:b0:6d1:8f7:18a5 with SMTP id ada2fe7eead31-77a6433632emr3704068137.1.1787584017657;
        Mon, 24 Aug 2026 08:06:57 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e199ad5sm9278440a12.18.2026.08.24.08.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 08:06:56 -0700 (PDT)
Message-ID: <aca6afe7-4659-4359-b5c8-e19390a07f8a@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 17:06:53 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] i2c: qcom-geni: Use geni_se_set_rate() for setting
 source clock frequency
To: Praveen Talari <praveen.talari@oss.qualcomm.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org
References: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-0-61171ab1cdce@oss.qualcomm.com>
 <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-7-61171ab1cdce@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260805-derive_clk_perf_tbl_from_perf_domain_opp_table-v1-7-61171ab1cdce@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyNyBTYWx0ZWRfX6J1q6h+ODzzb
 SB4MaSSRiHnG7qgDF277at6X8dCCCmuWtnbcGQBvdRuTVxAN48nlQwwtesyBo+NXWXCFDUgaOFW
 lI1y7Gjn95FMZddNrzQlTu84CdUlS8/+n3bT4nh7pWEOkO86AAhgLeqFPJMWk3leuoyh7gfx4kI
 iXr5siCpOF0qApsWY6NkD8iZYFrJUJ2x2ILf34uW2ZaVUU7ns4mEQfdL3qM03JK0owUvwrMeb2Y
 840UrkXAl52UC81an7JZzzOFicoxKF39CIXc5c1Ib9Xov2lamwrDhUcWZiNbupNBKxwD+F1Msmu
 1MiYzCf7PCbOgqHGX8d6bv53FRzL4dX3k4hc74sjn1m60etljuzKLkOBee1QiFlcEGioWSlfX9x
 4aso3UAzok3uXACA9WwcxkmJtm8Hr9J0KXgMYCphKPjaQLYaROCJvztNF3+6S8SvGyqUDh1Pl5g
 FLKJDBUD1Qc/gLEeeBQ==
X-Proofpoint-GUID: CnzqoJXFlp3sClPR8s6hryz1qARUx_cV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyNyBTYWx0ZWRfX2jXddmsM9MzH
 FNo2+Z0TNU/mA914ujURUrmrhyQzPOAY/E/uw0WAEpIhnw7aqYfmv/iwVrFfbVmp3nfVVJBezZm
 lWURAk0KJBotmGwuYxjICVvfd4ViKk4=
X-Authority-Analysis: v=2.4 cv=Xey5Co55 c=1 sm=1 tr=0 ts=6a8c5e13 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=7mB3cpwZ_riAn9QYn-4A:9 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-ORIG-GUID: CnzqoJXFlp3sClPR8s6hryz1qARUx_cV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240127

On 8/4/26 9:57 PM, Praveen Talari wrote:
> On the SA8255P platform there is no Linux clock handler for the SE source
> clock; resources are instead managed by firmware via a genpd performance
> domain. The I2C driver therefore relies on geni_se_set_rate() to apply the
> fixed 19.2 MHz source clock frequency expected by the SCL divider and
> counter values programmed by qcom_geni_i2c_conf().

[...]

> @@ -233,6 +233,10 @@ static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
>  				 itr->clk_div, itr->t_high_cnt,
>  				 itr->t_low_cnt, itr->t_cycle_cnt);
>  
> +	ret = geni_se_set_rate(&gi2c->se, 19200000);
> +	if (ret)
> +		return ret;

This wasn't here before and the commit message only says something to the
amount of "it's necessary" - what's the difference?

Konrad
