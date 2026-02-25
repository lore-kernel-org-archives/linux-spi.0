Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C173ECBDA;
	Wed, 25 Feb 2026 19:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772046458; cv=none; b=NqYAjl7G0dP76LDkzrDZ2rb6N+8tFiAj7bqUIq8krQRq03/WreRMpvoT6AhGA4ZSqWOwOM36twluGIUARdqlFDjRJniBv5hdcpWNp0RwBp9mnHZZaJ0T+Cd/0X4ogdo9BqcUvowExHQ3IjGppy+/PrfRO87F9X+CcmElOqLnu0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772046458; c=relaxed/simple;
	bh=aFuLYKEXDlVrxmqtiLhd3oSqmL8g1jZb9tt7+dTqYiw=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=V66hX5KuYHLPLHIm9df30bn01InLHzfX5ZyHgjXOd6nzwYbi5MBQhTqxX2xLD49XyTGj1Q88bgP2RkBplDascaLBsJrV3KJ/aZ/9A4AF4x3ny8iM8wXzIgNS+Jsd5hIIDWOJy8jlXiXG96hByOk0AH+aTyaw/wyud9gL5F9vr2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpMaU+Oo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpMaU+Oo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C736C2BC86;
	Wed, 25 Feb 2026 19:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772046458;
	bh=aFuLYKEXDlVrxmqtiLhd3oSqmL8g1jZb9tt7+dTqYiw=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=WpMaU+OoZFSMQpW3pwmXTF0cs/Gz1TV139ytIdNF6waEY62i4H6wRUchLNELO/K2k
	 z8oW9vByNyvozRTVMWITsu9FAOycUuZVLW/P0OZYIpM4kgxDqy095foS+dGCBgIexp
	 iw5+CStzmXENaSokmP2X5YdSVDobpc+6/C0/MsvvG8mX6MHg4Dj9WkcOSFqYCWGQCt
	 SjaOFDJAQok6BG2XF+jerExO6rY5hJEL3+e5dZaRyRT+PGr+Ie+/3zwiTKSfZxqda2
	 BKlLiV3Mmr+oU7DuxtZGTGNQmTIyHh6uiGtll6RfeiVWBSm/DLpmKXCQB2HqQzZVU1
	 X5SklZ++J9Xlg==
From: Mark Brown <broonie@kernel.org>
To: Alain Volmat <alain.volmat@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-spi@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260216085816.69888-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260216085816.69888-2-krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH] spi: stm32: Use NULL instead of 0 for pointer
Message-Id: <177204645680.169139.6555103942757659163.b4-ty@kernel.org>
Date: Wed, 25 Feb 2026 19:07:36 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-47773

On Mon, 16 Feb 2026 09:58:17 +0100, Krzysztof Kozlowski wrote:
> Pointers should use NULL instead of explicit '0', as pointed out by
> sparse:
> 
>   spi-stm32.c:1659:65: warning: Using plain integer as NULL pointer
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

Thanks!

[1/1] spi: stm32: Use NULL instead of 0 for pointer
      commit: 5e897a498a6b45145350e9de5e4753e9eee7d4f6

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

