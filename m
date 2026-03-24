Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D65535AC34
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774385671; cv=none; b=g5RT5icsALGafgL1vR68qkXEEZATnuaOhDipdtQi7PnHLStqe68OCQjXF+StQSmLoZM40BHhw5/lj/fDh9d94idNQdCFViyUONvHrhpbctpw0SDu/Q7+au5IwJa5KEmbh0AeVYet/6Pn4HOut8gTH8xRrDJzqCFLMACcd5JF8mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774385671; c=relaxed/simple;
	bh=Z8NlWAS8ibWrW+F1hqnwN7hUxPRmLS9DxyojjSXY4EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xvg9pq/JV6dT3KSDpIcDDZz7xPWEGeCwhPhNLvKCu8QtQjWDgjH4ue3EnrlREFN5h3Tea7qXh56Z+x0NbkZpiyEX6CXm7rhMaBg8VLrw1FHKL/S7suaqTB4JOv9tdUw/V9htEkrmvivc3Zca4YqmHEYAeAP6RQiqAsLbvyX+mo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ArYV2VJT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=e9dWchMi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ArYV2VJT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e9dWchMi"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OJCtvP2807972
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 20:54:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=416fKEesZoc7uRI0P7P5Lb7s
	vTGvf9yskNjv5O78rw8=; b=ArYV2VJTkIr5mRa5iUC/RuadD2oQBMMGc+Nlt8MS
	LljjJm0yS35LulUhCu53i5hyu8toL2JeHCkBhbpNdv/ce8ymLawvUkvFlSFMumVC
	tDd1EFFKfsPxUCOr6fX3YfUxAElhkLYuXs+VUUy6eTdVdHNsRmKmQyq0kTLTzxJH
	pkmfsAo65Z1FATrfbMnbjqFGvN7IJvBQE89dbzbZqVLo+jc1ysEA0AYpAJsariMn
	a0C5emNJXZIwlbcv4EbLWJTDDE0kXJNZgX3Aj6RKXKCBeS+CQAyeWQgXcQeWPg6z
	J2aMcVA0iVkV514YuvyijTM6DyL0Tni2jPtCpcH8a8WWzw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3t9ej2kd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 20:54:28 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5093b92f327so409163101cf.1
        for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 13:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774385667; x=1774990467; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=416fKEesZoc7uRI0P7P5Lb7svTGvf9yskNjv5O78rw8=;
        b=e9dWchMivgi9OmOR3I7jZgUyGr2Rp4SYoWrpozR0VGuialBK0+7aousc5yPO2b36q3
         RTWXRBuZxzoFEEk9baKTulpHCJP3THYRv5yo8ECmLB7SMzhqM+e4rzkR/GgPG0KH/5G7
         R3Lz2bDPLFk7grCo0MQcn547gSRU+s62OMu5ApIwHU0xGTjmaPTN2RYLu35cK5tEpreE
         CRR3sqpwLtZahasplD77BL9gqOJ5rspNjiTT0R6+e8jctkX6NSdV133zGtmlXhR6whxg
         1EEfopdgAXOusIXbR+6hUKK2JVIEwp+S7W76DJOdI43wnwxKim7aIPFXWd4ScvHW1oLu
         GVPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774385667; x=1774990467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=416fKEesZoc7uRI0P7P5Lb7svTGvf9yskNjv5O78rw8=;
        b=HWHbBLa29nknAaZNruw8EHwB8bW5CPkR/JFytXZ//oGqhUKMYG9TE7nsGcRFjDbx2c
         KOOmUc51FQUsL3US0HCIZJMJoa+OgxKU1KQFFBVc7xG/OaZ+JXMjnd/e9p/k9WnXFGnb
         s2z19JMxtz4FgCLmJr8Vl3jqUOkwwOV3nRIxsVlxFBeq154yIHeVBWU+o1lO8BajYg4K
         VnlFlxadxyABv204qh5uBLiar1NY8jUPODxewhc1mB1vDxFIiltk1OfLsqu1rQCEV8uc
         +Jzw/UF+X1DMaB/j9Z2olRbOpsmaJb4cyk1CAUMk4dYHtQmbs/Gxr+blh6XjgW6IRJvq
         n4VA==
X-Forwarded-Encrypted: i=1; AJvYcCWcuUAdRsyy4EuypPub/o44CzKPYzZYuIcx5Wp+UJ95RFEY9IGbKvIQAfKusyHcBNOQoIARRM9pmMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvsfvsiElK+9vUflOdOH9tl6a9rUzPum8U3ShCWeT3PwG6Jx6q
	E48omfz55ja9ttXi6SZfqT329XTGywjrGSQ7KTccJgCG7Z99rjmCJUyd7wJ2UHT5gKPDBya67y3
	dp5IhauQQaF5xb0aEvCso0sBk7q6ZU/bOqX4vmsBq+LNBFolOaPTImziuySoUtUrPe2PrDyk=
X-Gm-Gg: ATEYQzyroPsjAtWVUrmMKLRz8D6Mj9ZgCc7Sme6iEqPN8qc0Jvjp9Uq0heQ4XxwATEZ
	V3EQqc89oegAveXKF95pp5j0Mx0gKgmxSZRXKzeWwt9mzGj5WQ2DYsZp0imH9V6SgsI6B1yQKGW
	5W1122UMEkf3IzQdSJJRjCupF6lNnKn038U3Hue8P9YuqQnB1vysuTATOxI6UsgXOCG8rNXNqX9
	E+6erUhkOHwdhFelCkM9AwPDFzHa575yEiaPYRuYPWX4u2S3Pttyj4ZlKJWl39vP3QIPf4X84KY
	CF7fOb0bmqskm86ES8l6rTyUEicVlQKo07UvRC999ZcWCBTK6nISUDZadDp00cfpxYGuUaJX2GH
	gveEBMmtmEcz/hmSnxfjfRnZh1vKLkTg2GUQB0XvjeNNGy5mNhMZCX1yRPFyCM5JL7Nh8ibx3yW
	OOAJHMfcvqsU0YkdN9/UPkOFTw5pHojV98Sx8=
X-Received: by 2002:a05:622a:5c93:b0:509:481:5365 with SMTP id d75a77b69052e-50b80e63242mr14891671cf.50.1774385667387;
        Tue, 24 Mar 2026 13:54:27 -0700 (PDT)
X-Received: by 2002:a05:622a:5c93:b0:509:481:5365 with SMTP id d75a77b69052e-50b80e63242mr14888691cf.50.1774385662062;
        Tue, 24 Mar 2026 13:54:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38bf9753c7dsm36218071fa.13.2026.03.24.13.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:54:21 -0700 (PDT)
Date: Tue, 24 Mar 2026 22:54:19 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 5/6] arm64: dts: qcom: kodiak: Add QSPI memory
 interconnect path
Message-ID: <i73fny3nxdljztry4qn3rotjtrjnlau7oxzjfj2bfsox42ylti@lllrvsc4eyum>
References: <20260324-spi-nor-v1-0-3efe59c1c119@oss.qualcomm.com>
 <20260324-spi-nor-v1-5-3efe59c1c119@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324-spi-nor-v1-5-3efe59c1c119@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: AbNPVVD8iELlfwG7AMVus_BTTX6Lg2dW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2MSBTYWx0ZWRfX8S8LoJzVEE6F
 BknWbky5cFS2fhFLdXGcjquVW1V7L8jlVd8si5Rn/ZHRYLiUSB75eHO9Ki3iUtss/mkO23QmLMi
 kgb66pEGL3yGkp09z7utHBhxpQW/ZQLDGPFOSLWziSteG9YsTWj5TC4JKhqlNL3Bxb3zUvbpYRG
 bQgAOmszxtuM6bhWlrH8BcHzSlew2Ys4c1ub3YjgywZzepqCSYY8E0E8ryn9NppKuxNDePqFQEs
 b5puE5ydwenXFF4UzbHxx40a0Kvy6FIh4AR5pl7WQpWVqfid89H2nM9j3kBTBYNfceGDZjPtWXB
 amC9FNR6aUKvG8j90luX7/p3Py3OSH8ELpcLxLrY6qNsedpBvsNG1g/ttrUSk1rcQSHnIoXHndB
 DzhQ18pPN6+bMVcFvafAnC4RbPkrHVH5DD/I8G3ZPNF07yJIjjFZ0nSFK/qR7TujkWTW/ap+t7x
 VKhQloywKud29NYjSlQ==
X-Authority-Analysis: v=2.4 cv=DdAaa/tW c=1 sm=1 tr=0 ts=69c2fa04 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=b-WZSYoPuCkCoMZxyvkA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: AbNPVVD8iELlfwG7AMVus_BTTX6Lg2dW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240161

On Tue, Mar 24, 2026 at 06:43:22PM +0530, Viken Dadhaniya wrote:
> Add the missing QSPI-to-memory interconnect path alongside the existing
> configuration path. Without it, the interconnect framework cannot vote for
> the bandwidth required by QSPI DMA data transfers.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kodiak.dtsi | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> index 6079e67ea829..9a44bb3811a7 100644
> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> @@ -4312,9 +4312,10 @@ qspi: spi@88dc000 {
>  			clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
>  				 <&gcc GCC_QSPI_CORE_CLK>;
>  			clock-names = "iface", "core";
> -			interconnects = <&gem_noc MASTER_APPSS_PROC 0
> -					&cnoc2 SLAVE_QSPI_0 0>;
> -			interconnect-names = "qspi-config";
> +			interconnects = <&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_QSPI_0 0>,
> +					<&aggre1_noc MASTER_QSPI_0 0 &mc_virt SLAVE_EBI1 0>;

As you are touching thse lines, please also switch to correspodning
QCOM_ICC_TAGs (and I'm not sure if those should be ALWAYS).


> +			interconnect-names = "qspi-config",
> +					     "qspi-memory";
>  			power-domains = <&rpmhpd SC7280_CX>;
>  			operating-points-v2 = <&qspi_opp_table>;
>  			status = "disabled";
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
