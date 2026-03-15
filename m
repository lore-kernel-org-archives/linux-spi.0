Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672D02DEA8C;
	Mon, 16 Mar 2026 01:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625083; cv=none; b=Lg7XLfLLR9W6B4IGbezkkcajglpc6T1Cwlewg7hHIWk3Ozyq0YVpkUT+5khiyoPKSXcU4IhOKeciGnwC2uZZHe0w/CPrsQw3LwkqAFDm82MAebetbwjnT8X8Qv/8usxpSowHgOOwdCz3AcO5cpv44i0QqS9pe+ud1dSrDrZJYrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625083; c=relaxed/simple;
	bh=ZtzQFmnCAD6t2ycuWdAVnZ+vHyzhsgiuLsjiGiqGaPE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uBq6sC3IbhG6blCVW7QnPbbCfuaYmFD5SetxkKQKnk7eBwTTPeL22Bi/FazI1Cn5u/UhFKVtT9s57hdPaYsNKxf7TQc82bACBRGQEsN23t+mTCGCm37L90rrCYZQEpQRMplu9WnsW+yVBvvBieQ/a4LlOQ8x5sW94e7UMA7wrSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZZWERnP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZZWERnP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D990C2BCB6;
	Mon, 16 Mar 2026 01:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773625083;
	bh=ZtzQFmnCAD6t2ycuWdAVnZ+vHyzhsgiuLsjiGiqGaPE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AZZWERnPCexOjD3/N6/LKCPNZ+r/wZCMKFiip7tIBYKzCPg5/90oTiTEoPfS1Epjj
	 zbjSBgrE/D6O9iJCHNrZjdqSbFTTG2xMXXVbpb22Ny9jSA6/ifUzIdG8EVZ9xTrJhN
	 8qyaShZNnfocDF0Bat+iuE3fozRIFtZ9sCZwAqYKtXHMNFsvu09lG0u6+L4kBaH0m5
	 cEnJRlmffzupXReYUo8dlwZUuxQPjtNbx6hrYl8LC4jRIF9KpD+Pgmaf2zuT9IxtCL
	 PbddZt02bi/Glt9Obs5L6Ek/BEoojrRz34kvOtEJQ3JA5dqjjc4aIR6WswHpI76tE2
	 1i7u8uZRGvFTg==
From: Mark Brown <broonie@kernel.org>
To: Sunny Luo <sunny.luo@amlogic.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Felix Gu <ustc.gu@gmail.com>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260308-spisg-v1-1-2cace5cafc24@gmail.com>
References: <20260308-spisg-v1-1-2cace5cafc24@gmail.com>
Subject: Re: [PATCH] spi: amlogic-spisg: Fix memory leak in
 aml_spisg_probe()
Message-Id: <177361914653.162791.17263190036268237449.b4-ty@kernel.org>
Date: Sun, 15 Mar 2026 23:59:06 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-5154a
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ZtzQFmnCAD6t2ycuWdAVnZ+vHyzhsgiuLsjiGiqGaPE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpt174v79gvROVz2tFRcLX3taQ8ONQQkzfXz74y
 IWMhyBceCeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCabde+AAKCRAk1otyXVSH
 0PoyB/0bPz2aVcxdIpmRoDC6AR6uEe836PhOqcJEbi9qY7B/INxG8LY5j5bKH+XLa0jwoRKtzN8
 xYmG8PRC+lQGDUri950SghPEYj+BJ0Zx6MmysJPYKMc9h32fy+w5uT5IpDVclDik79uTrVwDruN
 zFKDXTWCMy3PHPwLgdYOQVA67kmO6ifVFZGpemO3jWqQLmeIy26RYYkOgFSVlhnRee9BVg4fL3Y
 nK9qWpOibESY62qrNhqvPxhdztyuoXErMNv1ZwyAwyMraJl8xm13piHdfCmS3Uw+U64gu/v2g58
 cia+QLXowSJSuNe3dngtrxWI4MpyXqNVhqkLQSHgYE7K/gMp
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 08 Mar 2026 14:49:21 +0800, Felix Gu wrote:
> spi: amlogic-spisg: Fix memory leak in aml_spisg_probe()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.0

Thanks!

[1/1] spi: amlogic-spisg: Fix memory leak in aml_spisg_probe()
      https://git.kernel.org/broonie/spi/c/b8db95529979

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

