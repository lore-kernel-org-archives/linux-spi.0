Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0621C701F
	for <linux-spi@vger.kernel.org>; Sun, 19 Jul 2026 02:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784427601; cv=none; b=bpzUaAc0N3K67XV85XxJi717ZJPh0THuyMzITUgWN1PsLn5DzElYV2kSjbmH4wRFk0f9XjN5d33s/Ctk6Gy3OKFc3+K3sv4rqglEOfCBF/ivsj0BcOqP1D/4B/JjouL4uOhbstJmd9M+vZKAVDNqCvsw7IvUW8+pR8l8zeZI+8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784427601; c=relaxed/simple;
	bh=YuQoysW1azYmuf6rDpcHaXat5Wr4R5U7hE1Fn78iZ4E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q/vUsxVZ7Q+v2/LYZkJAHzvn+uiU4QRZk6/gewFkd9cGpXVLu/qZPvOK35vR62XTTISHk0Ul6WHxPt60U37JyLDnj5IGny6d0cmM+E6WxH4bK8tYYqxRB6SRGv4dWSgRZq1TZboazkdHVmdTnpEMpyiVygOKiAnLcEFEx2a/obc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FaeywPmW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JwjSD0R4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FaeywPmW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JwjSD0R4"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66J22Edv2099113
	for <linux-spi@vger.kernel.org>; Sun, 19 Jul 2026 02:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OC7Lt1admKMC5oZ9cYYZw24Clyu0obewa2E3eEMrFpY=; b=FaeywPmW4pRwHMNU
	s5PKbAuKrb7q0CE1x/O/wMzweRloDyuuDi3iXieckIjOo3c1KzmjWus80zZK+9w0
	HLo0eZ/2F3HXYEDpkGIci4LJSsNrGIWRhzRzAVDOA9D7JDqxfDhIuPMEQzxVew+Z
	k4mF/nsRoHSv4+yOn8HhPGUf8xplXRSpiXa17FAaBMw5/x8LcQob7ap98kLAnrtX
	adWu/GklN2RRtDtfUZ3mtvMQx+yznjM3Woikwf4s78Sot/S0o+l3DmfT/ROtMQJJ
	KIVwug1+1hEDrP0QX6D2wRLEpJXa5FSEiwt1aTKaJZx6XlCgXY1tFlygYrVIlnFw
	HOnuVQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2s7svx8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Sun, 19 Jul 2026 02:19:59 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-848551b54f5so17277935b3a.0
        for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 19:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784427598; x=1785032398; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OC7Lt1admKMC5oZ9cYYZw24Clyu0obewa2E3eEMrFpY=;
        b=JwjSD0R45euXQc3heLpJAax2zwDUFqKHsi+VivaiF3JJmnnAPIzKYpHGfrFUHotyN4
         o+tbQKwHxblVzq/rrNhuF+dfQx+eEUlIu7bRO87KBESCdxa75UdOJ5z3QaNgAmxicQd/
         +VJMoiHto4inDhukDPhRNXAgpo/UZUlcO9OST8nOcrJKfyC06jTJuKc82lne0YDKqVTG
         yqFLLfBRtad36w64APIschOAOD7mvQ46WyarrmTPv6+9S6Kp7ZqE8NNY2zhbK3xi2b7T
         CbXWIJwdpnDSgRv0hzc8n1xlz7IxXIJmSaGmHgBh/C40vzuUVfXXTgVIrU+sO4S7d1AH
         zAaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784427598; x=1785032398;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OC7Lt1admKMC5oZ9cYYZw24Clyu0obewa2E3eEMrFpY=;
        b=YYhQiJn3IjWA6PjRZP9SVtpCdXlY31vPkkVDCbyjTBordd8rnd0q4lp4E+UCcWwNuO
         QB0RKAiTeY/WTHXUQYm8EDtjZzxS/ZcHIh03vsyvktsfMQSPV2VoKsUFI8mNS4MT+l8T
         MGpDlaB4ETHt0gwuu+y7ZtXlKRxF5pFifOkKqpcxIeVgyZpAVQ/uL96DJ86kAdpG/Tse
         JST35NN8TcQV9g9Zy/ZPOrrSjhZlzbweY6yscmLQmAJXysszDdDe7baHaAP6YUN/AVjR
         Nnw8yxz2tfI78mWefOnEbUDGugwfYi+oz75E2aNgrZi8WwbkG3RHHFHRSyhBLkYyheYe
         6qaA==
X-Forwarded-Encrypted: i=1; AHgh+RqSPWW4nm6vj5qfac2fnfKG7gsNBcFEp0k4CIRwgTQMRKWAksN900pRu6pK2OkPyI/i4Vo9F/NFhss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzakIX+aSrKTYLHTHueI4QW4Q8qXbVQtylFXqOX2SkWnL5CHzmD
	DoC/PeCKRdhZwa91Z1HYPMer3kcIUaiEoTDoTqbgtql4wjL8+n0eCEzvGDT8HT+5nQ+ArVYmSt3
	YwH3K4ucaXUUJ5l+b7686wTO1AwlFRUA13csHOp+gnJC8YsI3HGXaqxdH5RLAS0k=
X-Gm-Gg: AfdE7cmdjosv4vrTdGIK+EF62WroyJceCqyB6eJ3ZpQ0EwiH/iBKLnjZ/vI2aD9qR5B
	1/fKAm7PamkxBEiFfs8xk42hbyTxhuo6oyEvf8+R6kgpai5Oo4FGS1ARqnvCxJwa+HCX7Sz+jmZ
	FBGP1Y6ZuXk3j5FoUTOZh0nJKJNcxR2/TyAjRJAV2QivDxw5VLBqkJejTMaew8L1fargpXRZpxM
	8tKpIoKJ4byHoY13NreJOq6ZrrsifaFQfqqOKZZSyuCZQndKSAjR64yn2UHCfq9TMiPYGMSExIX
	w1Gw+jGOvpuV82QcJ2Sfmt/3z08KOglPmMALkj2PNfCYb7D0uoL1EUNcIx6LO6E3VCunlsnT2zM
	Ig6qB/D+MtiResl7E
X-Received: by 2002:a05:6a00:4f82:b0:847:759e:f617 with SMTP id d2e1a72fcca58-84c2948b110mr8797005b3a.44.1784427598404;
        Sat, 18 Jul 2026 19:19:58 -0700 (PDT)
X-Received: by 2002:a05:6a00:4f82:b0:847:759e:f617 with SMTP id d2e1a72fcca58-84c2948b110mr8796978b3a.44.1784427597959;
        Sat, 18 Jul 2026 19:19:57 -0700 (PDT)
Received: from jic23-huawei ([50.35.46.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af6d519sm3352091b3a.40.2026.07.18.19.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 19:19:57 -0700 (PDT)
Date: Sun, 19 Jul 2026 03:19:52 +0100
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
Subject: Re: [PATCH v6 5/5] iio: dac: Add AD5529R DAC driver support
Message-ID: <20260719031952.732e193d@jic23-huawei>
In-Reply-To: <20260715-ad5529r-driver-v6-5-cfdf8b9f5ee3@analog.com>
References: <20260715-ad5529r-driver-v6-0-cfdf8b9f5ee3@analog.com>
	<20260715-ad5529r-driver-v6-5-cfdf8b9f5ee3@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDAyMCBTYWx0ZWRfX/UTfQzRce/Bu
 45ODdFq8E8Ae2vw0qK34dGbYpmtKPtKvl/2RlwT6TztKl+prQ+AD8mraUTG43OLxgfRt3r2w2CK
 TStXPSmfe0DJUfyZhP7FvrSBoXkWSqEWfmT4ZrK1USV76wPOr+D22SvUywC0o17vSz0+JlfCJMy
 GsafW+ojTnXstHLmTXtlO7baR3uKfphlBZ4FdVB95vO39sguSfgMOtUqatmOAaBWDbPXcs7oZ+V
 QFkPnZ6NnQA8zBGuEmHZ1m0r8yV1BejMymgqTHJvDkmpi5Yz/wzAjVeEP6TXo7YgyRW8n6Pt/+X
 lDY7sozzAce75XdVub8hEB440vzizjC9++hslulRXUw3AbT2keVj119uKGkCIFPz929g+yzfmlG
 gG8dvnZP+TmpUtXMzKnQ1Ax+JZLdwb1pMSIvPLtN57/ytKZ4YatkqUXXi8UqEHidNcK3Jvq5gNY
 t25JoEVMeLpg8Ij0t0Q==
X-Authority-Analysis: v=2.4 cv=eKsjSnp1 c=1 sm=1 tr=0 ts=6a5c344f cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=qC1CW/w66vtJz1P9yTJxNA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=gAnH3GRIAAAA:8 a=qHo4TYnVUpYQsGEgifAA:9 a=CjuIK1q_8ugA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: DNRMGhw5v5MjFSk8lHLjhV2sVu47EjPm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDAyMCBTYWx0ZWRfX73s3EFbiVJQi
 X8G2kwQmqoQhRpp3HNYO9hkq5KYhimrhnjyJvraFUG5iYE1Qk8K2ZkJk5mFmvKVBUMU1GmzSTxj
 voSd8116IEv3dfNjqHYi2BEH2X6+ePU=
X-Proofpoint-GUID: DNRMGhw5v5MjFSk8lHLjhV2sVu47EjPm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_01,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607190020

On Wed, 15 Jul 2026 13:41:08 +0200
Janani Sunil <janani.sunil@analog.com> wrote:

> Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter
> from Analog Devices.
> 
> The device communicates over SPI and supports per-channel output range
> configuration. An optional external 4.096V reference can be used in
> place of the internal reference.
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
Hi Janini

Fairly quick review as it is end of day here now.
A few things inline.

Thanks,

Jonathan


> diff --git a/drivers/iio/dac/ad5529r.c b/drivers/iio/dac/ad5529r.c
> new file mode 100644
> index 000000000000..c279dc530d68
> --- /dev/null
> +++ b/drivers/iio/dac/ad5529r.c

> +static int ad5529r_reset(struct ad5529r_state *st)
> +{
> +	struct reset_control *rst;
> +	int ret;
> +
> +	rst = devm_reset_control_get_optional_exclusive(&st->spi->dev, NULL);
> +	if (IS_ERR(rst))
> +		return PTR_ERR(rst);
> +
> +	if (rst) {
> +		ret = reset_control_assert(rst);
> +		if (ret)
> +			return ret;
> +
Nothing on the datasheet to say how long it needs to be asserted?

If it is very small maybe add a comment to say that here.
> +		ret = reset_control_deassert(rst);
> +		if (ret)
> +			return ret;

> +
> +static int ad5529r_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad5529r_state *st;
> +	struct regmap_config regmap_8bit_cfg = ad5529r_regmap_8bit_config;
> +	struct regmap_config regmap_16bit_cfg = ad5529r_regmap_16bit_config;

I would fill both of these in using a designated initializer and do
it once we know the remaining fields.


	regmap_8bit_cfg = (struct regmap_config) {
		.name = "ad5529r-8bit",
		.reg_bits = 16,
		.val_bits = 8,
		.max_register = AD5529R_8BIT_REG_MAX,
		.read_flag_mask = AD5529R_SPI_READ_FLAG,
		.rd_table = &ad5529r_8bit_readable_table,
		.wr_table = &ad5529r_8bit_writeable_table,
		.reg_base = ...	
	};

That keeps everything in once place and removes the indirection of a template
that we then override parts of.


> +	bool external_vref;
> +	u32 dev_addr = 0;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	st->spi = spi;
> +
> +	st->model_data = spi_get_device_match_data(spi);
> +	if (!st->model_data)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Failed to identify device variant\n");
> +
> +	device_property_read_u32(dev, "spi-device-addr", &dev_addr);
> +	if (dev_addr > 3)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "spi-device-addr %u out of range [0, 3]\n",
> +				     dev_addr);
> +	regmap_8bit_cfg.reg_base = dev_addr << AD5529R_ADDR_SHIFT;
> +	regmap_16bit_cfg.reg_base = dev_addr << AD5529R_ADDR_SHIFT;
> +
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad5529r_supply_names),
> +					     ad5529r_supply_names);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get and enable regulators\n");
> +
> +	ret = devm_regulator_get_enable_optional(dev, "hvss");
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get and enable hvss regulator\n");
> +
> +	ret = devm_regulator_get_enable_optional(dev, "vref");
> +	if (ret == -ENODEV)
> +		external_vref = false;
> +	else if (!ret)
> +		external_vref = true;
> +	else
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get and enable vref regulator\n");

Slightly prefer these last two flipped so get the error of the way
a bit earlier.

> +

