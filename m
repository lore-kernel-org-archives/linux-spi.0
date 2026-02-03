Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AD9AD24;
	Tue,  3 Feb 2026 21:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770152776; cv=none; b=YwpBhwM13qP7Tjxc+IClgEI5RHXsqD6qUAKsqHv5Veo1jHybeMYz/AWVa4DaV2M5QhiheiVS9nJmNV8mkXGLrUDVlSH9XXAe+Mf18ziKqmuAFRKb2IpJAdfherlXVx8nEMBeWo0G4qGk900J6+qdXPDr5cOTn7GsqCz9mRRx854=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770152776; c=relaxed/simple;
	bh=QiR1z2+HeiDKpAyHdWBxPKPed1yY756ITXRwlIEc55I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fKWny6a59NMTHg/hX6wQBN6ifm5gg6POsX/Fem4jTs9q+OFWUegCsL3SObaSeI8SS6aquuUHcbGZChWwPm2y5BzgbF70xJyJuihDO/rjFTOs51uvR95/5IlhMP/aaoFP+1LZ0hHL9KUItM48yJltDUcWZY43m3mP6DErN8jBhbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHMghbet; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHMghbet"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271EFC116D0;
	Tue,  3 Feb 2026 21:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770152776;
	bh=QiR1z2+HeiDKpAyHdWBxPKPed1yY756ITXRwlIEc55I=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=AHMghbetgJ/C/gJNTWFvvDxmw1Sq4A0EIDLr6q+gXYVgVr+kqM9dhRRu/Pe+W7/HZ
	 w7rkkLl2PuptX70uBmwtSbpCXrNttwDxzqACf/IFK5ga24aTuc5ptpIEqhFI1fJa8Z
	 E1Jai61FsKDxQYuXF3BdK5a5GFPL+C4nLtTeHfA3ON7mDlFjknpvHEA0jXJDS7LJje
	 qWv9+OMiRThxNoRMH9AySdA/NbbgnBPBT/oJGB9OAjg7NLetX5ncapJkZZ+XABEe/G
	 F/PHjjJ9KyC7yvxrg3UVfVL26/zlOG0uUiq/UOynybcT9GcoJScXjLPC8wq9fCCRxO
	 tcYa+AjCklAhQ==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260203-gemini-ssp-bindings-v1-1-6d85c9c72371@kernel.org>
References: <20260203-gemini-ssp-bindings-v1-1-6d85c9c72371@kernel.org>
Subject: Re: [PATCH] dt-bindings: spi: Add binding for Faraday FTSSP010
Message-Id: <177015277489.369398.1449372282828529371.b4-ty@kernel.org>
Date: Tue, 03 Feb 2026 21:06:14 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Tue, 03 Feb 2026 11:04:51 +0100, Linus Walleij wrote:
> This adds a binding for the Faraday FTSSP010 SSP controller,
> a pretty straight-forward syncronous serial port and SPI
> controller.
> 
> The bindings are submitted separately because the one device
> that has this is using it in a "nonstandard way" with regards
> to the electronics, and does not make it possible to develop
> or test a proper driver. However we want to be able to add
> this resource to the device trees and it's not complex.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] dt-bindings: spi: Add binding for Faraday FTSSP010
      commit: 4c9d53794bcfd3db45103269696b019d5ef09d41

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

