Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CDF359A81
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 20:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774385485; cv=none; b=ZFaRND6MVGrA1tAOApN6/cZFGGhK+Udqu93m4BMcZ30m+HDKcOSosZgQ0emKuVXKYz+YNJKidp4V8pf+fSG7r7q1hCSTPO+ORZC4RHubdW2uK7dOYkU/6cjtb/vwLa1XG1CeheuoHyR5pY1DS2Ua6uG0En2Pz29umr6eoLDJICU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774385485; c=relaxed/simple;
	bh=MTU+U57pNpsq/dzOmftTdumIq1xKapp8p1N6d4QSp3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjL7gYRqlGGKHAtqRE5M+M2ybUT7m6OM4TFtezh7rWLREMgEe4Ebt1oVhXw6bun5O2RQlLM0cW0zgAM6QWpTAmoCruxmm+dQw8r/zehiLKjaYO+ib14agFmv0akmF4m+26BbknbC83eWqvxiI//v5vab3zHH0H3t8ZT0vsOZZN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=byJTW9Fj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bWkw73et; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="byJTW9Fj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bWkw73et"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OJCsTa104383
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 20:51:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LasjIgiDMjJB9GBC9e0xgSJv
	HR934FQ4A1U1HCWpijY=; b=byJTW9FjRi1+CaqmpriT6yB/g+DufB/jf9emRqJt
	09A11AnuYulJOltfc1ITWNfwCPG2cohwMiESWI+prRGedmRYcpRtyQHVrlEo1tSj
	4XPPj6DIhcrn8alJV0Zo1+K7yiz5HVZ4ATmwpxyBVcW5JLCqcWRjwOMgnxWwZ1tP
	VeIMERU5bNZn6Qt/JtNsano+Mb3TInnHeRgEMJVYstahmxwKKrb1FqKSGb5tAK2M
	tOncyh5/GlZcnDBm6ERgRtAxsmFrkcvy9KiHsXKBD1ounbb2VJmf+yz1J4FWSFEX
	2vAh0vEV05Nm9TtdcwY+p/7rfyaTG4mVtYU1VFWY5Pm35w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3rf0jf4g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 20:51:22 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5090bc4823cso275652381cf.3
        for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 13:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774385482; x=1774990282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LasjIgiDMjJB9GBC9e0xgSJvHR934FQ4A1U1HCWpijY=;
        b=bWkw73etfHIBRxPMhssFrE4TmkSSdXS0/k9dOUxGioYy2RBfkEX7odS2SgKjz4hdyr
         7KeTSvs6mPKFt1GYHxIcDCSznX8zVpdM6EjWnME6ZTWjhLssGfzI112aQdxLwl0pBttQ
         fYTF9jJTg55bV7/66puAr4uqbszz4tdKH75CgR66EvsJmQeW9+shrQD+DyKf1+Ac2mGJ
         +OHJcHpYB7yTdGVbPGvYV5ImRAa3S2RuvR6OjL93rN8+PjvF8990qE9MeQez1RkQ75gm
         LoOfm96WPmqaHrpCf7hLXleIgK+9Tr65FOKKCeXa6gaNcRB8iMpASBREMlaUlCVP55wr
         UZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774385482; x=1774990282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LasjIgiDMjJB9GBC9e0xgSJvHR934FQ4A1U1HCWpijY=;
        b=ZJkprLmAL+7QrUfncTFcVJC7e7PHoxWUu7a/ZzayHfKAOJrtqCvSeuSi2mntw0k06N
         C3LBtRL/WOWX+95mzlz0XHVf3SP4Qj5/o0trTSzU8WYcmQdkdk15AI+Wt746MZNHCRjG
         3r0APnpbI6QcazBFsmNp+W0JKvui2a0jPOBvTYpnlbW/K4gyp9sdgiTKM/lKATe5uL41
         JLRyc4UbZrjeiPP/womli0GLqNUyBhFnjF9vZpmB13OHW0XRwBmWrmBHuKBaLJKYrLUC
         Zt5vZ6aQyWXMp8R6tTYnYi+3svedHOaZv6dCWpuzyGy79upUcXEKSrIhMqNSwAnDDvTx
         XiMA==
X-Forwarded-Encrypted: i=1; AJvYcCU7wwKCyDFjyx1zRrQ7xroqjON2gICG5wszBlJ9zP+EQXuqQceUvwOv1aFN3NItoLkVdnlfh9yhnTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLBM3j4tCWIoFVtp9OQu4sYrjtDHfZBS6STePty+gspzhnztdf
	vD0PQKXb6BPLqtzE5iP3EKsNWXdYthVNxaq+4JvBWgAf56hCoWiMNvaTKUmj/7R7RUFSwu/L2l3
	kncFr6xcDkRvc/ZVM1VTqUdte2vugVj45XzCm5Ruvw7pn72NXqY2jP/+4w3UHgN0=
X-Gm-Gg: ATEYQzxuUfo9FfiOpJloifQt7b9D+wOs89E194L+Hs9bqbIkRc3uCXa9Z8MIrz5k6PO
	11RGpTABIMLZnc9aAk2X8BW55ZUjJyY/eEi1mOe8VB3mWsXwka3iShHBDOiifx8R8ayVvMY1i8s
	bT4fg2DuJ2odCej0NjgYpTkIp3dwPTVdndk4dF8I8NSJ2pStZsVWzUdHFQbYjHmsaryqmldasLJ
	L9Qy42srfoL2C2eB1zqBJpgOTZff6gaIJL9f3+e5M3z2B0ibaUV7iBZGBSX/zFgBE7zHtcz6/nu
	DgpKZVC1cR/sQHI3oG5Hq/nhmYY1QapVXWnM613/xilYSB13EDgBevGYsA8jUhGMSkBAuSxNg6i
	6yJpFoJ0Kol7g89r+HXaSOmzSh4MA5TcXQvHgY2f9V0GZnjCGt0cFLnBFxbgi8tww+aSLFV9K5G
	O1FSy9+i1HpwS7l0qPhJ8jLa8yXx2cI2/jF1o=
X-Received: by 2002:a05:622a:6684:b0:50b:1932:c9e with SMTP id d75a77b69052e-50b80ddf966mr11474991cf.39.1774385482006;
        Tue, 24 Mar 2026 13:51:22 -0700 (PDT)
X-Received: by 2002:a05:622a:6684:b0:50b:1932:c9e with SMTP id d75a77b69052e-50b80ddf966mr11474741cf.39.1774385481534;
        Tue, 24 Mar 2026 13:51:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38bf9982a6csm33495351fa.25.2026.03.24.13.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:51:20 -0700 (PDT)
Date: Tue, 24 Mar 2026 22:51:18 +0200
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
Message-ID: <34cifkyw3pgky4nhcu4jwf2uveszre23kvesr7ksyjvmqhfspo@avsvwa3quvsp>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2MSBTYWx0ZWRfX2RU4Jaj9JHjJ
 rEOvqJ+BqcQqRaU6kIEpGxps4xMdh0ohzssONogI5BP0UequLC+BPMa0JEw6yZozrWrEZN4aqB9
 /p4uPhGJyT+Jni5tvGEMGdgAY6djf1GVjopU8dzksNjUdsRg5ZV7pT9DVMlCwgqbGLK5MtyPrA3
 TVT7HLBhDU0iyIuGggvxfmDyojjSCM8wYC7Eon4t1etUweoCRr7xwVpV0Hzqt7lnox3siTMcEVD
 gLZ7g5sGa22zVts3+C0xxx33RYsz1bOao7eXZS2DFE2TXDr0C+78nuKBAGGA1CNAmUPAuBtTh5C
 83Patb+yqg4Ty88MiQLYYcZCDiBCcHF1D5hrIZVEIMIGS5UdyLWZZi5D/IfTvrr6UAc2fXsjfBf
 bast/3XQm7PwwjVcKszXbFGuqHmLvGNWpi0eVXn71iBvbOPYTCufp2PKIxGYcT4J2o5qNp+xGqy
 rT4QmUh7iBrSlMkjKbQ==
X-Authority-Analysis: v=2.4 cv=Ua9ciaSN c=1 sm=1 tr=0 ts=69c2f94a cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=LxJgUt3ayfaw469zrgcA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: aV9U9in6834NTujhV_UV9HQ7NHGXCIJT
X-Proofpoint-GUID: aV9U9in6834NTujhV_UV9HQ7NHGXCIJT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 phishscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1011 impostorscore=0 adultscore=0
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

Why is it not defined inside the QSPI device itself?

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

-- 
With best wishes
Dmitry
