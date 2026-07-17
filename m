Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4D038F65C
	for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 08:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784278741; cv=none; b=LoJ4ME75c1yFtU/hSJ+f0YturWk+rKjuyleJ+B+/VsbZ/2IKBmkD0qaiHqx/h8/mLTCqWAJmBZD3IHlLNtPJo7huBZWtaVfalSxI5B/pZVws2jzKzcWrg7zQvntG9tqFwclgaT5SbD3BPJIrLWR5r77wQip7tnrl1gfgxUobgkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784278741; c=relaxed/simple;
	bh=iKr+ORJN/0HmCwv5NrZPcwiCSwGwPmGXsiFEI46TzZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JvQYm1XGPhsfTY8gxjm5gGbzEuO/FNYQ8E/Kueb5oWSMDomOUJCwaWVUvyBnG6+Ude6S+UoqdH+mozqrmwjZSY/kkjJh7buKfwLqYBUW/kjhryLHZ7PnVLKOnffjNQL/JC3PNopuvFIw45dRITxsEZD3tzIp29oOg7dfcQmprLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l400jifc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VoVaXEjJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l400jifc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VoVaXEjJ"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6ciEu852028
	for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 08:58:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V6MbJnmX7m7Q+rNiwCmFsJ4wLFKfE9U7mLaz8j8CV9U=; b=l400jifcL5aKd65B
	5LUw2Bc0DKEUaD+NP5xqtPA0B+pUH7FOZJXvTs+5QjLB6A5Gg8elI6ZNoyfPveE3
	c6jq6vIIbzxH9mI9jgJ3j0N+TLBSoEiiPaWzLOHUlLViZNgsZmc/WjtUN0Bh+1wD
	FBsECLyhP50+rHKfuAww3lq6pCtK3FMsoNMX/+5UPmIhIgCf+34zN7ItdPiQRVn1
	YuBZTVahOP5+znFPqWN37skx8eW25UhncLxEY5No6gd7D2EJk6mlPGaNSy+HmlSv
	7ZU/elCzCRgFqR2DaXZBaHSiUoaiCj/LdbpP9HjwCRdDBT6RXnsOPSUQ69WmcMTU
	YlF3BA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9p8ha8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 08:58:58 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8e97889ac8aso106594886d6.3
        for <linux-spi@vger.kernel.org>; Fri, 17 Jul 2026 01:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784278738; x=1784883538; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V6MbJnmX7m7Q+rNiwCmFsJ4wLFKfE9U7mLaz8j8CV9U=;
        b=VoVaXEjJgzgcakQ7j9flfYo8ay7oKb+LCzu1nywgGyphgjXW/pfrlxRc8PTsPUFF8l
         UY2ZKJD3GKkkqE0A/CdT8G4+p4ZuBg6WG389unhxpnTSdKp/tKVoiLFffOCHC9AL5gLU
         zTrNAnRrleoAk5YMXXADPlEEnieKslz46mcKHoxZ6hRL22bHT3/8AcFa8eX8IEzgSI6K
         RB1E60kF+FAFMOqAfiwaTj9kORJ3WgVaZQ7MiQga28hj5S9Sz7edICbE5cKGgv8e9JmI
         X5b/1TZR78xtFoxJFGX5kUXwvrqtS1ZzfCK0H6NA4XznzA7k3cJxpuSHgw6ZA/sAggia
         ssZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784278738; x=1784883538;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V6MbJnmX7m7Q+rNiwCmFsJ4wLFKfE9U7mLaz8j8CV9U=;
        b=EWCKNPr4xgZM3sQbV4Kl1FxqdKYHpJSBe6lMKBmXngngxfPkaywfWM2qBsyTwualBA
         x5F1QJ+wt0iK4kC1vPGIkyvRfPn4LO2Cw2ZTXwfe+pB0YyJtWp1H/RMfuBP/FP07Gpi4
         ephr5Sn+kNZVz/rGT4+SPH2JtMB/xtK70IbeG3l7mNOOGZqax03XJfqyjcgYjt/fWQcI
         8fugi3bs7ziaRh1pGElk9OJ4j83AjROawhOlKYrNE7EmLIzeQxVyuJNa33pJa7rfDVlz
         swWgiccdORyBoIwN+kvDpjCdQ9JKOPxpoggJrRwLVLpQvpvbNikTTwj7HfUPvwNSIy6l
         0nGQ==
X-Forwarded-Encrypted: i=1; AHgh+RoRoMs8UKKuFXf9uSKyIz+OxYp3iG1jk6jWz5CQLg+ljgS8Ulgep3xIbYrdkFNNLTMYIQzLaId0WNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeNcvvS/I5lRssIxV0jsJac7CQppLCUlHUUVOBwZA8FA9pFDNB
	wNQRGmYoGUUQNFiN6NPZYZ/3n3/glkoeH3hVcKkw7PsmmPaW8lCgJzutbDsCWNogolEySnggWiz
	X4XLEnS83mcczTLMmFXTuquKt/r/LrHvU3lZzqEQJ5+VCLBxUpVPnEA+updCeqOg=
X-Gm-Gg: AfdE7cmTIAl733u1uh4+QjiECob1w6VdwAbLjK/xf6sJBQAhSZl3CaixXJR3fLi7rCW
	UiC8lH533GPHNtWJHvqHnGS8VazipNUklWdhuGzBedQlGnnhpb7eGM2s7XvWPYFdh17af87M3UJ
	vZJ2OzFUtvjbHgCT1kdhJE3o+2zl7/Ya7tVmsD1E43kM7cOxp5gcbyTsIfDpcbMbEZrwPwQqMYl
	k4J7GZiFKMC86dF3pk45kolMNi7YYS4GUZep2UzAs+Y1NlNaBUIKBDvm59aJpcg/F4M4jS86Tz5
	ontgkpbBEPKBQdEg38RjW7mV8J435yOiMK4bTcSe3FQoAcMS3NF/aSgczyAYSKJrtLEANRRT+dl
	O5JwIm8KYs3mWe7CsmMpy4k96O408
X-Received: by 2002:a05:622a:1346:b0:51c:1eb5:333d with SMTP id d75a77b69052e-5213eb757d0mr12604861cf.66.1784278737622;
        Fri, 17 Jul 2026 01:58:57 -0700 (PDT)
X-Received: by 2002:a05:622a:1346:b0:51c:1eb5:333d with SMTP id d75a77b69052e-5213eb757d0mr12604541cf.66.1784278737262;
        Fri, 17 Jul 2026 01:58:57 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:dc44:5b1b:5396:79d6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e65644sm1911449f8f.16.2026.07.17.01.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 01:58:55 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>, Jan Kotas <jank@cadence.com>,
        Michal Simek <michal.simek@amd.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        =?UTF-8?q?Przemys=C5=82aw=20Gaj?= <pgaj@cadence.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Frank Li <Frank.Li@nxp.com>, Boris Brezillon <bbrezillon@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>, Swark Yang <syang@axiado.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-usb@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: Re: (subset) [PATCH v3 0/8] arm64: Add Axiado AX3005 SoC and EVK support
Date: Fri, 17 Jul 2026 10:58:47 +0200
Message-ID: <178427872043.9452.9219608850005529427.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260716-upstream-axiado-ax3005-upstream-v3-0-c429095143ec@axiado.com>
References: <20260716-upstream-axiado-ax3005-upstream-v3-0-c429095143ec@axiado.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: P-nX7HbsjwR68nuOwIj7xV__h9HmZFCP
X-Proofpoint-ORIG-GUID: P-nX7HbsjwR68nuOwIj7xV__h9HmZFCP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA4OSBTYWx0ZWRfX2m6GnWI8B0N1
 Ur36oxHZXodIlXslMHxvU+TbbiTpsQTW/8kLLnM4lMK4o5gxCculdfyQR7wX4HaFNCHON/QqZSf
 hqRr882NMqkLHhJQfFExfdUFHXM5n/mBHEzQgvzTTZmI+EqbSajZM673kYSd0xqwM2paBHrtvg2
 blqKcsmBR7GaBYp/FgbhMYGiFPURzvdwH7UHHnEoT+KXcV4IHxb0T6Oz40zG62YEDHkzgbmmPFF
 AuvKzPKgZ2hVKpyo0ccL0a2+xDz5wuxLbt7nKqn/1B9ONUSOs6P0wyd6cVnc9++5DV5fgxVhCyI
 Aa1uOyzL0koTPJHmJEL3Zla7s6EUSPZg7hlVkPe7Uk/he+vc9h/AYRodnhT1wcuNsbWncL/fJgY
 GFw5hNA8u68c5uHdOb/oSYB3E2XM3X/6Ozgq9C6TUcJ+oaPOrrVLBbHYSrwFGGMbKw1hxmaRrFm
 gHJEKfKFCn3x0grq/fw==
X-Authority-Analysis: v=2.4 cv=TaqmcxQh c=1 sm=1 tr=0 ts=6a59eed2 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=zGYnv34WkyyXCUjmJXsA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA4OSBTYWx0ZWRfX4eBMs7u1wygd
 Mb7A5+Hdv6KUKnXVW+RBN1hKk+EbaG/rqTNYZdF6iVU6hqEeXYkwgVP27ufIsWoUYnM/R+Qu8Da
 qh01YOqYy1ja3xdQKYlsPKcivDkfEDg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170089


On Thu, 16 Jul 2026 20:51:07 -0700, Swark Yang wrote:
> This series adds initial device tree support for the Axiado AX3005 SoC
> and its evaluation board (EVK).
> 
> The AX3005 uses Cadence-derived UART/I2C/I3C/GPIO and Synopsys
> DesignWare SPI IP blocks. These are already described by
> existing bindings, so the device tree reuses the "axiado,ax3000-*",
> "cdns,*" and "snps,*" compatible strings; only a new SoC/board
> level compatible is added.
> 
> [...]

Applied, thanks!

[2/8] dt-bindings: gpio: cdns: add Axiado AX3005 GPIO variant
      https://git.kernel.org/brgl/c/e8a40b3566887c1c83d4cb87058d4e98ec8b4a14

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
