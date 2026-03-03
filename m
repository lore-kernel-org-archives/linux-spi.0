Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047C7396572;
	Tue,  3 Mar 2026 19:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772565593; cv=none; b=nbAW80L9baN5OCEEjRSeyQxJVEgWrejGI27Id0NCD7lHEMsK+ZfJ+PPCh6M0VtQx8+HGAEL2LFVJSCeLDSrQWwaOUZmm6ov29GFd1V6aU54McjSC94SsQ9luRhvo9G1xbgTWs4i/smHhwOQooo4BGnqYFnhfUHCPtb3vrOgYwzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772565593; c=relaxed/simple;
	bh=k0xMJMjHgddl5JPdpo4UCcyWrL6834EIgLwIJ5goCUc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=O3oUbKFq02M2YMeCNcMks9IP2k7FnMMtf34Feqa9TxIOxIFp39R2om9MaENs+/tn9MZTlNkF6Z/841j/n0oMMsTBgWIYS8AWYVSNQ0zsrMn8kwCvRL9LCOi2rGTxdjoUilj0u4A15GpCMethQI6JLa3nGJrfZ59FQfjGHPtDLIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrT8/m4W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrT8/m4W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0D4C116C6;
	Tue,  3 Mar 2026 19:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772565592;
	bh=k0xMJMjHgddl5JPdpo4UCcyWrL6834EIgLwIJ5goCUc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BrT8/m4WGbeQdQj6/Ca6gMAe5+VGadJqQuDgdGyiMx4Lsf0Vnm7L7fu0cxY+bnqmQ
	 VjgB42x0sj34cPZ2NhzFF6UdkiNO1r+3PWWglXqRUKihMCR46l/6Ro495eyUtuo00T
	 +icak+2Ar9vMiHPSNhfzA0oBPWl4umh++VZ+HGtnstQCqF4clV8BVuVSvfM7kTl8J/
	 lT+Hh2a1f9nE4rqIj+pdUaUlbxTgBvvnCxoniaS9WjuLqlW5LbBvxeIf3nGbo0HqQH
	 MXTUqJraJd4h8U5F3Qs6iXTvXbxGRnsjZ+uoSsuxUN3F54mEzM5kVatiqW2Pfb8e8M
	 Kpv1URpUTnVLA==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260303-deceiver-rack-82f2b89eac40@spud>
References: <20260303-deceiver-rack-82f2b89eac40@spud>
Subject: Re: [PATCH 1/2] spi: dt-bindings: mpfs-spi: permit resets
Message-Id: <177256559083.591579.3406513766690686799.b4-ty@kernel.org>
Date: Tue, 03 Mar 2026 19:19:50 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-6ac23

On Tue, 03 Mar 2026 16:41:50 +0000, Conor Dooley wrote:
> CoreSPI, CoreQSPI and the hardened versions of them on mpfs and
> pic64gx have a reset pin. For the first two, usually this is wired to
> a common fabric reset not managed by software and for the latter two
> the platform firmware takes them out of reset on first-party boards
> (or those using modified versions of the vendor firmware), but not all
> boards may take this approach. Permit providing a reset in devicetree
> for Linux, or other devicetree-consuming software, to use.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/2] spi: dt-bindings: mpfs-spi: permit resets
      commit: f5d09914d473059e4e851c6a3bfa9f0e848c63e4
[2/2] spi: dt-bindings: mpfs-spi: remove clock-names
      commit: 96f06d055ca03d1dfb5830fd07ff6eadbd66264c

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

