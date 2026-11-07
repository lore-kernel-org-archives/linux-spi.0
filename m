Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794037897;
	b=njCw7umwS13VQxdaHYDrgfju+yygHUEXqlEHgU55bkK4nstKuRXp/Z2639rfb8iAuWN/
	 KS/cNmvxQo5H1/ErSDM6tnByGibkQyH5X7TINN3d3Fgc19uXjheheC0aQ454sgUK2JRju
	 Y997++7V8pD1DgYiZC8E70nNkeODsg1EZB3eN6mPMY2bzzWh4SbsY2s3P/NDMR5Ijz4v/
	 12n5NkfPGIGEviSOsZcN/AZ1atIsAgJrJOZSiHul4BsgLHyml+A1WquphGe/s17A6vKlT
	 Ic2xCOgOl318WzjDr0HOd+NWRj9ubsh8wEKAYBnjmK74GA7tGoc77yAk0HeUR13yQ3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794037897;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Sj6CMLfZRSZwceu+TpKvMT5HIhJI2K1ZZoMBycU64eE=;
	b=JgRbmCTNO23S6i1+zBnbTWGWwGWKSw5NsT4zh1EH/9LNDxdOJunYYYRTJX+QlKYDaXbO
	 hsyMn7/LK9fysY+0hk98iBpgw4HtdERtQWIK+P4HjHQdIA9ZnbNOD0KFDSUlwNPD5qvsv
	 qJf9x25zxXMwFIwcma0/VAtKm3tFVX54EnMdgEXpqLTTiAMOMjsTM+Ap4OlIRbBfOYgGJ
	 FZ6SZ6SJxpERAkigScNznBmyf/HM9P3WbofqRFpICQR5bKF4oAUrryVMKZ0pdNZ7aIBpd
	 evghwgSGj04ws3fsBCia4oQGK0Wpdbfr3W3be3bOHhUj6xs7qWYACiIJAaBTcXoCp0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZXA3bRr0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5BC606A326;
	Sat,  7 Nov 2026 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZXA3bRr0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6DB1F008A1;
	Sat,  7 Nov 2026 07:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794037897;
	bh=Sj6CMLfZRSZwceu+TpKvMT5HIhJI2K1ZZoMBycU64eE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZXA3bRr0TZJBuY6JZQouhPq5YfxmnIoPqDJHTWvZAJmpG/HutZO1aopf68prUMUnx
	 dUv3edTI+TKDiCZByiPbCe4criNqB/UTswMShTsYQj8jzIRZr8t4U01Oat0Bx6UIJX
	 7E1Zbi+uMC5amGftAuJJaxJqy5wxLTfk+JWZBxpZxURkKMsoZ6w8mVCA5nn4W93XVV
	 yxDEYYlDZIt3jQ0IhO35R514O4koZpd+aPKsM/K/HOg8DYG/K/q8fjoH4Xwkaur9XQ
	 M5/rDzf+kdOSVdIq5apOGwKyQSpyGE9JuAhyWq881xju/kGNb8UQwLhzsnfOvc9MNR
	 M5EQL1MCRt0Tw==
Date: Sat, 7 Nov 2026 15:31:27 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Parshuram Thombare <pthombar@cadence.com>,
	devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Fei Xie <fei.xie@horizon.auto>
Subject: Re: [PATCH 0/3] spi: cadence-xspi: add ACMD mode support
Message-ID: <au7Tz7Xp_fropQVZ@xhacker>
References: <20261029-xspi-cadence-add-acmd-v1-0-f4f15bc807fa@analog.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261029-xspi-cadence-add-acmd-v1-0-f4f15bc807fa@analog.com>

On Thu, Oct 29, 2026 at 03:53:07PM +0000, Nuno Sá wrote:
> The Cadence xSPI driver currently drives every operation through STIG
> mode, where the CPU builds each command and drains the data. The
> controller also has an auto command (ACMD) mode where it runs whole
> sequences on its own and can move data with its internal DMA, which
> pays off for bulk reads.
> 
> Whether ACMD and the internal DMA can be used depends on the SoC
> integration (external SRAM, the DMA bus requester interface being
> wired), which the controller registers do not expose. Hence two new
> devicetree properties: cdns,has-acmd and cdns,has-internal-dma.
> 
> For now, ACMD is only used for reads of at least 2048 bytes with an
> address phase, using the internal DMA, and only when both properties
> are set. Smaller reads and all other operations stay on STIG.
> 
> NOR and NAND are handled the same way: NAND operations are still issued
> one by one, not combined into a single ACMD sequence, so no NAND
> geometry is needed. The real gain is on large reads which, for NAND,
> means chips supporting buffer/sequential read mode.
> 
> Another attempt for ACMD was sent in [1] but that relies on knowing the
> NAND geometry which brings much more complexity given that it needs a
> proper interface implemented in the spi-nand core. So we agreed on
> starting with this simpler approach and then build on top of it if we
> agree it pays off (mostly on cpu load).

Hi Nuno,

Thanks for this series though I can't test it because my platforms
disables the ACMD during integration.

I just sent out a series to reduce the cpu load and improve performance
(possibly with powerful system memcpy dma engine), if your platforms
have the suitable memcpy dma engine, can you please try it?

Hi Fei,

can you plz try it too if your platform has suitable memcpy dma engine too?

Thanks
> 
> Some stats:
> 
> ACMD
> -----
> 
> SPI-NOR - is25wx01g (only reads > 2k are done in ACMD )
> -------
> 
> flash_speed -c 5 -d /dev/mtd4
> not NAND flash, assume page size is 512 bytes.
> scanning for bad eraseblocks
> scanned 5 eraseblocks, 0 are bad
> testing eraseblock write speed
> eraseblock write speed is 1054 KiB/s
> testing eraseblock read speed
> eraseblock read speed is 106666 KiB/s
> testing page write speed
> page write speed is 1035 KiB/s
> testing page read speed
> page read speed is 15238 KiB/s
> 
> SPI-NAND - w25n08lw (all reads are ACMD given that page size is 4k)
> --------
> 
> flash_speed -c 5 -d /dev/mtd5
> scanning for bad eraseblocks
> scanned 5 eraseblocks, 0 are bad
> testing eraseblock write speed
> eraseblock write speed is 6497 KiB/s
> testing eraseblock read speed
> eraseblock read speed is 44137 KiB/s
> testing page write speed
> page write speed is 6336 KiB/s
> testing page read speed
> page read speed is 16842 KiB/s
> 
> STIG
> ----
> 
> SPI-NOR
> -------
> 
> flash_speed -c 5 -d /dev/mtd4
> not NAND flash, assume page size is 512 bytes.
> scanning for bad eraseblocks
> scanned 5 eraseblocks, 0 are bad
> testing eraseblock write speed
> eraseblock write speed is 1054 KiB/s
> testing eraseblock read speed
> eraseblock read speed is 64000 KiB/s
> testing page write speed
> page write speed is 1042 KiB/s
> testing page read speed
> page read speed is 14883 KiB/s
> 
> SPI-NAND (Cont mode)
> --------
> 
> flash_speed -c 5 -d /dev/mtd5
> scanning for bad eraseblocks
> scanned 5 eraseblocks, 0 are bad
> testing eraseblock write speed
> eraseblock write speed is 6564 KiB/s
> testing eraseblock read speed
> eraseblock read speed is 18823 KiB/s
> testing page write speed
> page write speed is 6400 KiB/s
> testing page read speed
> page read speed is 18028 KiB/s
> 
> For now, we have a static threshold to decide to use ACMD or not. I do
> understand that's not ideal. It might depend on sclk and number of lanes
> so not sure if that value will be accurate for everybody. So, open to
> suggestions if someone has something in mind regarding this.
> 
> [1]: https://lore.kernel.org/linux-spi/20260921093701.1341766-1-fei.xie@horizon.auto/
> 
> ---
> Nuno Sá (3):
>       spi: cadence-xspi: rename sdma_error to xfer_error
>       spi: dt-bindings: cdns,xspi: add ACMD and internal DMA properties
>       spi: cadence-xspi: add ACMD mode support
> 
>  .../devicetree/bindings/spi/cdns,xspi.yaml         |  18 ++
>  drivers/spi/spi-cadence-xspi.c                     | 269 +++++++++++++++++++--
>  2 files changed, 273 insertions(+), 14 deletions(-)
> ---
> base-commit: 7da2aca123754c0e06092bbe179d58078b58d8d4
> change-id: 20261027-xspi-cadence-add-acmd-3c0e342cb4f4
> --
> 
> Thanks!
> - Nuno Sá
> 
