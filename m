Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899303;
	b=NE5zOh4ypCR+sBrk+mbpYYAqyv3F4jXyKMevqKIw1xNgicNi2Os1btkT1Gm32ujPnJHH
	 V9JZaY+FhH4G0gFDUvmA9YESXGkTIPTKtq3Y/ZTg/T2x5+a49nFmZmUUztB0oCEi51KVF
	 eWQeD/zUvFIzMqh/KKLHUwIuEgkLREcWzhK5+depsRwBdrCAboTyZhkMKzMAw8jzgH+mZ
	 bk/6l+fiQ8AMOzPHy50lBZ5AmI5sbbpfPiM9Prb9ap7aK00GEIY4IU5SKqAo6Lu17U1tv
	 D7On30PZgLsPLhECRc6348/VbO8NJxxJjcK9jxXeEHhi+7Xj3QMi/Qy6g0hB3rrsu2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899303;
	h=Received:DKIM-Signature:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=J29j2FTF2kZyY8FR+vqT+YtHMECplwfMHUOlXHohMLQ=;
	b=svUSOByJlO48zbucXZF9kr1RhtXOhQu2nrikoEUCpC0dqP3KV8hFS8zoUhjMkXiJYVSg
	 lpg6B2MgGdRIPJs0AuTdWIPJQyH+GP5ktux4qJ6ksKmSaQ2W8xsZhTxjJ0R9P0gEI4B90
	 DOVTfDppas+C+O3MhYnvvXuxVprjDjthiHR2AnEhzmyr8R2b5/XonFoAw5rs2GkYzTTBT
	 E+yDnu6ea/BHyIZiWpTFcYxFwoYJ6nRqZkdgxo4tv5KK+I09Yb7qrpKBl+y31WN1cZMof
	 L8qYg3EvyYK5E0eap3PPC46LaBI++pI6LX0TJUkY9r5py27MsPQLle/GsupN5hRPARg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hozC474n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6265B606D81D;
	Thu,  5 Nov 2026 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hozC474n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD2F1F00A15;
	Thu,  5 Nov 2026 17:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793899303;
	bh=J29j2FTF2kZyY8FR+vqT+YtHMECplwfMHUOlXHohMLQ=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=hozC474nQcThmslZgShDckSTgkqAWA3LVbuIi/4tD8mnomn1ttPIJXIIt748ilLjD
	 fUCgZWlNGPXy2VX5xyDBQNZSKk8EjDjD+/54mqnyCL0pycJrHwZLHgLrswmBSr6wCf
	 7XAQjLEC7zdDy3YLuOxSWQf0O86xDogFb84szA9EruBDPU+ToZzmgJOkE+bvIoLWR2
	 nFaIowqK2yuUerXr5hSUVc1CbJ8Z31cW6bxsh8wx1ymp76WP4gUV9hc4Hvwu/nqePH
	 Yk5wejGwIfHoAErYIZKvFR+Gh2g6BakM7ojfD+jXgor61EsPOMn8mhRRayaubyx4Nf
	 m7rmwg5OIjXcg==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 58482279ADC6;
	Thu, 05 Nov 2026 17:21:37 +0000 (GMT)
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 5/7] spi: cadence-xspi: Add irq-less support
From: Mark Brown <broonie@kernel.org>
To: Paul Cercueil <paul.cercueil@bootlin.com>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Takahiro Kuwano <takahiro.kuwano@infineon.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Mark Brown <broonie@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G . Piccoli" <gpiccoli@igalia.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-spi@vger.kernel.org, Bharat Bhushan <bbhushan2@marvell.com>, 
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, 
 Tanmay Jagdale <tanmay@marvell.com>
In-Reply-To: <20261016102917.171095-6-paul.cercueil@bootlin.com>
References: <20261016102917.171095-1-paul.cercueil@bootlin.com>
 <20261016102917.171095-6-paul.cercueil@bootlin.com>
Date: Thu, 05 Nov 2026 17:21:36 +0000
Message-Id: <179389929639.3073895.14736746474148064109.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=542; i=broonie@kernel.org;
 h=from:subject:message-id; bh=lrq+vyqDhx2mj8qUXuuQDj+Q3aMe1F9V7cwQ55je/aY=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLLe7FY0DLdPfx1xemJUkqBHd1lo3pVZAhkLNX5Gynl7K
 7BfPLCjo5SFQYyLQVZMkSUui/tlfcnrNXwHF7bBzGFlAhnCwMUpABOZ9JLhf/H5ko1bS7Y+OXyA
 rbKleFVS9YWYcubO40e/i0Tk+kaKzGNk+MuSI/VcLevugQkcN07tfxaqF7T0fqDCH4PACTO3T1A
 5yAwA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> Make the interrupt line optional. If not provided, the driver will
> instead resort to polling registers.
> 
> This can be useful in itself, but will be used later to support write on
> kernel panic.
> 
> Note the cdns_xspi_is_{sdma,stig}_ready() seem to have moved for no
> reason; they were actually moved out of a conditional compilation block
> (#ifdef CONFIG_64BIT), as they are needed in conf-independent paths now.

This doesn't apply against current code, please check and resend.

-- 
Mark Brown <broonie@kernel.org>
