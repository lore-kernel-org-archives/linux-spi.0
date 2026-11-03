Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706837;
	b=jsE6h7jdciIqFmEjLyYOr6PQ3a8UHs7C5obyBLkwO0MgZy3V+b4jlk8fjfe5G2gVU5Vh
	 qcUjIKKafzt2mR8fwXDYRATk1jsQIPHZRdbDnIP+e+UiMzFdKGCDNFHkiAUfZGh73fFGm
	 sU2pyma0Aqeoe8elEqOpQ0ukdIK25oUzXk9MkcNf7jvvA7D2D2R0+rn30jRC6vaStHUZ6
	 ud0crswRLZGT38dxCZ2PK4Ym/ipaC1vAezvveSIW/5wlOp/6nfTISINTp/unPi0frFkTI
	 hwZqri7RC6fI11VdNswpsrYfxY+GKxD4pQtHuq56TP5zyj2yFtP6+Ai/vjPIhEJfzaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706837;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=qgssI0xYpOMAH5iVIdleET+YzqyBmZcZ+a8GZf98ttY=;
	b=Dr6j3vp5vuQDnxjeU90M427QRCJVtJEX699Wd2/6ozsmh9nY5GwgSnZHUc07jjdLo9bR
	 yEU4/994ojIQhIj73DEt/8DxA50bmLy3xd8Wa2YOKsUH+2doi69GMv17XlNeFfWnIpaR2
	 8ClS6vk7c1RPhRQ4EX1UJO69W4XmXNEnHsfgs/UFLLp/tAdca8NNqKLuQS2sOCOQTgMo1
	 MHEvmPqn3ObQ2a1xdlzc5rsQcsmTcfaXKrhxzVTA+1Ata/4e6yOuaUg+CSMr9QHhN+oZJ
	 6tz85U9/2HMb23fV0HKhUP9+cyOD6ADA6mN5QocyC2qVs4sR77l87gWj65wxZE4I9pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MWWjy+ZV;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KK78crOG;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F3E606D81F
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 11:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69F3E606D81F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MWWjy+ZV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KK78crOG
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3AAF0m2522010
	for <linux-spi@vger.kernel.org>; Tue, 3 Nov 2026 11:53:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qgssI0xYpOMAH5iVIdleET+YzqyBmZcZ+a8GZf98ttY=; b=MWWjy+ZVi2QdM7hV
	mqTyO4PsXxS1DeaTU7F0pAhk8eTinZvdhnDH3UY2nWUpcmotKOOoNSkfFYno6zvP
	REV6ABDEPV1Mi6FxJu8o8aHXxbGZ4bqB5mDrgZsk6oUaMDz/uw8uPELXjz6h/pe9
	XHsfsSXDnizijPjlIkO1rH/9HbhyfxvkHInASLwANmxINNEuUt1A8Iq3uXhv8gzD
	jtrLtrSdpmgIjQyTpzH4p2jGLgzKVv405S9fxEOkSFBSK17afQ5ypntnmcE+zZde
	OxDAZWtoPjUvNfQ/RumMUqU3vTm1o3B2J1r3WtcAYbHiubHCK8T8v5pdvCyKmcS2
	dVepVA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq4v5jgj0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 11:53:55 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a05a4396d2so3022242b3a.0
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 03:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793706835; x=1794311635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qgssI0xYpOMAH5iVIdleET+YzqyBmZcZ+a8GZf98ttY=;
        b=KK78crOGmZpSA555x++KwTfwjDuBx0eos14VrqpBCgLIy28W7f4uZKjNYHCI7ay+z4
         2yiQMJMvcstAWxARbkl6wagm9d5pCJdPQDIGKyQ+bDmXQr0Il8qweDzX5Aqmi+ES/jMo
         p1qyKLOd53d+6NGFXgfFWo7/m+hyV/iosjja3oBspeYvsOTBM9mfHfeXTKp877l6tdUH
         6x1ON/pCJLUfuO8SqvieUqr6Kwa2CxOQaFxRQcqfGvGfAqrFzwFUQ123x6HV4PN3w46h
         qpg4CNqiyGV2spbTKqgx5BUBc9npE2Lk0cUq5WUC49AxGU8melpdpfHqUlm0h18AwyGY
         05zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793706835; x=1794311635;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qgssI0xYpOMAH5iVIdleET+YzqyBmZcZ+a8GZf98ttY=;
        b=TB3c54Px7h0ziv0vgVCOnBlubTIKbQ3wDE3FrsayBunIOgLXIevWWQwiOG0HBEhTzh
         jWsLk98SzGpJPzReJ24W+HQef3gR2uMzyg4nHYinp0D/oPhbujAZRVOIIU66uwqJaxpC
         Xj571KXFDd54xDSCmls6RnpecNakETd8QJfCjCTTrxNxcpruq/pYRQP9Vo1ESVyYDg+N
         mvk8q0XDTuOHkP6BMMfXA51b485JOyhWvto3O8OcAZ1T90NPY6mBxzrlIHWkfhXOi39i
         omQiVG97OD2lUJ2oVPWJQXR4DFGjZBBnLhL3XniJ4/TmP94jrYVywwtcUPcQs4mTBmq2
         1pLA==
X-Forwarded-Encrypted: i=1; AKwUvBw9zrYTT6CARyg4lqEZ/DDZL8/oCbmZZtlO/UCLz0QnUaXW/MuGNmceSQnimduwDZJiII0u4RYd5zc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8kAL7r5QysMFP6+/ZGoLcnJB5LGHwFFRa+ND0aI9nKITt0rvc7
	Xcdkh71EiHDWRQYPAM0r4zFesbNTHLHpL+tRZEz08eR/KzeNMxE8+CfvGWbjkw+f2SF0hYDE+Nf
	ALrxez2p3ObDJAcay64BQ2s6JDOI1+3yezAmM83cMEPfIk/EShA8O8Voriw2GmUs=
X-Gm-Gg: AYBFou2+j5t787jaWxntWJ702szMmc/ybsq6MK/leGbX3v33Mq1s9N58q2JHyj5Rers
	sQnEdDrFg8e34jifmFgObWX/19oJz3IJoVNPaJzJmxeUfQKJNdZU7Px4oclt47cJ6UDoCZBwEUr
	RH3sK1XxOMEASjXWsIO74szhvkBIhZYvehbx4+pxfSo6Acqk0gvU1Ct/SiegZ6KxYchH7CT6+Hv
	MJb9Z91IFDcBUJOT81urlzHwgJRJCy9yxly6rafwhN7ni7P2woKgMPbMOLD+L361eXnZvkmD5GE
	YnN2O7DW56gjegXywo+dZKbb4q84H4mMOWHqARKSnhhWbw2VtJRAHubdZuQ/qkyVNl9iSxJAcu/
	swle5ftTBkC1C27ZsTEXloMWHd3xI9Ytc9gyUJZV8aa2Dx04BJl7eiYMsCPvnEVsnkzaPJzIZoQ
	Cqia1A6w==
X-Received: by 2002:a05:6a20:1f28:b0:3e2:3392:5408 with SMTP id adf61e73a8af0-3e928ff2900mr10480922637.79.1793706834815;
        Tue, 03 Nov 2026 03:53:54 -0800 (PST)
X-Received: by 2002:a05:6a20:1f28:b0:3e2:3392:5408 with SMTP id adf61e73a8af0-3e928ff2900mr10480885637.79.1793706834326;
        Tue, 03 Nov 2026 03:53:54 -0800 (PST)
Received: from [10.217.219.98] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb364cb511sm1161045a12.28.2026.11.03.03.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 03:53:53 -0800 (PST)
Message-ID: <7a873a59-247f-4e4d-ad30-32bb504da40d@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 17:23:34 +0530
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] spi: use dmaengine_desc_set_callback()
To: Frank.Li@oss.nxp.com, Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Radu Pirea <radu_nicolae.pirea@upb.ro>, CL Wang <cl634@andestech.com>,
        Ryan Wanner <ryan.wanner@microchip.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
        Vladimir Oltean
 <olteanv@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Han Xu <han.xu@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>, Linus Walleij <linusw@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Heiko Stuebner <heiko@sntech.de>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Tudor Ambarus
 <tudor.ambarus@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>, Yixun Lan <dlan@kernel.org>,
        Troy Mitchell <troy.mitchell@linux.spacemit.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        Chen-Yu Tsai <wens@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Laxman Dewangan
 <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        "moderated list:ARM/Microchip (AT91) SoC support"
 <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
        "open list:FREESCALE DSPI DRIVER" <imx@lists.linux.dev>,
        "open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
        "open list:RENESAS RZ/V2H(P) RSPI DRIVER"
 <linux-renesas-soc@vger.kernel.org>,
        "open list:SAMSUNG SPI DRIVERS" <linux-samsung-soc@vger.kernel.org>,
        "open list:RISC-V SPACEMIT SoC Support" <linux-riscv@lists.infradead.org>,
        "open list:RISC-V SPACEMIT SoC Support" <spacemit@lists.linux.dev>,
        "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
        "open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
Cc: vkoul@kernel.org
References: <20261102174005.3933649-1-Frank.Li@oss.nxp.com>
Content-Language: en-US
From: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
In-Reply-To: <20261102174005.3933649-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ox90mO0z_5_trnHcTa_I6hxAKnH9Hfak
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0NyBTYWx0ZWRfX50TCOJWy5j5p
 SdjaFanwpBTlCoVlFXYKIbGTOPlTDO1mB4AUo5NAeGxtDFDCiszKHfrpjPyf8DsbNZ+7QGYKkP3
 0Z3J5rHbSH+/PkYl135s1veAAA9tVtD0hV7h6M3Vw2Bd7EW/HkzES/IYEZYPd7ZVvLZ9CQrpJsZ
 fKisV4nAM0Wu51qsT8oe5IEv4fRRSa+ocA/fAUux6gZC/KT9z4F4duNIvzSaOAtLZIdjlFrprcK
 TCYtGML6plEDSnN0zVT1jQ/mnhg9mqw8S2rKW5+OBesCw0XWrkI3qXOf3heRlXHrm3SV7K2i6Js
 hUZwGvV9W1z1EuKJ7PEbCC2ADsRC140/t6IEAWwI0ysNHEbctW3/Q+jaqQ+/ZurYuEgvvCTS40Y
 56LpjkrJ9Bsd5yvNP4huddI30S+/uGHUaVCegCI1c0VEWneCm+DmaYY0nuuGSSYvrfHBCLfXPKP
 WVaeOqH2HnZqzIZMzNQ==
X-Proofpoint-GUID: ox90mO0z_5_trnHcTa_I6hxAKnH9Hfak
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0NyBTYWx0ZWRfX/GP+cuxeJuUW
 gvzg1XQ36pHMWw8K6p1K7Qc8hZ/Je5bhQenSk68Wl43dLGReQn4ousaGOuPYTrRf0FhoXFm4nsW
 ZBI5p5yHdPGcAp7bfePEb1CRcRNwzGU=
X-Authority-Analysis: v=2.4 cv=NeZzRGD4 c=1 sm=1 tr=0 ts=6ae9cb53 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8 a=ibj56h0FkVxt_nO8038A:9 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030047



On 11/2/2026 11:09 PM, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper across SPI bus drivers.
> 
> No functional change intended. Prepare make to struct
> dma_async_tx_descriptor private to the DMA engine.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
Reviewed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
