Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D405908DA;
	Tue,  8 Sep 2026 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788888519; cv=none; b=FJlR7TMqJlazY+m54S0HRU/T1EUHZc6cJszQFQlt8F6j4QkD7/zaaKsTS8wAKvpV43R1sSqoIA8tFeui3cZED7HBi12jIycWRXK46VSGfJWGw1vDsMAo+Y2PSEMKDtW2ektqn8MQG2RmStWGt1xXBf3MCNVn8fn6izzxDFM4+7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788888519; c=relaxed/simple;
	bh=cN+0Yh/iVR9Fq/yw46i3itGh4OTIcS9+F+vcebxnKBM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kxxYg+qp0S2JySZq16VaylbYiDu/I7coTvKtDcni//e7mE6vs+20ZHr6a5y/r89kzcCodO/6LwXgccPPrVNGUoyicRxhhasr38z0bvQnMa/K7y6zp1NoXUYesmBqIRKWjhPCy7B6choBMjUfvtrG8WbEJDXIiq/OdRE+3MfaUSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcwZE00Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcwZE00Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F721F00A3A;
	Tue,  8 Sep 2026 17:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788888518;
	bh=qytXKT2Bs7Fj1a5oD427rFJpl/QRHKEtRWn23VJps5A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=WcwZE00YZbCat3B23bNr4yvETUSPHmGcFwHwli5puCoV/nKZSlLPPnCCu2sV1hXDz
	 KEYJKjRv0QpbCh143LAQGn3mCRa+acyQIOUPVqykojXA3b2sWZw19MBoTsC9igc1mm
	 K6qztxRoLbqRV8cbVJagrGH2qMz558V5IfiYHI7kTX48Cy5dH8wW+NKNFmDsMJdhUD
	 Db3JxFJWCae7yglsazmkOU4Uu0WdPlgPPKv5xS+OKQiUxG4B+BPqtFpwvlCIOdeRLx
	 Ku59HsAhvtYi61F9LAmnimiKt1u40XqEeZtv3PsgmyOnLfnHNpmX8ZDfD1DQNiFEzg
	 ecwCmQ8fZRrCQ==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Anup Patel <anup@brainfault.org>, Andi Shyti <andi.shyti@kernel.org>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Jia Wang <wangjia@ultrarisc.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-i2c@vger.kernel.org, dmaengine@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20260907-ultrarisc-dts-v2-0-5eb4c97477c5@ultrarisc.com>
References: <20260907-ultrarisc-dts-v2-0-5eb4c97477c5@ultrarisc.com>
Subject: Re: (subset) [PATCH v2 00/10] riscv: Add device tree support for
 UltraRISC DP1000
Message-Id: <178888166750.78527.9666350258521008763.b4-ty@b4>
Date: Tue, 08 Sep 2026 16:34:27 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1576; i=broonie@kernel.org;
 h=from:subject:message-id; bh=cN+0Yh/iVR9Fq/yw46i3itGh4OTIcS9+F+vcebxnKBM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqoEW/xx71ld8bGzQNGA75RuPnRLPcvcpsICXtZ
 m2ConXuoN+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaqBFvwAKCRAk1otyXVSH
 0A0NB/9SicyMaMYqHrQpLTGrZEEoTKW/jaXP5bTkxZNIo5G02ydXYGJkNEhvzFH0FiXF9Un86d/
 BL4XtHkrdRciyXPc0cgH0WYW9PYnp7ZInE2zlMjv6XNZvfI7J4Rmq0jFXIvrWv2FIWaqFHeBDap
 RmhpQgOJUlP+zmnvK8kWL6MrCUcg+Td1KdQHD6nCZDY29cHnp/QS08+Xvmf6693lxU+DfhV9O5h
 NHZcRxWuN+UPgCcNJ9LWyBmunRUkzzvADKvmCPoS6JjUt+WiCKV0GXKjLhPOqkCkvVeYeHMHN0q
 +6+RAT82inmKbaaIieZZNo5ZhX1nH4+jZYCRpU3YN4/MrBbP
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 07 Sep 2026 17:54:39 +0800, Jia Wang wrote:
> riscv: Add device tree support for UltraRISC DP1000
> 
> Add Devicetree support for the UltraRISC DP1000 RISC-V SoC and two
> DP1000-based motherboards: Shenzhen Rongda M0 and Milk-V Titan.
> 
> DP1000 integrates eight UltraRISC CP100 CPU cores.  The SoC description
> includes the CPU and cache topology, CLINT, PLIC, clock controller,
> pinctrl, GPIO, four UARTs, two SPI controllers, four I2C controllers,
> three PCIe root complexes, GMAC, and the DMA controller.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[05/10] spi: dt-bindings: snps,dw-apb-ssi: Add compatible for UltraRISC DP1000 SoC
        https://git.kernel.org/broonie/spi/c/f77de4c33f0e

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

