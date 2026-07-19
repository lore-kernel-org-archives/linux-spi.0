Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C4425742F
	for <linux-spi@vger.kernel.org>; Sun, 19 Jul 2026 02:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784427060; cv=none; b=T9Xy7onY3nSljVHI56KVqX2pqyjFBx48YLxdJmfg9+nC8bt/tVuYqCmxkvL3usRQeP93otmu27nVsknHldxE6Lafs/JI9MrEK+3tpP7lHIcUUffhgwU4BxjV/urBIR3Xjt1MZxwg4ZLe2R4Omvga8E6ba0vUO8u/mMXYT/lPDmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784427060; c=relaxed/simple;
	bh=R6/eBx0dOExr5javRdf2etaJDNgbRZVlAciWScYcY5U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aUo/cFjeC4P6BSO/RHhgYpfBaRdkJF7IYvS+zMIBCM0GknoIbol7tM6I+6xqmGhWvCRGwudFgP38Sx/T2JDvRoa5g4J3QvSY/rrqbWpnFr4jBU3RBCfFJqPL2T0P8YLBFA6I3eJoLvRXt2Lkg8FZ3GlWsozKNIPUDW2KJWBU/nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WxnocBu1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IZncXMs+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WxnocBu1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IZncXMs+"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66J21VBa2522258
	for <linux-spi@vger.kernel.org>; Sun, 19 Jul 2026 02:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/nji6/9dRFy5m349usk56mPECY63Tbm+yUPmWxeKoJ4=; b=WxnocBu1lJ30V/DM
	J1JEwupYUox5MGNYUofBjb7Xa+s28TFdBk42yd6RVxYEyRSGasE3tmwQs/WgnlvP
	0nz/+Ad7ayx9xxgK/IwMIi+3FPtJdGD5RkBq95SFCM07qZni4ip87dA5YYlkqkzY
	TRkqYqHl3gWLLN9aYGiR8iLTRiDuBFDDx6ICV5fDHMpr01NjAdR0T9AiQ+txwF17
	oHHL8FmyC/Wufp79KZAzxb7DkBtV9Z+n/X05dNfMp7hjtuAOhaoag6vKJGcBbORY
	WOe5Gx/wWYZ40xamKPX+v5fCJYy+K7ODJ+wW0LzhgLWmSxHBJ0nf6DevCCcX6pFe
	PtwaaA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2d91wrq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Sun, 19 Jul 2026 02:10:58 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dad28e86eso15213115a91.0
        for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 19:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784427057; x=1785031857; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/nji6/9dRFy5m349usk56mPECY63Tbm+yUPmWxeKoJ4=;
        b=IZncXMs+XhaHb1n04/CFGsapePIvZNDs1J9ITyjoVQmqs2C/TdayRDBypVmqV5MNrj
         c4l5qshVXrO0ZbtJuLY6hiuxa9GsqXGErQIUyg9PvNADKQExg/5hiSjgwvPHD9BPNs4G
         XOCem0nm/gZzjdCz4h/EOGEDqb0FOJXpiPXgtobBNOMdZPPYWTjJQIIV95GL5C7zehv4
         G4u+gQ/aBOOo6/sS2ar/ifpuktiOBZh48xpLCCOnjLAE54+NaUpvp6rLzgBCJc01i8sy
         J1xomFjbQkvlu0WQeZ5qbiXAie05AnsjbE6irP57OjtDEYr4HBTBh5SZZoH5MGqDSMMt
         B1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784427057; x=1785031857;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/nji6/9dRFy5m349usk56mPECY63Tbm+yUPmWxeKoJ4=;
        b=d/sD73ezbS0xfSgyPu/9RPSMg4INaod6Ul9r5iWdtfkRBTchE8AYJlZob5ENnexO4s
         oCoEk+zEjFtTfJARAkI/2WCI7huuhAL5mk2jz/bFnzOehvT+5jC4INjWhSWZBqHE51nJ
         dGtId4K/SjGO/o+JWuV4lG9OcdpEYjKXxLwkUVqTsqOAqgT6cDQ36Cf42bvbJIvriCOh
         CT9qCiiTmUN3h5R+YPA5o89hWT5kRA/pn5CsZjcUQ5ZjPdYFBrFUdbu2OEQjDP985xut
         7RVeYpPLdq6CX0Hxfdpti5LrMbGVS8ubrgW+qacb5w8vc116PZGvjl/HTV8tSGLIIOfv
         V5pg==
X-Forwarded-Encrypted: i=1; AHgh+RrmTeqiKv97wWaTcJ9kA0ce4gb91D1+lYMrQG3KZL3YpGEiY7j3JVLPlge/64YG/NNBFAc39JABXxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YziddJq7r3KykIXrXzdqyjdBitPj7OSI5k0BhGaboY8WuH/oamx
	z8dFzvOeYK3ZO0jAaY9BRX1X+EpVPX7zRz2bmZ3cSYimI1Y8WxCU+ix0T8uJ0KQbQUs6C2cYwIQ
	PiFfpaT5lVLXebyXsoJDecP+czD0twoozh6uNiHZVkk+RzLyEuHOXLnlt6Jp2FIE=
X-Gm-Gg: AfdE7cnI2fEgpYU20sgJgwU1nGmwNk0O8v9fXW1kNBmygPfu5Y+hdIBbO+ZUTEBQL5j
	5IFoNQcd0aqrCdkZQHMFzM/FJtjVgiNP9feh4CwLKldSWWE4UvRxPvFpbR/1BckWs5L8NajAQ/M
	ui4ShpwN71rlhaluj8HlWxN9UEmLHIhp8MLZXokWy9qqlubsNRuJdGsXC04I6oEbPHhekhBAHfH
	3Dy70Q+3Q3muexU92Vux4hYMn4h/knDrH9acFZAyuFaM4dUF/1TdeYsvgoCAC1BcpP7CDsFHTMv
	7CJcoIfbCRhKB1pivKdP/035mp8Y61Gc7wzGbQ+XT/qC8602B48BjMfz7AOu8MuYN7PJt7nF22+
	YQxsGl6el8qB7elV8
X-Received: by 2002:a17:90b:3942:b0:37f:9ce1:cda8 with SMTP id 98e67ed59e1d1-38e4b59469cmr9276551a91.30.1784427057540;
        Sat, 18 Jul 2026 19:10:57 -0700 (PDT)
X-Received: by 2002:a17:90b:3942:b0:37f:9ce1:cda8 with SMTP id 98e67ed59e1d1-38e4b59469cmr9276526a91.30.1784427057091;
        Sat, 18 Jul 2026 19:10:57 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e3a100753sm5454606a91.13.2026.07.18.19.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 19:10:56 -0700 (PDT)
Date: Sun, 19 Jul 2026 03:10:50 +0100
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
 <Michael.Hennerich@analog.com>,
        "David Lechner" <dlechner@baylibre.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel
 <p.zabel@pengutronix.de>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Shuah Khan
 <skhan@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Marius
 Cristea <marius.cristea@microchip.com>,
        "Marcus Folkesson"
 <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, Janani Sunil
 <jan.sun97@gmail.com>,
        <linux-spi@vger.kernel.org>, Kent Gustavsson
 <nedo80@gmail.com>
Subject: Re: [PATCH v6 1/5] spi: dt-bindings: Add spi-device-addr peripheral
 property
Message-ID: <20260719031038.4cbb21db@jic23-huawei>
In-Reply-To: <20260715-ad5529r-driver-v6-1-cfdf8b9f5ee3@analog.com>
References: <20260715-ad5529r-driver-v6-0-cfdf8b9f5ee3@analog.com>
	<20260715-ad5529r-driver-v6-1-cfdf8b9f5ee3@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=HpxG3UTS c=1 sm=1 tr=0 ts=6a5c3232 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=gAnH3GRIAAAA:8 a=9c9bR3m6y8SIrhsu7zEA:9 a=CjuIK1q_8ugA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: 35WQ9pRg3FJ1kZsh_ZzbvT3KfTYyJ4sZ
X-Proofpoint-ORIG-GUID: 35WQ9pRg3FJ1kZsh_ZzbvT3KfTYyJ4sZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDAxNyBTYWx0ZWRfX8H8lBKn8mCqJ
 TR0ob4fGgqIo4qCVkJ9+g837DC/Nv7wc0rF92X/Hm6/xTw70Abhpj2xbgUi3hR26a7ggIb7EEFg
 CnU4VmMhQ4thPtWMbNj8eZbU3ueYs+olv2TPDKZkFagP38u55K06U2d4+IyPVBo5LRIU6DYlbNE
 2O9giAw4uAyhohfzIeKBoEoSUOa2LvZcfvYh9nCBqLpTqeoPJB7LpF04mWXtFVXGHjCtqkPRpRb
 xkyBIjpGBGuvtfmZJ70acp8GGAKWiSh12Yy1ul5LSv/7FOpSlruxjCkc6TYfOa2kuCh8RCWU4IR
 zVcoOt5rS0Ru3G0fP717oSzQQYZUxhvLOF9tOx2ojajMJG3JlKFcBOBwIq9fQ8ite2MLqOF64BZ
 byX64wP67hMpJiDVX27wz7nXv38nIVv6c/C4P9UstmRAZuZrqfySRuCqJrPjvQViKBrq6UxGGMh
 tG91KN2zdIOpq457sgA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDAxNyBTYWx0ZWRfX3jDDIkIi9YHr
 Sj+arTtpnacpyVvz7q5e47Yhx+oTEEy4wzAUqp3Xi/kw1aqK2F2hnfgwCQU8yPXWnen4Z866DC5
 1r77Mq6P6uWI5a8joFmhSf9c2ooIUzc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190017

On Wed, 15 Jul 2026 13:41:04 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> Some SPI devices support sharing a single chip select across multiple
> physical chips by encoding a device address in the SPI frame itself.
> Add the generic spi-device-addr property for describing these hardware
> addresses. The property is placed on the SPI peripheral node and may
> contain multiple addresses.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index 880a9f624566..135657582131 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -142,6 +142,11 @@ properties:
>      minItems: 2
>      maxItems: 4
>  
> +  spi-device-addr:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      Device address used when multiple peripherals share a single chip select.

This needs to also explain why it is an array.

> +
>    st,spi-midi-ns:
>      deprecated: true
>      description: |
> 

