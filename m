Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D23A28C854;
	Wed, 25 Feb 2026 11:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772020678; cv=none; b=nIVllYkJxBSoCnv1+3uLk5Mg6VQR0iNRlZ3zItsn5pUcAiaF/C34SFwfnxTzwHeEGIOGQmQug2n33BgpWSGuvZdPo/VWHx3ZhI67aVE8dHC6KmJMdaOc+fjgouUtGLKJig5mYjGreOSlgxi8ybu0hVLDmCxsHZi4HkKMpUZwUgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772020678; c=relaxed/simple;
	bh=SnDXFB2r7V70zXXX74nuud6OwDW85g5QuoA0tIzR1Bw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TszD8CUHHuS2jJ3Tr+1O6vMpOx8GBAj3FMCY6C4WioFIR7gb47rCjTOpFYJCUJb4d4EqJ/dGVeB9m0kbHBnErLCwqUM+I9NQA+tBzgS7rMfmYvdGZLdLGZBsIV0BmlVStjKrUve3Id9OLAjLty4mLd/JHFZtlHH7vG9qF9fENQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kS1SMVVg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kS1SMVVg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8F3C116D0;
	Wed, 25 Feb 2026 11:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772020678;
	bh=SnDXFB2r7V70zXXX74nuud6OwDW85g5QuoA0tIzR1Bw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kS1SMVVg4dpBNtAVkaoeTgL3uXcK30vOxBlBfsNFnOIf6c1kCC0vdl7LMqHf6BAAB
	 jmFugA4/Lm0wWT4irUvp1+wu+o023yNqDAIyBblHQ/NofdEaMc6+j4TAUr84QN4q0m
	 8gTTf0U/0FoPtcG2zXKvvI+pca6+Xpam71d6XhoItR/0EXhy5rdvtWr1vb+QLURpxw
	 StIv6xr0KzAgIm5QmIi17eR0P0Hvotj1ssAzsnHNZ5oT/nihtMSQz0t2miEwV8L/QM
	 nhk/v8/6286T7YKNn78n1zwUA6hswGb7hZZUkH51peY+T1+dZuv05SljCEvkLvT6UE
	 UUjrWyjdGfKlg==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260224115218.3499222-1-andriy.shevchenko@linux.intel.com>
References: <20260224115218.3499222-1-andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: dt-bindings: snps,dw-abp-ssi: Remove
 unused bindings
Message-Id: <177202067638.44572.11511981026229804023.b4-ty@kernel.org>
Date: Wed, 25 Feb 2026 11:57:56 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Tue, 24 Feb 2026 12:52:18 +0100, Andy Shevchenko wrote:
> As stated in the da0a672268b3 ("spi: dw: Remove not-going-to-be-supported
> code for Baikal SoC") the Baikal platforms are not supported and
> the respective driver code was removed. Remove the currently unused bindings.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: dt-bindings: snps,dw-abp-ssi: Remove unused bindings
      commit: 297318a1c26dabb5a2d8540fdf436c22094eb2d7

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

