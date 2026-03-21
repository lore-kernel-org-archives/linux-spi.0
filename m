Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94894284693
	for <linux-spi@vger.kernel.org>; Sat, 21 Mar 2026 03:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774062326; cv=none; b=ITYU1rh5vDIRWe9bSmEJnOuwJvb+BaKoQL3HLEm+2bnqFyG4L+rRlQYbnSYPCNK6Weik3XYZPIU3y47/xu+AcUj5ywLJiUhFYGYYRlNloDSXv2BUmP73H/HxAQK7+uzAOjp9YitylbkJDA8ujobSd676Q21aB2mbjOn+m/TiucQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774062326; c=relaxed/simple;
	bh=hkEbWHvoyfi4N2vi01N5wh/+M84rhTi8RB7e+26RNm8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TOwiHR8JV+mH+ZTRRSMZApz5t5a+vWwykRdAXHiXDdjYOAx9p21ng3+j0jnFZmB0zirPnqP2W6Uq0mPXB1wflT1zkaEfQeHjRfFpefGXc8aR/bnK+SouNy3azqawm2LIym+Ik1yYJuZ80v6/HIE+iGvA63HWx0rIg8VOCARFf9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=fVBcEMd9; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="fVBcEMd9"
Message-ID: <2d0ca19b-9b8b-4cca-9679-56983ae75b99@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1774062312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZXbJCxPsCXe3gsiN6EBXHO7z8maO4HKWRtMFfUGI4KM=;
	b=fVBcEMd9yEFI3jf8A/z7nxnlZMEmz4yTOmzHKogS4+FtOL7Ny0USYNvvotZHinWUAQKVg4
	gEOc7sRm9P36Qx903N8JR4Q3KZFe6CmPL+1mtUJ7p6tGK1iBVSqs9Xz0whu+QrPOmjswPk
	ogQhAbrqirF10XpeOJEpFUr//t2GM5xRnIo+6zSwl5S8HiDSDFom/6SO5z7eIKwR7TLcsu
	XXGzZ7vHFpj6Zsm16SXXtgTvWHADnNkC0PO1D/ipqUHnvqCvmqmhufN2PNV/XMfRjPCVuL
	r6KI/AWZR7Kz8U2wWl9mEwgeUtxhq5DsNypCzk8a7FGVL7YdtprBRjcF9iVWXQ==
Date: Sat, 21 Mar 2026 00:04:55 -0300
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] spi: geni-qcom: Fix CPHA and CPOL mode change
 detection
To: Jonathan Marek <jonathan@marek.ca>,
 Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>,
 Mark Brown <broonie@kernel.org>, konrad.dybcio@oss.qualcomm.com
Cc: kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 bjorande@quicinc.com, mukesh.savaliya@oss.qualcomm.com,
 praveen.talari@oss.qualcomm.com, jyothi.seerapu@oss.qualcomm.com
References: <20260316-spi-geni-cpha-cpol-fix-v1-1-4cb44c176b79@oss.qualcomm.com>
 <4a7d89ef-0f63-a7c3-e996-ff9fc476a04e@marek.ca>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <4a7d89ef-0f63-a7c3-e996-ff9fc476a04e@marek.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/16/26 2:13 PM, Jonathan Marek wrote:
> Reviewed-by: Jonathan Marek <jonathan@marek.ca>
>
> at least it doesn't look like this stupid mistake breaks anything 
> upstream (no spi-cpha/spi-cpol in any qcom dts)

There might not have been any users upstream but you never know what 
people are working on :)

Looks like this might've unblocked my progress with one of the phones I 
have WIP for (sm6115-motorola-guamp) which has a Himax touchscreen 
(yuck[1]) that uses SPI mode 3. Only tested quickly but at least one 
reply in the early init sequence makes sense now!

Before:

hx83102j spi0.0: himax_spi_read: xfer_tx_data: f3 08 00
hx83102j spi0.0: himax_spi_read: xfer_rx_data: 08 00 00 00
hx83102j spi0.0: hx83102j_sense_off: Do not need wait FW, Status = 0x08!
[..]
hx83102j spi0.0: himax_spi_read: xfer_tx_data: f3 08 00
hx83102j spi0.0: himax_spi_read: xfer_rx_data: 18 00 00 00

After:

hx83102j spi0.0: himax_spi_read: xfer_tx_data: f3 08 00
hx83102j spi0.0: himax_spi_read: xfer_rx_data: 04 00 00 00
hx83102j spi0.0: hx83102j_sense_off: Do not need wait FW, Status = 0x04!
[..]
hx83102j spi0.0: himax_spi_read: xfer_tx_data: f3 08 00
hx83102j spi0.0: himax_spi_read: xfer_rx_data: 0c 00 00 00
hx83102j spi0.0: hx83102j_sense_off: Safe mode entered

So that's a very late

Tested-by: Val Packett <val@packett.cool>


BTW, spi-cpha/spi-cpol in DTS is not an entirely reliable indicator it 
seems? Loooots of drivers set SPI_MODE_x in code explicitly, my 
understanding is that that overrides dts.


[1]: 
https://lore.kernel.org/all/TY0PR06MB561105A3386E9D76F429110D9E0F2@TY0PR06MB5611.apcprd06.prod.outlook.com/

> On 3/16/26 9:23 AM, Maramaina Naresh wrote:
>> setup_fifo_params computes mode_changed from spi->mode flags but tests
>> it against SE_SPI_CPHA and SE_SPI_CPOL, which are register offsets,
>> not SPI mode bits. This causes CPHA and CPOL updates to be skipped
>> on mode switches, leaving the controller with stale clock phase
>> and polarity settings.
>>
>> Fix this by using SPI_CPHA and SPI_CPOL to detect mode changes before
>> updating the corresponding registers.
>>
>> Fixes: 781c3e71c94c ("spi: spi-geni-qcom: rework setup_fifo_params")
>> Signed-off-by: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
>> ---
>> This patch fixes SPI mode change detection in the spi-geni-qcom driver.
>>
>> setup_fifo_params compared spi->mode against SE_SPI_CPHA/SE_SPI_CPOL,
>> which are register offsets instead of SPI_CPHA/SPI_CPOL mode bits.
>> This could skip CPHA/CPOL updates on mode switches and leave stale
>> clock configuration.
>> […]

Thanks a lot for finding this!!

~val

