Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D061C2236F7
	for <linux-spi@vger.kernel.org>; Tue, 11 Aug 2026 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786483743; cv=none; b=eK1jCiPLJ+/tyTtuQbXLrR6d5IW3Lga9/B3X9diTR37Bq3q+paXrXUSKisbGIz6WmNza1oCClUwWurS/QRYYrsZUsvQbU6fZBo5wz+FCIbvJY7A0k3pI+puYbkwrQ4Iehp1u680MvRQtmfzQ4BwFHt5bRVhA+3ZT6BnaqZ6qMtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786483743; c=relaxed/simple;
	bh=wtyFxw87QIcDyVCMx9KJ/sLvqa5v/E/XfP2PTsKx8J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NI7ZF6u/HOJA1nwTPVpie40iGXL5/QmH0genz7s2SJv+wa0J1kuI7ktjrEGdgp8e7AYn4KeHi+Hb5xPexboUy4ys32gDCqURgTb6RooAr4pI0eIuYUbR3J+y5CuFJs4ml3+b/5EcnS4SHYDPCaD8UectE7wPriYJNv1MBzQ+y1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m9D7zehZ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m9D7zehZ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4954c08a7c8so211455e9.3
        for <linux-spi@vger.kernel.org>; Tue, 11 Aug 2026 14:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786483740; x=1787088540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4gI9dvpa01ZokOTfkufKVuKta6ddjK6CUnqdhudxrHk=;
        b=m9D7zehZT5B9BoWggIlejtInoNkObwXmzf/kNoiBygEofARdRXZ5L9gtPEWWPACPrz
         gVbXNNs7MGzaOkfIcSlJF4G5EOCahTBuz5V9VRgEk/rWIg9u8TENrOAj3ACHDAdttsME
         KoS0wxHhCEXbZ4e3+P17mxJFSgOMEI1eOrjZIdA6cFxxJ4xKoMI4i7/d7qNz0fggJL3h
         nXSBrTOeyfUBbkML8+3i/vpbBCuythRS/JKmjCXE/Ywvp7JgBl4sWdC7jSLzw5XFvum6
         ViaGZNknq94YTBBiTmpkYg7tx3fBsnVPowCQ22YJXCTO+7dDaf1jOnb3cqvykC40NeVF
         5znA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786483740; x=1787088540;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4gI9dvpa01ZokOTfkufKVuKta6ddjK6CUnqdhudxrHk=;
        b=ISGqoiToD/fFlXFd0LSrT7B0jNyUbxwal+9AezeSXiTfpeogzMcm3V/dvPBm8I5D5n
         VV/RefWnya2St54arlDEOqAXJMrHc9BdsEVkGvVEHAz8CNJpK9c3nI/jHjWgAb5i/Bfx
         xSYAYpfBCRa2Bz+eGq4irqKpU20B1ZH9GOw0LJWAH7/HxDGuqOPq/iBTf/DnIolLRmi8
         8SrBUORgjLpXsOqUckx5tU3O5mAyTcReGpXUgirzocsHVw4JwGOZVj5ueemSmU8P/axD
         ZY+/9xwcbgt1axxo4VIcCLOfhUqeVtjM0V39fma09UnTsNnH4JzfyqpQzz8Vy03ghZAi
         SjBg==
X-Forwarded-Encrypted: i=1; AHgh+RpMPp4R1aX1fC8DKQ/57kx9ryaFJEZV5vVtYaQ+EEMPWq2xZ6uMxX0CzaXU5PMH//3Q1A+0hkJ4GG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YywFXse5c5UDy7KWwF5kBrgmvADr3hoJ+IanXvU7JYKlx8L50yq
	UBs4DvyN2Uj9TiuP+LLu15fb5xb2MLnufcXOczG37QKhjd5j7+Ba5U5l
X-Gm-Gg: AR+sD102I9wRKcF1vwFO0NPX3h349R7ezzyLiTAb4tKKErmdKZf8jqu53hGZbBCQ51R
	KPZtbKYOJtRT1kGT/2y4FGS5mWQ4N+Kg8mE6pYpBEuBQotpje7G1BGgLMHWq13hInEy3+MYbScq
	/AhDWRYK/XuUMACGaTx2rpiZX89TPApGVNWCqHLRiLCt/fU5hg8DB8BHCMpwdtUSF6JO+ObLUJa
	Q/4ksMiYZnqDr9f1bndq42OUh5pZC4mLOtRP9RWHijaOpFddAGr6zMSkkJXSJKORm818PcHVxDh
	0u+TDRisT88375+imZlqmPNBfZcqYFn66ds+x+KGOkeOjPpiuD+z6/9sUYi+ezZ9+rKep7HuRqD
	AaiX1TMycxfU9dKsJFQsyvSI59EJjZR8ahXZdwNUbBfCwOhdAJFwSoaE268nGlEGDeSpiu5pehe
	6Pa088JRYB409lXc9UslSgHX1mE0TJq++rKR8C/pkhJUr51c/P
X-Received: by 2002:a05:600c:4ecc:b0:499:5b0f:72b with SMTP id 5b1f17b1804b1-4997c0f76b8mr1016395e9.1.1786483739910;
        Tue, 11 Aug 2026 14:28:59 -0700 (PDT)
Received: from skbuf ([86.127.220.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997aaa63cbsm22316875e9.6.2026.08.11.14.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 14:28:58 -0700 (PDT)
Date: Wed, 12 Aug 2026 00:28:56 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Sasha Levin <sashal@kernel.org>
Cc: James Clark <james.clark@linaro.org>, stable@vger.kernel.org,
	Larisa Grigore <larisa.grigore@nxp.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Mehmet Fide <mehmet.fide@gmail.com>
Subject: Re: [PATCH 6.12.y] spi: spi-fsl-dspi: Avoid setup_accel logic for
 DMA transfers
Message-ID: <20260811212856.4wp56ryqgtgzahhc@skbuf>
References: <20260811091322.3592403-1-mehmet.fide@gmail.com>
 <20260811184500.stable-0013-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811184500.stable-0013-sashal@kernel.org>

On Tue, Aug 11, 2026 at 02:55:56PM -0400, Sasha Levin wrote:
> > Either way the behaviour is the same. On vf610 in DMA mode the accel path drops
> > the tail of odd length transfers and byte swaps under SPI_LSB_FIRST, and this
> > commit removes both. That is what makes it worth having in 6.12.y, whatever the
> > original intent was.
> 
> cac7e5054115 ("spi: spi-fsl-dspi: Avoid setup_accel logic for DMA transfers")
> applies cleanly to 6.12 with no dependencies, so this is not a mechanical
> question - it is whether it qualifies. It has no Fixes: tag and no stable tag,
> and James reads it as a refactor.
> 
> Larisa, Mark, Vladimir - was this a fix? If so, a Fixes: tag would let me take
> it here and on the older trees, where it applies just as cleanly.
> 
> -- 
> Thanks,
> Sasha

It wasn't understood as a correctness change until now, but yes, it is a fix.

Fixes: a957499bd437 ("spi: spi-fsl-dspi: Fix bits-per-word acceleration in DMA mode")
Acked-by: Vladimir Oltean <olteanv@gmail.com>

Explanation:
As part of the original introduction of dspi_setup_accel() in commit
6c1c26ecd9a3 ("spi: spi-fsl-dspi: Accelerate transfers using larger word
size if possible"), it was well understood that this is not applicable
to DMA transfers.

The reason is that the correct clustering of 8 bit frames into 16 bit PUSHR
transfers ultimately depends on the ability to modify the SPI_CTAR_FMSZ
(frame size) on the go. In the case of a 3 byte SPI transfer using
8-on-16 acceleration, the logic of this clustering is to first transfer
the first 2 bytes using a 16-bit PUSHR transfer (with SPI_CTAR_FMSZ=15),
then to update SPI_CTAR_FMSZ=7 in order to be able to push the last byte
using a single 8-bit PUSHR write.

The difference between FIFO mode and DMA mode is that in DMA mode, there
is no software hook to update SPI_CTAR_FMSZ in between PUSHR FIFO
updates. The DMA engine handles them.

This was well understood and was the basis of this code path, which
explicitly excluded DMA from dspi_setup_accel() with its dynamic frame
size updating:

		/*
		 * Static CTAR setup for modes that don't dynamically adjust it
		 * via dspi_setup_accel (aka for DMA)
		 */
		regmap_write(dspi->regmap, SPI_CTAR(0),
			     dspi->cur_chip->ctar_val |
			     SPI_FRAME_BITS(transfer->bits_per_word));

However, this truth was forgotten soon after, because as soon as a bug
report came in - the trigger behind commit a957499bd437 ("spi:
spi-fsl-dspi: Fix bits-per-word acceleration in DMA mode") - it became
broken.

Namely, the separate code path for static SPI_CTAR_FMSZ settings for DMA
mode got deleted, and dspi_dma_xfer() started calling dspi_setup_accel().
This had two effects:
- dspi_setup_accel() correctly updates dspi->oper_word_size, necessary
  in common code: intended, fixes the bug reported by Michael Walle
- dspi_setup_accel() enables 8-on-16 acceleration for DMA mode now,
  which will transfer 1 byte too few if the buffer size is odd (it
  incorrectly assumes that the caller can dynamically alter
  SPI_CTAR_FMSZ and then send the trailing word separately):
  unintended, causes the bug reported by Mehmet Fide

The breakage probably went largely unnoticed because Michael Walle's
peripheral only used even-sized buffers (a flash, IIRC), and the silicon
on which I regularly test the DSPI driver doesn't use DMA.

The commit under question here - cac7e5054115 ("spi: spi-fsl-dspi: Avoid
setup_accel logic for DMA transfers") - fixes the unintended side effect
while maintaining the intention of previous bug fix a957499bd437 ("spi:
spi-fsl-dspi: Fix bits-per-word acceleration in DMA mode"). By having
the "goto no_accel", we bypass the 8-on-16 acceleration on DMA, while
still assigning dspi->oper_word_size - which was the reason for calling
dspi_setup_accel() in the first place.

Note that 8-on-16 acceleration is not intrinsically broken for DMA mode
(it can yield a DMA buffer more densely packed with PUSHR data), it just
needs more work to skip it for odd-sized transfers. However, that work
may or may not be justified from a performance standpoint, so the
approach taken here is reasonable.


Regarding the SPI_LSB_FIRST issue - from the description it seems to be
a completely distinct problem not intrinsically limited to DMA mode
(should also be visible in XSPI mode), so disabling dspi_setup_accel()
on Vyber and Coldfire only partially addresses it.

I don't have a use case for SPI_LSB_FIRST peripherals, so I don't
personally mind another "goto no_accel" follow-up patch rather than
fixing the underlying byte packing mechanism, BUT this should be done
by the issue reporter with a proper explanation in the commit message
now that the issue is more clearly understood, rather than just be
happy that backporting commit cac7e5054115 sidesteps the problem on his
platform.

I am currently on vacation, and I am unable to do much testing on actual
hardware. I also haven't completely evaluated the SPI_LSB_FIRST behaviour
with 8-on-16 acceleration, it just *seems* plausible that there is an issue.
