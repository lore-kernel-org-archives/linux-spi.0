Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D80C373C1A;
	Thu, 10 Sep 2026 06:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789021414; cv=none; b=FpsVIsRrSJGfUtDXh78bMfCjMiRNzaYSGvVOufmEzQ0sfqZz18KvpK7OPif3cK6zRRXrw1aDF+4af02WD3CDBUb1QWpv/kby3Y6NpHnbAA2/e6gSrNUS1xc6Udnj2+0ycacLY1TBdeUp5O9MKSAu2WqQPOdOQjQHIeZfR3hzhe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789021414; c=relaxed/simple;
	bh=aqNX+9tAjd2/jVm9O8DWI+lgMgxqRluvBk2uSuJJv/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=taDO+ayM1XLkFAnCEJHqb5BKsBjXwJ8MUhc2TnMbZX98BJFq7X5e51P9EVJBCEeXLV2NptfCPUw093cuBJg3WqT/gGVX8/YQypPuP9fZMg0B/rMpHxbIjbEZJAq5f4lS8gN5oS6DVNnWdAmGH0w1ejsiNKcAAPktvysE8AAmRmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=y5gn1AHo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y5gn1AHo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Nr+oq6PsKxcBle0H0lwiDVCL6Vp35iitzfLcmlTGscQ=; b=y5gn1AHogARHFoH8bdigWxHlqv
	oS3og6i6V0pacOjdVHdKUUJKc9i7gAvLNrZtuCIauSn0y6DFcaYJuAfe8pwhsaMgwLtY/CrPcTd1T
	BLGilI8k7TX/dIKzzb+jGTkUorL6NEb7caA38Lx2HWtndY8W73DO7/YrhIfKa5j/mGxT/5/hkZYSP
	9GlE9FgOec4tHwo4jimppN1N4cHVGi7DGGI8dtn24109Iq4C4F4eEmfFWkd49qo6KmYWNt5LGWyJm
	fk9XchVlfSziME2QlLO+bVLBaWgW4MMQbvCB1BZhEQkxWs73UO3yaZsv51aov+RGzom8+ZCGl5oVk
	sykDuO3A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4YBu-0000000DVWG-4AfW;
	Thu, 10 Sep 2026 06:23:23 +0000
Message-ID: <a29070be-02ff-49b6-b0dd-625a3371a780@infradead.org>
Date: Wed, 9 Sep 2026 23:23:21 -0700
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: docs: Use the multi-lane mode constants in examples
To: Karl Mehltretter <kmehltretter@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
References: <20260910033219.15996-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260910033219.15996-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/26 8:32 PM, Karl Mehltretter wrote:
> The multi-lane documentation names SPI_MULTI_BUS_MODE_* constants,
> including in the transfer initializers. The interface introduced with
> the document uses SPI_MULTI_LANE_MODE_*, so the examples refer to
> undefined macros.
> 
> Use the interface's constants in the descriptions and examples.
> 
> Fixes: 05c3bd745bb0 ("spi: Documentation: add page on multi-lane support")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/spi/multiple-data-lanes.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/spi/multiple-data-lanes.rst b/Documentation/spi/multiple-data-lanes.rst
> index 69cb532d052f..802aece35d56 100644
> --- a/Documentation/spi/multiple-data-lanes.rst
> +++ b/Documentation/spi/multiple-data-lanes.rst
> @@ -127,7 +127,7 @@ field to indicate which mode they want to use for a given transfer.
>  
>  The possible values for this field have the following semantics:
>  
> -- :c:macro:`SPI_MULTI_BUS_MODE_SINGLE`: Only use the first lane. Other lanes are
> +- :c:macro:`SPI_MULTI_LANE_MODE_SINGLE`: Only use the first lane. Other lanes are
>      ignored. This means that it is operating just like a conventional SPI
>      peripheral. This is the default, so it does not need to be explicitly set.
>  
> @@ -149,7 +149,7 @@ The possible values for this field have the following semantics:
>          ----------   ----------------   ----------
>              SDO 0    0-0-0-1-0-0-0-1    SDI 0
>  
> -- :c:macro:`SPI_MULTI_BUS_MODE_MIRROR`: Send a single data word over all of the
> +- :c:macro:`SPI_MULTI_LANE_MODE_MIRROR`: Send a single data word over all of the
>      lanes at the same time. This only makes sense for writes and not
>      for reads.
>  
> @@ -160,7 +160,7 @@ The possible values for this field have the following semantics:
>          struct spi_transfer xfer = {
>              .tx_buf = tx_buf,
>              .len = 1,
> -            .multi_lane_mode = SPI_MULTI_BUS_MODE_MIRROR,
> +            .multi_lane_mode = SPI_MULTI_LANE_MODE_MIRROR,
>          };
>  
>          spi_sync_transfer(spi, &xfer, 1);
> @@ -172,7 +172,7 @@ The possible values for this field have the following semantics:
>              SDO 0    0-0-0-1-0-0-0-1    SDI 0
>              SDO 1    0-0-0-1-0-0-0-1    SDI 1
>  
> -- :c:macro:`SPI_MULTI_BUS_MODE_STRIPE`: Send or receive two different data words
> +- :c:macro:`SPI_MULTI_LANE_MODE_STRIPE`: Send or receive two different data words
>      at the same time, one on each lane. This means that the buffer needs to be
>      sized to hold data for all lanes. Data is interleaved in the buffer, with
>      the first word corresponding to lane 0, the second to lane 1, and so on.
> @@ -185,7 +185,7 @@ The possible values for this field have the following semantics:
>          struct spi_transfer xfer = {
>              .rx_buf = rx_buf,
>              .len = 2,
> -            .multi_lane_mode = SPI_MULTI_BUS_MODE_STRIPE,
> +            .multi_lane_mode = SPI_MULTI_LANE_MODE_STRIPE,
>          };
>  
>          spi_sync_transfer(spi, &xfer, 1);
> 
> base-commit: 50d05c7c76c96b90462f24debacca971d2e86713

-- 
~Randy
