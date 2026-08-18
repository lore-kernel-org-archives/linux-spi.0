Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4BA26E71F
	for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 16:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787069190; cv=none; b=sJvwwsgJhWcL3ZVbYYOzVtjzcgVsmInbq6ZGWB0+yJr+OOb+tGYbjaKTHg/ssHUGdMz3nSFq32oKR1WkjL7kieDmELW92vVtS1Imv+wghUCjtQPq3U1yKXIeSa0hU+LbIJImhsRV2WEc5rq2ExqPl+bHApxYO0xjomwewT58oO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787069190; c=relaxed/simple;
	bh=B2ywwMonHrBnjH6vS+Aj0n1qipbU/Z36vRox+vXALBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VbybGO63HHTJ1dmUm8kZL9Kj8fWBsKWN5WEPWnTYWFqzx20Z0UV7lXkScaoihqolvb849u7BKP15lfVka611/u5O6dJDfuPZlS046RUGHotSbDC42huSMWJemu0npzCgLdJwfuPxhwhmwPiptBpA/VuI/t03R5xqJzByWBGNKy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=UAh8xeUj; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="UAh8xeUj"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7ec1e9d3359so13353a34.0
        for <linux-spi@vger.kernel.org>; Tue, 18 Aug 2026 09:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1787069186; x=1787673986; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y6N4VqRsPZbynWcj29TJaieC8DdAOJl0e37hrVQsSOU=;
        b=UAh8xeUjAqAITwiCdntbGGtcV8ea6F9Gx2nOxgOK2DHUfEVeCBAtgeC+Pcf0ROWLCQ
         g2U7D4RnUh+P8TOTrbnXXeyfegh8zRydqUp5AfQxJ4Yb8TizYL8slXlUHTwtccaEI5Om
         AfcZrBkLM3SR1qrDShjT8LWhvEHWH1j3X4oQM9Yq6jmDcOfaEqJzhXHXFlb6Kd94iYNZ
         zf420GZyfIiI63EWEr10j7syvOVgD2g331BtX5M4NFHCbaXdIwopmSBXPZ8c64dz4M28
         lLvYxT8RhBeM1iYhxnCvwsCV06GBQ4EAbHKEfYusSd1RgyFgve40yFNqTQsvfXTPUfEH
         5mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787069186; x=1787673986;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=y6N4VqRsPZbynWcj29TJaieC8DdAOJl0e37hrVQsSOU=;
        b=GJE/+artcqbkqqF4LOdyn7EtIXVaQqUohV4FJtvBcIY2pHWWh8FdVjPUef+C78qMge
         YXzPGMkpaw22eoMIje1quUWIHzHOHbolSOkwKvCUa98b6HjJ2B8uowt0lnL4xKUhBYAI
         EoxMxTnLOTD4Dhj2NUq6HIKmu3ch8JNMB1amGIrLBJIQ0E+d21WeV/eJiSKJIE0rQ9TZ
         gmITqMO+OEbOXMBaz5bO0+V74WkFIIdVa7s08tRYP64wixtvALpi+GK6J3ygSYw3xCeK
         B3sN9x/ler0EYW6meLr+iebF0R7x24BgrJtYAx5FqZq2abh9s0zzAnZiKETobTipY9Rw
         uWTQ==
X-Forwarded-Encrypted: i=1; AHgh+RoH40QBWpDkj7mB9JF3iybDZlctFcD6zP9ZlSxVGhXOdiHE9lEzqQ9Fx9XNq+mBPTUIqrdx5ct6Wfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPOUeaHaAJUE0gwMwurYnkVtj7pYrW9udlY0f1ehm63EQwEfMY
	tKJ8H8Ch9R/Im69djaMJgQSZjpAPMV4D2oLN5nPYjRHmnxHZvTgxUPYVad2XfTdkUJM=
X-Gm-Gg: AR+sD12a/grEfkc+k9rOZf4plA3pklXvm5QreFBT4nRSyXpHZ+UofATDQQgy7fN1T1J
	0vTX9sZExxK0aXvQr8rbQ5y6eQoQ557nFMbyJzVPDdBa6GOdl4IcuGFj11oyl5PJcTudPUjoQU+
	SpmkWNrCgiRDM9lv722zH/Upj6PSQZmjC51VM/he4bLvQ0sHAt30FsHKkZ7voaDSmDW+Tql9S+7
	z1SB++naOOuZue4lqzrH6p9i7PmSiSc/n/DX5hD418ZmGEKdQCSaCbKkL/i0+l0nKPhfsXMEDiU
	VsRGF58qNWyUILQWJDWNhc2direSocMCmtoaWpWDIGBgjnwjuYz/3+w657BjzQ09DUgZUXXHI0Q
	8Nlpra9buBQIuK6f3tCm2dOFpC8KUcOjFiR5IO4o9EFO9kEn4CMz4m1G3tq6sJgedRNojtKPPIK
	cDp7a/JX+ccmdEzRz5q2yTRUuvTgUfaoFFQ6A5rKQJQiE6qMXDz/eNcFCoHUYBJLbfAH5N7Mk0/
	muwW4QbUt7FgLUOPf6KYoseL2Kvnyj1EywkOdY=
X-Received: by 2002:a05:6830:3142:b0:7ec:2fe:1ec0 with SMTP id 46e09a7af769-7f423c25d11mr8527346a34.4.1787069185976;
        Tue, 18 Aug 2026 09:06:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:1cf0:fc72:ac61:29db? ([2600:8803:e7e4:500:1cf0:fc72:ac61:29db])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f41c12af87sm4613659a34.25.2026.08.18.09.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 09:06:25 -0700 (PDT)
Message-ID: <e2016946-83e8-46f5-975d-634a219417e7@baylibre.com>
Date: Tue, 18 Aug 2026 11:06:24 -0500
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] spi: support simultaneous assertion of multiple CS
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: nuno.sa@analog.com, michael.hennerich@analog.com, broonie@kernel.org,
 jonath4nns@gmail.com, marcelo.schmitt1@gmail.com, andriy.shevchenko@intel.com
References: <cover.1786973376.git.Jonathan.Santos@analog.com>
 <e8870b405f29cc89439701d1fcc7e88781aaab22.1786973376.git.Jonathan.Santos@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <e8870b405f29cc89439701d1fcc7e88781aaab22.1786973376.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/17/26 6:32 PM, Jonathan Santos wrote:
> Some SPI controllers allow multiple CS lines to be toggled at the same
> time. The existing code always used CS index 0 when tracking the last
> active CS in spi_set_cs(), and unconditionally set cs_index_mask to
> BIT(0) when parsing DT, both forcing the single CS usage.
> 
> Modify spi_set_cs() to iterate last_cs[] using each logical CS index
> instead of always reading index 0. Modify of_spi_parse_dt() to build
> cs_index_mask from all parsed CS entries rather than hardcoding BIT(0),
> so the controller correctly identifies which CS lines belong to a device
> when asserting them simultaneously.
> 
> Board info, ACPI, and ancillary device paths are not updated here.
> Board info would require an API change to accept an array of CS values
> and is left for a follow-up when we have a use case for this. Ancillary
> devices are by design single-CS, so multi-CS is not a current use case for
> them. ACPI represents the CS as a 64-bit integer with no established
> convention for encoding multiple CS indices yet, so any extension there
> would require a separate specification effort.
> 
> Acked-by: Nuno Sá <nuno.sa@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> Changes in v3:
> * None.
> 
> Changes in v2:
> * Include Summary describind why the other SPI paths were not addressed
>   here.
> ---
>  drivers/spi/spi.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index d9e6b4b87c89..55fb96fea243 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1090,7 +1090,7 @@ static void spi_set_cs(struct spi_device *spi, bool enable, bool force)
>  	spi->controller->last_cs_index_mask = spi->cs_index_mask;
>  	for (idx = 0; idx < SPI_DEVICE_CS_CNT_MAX; idx++) {
>  		if (enable && idx < spi->num_chipselect)
> -			spi->controller->last_cs[idx] = spi_get_chipselect(spi, 0);
> +			spi->controller->last_cs[idx] = spi_get_chipselect(spi, idx);
>  		else
>  			spi->controller->last_cs[idx] = SPI_INVALID_CS;
>  	}
> @@ -2594,10 +2594,11 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>  		spi_set_chipselect(spi, idx, cs[idx]);
>  
>  	/*
> -	 * By default spi->chip_select[0] will hold the physical CS number,
> -	 * so set bit 0 in spi->cs_index_mask.
> +	 * Set cs_index_mask to indicate which logical CS indices are active.
> +	 * Each bit corresponds to a logical CS index in the spi->chip_select array.
>  	 */
> -	spi->cs_index_mask = BIT(0);
> +	for (idx = 0; idx < rc; idx++)
> +		spi->cs_index_mask |= BIT(idx);
>  
>  	/* Device speed */
>  	if (!of_property_read_u32(nc, "spi-max-frequency", &value))

I have the same concern that sashiko calls out here.

Existing users of multi-cs (not including spi-mem) follow the pattern
that a SPI device gets registered with the CS at index 0 and they later
create an auxiliary using the additional CS. This would cause the main
device to now assert both CS. Not what we want to happen.

If I understood (and remember) the previous explanations of this series
correctly, we have a different case for this one.

We want a main device that acts as a single composite device that asserts
all 4 CS at the same time. Then we also need 4 auxiliary devices that
only assert one CS at a time for configuring the individual chips.

So it seems to me like we need a new DT property or some way to be able to
tell the difference to decide whether we just use the first CS here or all
of them.

Perhaps another possibility would be to leave this code the way it is and
do it this way instead:
- The SPI device passed to the IIO driver is just the first chip (one CS)
- The IIO driver then registers auxiliary drivers for the other 3 chips
  (also 1 CS each)
- These 4 devices will be used individual to handle configuration.
- The IIO driver registers a separate composite device that has the
  multiple lanes and and multiple CS. Whether this using the same
  auxiliary mechanism with additional parameters or something new
  probably doesn't matter too much.
- In this way of doing things, it would not make sense to have the
  spi-rx-bus-width property in the devcietree since as far as the
  devicetree is concerned, these are more-or-less 4 separate devices
  (from the SPI point of view).  Instead, this new composite device
  registration function would be the one setting the number of lanes
  based on the number of chip selects.

---
sashiko output for reference:

--- Patch [2]: [PATCH v3 2/6] spi: support simultaneous assertion of multiple CS ---
commit 17290644299c39d6ca397b14180cd885c5b04919
Author: Jonathan Santos <Jonathan.Santos@analog.com>
Subject: spi: support simultaneous assertion of multiple CS

This commit modifies spi_set_cs() and of_spi_parse_dt() to allow
simultaneous toggling of multiple chip select lines. It builds
cs_index_mask from all parsed CS entries instead of hardcoding
bit 0.

> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index d9e6b4b87c899..55fb96fea2432 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c

[ ... ]

> @@ -2594,10 +2594,11 @@ static int of_spi_parse_dt(struct spi_controller *ctlr, struct spi_device *spi,
>  		spi_set_chipselect(spi, idx, cs[idx]);
>  
>  	/*
> -	 * By default spi->chip_select[0] will hold the physical CS number,
> -	 * so set bit 0 in spi->cs_index_mask.
> +	 * Set cs_index_mask to indicate which logical CS indices are active.
> +	 * Each bit corresponds to a logical CS index in the spi->chip_select array.
>  	 */
> -	spi->cs_index_mask = BIT(0);
> +	for (idx = 0; idx < rc; idx++)
> +		spi->cs_index_mask |= BIT(idx);

Will this loop break backward compatibility for devices that use multiple
reg entries for independent logical chip selects?

For example, if a device has multiple reg entries and uses
spi_new_ancillary_device(), the primary device's cs_index_mask will now have
multiple bits set. During a transfer on the primary device, all of these
parsed chip selects would be asserted simultaneously.

Could this result in multiple chips driving the shared MISO line at the same
time, causing bus contention and data corruption?

>  
>  	/* Device speed */
>  	if (!of_property_read_u32(nc, "spi-max-frequency", &value))
