Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46398218AC4;
	Fri, 27 Feb 2026 01:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772155426; cv=none; b=RxcpRurQNXxF4zwAebGgfWya+uFI0emXWFZ4UyV6L80BiYcWqrG/Ot39rBuXonDGhsC4WnH5Fcd5QpDcYBlh5nJoDIHT5YGEg191c3UC5NdFr3KhvCW32EoatfP2cih8DGsDKFnSJZMBkbmjpBWMmpnhkiDlXzXkApcBUA/IW+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772155426; c=relaxed/simple;
	bh=iNpKTxg26EiS2siUu/UFXfqcUPELCw3aJIOd825qeUQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=pCqXH1+HyyFepZXzWCxmXe/+4sNaj8gDIVF/aMYQ4fLafDmH8ZREhtd6xQnEWlq8cuQbhTnYre6idk7Swlo65DuuznWqE7IrTmOcgS6ft/CrH6C3e6TJHZDVuxYQFA++ZQPzS3Ue+c3nqEqgarp1u4Yy6/L1YcdVAuOAW0v8FS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dc1S994q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dc1S994q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435E8C116C6;
	Fri, 27 Feb 2026 01:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772155425;
	bh=iNpKTxg26EiS2siUu/UFXfqcUPELCw3aJIOd825qeUQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dc1S994qp+jOc8gXIv6G2LFN3/qfv/eWmKgFRDsdR1w3APFpqOdiZxFftHDSg8gzC
	 CDmP0WwK0nXCevcWBvwtJAkn8IoCZDzVPW3W4Y2qcRhh5dXnt8ub0RR8ugV2fvD1J8
	 PuHE2zjPiv8ew6ZX5t5t9UqVP6Yi1N6GOrhb9pLGrRoBC9dEpuQ/w98zIhg7MZxNrf
	 jU4/CLaXUCQF+mAYfCl+2J1bXjvF+llAydGF62wNDBbUZMaI7KdT/qm72XWUTVXPcg
	 8zU9dxidx00SgAlgXp0naH8yxdmIRvYY5+cwBPxzIOtxISbcfLpK17KrjhwJuXTLmb
	 1zp2k7phOHuzw==
From: Mark Brown <broonie@kernel.org>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Clement LE GOFFIC <clement.legoffic@foss.st.com>, 
 Antonio Quartulli <antonio@mandelbit.com>, 
 Alain Volmat <alain.volmat@foss.st.com>
Cc: linux-spi@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260224-spi-stm32-chaining-fix-v1-1-5da7a4851b66@foss.st.com>
References: <20260224-spi-stm32-chaining-fix-v1-1-5da7a4851b66@foss.st.com>
Subject: Re: [PATCH] spi: stm32: fix missing pointer assignment in case of
 dma chaining
Message-Id: <177215542400.421349.12022854371341188766.b4-ty@kernel.org>
Date: Fri, 27 Feb 2026 01:23:44 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Tue, 24 Feb 2026 16:09:22 +0100, Alain Volmat wrote:
> Commit c4f2c05ab029 ("spi: stm32: fix pointer-to-pointer variables usage")
> introduced a regression since dma descriptors generated as part of the
> stm32_spi_prepare_rx_dma_mdma_chaining function are not well propagated
> to the caller function, leading to mdma-dma chaining being no more
> functional.
> 
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: fix missing pointer assignment in case of dma chaining
      commit: e96493229a6399e902062213c6381162464cdd50

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

