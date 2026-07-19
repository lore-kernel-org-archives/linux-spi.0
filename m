Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E234421ABB1
	for <linux-spi@vger.kernel.org>; Sun, 19 Jul 2026 02:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784426860; cv=none; b=EY2Sl8xxjqadMVnlBzzmJbNANMn2IErB2Fcnq0Y2AbYM/oER1EQK8WsU8ioBlfGToFc+9Ulvz97IFu2d8UPhwj9bHcrLiJLabBZam/SNa7jtNuXWRfGr8bmITG1LJ4iXrSgGq2kgQ7DF5w/kndYqyvoqNw+hOVBktprhkKIakiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784426860; c=relaxed/simple;
	bh=0U5P265APA9y42OE48PXJRVs+DVukO5q8VN35MNnDus=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AnZXr6RvXLh7VmfL68eIItEv8JONwfUusijZANKHtUdK5U8zFGeZe+jC3Cgjr3ACsUuhPzNfHDHM3ju5kcJC9qAzj/jJbahAqYgpM83Rqd7FpuoGRmVrQSi/o1koSfw/lPURYRZ6yKQ5xRDv2bHNal9F9xE+1zSVYcW//qluSfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=inbb7BZ9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WOXuJk3Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="inbb7BZ9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WOXuJk3Q"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66J24FLE2313220
	for <linux-spi@vger.kernel.org>; Sun, 19 Jul 2026 02:07:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bij0tRK5KgUgPL1VneMcyKdlpgkQ1t1V4gnjIpr3G9s=; b=inbb7BZ94Y8yja+z
	5N4QJkhLH4yo/P2TXNa0Hz8VPLBE/0RaFG8qa4X/0rB9RUlglayZJmrQEstzsswY
	/b305XSVWcwVwKwwHzaMPz+9Djf27r7i95ToKjFSRphNqYrWOfQWYxUredWUn9Q+
	Gt+K3rwXIBrt1/pYo98Nhw2kopSrIikHPCAqBTfEW0j85rYj+UzDg81oUksOv1c9
	FtXL0J2cJsXtkF4Gncm1gny+Y6wKWnGIaQvlWYMsBcwN1mpCbIiuWUyrtBohYBEq
	NF0YblUiPGlvR89hSLYhTQa0XaHk1oJs5N91KMUqvqOA7OpGd/iwQ/Q878pZ8ld3
	m7fr9Q==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fgd04rvdb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Sun, 19 Jul 2026 02:07:36 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8483e038efeso6339770b3a.2
        for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 19:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784426856; x=1785031656; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bij0tRK5KgUgPL1VneMcyKdlpgkQ1t1V4gnjIpr3G9s=;
        b=WOXuJk3QkrPHYVC3Fm+rWBwF747FBG2Qvas5v1G5iP4lPR58FfBPbHCuX4yLx8R0gp
         wUJTHD37Eq1rFQ7qot9+DPgPxKUt2VtjR+BfOdWhc4MtGhHI1jBnU55nvfMaGuVlvIUP
         Dt2cX8t6ZStCOwfrnN6MUmiYlRp2OJy2eA+u/koN4J1n0WSITGFFl0J+9BvCPpKHJXoR
         WxZ9smHPnUgRcYz51oC7nUQEFs5t3Spe8OtLqoBJx1WYgPt4WSY9JhQaKm2dO6HU/kmA
         CfrG7nr9CdaeLvX1Il1zdcjOTDklxJHsOOPGh5u/MRWUc1kvSKSVBcn8yJdOff7r0EME
         wGhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784426856; x=1785031656;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bij0tRK5KgUgPL1VneMcyKdlpgkQ1t1V4gnjIpr3G9s=;
        b=DOJbRlf4jvy2yPhlmXQ3nQCzuqxR9DhQoZSCmOYUzXzSYvtbJVgjIi5WE4VkIULBJU
         rrKm/mXCJ4qX0PYp4eVfCMYlxMfRt8JS5QPR4c0vx2VdUbz/XcpNp/q9gPH+1Ozv7oJh
         yC47iqIE5Etqh01NEGTeuK967Yan88rPeqT0egx9hvKl31RL9x8l6CyY2W5hGKsjxM4N
         2M33A+Dkinad5ErKAU387R/d9L+9B/S6mjwGa0z2z08Gd+BkVFnfx5StBTkQaWT1GSrj
         Vo8RQvz49a8OtxF7OqvXXtnwOcYBaekmff9fd6r1TQQHM3bcJb4nwK5zcnRjZs3vnuto
         bdag==
X-Forwarded-Encrypted: i=1; AHgh+Rpjij6fPRjKvRJoe0NLaTyPmuVzuODmlfKmt3itlt8iSKGyXkQ71wtjs0wc2VGll6rBi6Mg7tFrqbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwczvOWeekGj1UScLXnxTxMuXX4eHOicSTxRDX31ggyHLWr+LSr
	bW3Q0iwGG9P6RDEpAZK9vWcoCc0d4f4CxQ761kOHYt7UD6iOdETJziSVNYpo7puAef7G75rmwqh
	+vE2qWrOFue/MHN7WLcFIrSAcP6qiaxQFewDgT1/kE1r+E37O1nAKUx5c+e7j3qA=
X-Gm-Gg: AfdE7cmFy+nwk5pg4xhD/fO6+h3CHVkdGkCF6Xy2yI6X8vw8mGsVr/q2zzSk+H3J5Bb
	+2oe+yED+irvkPQQgvWMy3YDlvyOcq3mRsSk2shyICNzUIHc4SuGgOjKm7dTb2Vxw1wtl2gtGnY
	uxahc2ZPMmUdWYU1yg8/lU8pJJvXTfJLTVOeZfaF17bR7Mq9vk8POeBGuNB9Qno5G7eiZ9G6a9S
	S61jx8PNmEQ12/hAuGK5rZax8AvK6TRN70w3YG8BUCpWO5pXaDugjnP7xYjgYkHsrSrS3hK/0B/
	qS0QWCRt9JKiVBvGNnsPj7vcBBZ6zB6iA1Nuvu9+ZmBQdfE4m0U3k1r+YfqDKId/ur5TVKV0aRE
	w3cfqZgMSKeRuggzZ
X-Received: by 2002:a05:6a00:228e:b0:848:47db:a0ac with SMTP id d2e1a72fcca58-84c292ab554mr8722167b3a.27.1784426855556;
        Sat, 18 Jul 2026 19:07:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:228e:b0:848:47db:a0ac with SMTP id d2e1a72fcca58-84c292ab554mr8722131b3a.27.1784426855066;
        Sat, 18 Jul 2026 19:07:35 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c30fb62fesm2946475b3a.29.2026.07.18.19.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 19:07:34 -0700 (PDT)
Date: Sun, 19 Jul 2026 03:07:29 +0100
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
Subject: Re: [PATCH v6 2/5] dt-bindings: iio: adc: microchip,mcp3564: Add
 spi-device-addr
Message-ID: <20260719030717.3ec27870@jic23-huawei>
In-Reply-To: <20260715-ad5529r-driver-v6-2-cfdf8b9f5ee3@analog.com>
References: <20260715-ad5529r-driver-v6-0-cfdf8b9f5ee3@analog.com>
	<20260715-ad5529r-driver-v6-2-cfdf8b9f5ee3@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=POs/P/qC c=1 sm=1 tr=0 ts=6a5c3168 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=gAnH3GRIAAAA:8 a=WutwVF5OcC7bkNhAIqMA:9 a=CjuIK1q_8ugA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDAxNyBTYWx0ZWRfX2GBfZfUbrnfi
 KB4V8PPsDzXUdvTCWU7yF5VXjMljTcZF62pdaZfswZPGVhwukxJrbwkqnb66I7pLIwn1sTjrVGa
 3bBoZUQwmsVy9NW7stByKGnXK/sEW0lTs3j2kHsd6Mfim0eeLelmkuanAkEJyA5f2W8NQhfL2Th
 dynZdtDy+DfWkyaS66hZN/pLoxRX1BA2JAlT4g6UZGZIZLv2ls3sviTVwNQBx56SS8gXYyGl/EE
 dox0EVdrUwUn28QcGFWzYdGuXpqojaTJKqan5JcNNl2mFibIDCK5gOmhENVMunIeldKSA528N7I
 jhZRs5zOP1H3XcdMwAA4y5b2/MPZrkTqoKtFu5p9Lkfjd7Zpa2L9fH4RwEm5V6HIncNdK6xJMDu
 EJpZx3I/uo+El034wfzg6q7toIeZoshDZ8tBaYFnLj9S0ur29R1zHTcaAMOuIhMRdnRSY1b4YiH
 Fedgvoaom3VEUcZUHTA==
X-Proofpoint-ORIG-GUID: dTmKW8lQdkN6k-AXhKSBb3BRQyZ8P4fB
X-Proofpoint-GUID: dTmKW8lQdkN6k-AXhKSBb3BRQyZ8P4fB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDAxNyBTYWx0ZWRfX34bzTm76QxOH
 5SW9hW/V+UmjrBCPkDPXTJ+p6eBiE7pvMEfV0puxJr7w8RsxI2PnQ+YrJEX0Fb5762MzNTIf8aL
 SK7VT8XnOSleTBxgInJACdBVqO1c3do=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1011 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607190017

On Wed, 15 Jul 2026 13:41:05 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> Add the generic spi-device-addr property to the binding and deprecate
> the existing vendor specific microchip,hw-device-address property.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

Maybe I'm reading the situation wrong but I was expecting to see
driver patches as well. Or is the now deprecated binding element
not actually used?

One other thing below.

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> index 675319276197..02bb198e9fa7 100644
> --- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> @@ -80,6 +80,7 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      minimum: 0
>      maximum: 3
> +    deprecated: true
>      description:
>        The address is set on a per-device basis by fuses in the factory,
>        configured on request. If not requested, the fuses are set for 0x1.
> @@ -91,6 +92,11 @@ properties:
>        clocking of the device address (BITS[7:6] - top two bits of COMMAND BYTE
>        which is first one on the wire).
>  
> +  spi-device-addr:
> +    maxItems: 1
> +    items:
> +      enum: [0, 1, 2, 3]
No default here, yet not required, so how do we know what the value is
if this property isn't there?
> +
>    "#io-channel-cells":
>      const: 1
>  
> @@ -123,7 +129,6 @@ dependencies:
>  required:
>    - compatible
>    - reg
> -  - microchip,hw-device-address
>    - spi-max-frequency
>  
>  allOf:
> @@ -159,7 +164,7 @@ examples:
>              spi-cpha;
>              spi-cpol;
>              spi-max-frequency = <10000000>;
> -            microchip,hw-device-address = <1>;
> +            spi-device-addr = <1>;
>  
>              #address-cells = <1>;
>              #size-cells = <0>;
> 

