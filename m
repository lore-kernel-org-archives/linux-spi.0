Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0992C3CE4B6
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 08:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646678; cv=none; b=lq6r5V3gAYc0IDHJvbrKsUHG7d7nmKjXLz2ntkJUCEHXZfW3HQcw95hFVujmpdBMlGfqP9PvibOUA8PnnwxqRzjB9BpU/tmTfrsFwQYXs1BqGe156x34spg0hrJJK4+oJ1jwZuE32h/wBGW/cQqjruo4e4x9cKBHau2KbOyhawY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646678; c=relaxed/simple;
	bh=1OcT/+68aFgiyGo/IZHJDt9O/nR3cz/ZEzkgZtmV+50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbuGG/S+aONTvXgqdLXG9hOGVEUKZKSr71QaQe0A+rs82xwAO+69okagYkDOUu2lpr54Klp+tCBAEkOPcYSrT4JDqQMyrYDnaKuynhF7M91Vn7tBSaTGJTCKX+XQriZLyvAi3qDT7AO3YacEK8PXm2q8W6QrkvT4ZMN3Yxps1h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KDApZ35E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PvS6iV4u; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KDApZ35E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PvS6iV4u"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P88KST2387851
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 08:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0XQbf5evE2zhZ7gWH4294Whbd+Ksxk5D6CkMg8YLsEs=; b=KDApZ35E37DJ2vhp
	7Muf78TYL43ahPAlTa/ldTntpZQtdZdPgPJqu9+PuV78ZRj4e6J/DD2+tyBaOPH9
	QqcZZT02Z3QNRFXwZeWJW1Ek+aIaHqWtpCFfLCFlUeo6/ishkljVg9a8yKxGYHuR
	q1vrCaoqGvxQBlNn+U1PtP+L6+qBbKTDaQK1oI0ri+jU4nozheNKVThig+eVWO9C
	odUfQc3GjX+gRsct+EUqBhluIMRKtNwSyj9rYdUwMymvJw07wCQcKWzli4ud7KUf
	zQqmLenGMy9h1lPdJKqn9NXQK9RKDMe6vZtdwu0IC0TcAmiBgx9UaYeFILbwCRO0
	g1RIew==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8swrb1r3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 08:31:16 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2d6df0a1e18so15529325ad.1
        for <linux-spi@vger.kernel.org>; Tue, 25 Aug 2026 01:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787646676; x=1788251476; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0XQbf5evE2zhZ7gWH4294Whbd+Ksxk5D6CkMg8YLsEs=;
        b=PvS6iV4uj/ZMhjyRAmWWbE8JWcgL5PRjmIp+h6GwgBqelAw42TiS2/tukoaguaOIuV
         QZBxbmV6ytwCIeRgV66KDxlDws3tUzf7OrUCvU+cVxr4dq9XMRXmychkLBFBpbrqcama
         XQ1yA+mVhvG3pqcRG4MD5ySJFH8BrBimKMQiAh86dtWv5GNDWuDPfQnTAfPJvx4QLIti
         zY2uwJZujCaf8e9VhSyPEaX7s6DKxeK9TKFtwsRFRyfES/iZdx3DBHVdTnFN0H8QccwO
         3N6LrnBIoLwxpuGn/CjekKb2yil+PmdH/SjSqAkNpGaEYCwE9N6AIxUFxZAQp83LDw1j
         SJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787646676; x=1788251476;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0XQbf5evE2zhZ7gWH4294Whbd+Ksxk5D6CkMg8YLsEs=;
        b=NwUR06U8vsSue4PbY8jAAc3Ame4uMaNinF/rBOAKbtamBdUc15DnSKFqMbr27kSuwZ
         J1mEn/X1S1PB9ZORreL6816guMJKgvX61TgiP5FXTNcAQi92Ox8M9kUiASUoETTkZfuk
         0d83u3KUjpnshvKyl1MRUom/PAEBZkrv/bJ+Ayg9mn5nZp2q2pZImTjfxoGgdGU7I84A
         wt7ouUokBttjKZLAdBmngfm6a9KDw3GlIAZ9FX+1Ut7Hp9b5wk97EUmP+ifnt2HL7c5n
         3wz3OPWkAd9xmnG6koUJm2o7rhBGTKDsGBh/BPRhid/rgTdlXGtd30AuVAVgdG1RaIEv
         2yfA==
X-Forwarded-Encrypted: i=1; AHgh+RpHzIILeGfB/hGmcPelcl5n8F4tSRdTsjIjV9owTor1TDeQgq9qC+avrWRbtl3T+idb+vFAmqiHPhs=@vger.kernel.org
X-Gm-Message-State: AFuF++nFgmS2tybIkZmhHxSVgx+lixzAdwoi7EYQ7hjwhAq4+hSWaYjU
	tAUfrkqrlDOt5HqRK19l04Xngg2ZBrMKASBY4q9FLhU6DsubzBDO5d0IxzeR7izfUDQlVMjhUrI
	5DotQ1D43+Rf1MnCJmYdIbnVgNKJ3QDL/Lxc1Jttn/yJv7um+PTPPTBWe/exckIo=
X-Gm-Gg: AR+sD11eOI92lJdbo2+SYzpR+21ublcOsSEvPJYP5FhxY7nsRVqSwfBlpol8wIlBpMZ
	KaNN7WvtXfYVYAp27FcOsIJt58yujueSb3MTi4CMwDbrrQQRhN45JJVyAN66CCBuh5OTd5Y3aGr
	+bSi9on5jqiCFYTVw3o/871z8/Qlqb7HG4cDPGh5Iu0+wUn5o9pNGKVYft+rmUHyJD9WxmDairW
	8GNckscnwQN3hDgQtXXgSqlRMpUsyTWNPk9TLOSUtjwBcsW4nBs65gbosEei6tdnTvIZSiK56kq
	p0Njcy2HjKHmenaBlOtuWmkDZbzFK5sDk7a/Sm0vhxseX3xxhUfpCyvKeEdGBSFE+VbWq8DvwjY
	KJ+GYc6f0gB0KA14Ha94NVz7VtjJmZN3v3Xo=
X-Received: by 2002:a17:902:e943:b0:2d6:3c2f:69b with SMTP id d9443c01a7336-2d64af6f8cemr618485515ad.8.1787646675688;
        Tue, 25 Aug 2026 01:31:15 -0700 (PDT)
X-Received: by 2002:a17:902:e943:b0:2d6:3c2f:69b with SMTP id d9443c01a7336-2d64af6f8cemr618484565ad.8.1787646675240;
        Tue, 25 Aug 2026 01:31:15 -0700 (PDT)
Received: from [10.217.218.158] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6767ac8c6sm25061425ad.34.2026.08.25.01.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 01:31:14 -0700 (PDT)
Message-ID: <8e4684d0-d130-4c75-8b28-11fd98fc4a29@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 14:01:10 +0530
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: qcom-geni: rename setup_fifo_params() to
 setup_spi_params() and make it void
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260824-spi-qcom-geni-cleanup-setup-fifo-params-v1-1-bdf98ae62953@oss.qualcomm.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20260824-spi-qcom-geni-cleanup-setup-fifo-params-v1-1-bdf98ae62953@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 4y9l14ABRE2wSNLAQyefh4OSWyEflI-G
X-Proofpoint-GUID: 4y9l14ABRE2wSNLAQyefh4OSWyEflI-G
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA3MSBTYWx0ZWRfX91FuJr44gFuE
 /+sYSqBW0xqJ+hCKzVlK1XiYDHvDeJkiSJa27cIK6x/OTJ82IcN5owRhyZPOZPwFfCfkkeIrCXy
 7oqLrQK5V63rTTB8hKoMAIkgM3vrgTQ=
X-Authority-Analysis: v=2.4 cv=TqPWQjXh c=1 sm=1 tr=0 ts=6a8d52d4 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=pkmFLQsO-xIKxrFyL9MA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA3MSBTYWx0ZWRfX8oiy3Rxywyns
 EIN1uiVoKhUPY1qIr2bjgFtVUNWUot3GWl04S1TikbqPGwRe9F8I0GTsEmY4wbVBm/yfuDZLLvQ
 oSxwUwvQYVPl6Dfa1pwBbgQSCWiCjnVAc2of3H++7gnfTn4Hjvlg6m5N3I8s6PrWAWL4BP9otIe
 9R99zx/8nxSZMX/CHqyq+H4sGOAJb+/Y6AWU4QYwmNs1pogqepslJKvt3vrP5FG3vzSV7gePr4y
 gfNXTf+BnY0DFbe5Fk1sBBJj6uDbwypIBBLzPCp7LvlS8rK77brXDR/FpbBYiwUytJXXvJC9Tdm
 dRIBYVROXSQkOswfna8501RapfQ/d2IfJ0wAQiSJgMhgOpDC7Hp6mTRLb7/fCRYgd2DcladrFBq
 PftFBHOw3edlLXJmhHjqveaNJF29mu2EDu59GX4VIQGtUJ4lWUuv5N9DQFHpQLgYl1kU2AuACuR
 Wqx1SIFTBTbg38a4N7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608250071



On 8/24/2026 3:43 PM, Viken Dadhaniya wrote:
> The function always returned 0 and had no error paths, so change its
> return type to void. Drop the now-dead ret variable and error check
> in spi_geni_prepare_message().
> 
> setup_fifo_params() is called for both GENI_SE_FIFO and GENI_SE_DMA
> modes, so the "fifo" in the name is misleading. Rename it to
> setup_spi_params() to better reflect its purpose of configuring SPI
> mode parameters (CS, CPHA, CPOL, loopback, LSB-first).
> 
> No functional change.
> 
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
