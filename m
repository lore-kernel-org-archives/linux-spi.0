Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F9E37C0FE;
	Wed, 29 Apr 2026 04:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777436434; cv=none; b=HcRMgmtH1Xv0nFN4opSj+kl1VEF0o6J3RVb5s1UZsxcooTCPTQMvGFE7q6cHaPrjJJLPzKz6MLaknn9EZVCZQIrbttIDBgmc6AIy17wDfD6/uyCoMjCrbqhJtaMXDuUK/Iiv7SY8idcWZM7HOrx+cEXsu5+BEVgAffIodqY7Qvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777436434; c=relaxed/simple;
	bh=x3w6FaLWJ59do+8E7V5wI/XYBwr9jdmDBJqLxGxgp/g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fdOdUxzBFYHP6Pgr0EY1YBL21heogYemKdHGgiNec4U58tPdfe7B4BOd4S7EbqbTYx4N2lbhVGGXm6BarhBm4YXROjP1KSGjp8puEmIPob8arqc8cq4ryqtJUnx9fNFLuw0GkQIW7pcPMGGDJJoausZM13v1ohRKl80lVz2RI28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWkM5xmk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWkM5xmk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C08FC2BCB4;
	Wed, 29 Apr 2026 04:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777436433;
	bh=x3w6FaLWJ59do+8E7V5wI/XYBwr9jdmDBJqLxGxgp/g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=WWkM5xmk4snhYtVCxVxuqp/1ufDyP2swk0YAh0lkvnvrq9HNQqIvN337FQfcrGENz
	 EGiALEORkkDuXGP5/QLGEdf+6mpR4Ki3UNR/tDm2irPcF/WUeULMvkSWPXW8IJMm4g
	 wvJtyDdNcOQ9bqauWjC0VJJB/Rn/0j3tSSkGWzEDrF5+zPevKyW9G2IeVHFTLuFcnt
	 3t6XgedTyn6nEZIh2ip/uz+cuDE/+fCazVcdJ1+AVkRw1fXOSeG3BhsCOjNeHdNYZn
	 uYxNjbS7MgacplQNBNi9JrEEgUgGRd1HRKpI36MrDs3YNcMcNagujFFzesoJ+hyUEY
	 oQBW3oWVCf1Kg==
From: Mark Brown <broonie@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, 
 Daire McNamara <daire.mcnamara@microchip.com>, 
 Cyril Jean <cyril.jean@microchip.com>, 
 Valentina.FernandezAlanis@microchip.com, linux-riscv@lists.infradead.org, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260428-surfboard-unhearing-96776be0495d@spud>
References: <20260428-surfboard-unhearing-96776be0495d@spud>
Subject: Re: [PATCH v2 0/2] microchip core-qspi cleanup
Message-Id: <177742876220.363516.73601840697698170.b4-ty@b4>
Date: Wed, 29 Apr 2026 11:12:42 +0900
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1406; i=broonie@kernel.org;
 h=from:subject:message-id; bh=x3w6FaLWJ59do+8E7V5wI/XYBwr9jdmDBJqLxGxgp/g=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp8YcOsbmCPHp3xpu/qKTKRWLDPe8yJuYwpHEe5
 WnkCb/RKPeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCafGHDgAKCRAk1otyXVSH
 0GBRB/9ubkwyYmEIi80fmz723UTgCwHlKID9G4+AW6S1WI4ua0OYgk0PJf2itdjF4yJW5LE1kt8
 yZCS0LZa05MyXwANWlsAC2w13GvM5BFDSJiQyKT3/1F5PIv9XlB8+L/GxDYXzXgPWACkvY1goTi
 6aXXT9qQDr+5p4kWOBiMEr38sHqjb2jTnouXKYZr/4sAO5H9BALfH5oxE4qg2QmC3LxhnziA4+O
 WXgeeDd9K4VQQ+xo3BgEL2nGM/gVZvASRGUoLsGBo/QK27hrE2mqG6hJowWj6NVzKds9MCeJtyN
 IW3fywLQYvtnBeY4YMnW9yIJ15vy5cUKWoLBQO9vmr7QJgZU
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 28 Apr 2026 19:11:10 +0100, Conor Dooley wrote:
> microchip core-qspi cleanup
> 
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Hey Mark,
> 
> Here's the other two changes, that didn't conflict with the fixes.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.2

Thanks!

[1/2] spi: microchip-core-qspi: report device on which timeout occured instead of which controller
      https://git.kernel.org/broonie/spi/c/4cf8806a637e
[2/2] spi: microchip-core-qspi: remove an unused define
      https://git.kernel.org/broonie/spi/c/9c69bc6057a2

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

