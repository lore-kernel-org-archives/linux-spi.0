Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B393CC7CC;
	Tue, 30 Jun 2026 11:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818244; cv=none; b=L0WLYhKMxRJWU01cV4thxMugSaVoIQxKOPW3fCdbvOYEHbsVoFMrXfJ0Obl/tTda37QgdmkJb4Fsh/+lnnLFgylx8BDM/3vurnUsd04UCssyvjWbiBVsOAiEXTxLYqOarJAYqdd2usjcNB9qDXgY3xGpQJZZSgIWFxS0lCZj2gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818244; c=relaxed/simple;
	bh=aKfGsNB/rYGTPsm7SpBmxT4bJNWAAK7ysLKQHTgW/Mw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tkd0UEH9m9fyBODk0UyZu7rwXBjTR4BgVXC/fqVneelVcr1seonLlzcOOo6largEcyxtYJa/EGH5MgbtmkkkG3Q0gzB/6nQacBltnGSYgv/gnEWs2EfE6AKeXFwuIjdlyS2QXlhfqHyM5vuAgifk8Gw/gaZS4AhNAJ+HTtE5mWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTbg79v7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTbg79v7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99EB71F000E9;
	Tue, 30 Jun 2026 11:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782818242;
	bh=s9N54Uo+6f5J1Zku+s0K2g8NKpNqzGz70Q4dEIQnIo0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gTbg79v7L36dOzuM+U/Q7Z6940qK1tdXGz+2H/8P1NvuUDV/jYJ6DQkITZteGIFfo
	 cAarfQxNTchQjbYA3opn7rt6PuK9a6pv4t9+J+gL0PmYzqigTEBIo4+ArloqKlTFJ0
	 vRpiSyjV7XJAu6m6qexbUNX3w2rO/8HTNMRLpuVF6H/byJGpJyTqAqJjrdV8xQWVwQ
	 9+B21NUniZaTikz4V0D0dDZuJT8hsgPl2+5IOqOzKbYmVJVZvFthgi7ZxgtdaWzNM3
	 EN2pAZwFwh+VfLunVBFbY1MEnc+fq+fnwdi/ktroQ2DB+3X0R+/BWBqMxoIqGZLFG0
	 rzttYjZIfIW2w==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Christophe Kerello <christophe.kerello@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260618-add_power_domain_for_qpsi-v1-1-4d7e57bcfb9a@foss.st.com>
References: <20260618-add_power_domain_for_qpsi-v1-1-4d7e57bcfb9a@foss.st.com>
Subject: Re: [PATCH] dt-bindings: spi: st,stm32-qspi: Add power-domains
 property
Message-Id: <178275509841.47562.5600063205070514868.b4-ty@b4>
Date: Mon, 29 Jun 2026 18:44:58 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=broonie@kernel.org;
 h=from:subject:message-id; bh=aKfGsNB/rYGTPsm7SpBmxT4bJNWAAK7ysLKQHTgW/Mw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqQ6W/8GPDC1xFkVsF6UiqKD20ycumS+LocYOKD
 65/p8iixkGJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCakOlvwAKCRAk1otyXVSH
 0E2oB/9bs442EaGu5J0NsN5932LvwU/hGEMRFI69vgX2nSqzxKDXiomxhhgttWGBwer1qQqgEqk
 GdZXoxBHk6EqAnnLNT61lA82YrskrQnJiYlbTIG0yP2CTx5zVGpjE+ksViW8BwAHOCVIsioyxRQ
 wRmIO1Zlt0uJfcvQ3qmpDq+rfiOZpWh9ykGqhfXOYvy03h99+Qy7j850TQAYzIfeYlqoSF7NfQN
 9kBoqJ4dPpKCHjPilVOMYN1Aart81IphDfx3UFRajWFZYPy29+JbERJF7NcyZCSEDQLRpXNC73V
 XqgvXKAjNTIzVQmOrrJ4QK8y68T0LUqvfJ5l9fnDzL2YJLsR
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 18 Jun 2026 08:46:35 +0200, Patrice Chotard wrote:
> dt-bindings: spi: st,stm32-qspi: Add power-domains property

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] dt-bindings: spi: st,stm32-qspi: Add power-domains property
      https://git.kernel.org/broonie/spi/c/7a0d22e632a6

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

