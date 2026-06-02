Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2060380FDD;
	Tue,  2 Jun 2026 16:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418987; cv=none; b=A3CcUchPTu2I8fuXY4A0UssrqXOVDpFqvvtz/Zaq6WOwThOCY6ys8Uyc5XnrZgiErIrliuLKDH74g+HwXz6Bwx2x5RAaLH0hIQHh6CTiu82S2NwBKW2RBjwbUHsjuTAJxrzi2MSp1Lf4K9WHOmdMZIfnk9blm4mvmkvC/xSQOGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418987; c=relaxed/simple;
	bh=nOPcku8qb+krptKfLwxVYvZvT7ItqzNcscnUvyFCJOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljBjsPR5qm6eT2m0cvSm8YWKsGCR5zhT8iUiqd3QHcD6YXGO8iw6WIC/q9AdKWaTaNa3k+M+Q+zH0Q3m3iaW57wYzEENQLReHHUvbzR6eUYw+6hHCXzIpnp4S0E2PCh4+Ju6op/e2OkZUiCZvcutMF5DxsvkgA4YE+PRg5pvDJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0f+O0gv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0f+O0gv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0681F00893;
	Tue,  2 Jun 2026 16:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780418986;
	bh=LFB8O8U4QgaKB297gBssYNIgpiABI/UmXL93J9wGzfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q0f+O0gv/nkLTpToavxBJddtyEo1zobgVX2X7Jj3xKtlSsDjIRF9S8gJpma1B7Qw/
	 qpl8eEOQV+9UPVmeeufPbe/H5gPWw7dPYQvaS3mMUo8Ro7bHTttsM4nKQNeSsFd0dY
	 ANlwIX1w3c4u+XYNghpN2ACSZhR8hrfvovzH1+aY5cRB/ocUbAiQku2BvRldicjt06
	 KHiK20PsKJ6L2N8hxPXB7Y/QqXvokTdFt2k116t2kSoc8RMJMz4Gdrs239n/VK7i3C
	 287/dtH4ozIY0ReLdShcsEkgmwITonFIAQzwfVOScdz5P0rWtKCYnSD5/h9gXD/48J
	 u0Sjr3Er+fpyQ==
Date: Tue, 2 Jun 2026 11:49:45 -0500
From: Rob Herring <robh@kernel.org>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: broonie@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	pratyush@kernel.org, mwalle@kernel.org,
	takahiro.kuwano@infineon.com, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, praneeth@ti.com, u-kumar1@ti.com,
	a-dutta@ti.com
Subject: Re: [PATCH v3 02/13] spi: dt-bindings: cdns,qspi-nor: add PHY tuning
 pattern partition property
Message-ID: <20260602164945.GA475455-robh@kernel.org>
References: <20260527175527.2247679-1-s-k6@ti.com>
 <20260527175527.2247679-3-s-k6@ti.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527175527.2247679-3-s-k6@ti.com>

On Wed, May 27, 2026 at 11:25:16PM +0530, Santhosh Kumar K wrote:
> PHY tuning requires a known data pattern to be readable from flash.
> When no partition is explicitly identified, the controller must search
> all available partitions to locate the pattern by label, which adds
> overhead and relies on label naming conventions outside the
> controller's control.

I agree 'label' is not the best choice. Software should not care what 
'label' contains. It should really be 'compatible' instead.

> Add cdns,phy-pattern-partition, a phandle property that allows the DT
> author to directly reference the flash partition holding the PHY tuning
> pattern. The controller uses this partition during calibration, avoiding
> the partition search entirely.

Do you have any data that this approach being "direct" is faster? In 
fact, it might be worse. Instead of searching just the limited number of 
partition subnodes, you now search the entire tree for a matching 
phandle value. We do have phandle caching, so that might save you here.

Rob
