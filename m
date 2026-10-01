Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0203B1029;
	Thu,  1 Oct 2026 16:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790873348; cv=none; b=hUfk7aRaqcVR9YR3cfNXJZgbP6zWxQRAkbt13Xct1ra6RO8C6phV5SDc5DubzABcrKPXIVAKlJlK70Eckz+kltMThqRp/qMnP2Xc/6Dd+unmZUBQ40yYRijPmVHjwJoEzQPT3/hh2N6fsd0nITzdQpQ2BS4oxudhW/MBgH6+40U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790873348; c=relaxed/simple;
	bh=yi/iOdB3XkeKJG4NywuSBty4SjiQPj4PbgkDK2mpvFM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iL3RFNbVbGUp+NuKn79tkMkCzkY8+MfAB0oe9KFoF8NfaeJvmpK+SnAU5JQH0by45oCTdnDhNQ6XcRKnTiEup8F2HXfgoGQAVcm/zVey+Sqqv0v6lIJVCmJS/7KpKNf5DGXuz8zokWzsHno0KH0KfDT2XC7HPub+TN/hNMsz3X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eOB/kesq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eOB/kesq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767851F00898;
	Thu,  1 Oct 2026 16:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790873346;
	bh=GLOsEiOcPOwu3tKOoAo8L8EDZt9SBH1wAKk2F8CTFEo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=eOB/kesqHLJRSdE609agTLKKGnMa7Ih0at/KhR2ZNy2nW5EJX/Wk0TwbYy7ukJRC5
	 0wQCqcfOdpMux40JHu73U5qpjVCXcwDmvV38e5w0NVlvuphhwM4GM+2JejXQ+6wiSu
	 O87GeBFD5cTighRCytgl4ZfxsUQZKUkhi4dgLb8xCzKfDH0KRg8vqjiNg31O9ZQEa0
	 XCGDwgAXpRbLm3TWBUL0NM9D9/IZJy0y9VUfXk1tFMyWUsJcYZQyq/QU+ba33OX2R0
	 pMAcJi5Aby3zUAARnI4Q80vzmjJyirB6OzbNn0n1BLtyV0AfgPQYWOnjKxbKXrfDeR
	 Z7NeRTdn+nd0Q==
From: Mark Brown <broonie@kernel.org>
To: Longbin Li <looong.bin@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <chen.wang@linux.dev>, 
 Inochi Amaoto <inochiama@gmail.com>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Han Gao <gaohan@iscas.ac.cn>
Cc: Han Gao <rabenda.cn@gmail.com>, Hangfan Li <lihangfan@iscas.ac.cn>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
 linux-riscv@lists.infradead.org
In-Reply-To: <20261001-fix-sg204xspi-v2-0-014dbaf22b5e@iscas.ac.cn>
References: <20261001-fix-sg204xspi-v2-0-014dbaf22b5e@iscas.ac.cn>
Subject: Re: (subset) [PATCH v2 0/4] spi: sophgo: Fix SPI NOR errors and
 clock limits
Message-Id: <179087050674.90966.6118735285003982694.b4-ty@b4>
Date: Thu, 01 Oct 2026 17:01:46 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1558; i=broonie@kernel.org;
 h=from:subject:message-id; bh=yi/iOdB3XkeKJG4NywuSBty4SjiQPj4PbgkDK2mpvFM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqvo788QZjKL23ksoySCouh5gJZmYiqbz6jZtdu
 ozueBDU8qSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCar6O/AAKCRAk1otyXVSH
 0GxxB/9Wup5wcUaF+oupk4Z0bZHrFp+CXB+s6cyynLtA1FATbYaKy9AW9Umn2LTq5tnhzsV9uLh
 PXKst0WcQJswkkRqg0ZCiFtok4Pori0LnaCQvR4ZJ2jUsptfrDskBdbhYQOYkayZw1B99gniw4z
 V5R63ephcglhYWnChADM6EQkMOnCFwU9bre3K+TNplH/0xlh20/4NsN5Tcx/FB40C8eXQiJB3rH
 OozsbkSBDPaMZKhSgFLHRFlVOEuA5iE7VcdRUSeFyWnIVNB7I0etj5+BxElBLXiDPST5z7x5KQG
 9kG2Cgh3FbYn1NcUMk5VzEJBeAOJGt4e0wznLitAauuwqr3S
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 01 Oct 2026 02:22:49 +0800, Han Gao wrote:
> spi: sophgo: Fix SPI NOR errors and clock limits
> 
> The SG204x SPI NOR driver ignores transfer errors and clock limits.
> Fix both, enable SPI NOR on SRD3-10, and use 12.5 MHz on SRD3-10 and
> SG2042 to match EDK2 and the vendor kernel, respectively.
> 
> Tested on SRD3-12 at 12.5 MHz: both flashes identify correctly, SFDP
> reads succeed, and two full 64 MiB reads per flash match.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/4] spi: sg2044-nor: Return transfer errors
      https://git.kernel.org/broonie/spi/c/53cdc4266b93
[2/4] spi: sg2044-nor: Honor SPI clock limits
      https://git.kernel.org/broonie/spi/c/ed400c241b3c

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

