Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7436430595B;
	Mon, 27 Apr 2026 10:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777285267; cv=none; b=Em21EXOVHh4ItIv3FN5FylXVhu0+Tu6UXNNTWlg1zBgE3m+cCeapdgrvyGUiwe2yXG7u1wGTX3T9NG9YbtJmlI1KCsnYFCOCIbLDiv44ESTeAgBedv/+JBAcKJXcpm86EvmXGKS91spOyQgZ7cSSNUJ3rGOdYFaS/DFCcvqi1JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777285267; c=relaxed/simple;
	bh=3s2vlZAVM0si8Ah+j0xity5GAtdZkBhi48UcoFbHf8g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FOrEequYLWSOzF1zvJUNL7/KE8VbptK17DqZPxO0vf84DlzBT+zyt/UPuRi6b1RGM7JlevirSwSyrWoXGEPdE8v/PVWqVARoMWMYsPu1b+jBT3p3hbryNbuXJ0DbAQ++igTh45uzF2tdGNbWExcmX2aKsXhlWC034KMAEjCFf50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XfgyD58w; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XfgyD58w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745C0C2BCB4;
	Mon, 27 Apr 2026 10:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777285267;
	bh=3s2vlZAVM0si8Ah+j0xity5GAtdZkBhi48UcoFbHf8g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XfgyD58wPvRll4v2PX56IXgzCqZbbs6pmTdfbwRrLjKPcjx/14QS+ty2z4BDRnlPV
	 bz8ALFevh20DVx2dumY6+uhedpQqkZ0oHJZBOvXLQuYngB6tFRFX47eaYJuJtLmTAz
	 oZ6IkESgRhzpCW+yAXAiHCYZxrdhRqQuhpclsdVEGrHzUfhwEJurZALLCPSFNU/TO+
	 7tliRkgdVLLlygRAf0IfBNjXv1Sbz5tugCCOjfx0rRiwsyWmI5aP9SV5jdPRlIzajB
	 cpqHZIym9I6+A3tZa0B5JTJ1QqHLns+RdO1zqdz3uAE0CJkDAZ0qr16D3hUlK+h57Z
	 FXopP5S07JSHA==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260421123615.1533617-1-johan@kernel.org>
References: <20260421123615.1533617-1-johan@kernel.org>
Subject: Re: [PATCH 0/4] spi: cadence: runtime PM fixes
Message-Id: <177724595610.266775.15896153661977362197.b4-ty@b4>
Date: Mon, 27 Apr 2026 08:25:56 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1572; i=broonie@kernel.org;
 h=from:subject:message-id; bh=3s2vlZAVM0si8Ah+j0xity5GAtdZkBhi48UcoFbHf8g=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp7ziRdH7Zned4ygaXHPZaf/JPyNkMFLVpDvTZG
 NXRHaHMb26JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCae84kQAKCRAk1otyXVSH
 0AjuB/9L1g6ij1JuTj/h+rLti/nrR8NkBUMqjIsV0qANuWUEDM2OFSlf2HoJ5xjo2cHjwx0gGZQ
 6F6uk4plu/Jx+u/UWI2eENAY0NomZBuQXb8WljVB/9o5wKNa3rfNP/kTL4+IHhvADNXfk7Ugds4
 Jf7YDI6mme8LWJh/hjBT2VvZx0tqpmrFHf82dy3yOWnZLFW7TDcBpOZEH98E2UmgdVA7LysE4Mk
 I+Im38PqjLfspwDV47syez9GC270j9Fr0Wmu/ra3VeUt2NHqKQSwe/xN8zl5PAdbr+UyBJhEZ75
 A1VBSzZBZvXSqq7+yx3OoZgRF9K9mFe9vP5MqK1dyFA0s4lm
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 21 Apr 2026 14:36:11 +0200, Johan Hovold wrote:
> spi: cadence: runtime PM fixes
> 
> This series fixes some runtime PM related issues in the cadence driver.
> 
> Included is also a couple of related cleanups.
> 
> Johan
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/4] spi: cadence: fix unclocked access on unbind
      https://git.kernel.org/broonie/spi/c/5b1689a41f02
[2/4] spi: cadence: fix clock imbalance on probe failure
      https://git.kernel.org/broonie/spi/c/ecea4f0e9db2
[3/4] spi: cadence: rename probe error labels
      https://git.kernel.org/broonie/spi/c/63f34e35f87f
[4/4] spi: cadence: clean up probe return value
      https://git.kernel.org/broonie/spi/c/bf7b648acd48

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

