Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795117196;
	b=TQvh9gSpi+sVpeYLbrVEa4M0UNGMmKc1mzaVAEoq/Cb/aVVVU72DtiLcSfemq++PXAYE
	 PZt7FeWifzS5RBUcwEKl5KoKWX5yhCq7HuMVTCfQWhz0/mhSJwiQx2CI1EOAXMsyvnHPV
	 OQnvGaumiriLBPKbAgGyolvJik7TWcpuhXn0wfhb8LupaosbDYAgrU2KspkQDKrk+uUPP
	 Os02NtfWkLrH3QitydnhRWqvoTap4FYFey6AzEWdVlVLJ9V6MTOALKe9r8mAKASaGWvwd
	 OwuY4Vbi9OJQrPvVUzyX/tMe5xfv4DxGbDZyz7HbpaWG1RML53waHucFyAZWHK3oU4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795117196;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=C53DTbNteph+VnyBSFKp3eIaRme10l9PdlmgiMKvdiM=;
	b=tARgnaG6w3KDkP9S2phbO77IOO3dr1mGWYcMa58UHFnID4fzQS57R03XwOCc7DNjgmNs
	 o2kPS2cPTdwQri6/jGAmNyPRKSP+XfbEPGJw0Yw0ubCVDe/Uh0IM7hxPEqLSfX5x009kd
	 pToRNKZbweHK68NuL4aMbyMkF7B5bXbt/eu0lJ7SE0+RB1mnj8SnZEZoghhbN5LeOiZD3
	 rP86IcIqV19LgEeZvQpw9rEXrgvLGRflokNIThOzhHWRn/e7S1IGWNhiZmiTSfK11sf3l
	 dNZ/B8MoE/K/0R3H2skalGiJvQrepqDnPDb9I32GCYX1+8wnASXxbDkGsDcD7eNDhRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dwCQYyhF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66DE606A32A;
	Thu, 19 Nov 2026 19:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dwCQYyhF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836B21F000C5;
	Thu, 19 Nov 2026 19:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795117196;
	bh=C53DTbNteph+VnyBSFKp3eIaRme10l9PdlmgiMKvdiM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=dwCQYyhFD3dNjS+e/Yi3P10kLcUmf3+983euuzKM8JTbpr67ygaqPxSj5KwuYdcyx
	 2T39aXOHkfF8vekNd5cjukoQX4T2jJOJMhwFtSECl9lTlgah28F8eddKPdoXM9OCpX
	 OhF53v0FDYPoSNrdQY8lMWInK/8mb322LLFKESdt4USW5DB/qkGd2iupZhsDXrIbZE
	 WmlUy0apFV83gkdTGzdZH/IOlZq6tRVSHU5PmnKgTUhp7+QrpE77OEVUkygVpN9vWZ
	 yq+FpE+XH9IYrFJD8qJCqRYiAmswPlG7K+QMcX4aldo3E07Ig/UBPee27/mA/kZFH8
	 w7+LJ1qdzua/A==
From: Mark Brown <broonie@kernel.org>
To: Frank.Li@nxp.com, mkl@pengutronix.de, carlos.song@oss.nxp.com
Cc: linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 Carlos Song <carlos.song@nxp.com>
In-Reply-To: <20261119101539.2536367-1-carlos.song@oss.nxp.com>
References: <20261119101539.2536367-1-carlos.song@oss.nxp.com>
Subject: Re: [PATCH] spi: fsl-lpspi: expand FCR TWATER and RXWATER bit
 fields to 4 bits
Message-Id: <179510959107.116416.5712967503709630135.b4-ty@b4>
Date: Thu, 19 Nov 2026 17:33:11 +0000
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
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1157; i=broonie@kernel.org;
 h=from:subject:message-id; bh=hWHU7cweVnJ29v+NymxgLBWWMuD1zJ8DEwcXYxlwxgc=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLL+B3SGnb9bV7xn7/FnSud4/01+yvf2021JmePvGpirb
 929/uzQrI5SFgYxLgZZMUWWuCzul/Ulr9fwHVzYBjOHlQlkCAMXpwBM5OB6RoZ33jZXjzr4O6Tc
 SJIqFXP88yvzfM2XGAX2u0ovssQninoxMvwRbMy+kGXMuyg/PanlxZUV0dFBj/bzJVq/SE6fmtN
 szQUA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 19 Nov 2026 18:15:39 +0800, carlos.song@oss.nxp.com wrote:
> spi: fsl-lpspi: expand FCR TWATER and RXWATER bit fields to 4 bits

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: fsl-lpspi: expand FCR TWATER and RXWATER bit fields to 4 bits
      https://git.kernel.org/broonie/spi/c/6008a6e34ca0

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

