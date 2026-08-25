Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6073F4854
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 10:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652587; cv=none; b=gO2nwY+VlkH/lyGcdunDJhi4GMrKmegBvqWqlYqtZCn+80z29VDPfLiCksNLSBCozUuTGkohN0cAxTyYPy9A2K0czApLZWeTg8D3SSzkmD1Ol7TVztlbGdVYhv+k6qDp1vNfiDaxkkIBQx0nhf9eoNrImc8ZfKtkzdiFPR/3HPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652587; c=relaxed/simple;
	bh=KgPjNR1beIIVR1sLf+AckdqU/z+Gqj06uIHvw6+fvdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dR+2l8uQqcMboy+J2xd6we5+oYgmHFQlVjb4Mj5DLIyTWPX7YB/E4GVRJeXe6kA6ImG5OZo4vmQxueY9TurF5UcQIz/7lS2G+pXsl35CKFdh0R4TdWABdU6mM5G8x1butTtdV3xlBQBfCLY0pcES56Zu2M9rJ4hrp3rGu5cyjBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=o07VeGWR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SPZMZDri; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="o07VeGWR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SPZMZDri"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P88QMf1359551
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 10:09:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=eMJa30H7DkzCjuo1rsUnN+eg
	1rmbr25bqyL+tJh6XTs=; b=o07VeGWRriS/KUySrEGVaZl8V+7909ZIIysaEWFd
	JkmzYKiWCFRcv6+8zZSMH1I6ztMWzGOnjOpxOKE9P0LG2cib3W6Pk0+UQYe2NX5S
	zrSz4bLORZWAR4smTVN3r4QfbZxjRPvQuBNPvuWA76IhsWejIF2XyKQnN48oRzB4
	AFxtofGs5zIYAMQJ8bwRA9PP407FJFSjWTz+GmVYQ1SRgDXxpfjm3/irxfsEfLp2
	2m5H6Sog3x5JfR0cgH++i284You0V7CF7joSRkWHUIUKwbQbd3Ftzw5oOJfs2Yoy
	RQ4PNRIstHidSjiL0alj4w6/ZNYNbSuULxRGEFFTNziz3w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8swy3ebq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 10:09:44 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5174a23afcbso65015861cf.3
        for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 03:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787652584; x=1788257384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eMJa30H7DkzCjuo1rsUnN+eg1rmbr25bqyL+tJh6XTs=;
        b=SPZMZDriYLpI3AOekXAIGQ8UFoCQ2mIJEJsuO9AU8ZhjD8j9lJCjZ7uCBOvhzMSz2K
         4tO3StWja7cSk2ljyE/XVMe+TVJ5q7SOutiCREojVIBzIP5tDKjaVPX1EPK8ndxSKDnq
         Mv3dkTo3jQnbrsA1vpC5xQ4Bhm7BkC/NJDSxO4M18NAMFJ0uLVi1671EYQHmRYNiLe8S
         JjKeuEVe7VhiKRCdSZBGRXJxyMFUgheTO+whyYAu0dxlW96Pbgq/TFbYzC7rb+p8/A/x
         EHJ0KMSHBsrKYVjLIhHtiSFN7zsHXAm0/qRfMMp5kzVraDbe60Kf0y5AEWmzBd1IdCUa
         /GQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787652584; x=1788257384;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eMJa30H7DkzCjuo1rsUnN+eg1rmbr25bqyL+tJh6XTs=;
        b=MrIo2rpdZF6K+ATUNww+LyRv/9DEa3Dw2RNpntDkeA3qYYGR4t6ekL1462GCDwp689
         3usbIj3D3ovh0KvHQi0db4bn6aa6/Usr9hj2/g1J3NDAtBuY9EUaf7GCFOHfpyJvMKVr
         myX6aq7q8r8bjziAiR8ETmEAgoATJM7mp3umJeExIQ4RYZ3+tUMZpsRMYw+nvYrvwI/M
         oPPS9y8/316a1Q7GiYDwtyEBrl5hcw1cEY4C681GPhieabXz+bQmns6j883PPuZbCV1l
         YQ1F/bi/KR8ZbMkrGL4UiRTICX7QvxkvFmokdb1cB8+d0UnljaJ2hhTyBD/NltX38vaT
         yJnw==
X-Forwarded-Encrypted: i=1; AHgh+Rp1TzX8h/k4m4EnlJ/uMUtvjeuC73HF3KXnHrp28a2sW95Dnjv1Yk4+IZZ5eEh/L52qDPZYGHwSCLQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mvlh2Nuf2LpoN676rvMV7DCuyiE6Pm2zKlbK8kYr3RxmGizWNI
	61P4A8UDR45zp7GClJJYoKURAQkudhZsZ8rjwyZFYJi1nMaT5ac8vi+HEfgvWnCR0X6lYROktHi
	J8btM3TyMmwE7cjc/DV7X1SkIoHSrBxpqm8HLGts9mW9H0MhgDIgOxPh2kcC2ZGA=
X-Gm-Gg: AR+sD112CHI8MFa8DeAu5beyh+ReozPq/6qjOElUXBKz+SuL5kn2OSifmVWGaj0EZ3w
	/Ls5SwqS/VqREMDhJFPbqkdoa0UlSXnTQCzo72ZkETlkqIqZ7FXBtUD4myD3n+3CC1B40to7T/i
	jpLpABsPnBYNXP9xUP5ZVa/sKa8JMb4tIMz1kAvdxXUfRZDi6gFHSIcuR6xuyKOlN3rjX33j2/H
	M51c558f/YdYzhmUCmyOys9LKUqE+lelwsxUXnzZEruLhs9mak/69wiVDq5vGjT1xWauTwLdJ5V
	97z0tkeygDoYWpFIR8fIe6VUdAybvV3DDFbng1jrudIDR0OoJYPlNiY/X5KWNS34/K2gCU+LOj3
	By67RFjtZXoc5
X-Received: by 2002:ac8:5881:0:b0:52d:ca81:e5b7 with SMTP id d75a77b69052e-52e2f069100mr52551491cf.8.1787652583690;
        Tue, 25 Aug 2026 03:09:43 -0700 (PDT)
X-Received: by 2002:ac8:5881:0:b0:52d:ca81:e5b7 with SMTP id d75a77b69052e-52e2f069100mr52551001cf.8.1787652583117;
        Tue, 25 Aug 2026 03:09:43 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249606a8fasm1874057466b.8.2026.08.25.03.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:09:42 -0700 (PDT)
Date: Tue, 25 Aug 2026 13:09:40 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: qcom-geni: rename setup_fifo_params() to
 setup_spi_params() and make it void
Message-ID: <lxif5gsyfq24aq3vsiing7xufwdmhllmn3gzdm4sqopz2ttele@myvffcz72jqq>
References: <20260824-spi-qcom-geni-cleanup-setup-fifo-params-v1-1-bdf98ae62953@oss.qualcomm.com>
 <8e4684d0-d130-4c75-8b28-11fd98fc4a29@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e4684d0-d130-4c75-8b28-11fd98fc4a29@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA4NSBTYWx0ZWRfXxf5OpiLQkifT
 EehWdBZlvj+Y3cDoPfXLb1kkXBwRKt5jRKV3tuOHk2iSaqetA+2t+CvW/ZrnKEtof03RS/P44Qq
 NU6mmihDJHBP270lJFStBVYVz/Vv7fboZ9cWwp/Q303gG/5VjZ/baxdLZ8LJBpCg5hqE72tBQaY
 ih+yaUQYwS/IuN2XfW2DcG+e0VbNuS27DpVXItoZ9Tzje0D0GXbEEr1EyEuUJDA0PkTxkx5w0Hv
 QHbG4cPaGRs2OPOaKGpm2SFp+Xp/Sfx/WG3yOIXjEdixBTDxirAbX3Wsym47arpBvwFsJTtBdr7
 iXQiuTwSj10vstVF0nLrzEXZWq+UCDHqaIib1udKgEN4/bLdFJ/L8/gGJpeB6IkDByRqTfHeY/h
 pNfzLg/TMJEjCkhpkesx3h6gJRxuto2PSmrMOFlsyyBTpZjW+ytnumsnOrbteQ+HZA4Fgi4CINg
 XrTNZdfsWQpJgGvhxZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA4NSBTYWx0ZWRfX75c3AGNS1r/Q
 gwoNDFun1cIzfkqp21r7vaT/8GmNEQhS95ypOxuAGgv3odt2fry9SHdk3w4cc+tQwdTbkCwS40e
 u1teYaLDws8BrKSfwQFJnTnMN5504ws=
X-Proofpoint-ORIG-GUID: Q8tHrFH0XJ_Atotz9LaBaOxhgFnwa9Vh
X-Proofpoint-GUID: Q8tHrFH0XJ_Atotz9LaBaOxhgFnwa9Vh
X-Authority-Analysis: v=2.4 cv=QIlYgALL c=1 sm=1 tr=0 ts=6a8d69e8 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=clBUptZa5v5FR042Ey+sjA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=l2S-4nWEfdgaFz3rMeQA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250085

On 26-08-25 14:01:10, Mukesh Savaliya wrote:
> 
> 
> On 8/24/2026 3:43 PM, Viken Dadhaniya wrote:
> > The function always returned 0 and had no error paths, so change its
> > return type to void. Drop the now-dead ret variable and error check
> > in spi_geni_prepare_message().
> > 
> > setup_fifo_params() is called for both GENI_SE_FIFO and GENI_SE_DMA
> > modes, so the "fifo" in the name is misleading. Rename it to
> > setup_spi_params() to better reflect its purpose of configuring SPI
> > mode parameters (CS, CPHA, CPOL, loopback, LSB-first).
> > 
> > No functional change.
> > 
> > Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> > ---Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>

FYI, there is a chance these might not be picked up by b4, when
applying.

Make sure when you reply with tags, they are actually part of the new
message.
