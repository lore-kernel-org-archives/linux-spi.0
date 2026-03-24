Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D84246781
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 20:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774385574; cv=none; b=SFWULLwBOYrmRoNBAMz+9g4AVisaT57R5Vbsr6OMNesg0uzoIeFolFMzmHnabdfVQMFOnkXUTx2wkFNftCnP1XuSWkuqMSbDSSexkaBIypvOyHWApni0z7H3NwELFXRTWFXhABR7ZWjXncrmyAmbozzdbwRPhwkZDX62Sb2qyaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774385574; c=relaxed/simple;
	bh=2iDi1ewMnzAeZQ9g7JuXZipx60ngATftH2vw/8iWOE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TOp+YKUOldYaltptTkfJWOIA0dwQrJDFG8jDYaPKraHp3sJ5Th93sIjTrWeg9vtldOJrfX9DyZ6zm4oUsiregLYrqI83NUpkD2xhHICYlEs/h1jI+22sDq5jr2g+8lGV1CLqGOwVEg1rESWqmQeFfPdadeEKykCJAqKuLNZvmwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Po2Squ53; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fEaJ7zEo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Po2Squ53";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fEaJ7zEo"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OJCxUm2340461
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 20:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=rqQjayTeZEhxnqXufBt6gqjE
	f6UwDuN2Pb+F55fjRok=; b=Po2Squ53jnRvXfAhYN2ygVpFKzoBHfaNuuZJu4s1
	hjIKr9JyZ/n98sxB9VR24AM1nqdNrSC2MUNUF5QSem87X/Qfq423C7uK4HugJLJB
	B7rJru3ornynbZFRyFNRtNpYsV0WmVSArtDIJG3oqJSSqu6oEsdkMTbZZiuIi0Rs
	6v/IkvmBg+VM1c9ppSBkAGBc9vVIfWuHuLMTMLnZtZCZYizQo3cejA28csLvltzs
	SgzSjrpYwKg5rn1Ukj9URwo7r9J64jJTABAEqkKZ587ZfTENAsNnA2cUXJ3gOOsM
	ANoLQBn2LhJAt5KWvtv+Pc41JS8SUIHe1Fd7VxBtlur+BA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3sw426wt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 20:52:52 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5090e08dcfcso99498681cf.0
        for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 13:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774385571; x=1774990371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rqQjayTeZEhxnqXufBt6gqjEf6UwDuN2Pb+F55fjRok=;
        b=fEaJ7zEoOlgOTV40khg2Ie+zUn0LQvZtUvG+1mriAlSfqKbvqtA2rafu748ilre09q
         3CSNig61CJtMYYvBSTCKA5M1D4VAWuiNlMQdOgZMCfdPYodS6u0Sv0QedsGJHRwcGYlc
         kblrf7vh+XRXgSKdxz8wFR0uhkXKtDYSC8SVCaE4OExbp9ZAeaepoihSELTfev5yC38L
         0nHNLfi+a2L0mc51/itQWnlVVEP4XaxozbIv8o2Wy4Z6C9ljkHrEWzNFipuvQB4HY8Qz
         eTaqwVJfV493Frh79lf3LaoL5joUj/TDbYKaJZei0+GQprNSFZHe849sB2dQjLWl26bg
         FGyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774385571; x=1774990371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rqQjayTeZEhxnqXufBt6gqjEf6UwDuN2Pb+F55fjRok=;
        b=syOaxP1J34LtDw/muJ6FDSkXZ2+msDuFYK2fRx3jLR6hvnwVF6qgkHo6Kno2d5hEzG
         4Rs/mxquGopL8PvXD235wrN7McYjKKeuEhfr7Wma4KMa3NOGshPerYpc5ApdINIeiTjQ
         mW5jeqZ/+o+OUVypndbJg3rsFpRKAeIxscdSkQ+s8QelVMMmafU1n5y0Pnn0lgRAyUru
         NIvAUqFuo/mCXnganQq7hbKvYYLP+0+g9OR5+y72FLTy1ItP3EhT4sI6NKMn2/OQGv3d
         Wv5ERaINOze2VDjLiDbv5XU5BREflZxaK848UMsjrBFam7CjbvobRU+QgR/F32urXUWb
         brgA==
X-Forwarded-Encrypted: i=1; AJvYcCU/ABGt/i/3Z9sr3KK8SWqRQbdrxqzYwBBkasRe8onvQ0YKoXHfASIuumj6g4rvkKYXPo2K4qeCnfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHpptJ4WP1mWGQ3VNqoxUiS3uMzXxx9qOFHiBs7oFaaEFnIXw4
	sYCYuDeBZGGO6qookXVUA1pr51MpvJcx4GHx3rU4RW0pkBzu6mPAZielFuoRKuFcYFtnsUxsiCs
	xsVlzasHRo0RJMANYb0eRvQHR1TAZe4DwRHBTfNm6RD7RB7+iibyVRSAUEFfRoktCdHhvcrU=
X-Gm-Gg: ATEYQzw4tWDZ24tXHc7SWSv5N4rWOaT+jdtKqWEoB6L/LHWMadgoTt+VLeH93R4vJ9K
	CqOaLjV6vYAC+Y8gv0YrEaGDJiIbud8M+ZExxSntw7shvJa9d18STU2RhCR3xzlNq+4SOMl1thK
	6gSII4oRXtS01I65c5uQZFI4nPjvVhbwCuDEToQ6qrkdZaSe/W2/pE5U18I8FavjiVUPPOHQ49w
	I9rG3jIp8e4rUqRfD0dnOZxlJ/O9RcW25ptGyCitVJu2FB9QeBOTYyJBw85MRqae3QsFhYLfjMH
	LbG/4/lyTgHnCUFesQAOtx747XyFNWLbaVdONUdvhf0MyO+AxDDGWwN/kLDA0rk9QFr9rZed1KU
	dUqfPbn5n+wx9ZkVbn6YFUk/9c96hggZ6QxmNHTwQuWdaTWIVtP7z4JRn5g9ikiIncF6V2JjNn5
	h/y8cqMLtV6OQdMrk22HEsyXfYlX/2bRboCCo=
X-Received: by 2002:a05:622a:98d:b0:503:2c16:c1f5 with SMTP id d75a77b69052e-50b80e8a543mr16740461cf.48.1774385570602;
        Tue, 24 Mar 2026 13:52:50 -0700 (PDT)
X-Received: by 2002:a05:622a:98d:b0:503:2c16:c1f5 with SMTP id d75a77b69052e-50b80e8a543mr16740061cf.48.1774385570121;
        Tue, 24 Mar 2026 13:52:50 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a285206f24sm3503310e87.39.2026.03.24.13.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:52:47 -0700 (PDT)
Date: Tue, 24 Mar 2026 22:52:45 +0200
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
Subject: Re: [PATCH v1 3/6] arm64: dts: qcom: talos: Add QSPI support
Message-ID: <bg6h26xk7cdpf3fx2znm3y5snxmhtrddvrkn5j5ft5uovgpk3i@ume2erp5lrax>
References: <20260324-spi-nor-v1-0-3efe59c1c119@oss.qualcomm.com>
 <20260324-spi-nor-v1-3-3efe59c1c119@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324-spi-nor-v1-3-3efe59c1c119@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2MSBTYWx0ZWRfX/Ey+BXA0+WOL
 5+mU78GzDZT5C30zSS7epiEXPi3GOoIjJ6Jfnfg0sYAw0o/IieUBH4tNpamXlru4ym4fJpYyawT
 oEQMphr5Ft6hmsu27o/EN0E2fFoQx1e7CXz8okYTJoqHr9lOouUYT7H15tL9MU+XmgtH4Qy9xYJ
 JddRWsxGW/AIEwzaxOcqhVwqTwK7/mJ/JREyJAzMUpOi9YHjs+zqyOiMssB6RgNrX1LJ30pW3Ya
 MZApJmb0JpZEYjbjhQhzzBSaJdJjALUbGeLncfqmOdNYwKe7H/PIPSADqX0cLGtbVylQJfm2TTL
 ly2LTc6/WVh8jjdvphkju/lPFqMqzldrIurr78agCJspRYu75PcH6lH46bULWYZm4Y/dGRwfHYX
 /bvGSWgRvQLJ/BtLdW9qqdQm7KHoAjijFbiWUMefYfhIprlOYm3X5jtShiWnADuH99Qux+XyEyg
 VMpbPNE9NG4DyU5LNIQ==
X-Proofpoint-GUID: pjsAzgb4JDYLGSHgXKxWK9JnkJmEi_Qi
X-Authority-Analysis: v=2.4 cv=bpVBxUai c=1 sm=1 tr=0 ts=69c2f9a4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=qq52r8Dd0ieUO58wh1IA:9 a=heC_-aeoyD3psnDD:21 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: pjsAzgb4JDYLGSHgXKxWK9JnkJmEi_Qi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240161

On Tue, Mar 24, 2026 at 06:43:20PM +0530, Viken Dadhaniya wrote:
> The Talos (QCS615) platform includes a QSPI controller used for accessing
> external flash storage. Add the QSPI OPP table, TLMM pinmux entries, and
> the QSPI controller node to enable support for this hardware.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/talos.dtsi | 80 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/talos.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
> index 75716b4a58d6..fd727924b8ca 100644
> --- a/arch/arm64/boot/dts/qcom/talos.dtsi
> +++ b/arch/arm64/boot/dts/qcom/talos.dtsi
> @@ -530,6 +530,25 @@ cdsp_smp2p_in: slave-kernel {
>  
>  	};
>  
> +	qspi_opp_table: opp-table-qspi {
> +		compatible = "operating-points-v2";
> +
> +		opp-60000000 {
> +			opp-hz = /bits/ 64 <60000000>;
> +			required-opps = <&rpmhpd_opp_low_svs>;
> +		};
> +
> +		opp-133250000 {
> +			opp-hz = /bits/ 64 <133250000>;
> +			required-opps = <&rpmhpd_opp_svs>;
> +		};
> +
> +		opp-266500000 {
> +			opp-hz = /bits/ 64 <266500000>;
> +			required-opps = <&rpmhpd_opp_nom>;
> +		};
> +	};
> +
>  	qup_opp_table: opp-table-qup {
>  		compatible = "operating-points-v2";
>  
> @@ -1553,6 +1572,34 @@ tlmm: pinctrl@3100000 {
>  			#interrupt-cells = <2>;
>  			wakeup-parent = <&pdc>;
>  
> +			qspi_cs0: qspi-cs0-state {
> +				pins = "gpio44";
> +				function = "qspi";
> +				bias-disable;
> +				drive-strength = <6>;
> +			};
> +
> +			qspi_data0123: qspi-data0123-state {
> +				pins = "gpio45", "gpio46", "gpio47", "gpio49";
> +				function = "qspi";
> +				bias-pull-down;
> +				drive-strength = <6>;
> +			};
> +
> +			qspi_clk: qspi-clk-state {
> +				pins = "gpio48";
> +				function = "qspi";
> +				bias-pull-down;
> +				drive-strength = <6>;
> +			};
> +
> +			qspi_cs1: qspi-cs1-state {
> +				pins = "gpio50";
> +				function = "qspi";
> +				bias-pull-down;
> +				drive-strength = <6>;
> +			};
> +
>  			qup_i2c1_data_clk: qup-i2c1-data-clk-state {
>  				pins = "gpio4", "gpio5";
>  				function = "qup0";
> @@ -3682,6 +3729,39 @@ opp-202000000 {
>  			};
>  		};
>  
> +		qspi: spi@88df000 {
> +			compatible = "qcom,qcs615-qspi",
> +				     "qcom,qspi-v1";
> +			reg = <0x0 0x088df000 0x0 0x1000>;
> +
> +			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH 0>;
> +
> +			clocks = <&gcc GCC_QSPI_CNOC_PERIPH_AHB_CLK>,
> +				 <&gcc GCC_QSPI_CORE_CLK>;
> +			clock-names = "iface",
> +				      "core";
> +
> +			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
> +					 &config_noc SLAVE_QSPI QCOM_ICC_TAG_ALWAYS>,
> +					<&aggre1_noc MASTER_QSPI QCOM_ICC_TAG_ALWAYS
> +					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;

Should those be ACTIVE_ONLY rather than ALWAYS?

> +			interconnect-names = "qspi-config",
> +					     "qspi-memory";
> +
> +			power-domains = <&rpmhpd RPMHPD_CX>;
> +			operating-points-v2 = <&qspi_opp_table>;
> +
> +			iommus = <&apps_smmu 0x160 0x0>;
> +
> +			pinctrl-0 = <&qspi_clk>, <&qspi_cs0>, <&qspi_data0123>;
> +			pinctrl-names = "default";
> +
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			status = "disabled";
> +		};
> +
>  		dc_noc: interconnect@9160000 {
>  			reg = <0x0 0x09160000 0x0 0x3200>;
>  			compatible = "qcom,qcs615-dc-noc";
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
