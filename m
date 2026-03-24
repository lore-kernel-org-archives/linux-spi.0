Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B021135A384
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 20:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774385607; cv=none; b=Nid2wyudccx2VWI2CUjSG3nMZarUjXsh23r5321wjJ7Yd9bUg/v37I1Hd97Thhjz6ojEaKIhxMzYLBZ1naxQaNQVkHSV81c2BQwJh2gKxXWTN3uVCL3+Mkx3tl1jo/CHGpcZuA7XOoeKw+Q9/QwzbE0p//2e9HXtLI/8VCayrc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774385607; c=relaxed/simple;
	bh=NSQDaIc6B+6AKH4NtV4sGz6xY8nqprSwpjDJbl38Ofk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4biUDzfq50Gdn8NN3gbFyu5ErVf0tobMFeM6hkKtX4EhNINrx9hNV7VTeLzHcZmPwPmOJGXmjAg/0iBiJYu1ME375JeyD7e/yUvSrZrKHcEw0qgpj5zaF+jE0MdlKHnCNYsO3f7ZCmCdk6OCluC/c8zwyTDrxbFKmh0TqZ+Qxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FAJTtUAR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LTQFIWMO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FAJTtUAR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LTQFIWMO"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OJCbta2973524
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 20:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uUcSB1EO0xjAITGH0sHDE53x
	GeXK6K+ju8W0/0xClh8=; b=FAJTtUARZXImI/LjWYXkv0MjSrpJcge+EfNpV98q
	ecHUwOwKTKOJXfoJxj6Vq51JTsyK7wfEj03yZ3rpYWz3OQwFOzjdEN8xiBM5brrh
	bHIP4dH643W0AFpfbYfn8iaMVLhsHYMvaYLGMI4cTqUc6FieYhykF2g/d5/uoFHD
	IaRPYaNTQnxVAafeApodGq4bI+QZ1QM2Ya5LDn/B1ahH2qfg7wJuNQcsqc2ov8GD
	Ya0yu4/mBS2EwN32TryKQahLZ91Qqp9ULB5+xbAawN1/SgAFbYHxFgtBUleYwYQz
	BqKvjiU3YQ5oLVJhs9GJm30RjAe0v1n4ODjvSS95v1riTw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d40f4gagd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 20:53:24 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-509219f94b0so134994191cf.3
        for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 13:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774385604; x=1774990404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uUcSB1EO0xjAITGH0sHDE53xGeXK6K+ju8W0/0xClh8=;
        b=LTQFIWMOw2kFGKuSEerya2ErjKd0B6VisgTq2vTE2U+UKoz8XegQ+FOeFPNzee4Q+A
         KCfVQuSfJYJIzsEUvGxGkbWUES84KyBcfXuTVjyH8xKUm2ANXS+3yKsZEgJahyR6tixF
         s1UAzgq4VNFkgKMcLGuJ6C1g7oDgxi+vn2ybV5cjhGf6NnGj3Ij0LEV9RdfYB/vmCIql
         SjK3+40NUR5qgpP+KHAhYAmWYQ7DGQzlL6cTzXHE3W+xQdy3vrWrQqQrXUlQeRU82P2E
         n62nfOfcfE9JbM0iLEqEE8Lom7+pp/bvMLD4liz7dzwXxUamEG1G0fmmYFrtR1Ea2Csf
         F6wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774385604; x=1774990404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uUcSB1EO0xjAITGH0sHDE53xGeXK6K+ju8W0/0xClh8=;
        b=imzPpPRrEpmq/SVA3VrMt4MluAS9T+w/B2psaizDMsaysI8jOPLOhFdUZhPKa9ZSXv
         UD2aa2UbzhpCywDLvPMGkqdi1DvGCaa/BOJcX23G1TBmXnVtLheiBrZ9Z8YoPhGEJKpW
         /pByK24IaKhWRudswY5GkOGXJcFsLy5z3okF2o0f0owm3j3KsKiNTOW9fnzLuyPBnDF5
         UcpXtAx/pM4mR0r/xS6S3PHTrYzNvJDXlGlGbela3hOTzbjk/aShFGelrZjuVTNNd1TH
         MOY1+NFe1EoubJy6638oHdedebfmgdg3zGDhQjstavsg2njpuDd2HdSiE91OFvLF0NWx
         guEw==
X-Forwarded-Encrypted: i=1; AJvYcCVly8bKr54CSsH0zTtnYmgYQOE0imBI9nnoR3dcHBOOWugpySYdnTNIZbMUXln6Zm9zc2LDKDUIWyw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFiVulPw+d8ux75iXYFWUaF1fxEz+5rMP1q17XyPHz7KNlIhnS
	uIxd3gNr/X4ps/m5I6U0cCbYOP54InWYj2VgaFTsU9l9w7AVdvv7/lQLoBSt1TYRzylj5wrrAO9
	IrxuUgDw5gRMfqb5EqJTPE5rJveIT/ubgaFmtBqiHHMAuDHykWNUuVksAeMMfvnw=
X-Gm-Gg: ATEYQzy1cvYtfK0mLrM2uq4PO9aw8a0SIUKEySa5cI9Mslo1rXhAaOWQoCt85pBn600
	cLv3YbxZs0DRhOT4dolE70TCsmoQehzQM49vhtexExXydvL+xoqn9ZnZfxkSK/wGLWwlJDXGBkw
	uyOzFmMjwlAdB0yz0pOdjGVIZMqNoXdH8GWfyrJgq+FdQQ2DA+jGk41tKNBfuUDRX1brsZq+Cpi
	LT+ntt8XwIX7T9Q60kDLL8I/Uj8HvKFMDWfxfG/xd+N2aEK3XJq2zZZnkHmh4XfbVjsrgXKBRu7
	W+dSCrHoiep5cTgk7vK5tG/MurGxl0AQ9xu1x024119gfzS6JRfLtmjWjyHgT0zRc/bbFglNu/b
	iy1NgK+NUC5QK7MN62BW3cE4dXe7MW+C7Q4mDgvU7FK9A+MMQIxXHudaEWYcoijm/BCqWT7oQoO
	u/XkTEUlxLBfhRq/MP8xozRIEAaZmWQPXaSzI=
X-Received: by 2002:a05:622a:8310:b0:50b:5258:28df with SMTP id d75a77b69052e-50b80cd1eeemr15392381cf.1.1774385604092;
        Tue, 24 Mar 2026 13:53:24 -0700 (PDT)
X-Received: by 2002:a05:622a:8310:b0:50b:5258:28df with SMTP id d75a77b69052e-50b80cd1eeemr15392131cf.1.1774385603624;
        Tue, 24 Mar 2026 13:53:23 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a28530ccf9sm3368152e87.74.2026.03.24.13.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 13:53:21 -0700 (PDT)
Date: Tue, 24 Mar 2026 22:53:19 +0200
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
Subject: Re: [PATCH v1 4/6] arm64: dts: qcom: qcs615-ride: enable QSPI and
 NOR flash
Message-ID: <zwfbabbr4bwlq4bnc7hwy5gbfrs7j52mloukkmyytxwqgl667z@eoq75ye27yul>
References: <20260324-spi-nor-v1-0-3efe59c1c119@oss.qualcomm.com>
 <20260324-spi-nor-v1-4-3efe59c1c119@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324-spi-nor-v1-4-3efe59c1c119@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2MSBTYWx0ZWRfX1+Qo/3xAFRjV
 mrpY2umV3V9WTKxz4b6gcpYcyGJPSU0eIyn2lpjJQCwjwMlv9Ub7kyl4l5B1P6jQGM2KwM8cE79
 oZ6NEGmP+yYbRnbv8YShi2B8OAkjfQsLRWMPqD6lHwy9wtLIJU61MWkK5DqC7PusjLepcRi3tmT
 f2G+C9RONOX4yFg3HaigMYe2HoFvmpORVvfun0pxP4zUU1iiuNcKeg7milbfBu7AkhKpuUdMRXL
 zWoeRFtxYhhyRxY91SwlxP5eNaSPG5mRHLQgKyhr1JJoO6yP+c0DvuQ9660L5sctOVzp+wIMm2o
 /bljX+eKr8g7+fnJxRfZ22gWSRRDcDrveThRi3gZT5Jx1MIzkE+ugjxpF3xpDzopAt9Lhbu0Wco
 LDStWsOxMiDAdD6h/p/PVSg2o2YGtqrj4I1KmtuPR/VchcQKFvRtR9clR0YXV1y2DKOCDm98r6n
 OCExyk1jj3eKLeexwRw==
X-Proofpoint-ORIG-GUID: iBg46zdfyQ5yKR51aZumxaZvQfL3uioB
X-Authority-Analysis: v=2.4 cv=Cd8FJbrl c=1 sm=1 tr=0 ts=69c2f9c4 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=Nlfn2TMoNVKOkoW8Ct4A:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: iBg46zdfyQ5yKR51aZumxaZvQfL3uioB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240161

On Tue, Mar 24, 2026 at 06:43:21PM +0530, Viken Dadhaniya wrote:
> The QCS615 Ride board has a SPI-NOR flash connected to the QSPI controller
> on CS0. Enable the QSPI controller and add the corresponding SPI-NOR flash
> node to allow the system to access it.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs615-ride.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
