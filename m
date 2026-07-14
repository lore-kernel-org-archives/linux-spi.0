Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14E6363C5E
	for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 10:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784024948; cv=none; b=UJnxqMSqOjZ3c3Az4GOXjJPfdM9joop+r+Mo9lISeT36ZP0HpqX3m1BqRG7zEP4T0SGmWuARn9UrcA8oYtoiegaNbCr1ZA8VPR3XVYspvxPySwj9gNzM6KAa2vDPA39pkhc4B2bjl7PHyjTL4dpvh/jwwL8J1r9z7SxnVE6wxTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784024948; c=relaxed/simple;
	bh=ppdlqc7aGmwIBtM7rV8FGwLMLfecZom5klWM1D0cau8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYs1kARpsubvZH9kKVIXArNi8MsDZWDH1SeLZW/XGjdc/eDdRt+ywl3q7v6V3wbI9iIv5mZ/k1w8yQUY3y0FlPcG2/CDnpnRMgZ1h59ylfErOKM38jtJSJCaRo3A6314VdJ/b3ylxyupHk694CXcFhA/kGhyjUzSOHSd48tGsqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHaeLLq+; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHaeLLq+"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c165a41a52bso142233466b.3
        for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 03:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784024945; x=1784629745; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V7NlB4CVXGAzGyZFkybVWrUhppspBJXa8haDERbPMLU=;
        b=BHaeLLq+3ScmffxyFjrlvzeY4aXY5eRoAh29VN3/a+0rVOO6W677AroVTbbmzFXuTO
         l8/iK/i1sJD02DO9DPitz/e4KvQ8nq49hSTWPg4tLqcCIK8jiMvzE2mCOIaCNUlXLdAs
         Ehr0WaPoa8izojntQlbIPZ1bEAT1koZ0nN5EzlcRoMdv+uVr/JEdpGrABqjzgykD+7Cw
         nqYHiP3yAs1P95hua1iSTMBfbprnQ+1w9NiMPVeKoUaAkECW6bxl/ZCmRn+El0I5IT9K
         tPrCFvsoQcLBwE2K+tVl4oQnUCdBLbkx12lLr+Rr11UIJIAeU/8bPvBEo3MhRvzcvD3L
         KI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784024945; x=1784629745;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=V7NlB4CVXGAzGyZFkybVWrUhppspBJXa8haDERbPMLU=;
        b=ZMUOFAI3omHkhXx0eKFzDRJNI9tiU4dmA3Oz1q8vVAeQQOMpScFBEp75m2nSPLtmA2
         GJzWE4I+rsOoKFsAgtHd8r+23VgexOznxba8HS46sYbihxUAw0wtPzekh4C7qtOZyshM
         41F+9BRx3Zs1htfbGTcc+2gIWzfEbY/PTYiUMKR2k5Te0kJjaldxKiHYTNQrOjHZ6okJ
         5FqXiqzoDrpKadtCBJW2DqedHDVpIinF0Ccq94AM9kr4MB1O5u92DLw983OTs6eTbNfa
         XLFi0WbioQ91tSrYPqf1KZMHAPwMYBN5W6W40I+zFLFd+IbAYv3t46hx38o06JeTRO/D
         pk7g==
X-Gm-Message-State: AOJu0Yxy1RoU5PcdBks0UH5VfMiIwx2ewFmFgeXxkIrZk8eY2pf6B+KA
	bH7wkPkLzUX4yyWrDknsZW96z9SezrieXVeH/sqE7rLdeC2O6/FY/QR6
X-Gm-Gg: AfdE7clbmZyQDk0yG7hmzAGpga+/GnhD9Le2m0hspeAJWQsNUrwp5tG3eE2XGLapl2q
	jDATWbp/QAcN5AoAqeBvQlMYjXgbssUN+tBXvYZW+awg+9ZCJBr4R+la3f6hDKr78iwvMQstyIZ
	dDa1Pe6Tp1V7+cScWWnlYg2BFtE3ZvvYgzeHmTXxTb5501tZwpfom9pWfKmVvvAUubT1lQhjEN9
	Ked7h9U/xPL0bRStsMudtq8M8jFoMOmrZVFyYIi3avhMWCIBGFOSpReDe+fFPVZn5/1hisKhZOa
	gv96YQdm5tYxLJwuD6jX0MLW6cJ2XZZqRFqSDvKvbl1ta3mcwBcIRtM5uhBc61JqU0cyWdTtTU0
	tL1hAzpfBdUkZL6U+QTQbqGhjokcaS6GnVnVZh8Kailkfkd8s6eocKQZpkL5pGFlWOAh6lxgygC
	YEtJEMHkvm0EEm+VEnDSRrDt4zzsI=
X-Received: by 2002:a17:907:a710:b0:c12:6584:c1 with SMTP id a640c23a62f3a-c1667a6921dmr72643966b.40.1784024944677;
        Tue, 14 Jul 2026 03:29:04 -0700 (PDT)
Received: from NSA-L02.ad.analog.com ([137.71.226.102])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15b7561db1sm1073971266b.12.2026.07.14.03.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 03:29:04 -0700 (PDT)
Date: Tue, 14 Jul 2026 12:29:01 +0200
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, michael.hennerich@analog.com, 
	broonie@kernel.org, jonath4nns@gmail.com, marcelo.schmitt1@gmail.com, 
	andy@kernel.org
Subject: Re: [PATCH 6/6] spi: axi-spi-engine: add support for dynamic
 multi-lane selection
Message-ID: <d7tpahtupvpde7ehqwsrdrhigeweuuu7as5vl332eaffig6ppl@5nq6a3ql76ws>
References: <cover.1783729282.git.Jonathan.Santos@analog.com>
 <c37b7c63f8d5e4e0df6f0130d202e1d2291e12af.1783729282.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c37b7c63f8d5e4e0df6f0130d202e1d2291e12af.1783729282.git.Jonathan.Santos@analog.com>

On Tue, Jul 14, 2026 at 02:57:00AM -0300, Jonathan Santos wrote:
> In SPI_MULTI_LANE_MODE_STRIPE mode, a transfer currently activates all
> available lanes. Some use cases require operating over a subset of lanes
> per transfer.
> 
> Make use of the rx_lane_mask and tx_lane_mask to allow setting the
> multi-lane configuration transfer-wise. Rename rx_all_lanes_mask and
> tx_all_lanes_mask in spi_engine_offload to rx_lanes_mask and
> tx_lanes_mask, as these fields now hold the active lane mask for the
> message rather than all available lanes.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---

LGTM,

Acked-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/spi/spi-axi-spi-engine.c | 62 ++++++++++++++++++++++++++------
>  1 file changed, 51 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
> index f2d0a6dd593b..d6c5264fee9a 100644
> --- a/drivers/spi/spi-axi-spi-engine.c
> +++ b/drivers/spi/spi-axi-spi-engine.c
> @@ -115,6 +115,10 @@
>  #define SPI_ENGINE_MULTI_BUS_MODE_UNKNOWN	-1
>  #define SPI_ENGINE_MULTI_BUS_MODE_CONFLICTING	-2
>  
> +/* Extending lane_mask values for optimizing messages. */
> +#define SPI_ENGINE_LANE_MASK_UNKNOWN		-1
> +#define SPI_ENGINE_LANE_MASK_CONFLICTING	-2
> +
>  struct spi_engine_program {
>  	unsigned int length;
>  	uint16_t instructions[] __counted_by(length);
> @@ -155,8 +159,8 @@ struct spi_engine_offload {
>  	unsigned int multi_lane_mode;
>  	u8 rx_primary_lane_mask;
>  	u8 tx_primary_lane_mask;
> -	u8 rx_all_lanes_mask;
> -	u8 tx_all_lanes_mask;
> +	u8 rx_lanes_mask;
> +	u8 tx_lanes_mask;
>  	u8 bits_per_word;
>  };
>  
> @@ -312,6 +316,8 @@ static int spi_engine_precompile_message(struct spi_message *msg)
>  	unsigned int clk_div, max_hz = msg->spi->controller->max_speed_hz;
>  	struct spi_transfer *xfer;
>  	int multi_lane_mode = SPI_ENGINE_MULTI_BUS_MODE_UNKNOWN;
> +	int rx_lane_mask = SPI_ENGINE_LANE_MASK_UNKNOWN;
> +	int tx_lane_mask = SPI_ENGINE_LANE_MASK_UNKNOWN;
>  	u8 min_bits_per_word = U8_MAX;
>  	u8 max_bits_per_word = 0;
>  
> @@ -339,11 +345,21 @@ static int spi_engine_precompile_message(struct spi_message *msg)
>  				return -EINVAL;
>  			}
>  
> -			/* If all xfers have the same multi-lane mode, we can optimize. */
> +			/* If all xfers have the same multi-lane mode and mask, we can optimize. */
>  			if (multi_lane_mode == SPI_ENGINE_MULTI_BUS_MODE_UNKNOWN)
>  				multi_lane_mode = xfer->multi_lane_mode;
>  			else if (multi_lane_mode != xfer->multi_lane_mode)
>  				multi_lane_mode = SPI_ENGINE_MULTI_BUS_MODE_CONFLICTING;
> +
> +			if (rx_lane_mask == SPI_ENGINE_LANE_MASK_UNKNOWN)
> +				rx_lane_mask = xfer->rx_lane_mask;
> +			else if (xfer->rx_lane_mask != rx_lane_mask)
> +				rx_lane_mask = SPI_ENGINE_LANE_MASK_CONFLICTING;
> +
> +			if (tx_lane_mask == SPI_ENGINE_LANE_MASK_UNKNOWN)
> +				tx_lane_mask = xfer->tx_lane_mask;
> +			else if (xfer->tx_lane_mask != tx_lane_mask)
> +				tx_lane_mask = SPI_ENGINE_LANE_MASK_CONFLICTING;
>  		}
>  	}
>  
> @@ -364,8 +380,13 @@ static int spi_engine_precompile_message(struct spi_message *msg)
>  					     &priv->rx_primary_lane_mask,
>  					     &priv->tx_primary_lane_mask);
>  		spi_engine_all_lanes_flags(msg->spi,
> -					   &priv->rx_all_lanes_mask,
> -					   &priv->tx_all_lanes_mask);
> +					   &priv->rx_lanes_mask,
> +					   &priv->tx_lanes_mask);
> +		if (rx_lane_mask > 0)
> +			priv->rx_lanes_mask &= rx_lane_mask;
> +
> +		if (tx_lane_mask > 0)
> +			priv->tx_lanes_mask &= tx_lane_mask;
>  	}
>  
>  	return 0;
> @@ -380,6 +401,9 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
>  	struct spi_transfer *xfer;
>  	int clk_div, new_clk_div, inst_ns;
>  	int prev_multi_lane_mode = SPI_MULTI_LANE_MODE_SINGLE;
> +	int prev_rx_lane_mask = 0;
> +	int prev_tx_lane_mask = 0;
> +	u8 num_rx_active_lanes;
>  	bool keep_cs = false;
>  	u8 bits_per_word = 0;
>  
> @@ -405,6 +429,8 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
>  		 */
>  		bits_per_word = priv->bits_per_word;
>  		prev_multi_lane_mode = priv->multi_lane_mode;
> +		prev_rx_lane_mask = priv->rx_lanes_mask;
> +		prev_tx_lane_mask = priv->tx_lanes_mask;
>  	} else {
>  		spi_engine_program_add_cmd(p, dry,
>  			SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_CONFIG,
> @@ -417,15 +443,27 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
>  	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
>  		if (xfer->rx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_RX_STREAM ||
>  		    xfer->tx_buf || xfer->offload_flags & SPI_OFFLOAD_XFER_TX_STREAM) {
> -			if (xfer->multi_lane_mode != prev_multi_lane_mode) {
> +			num_rx_active_lanes = spi->num_rx_lanes;
> +
> +			if (xfer->multi_lane_mode != prev_multi_lane_mode ||
> +			    xfer->rx_lane_mask != prev_rx_lane_mask ||
> +			    xfer->tx_lane_mask != prev_tx_lane_mask) {
>  				u8 tx_lane_flags, rx_lane_flags;
>  
> -				if (xfer->multi_lane_mode == SPI_MULTI_LANE_MODE_STRIPE)
> +				if (xfer->multi_lane_mode == SPI_MULTI_LANE_MODE_STRIPE) {
>  					spi_engine_all_lanes_flags(spi, &rx_lane_flags,
>  								   &tx_lane_flags);
> -				else
> +					if (xfer->rx_lane_mask) {
> +						rx_lane_flags &= xfer->rx_lane_mask;
> +						num_rx_active_lanes = hweight8(rx_lane_flags);
> +					}
> +
> +					if (xfer->tx_lane_mask)
> +						tx_lane_flags &= xfer->tx_lane_mask;
> +				} else {
>  					spi_engine_primary_lane_flag(spi, &rx_lane_flags,
>  								     &tx_lane_flags);
> +				}
>  
>  				spi_engine_program_add_cmd(p, dry,
>  					SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK,
> @@ -435,6 +473,8 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
>  							     tx_lane_flags));
>  			}
>  			prev_multi_lane_mode = xfer->multi_lane_mode;
> +			prev_rx_lane_mask = xfer->rx_lane_mask;
> +			prev_tx_lane_mask = xfer->tx_lane_mask;
>  		}
>  
>  		new_clk_div = host->max_speed_hz / xfer->effective_speed_hz;
> @@ -453,7 +493,7 @@ static void spi_engine_compile_message(struct spi_message *msg, bool dry,
>  					bits_per_word));
>  		}
>  
> -		spi_engine_gen_xfer(p, dry, xfer, spi->num_rx_lanes);
> +		spi_engine_gen_xfer(p, dry, xfer, num_rx_active_lanes);
>  		spi_engine_gen_sleep(p, dry, spi_delay_to_ns(&xfer->delay, xfer),
>  				     inst_ns, xfer->effective_speed_hz);
>  
> @@ -1034,10 +1074,10 @@ static int spi_engine_trigger_enable(struct spi_offload *offload)
>  
>  	if (priv->multi_lane_mode == SPI_MULTI_LANE_MODE_STRIPE) {
>  		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDI_MASK,
> -						    priv->rx_all_lanes_mask),
> +						    priv->rx_lanes_mask),
>  			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
>  		writel_relaxed(SPI_ENGINE_CMD_WRITE(SPI_ENGINE_CMD_REG_SDO_MASK,
> -						    priv->tx_all_lanes_mask),
> +						    priv->tx_lanes_mask),
>  			       spi_engine->base + SPI_ENGINE_REG_CMD_FIFO);
>  	}
>  
> -- 
> 2.34.1
> 
