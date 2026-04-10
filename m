Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990F23DBD70;
	Fri, 10 Apr 2026 16:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838521; cv=none; b=t0pKz6sB17ny+enaNQTKeJv65v+COj9QpB3X4WFYUANyxwThgcI1HpbPS28iv/34x2aFfD+9JQGPpv0WE0IDKsJy0GOS1ze1dC3eV+QoEXYKf3Q/DK60FUNeUBWjt7pM4q7VgzAEVATXssZqplm9zK9bd0dq7V5YqUnXxgX4OqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838521; c=relaxed/simple;
	bh=osnLMVmDFnwHE+le2JetnpP1rDIKNK8VoMDGuRUbSkQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=k26GW6RsZ9uhdb3iWKjfLqR5a2EKt9VPcsc5FnUuAjIRQHUJzFetSVVBfTlkNDDi14baxxd70SeDDY9cWRX6HElxNsx9gW+SnhP772BHbPyBg27fD8BhAia2WDzHrBzvVEWijBtgbrfCoFrolKwqJejIPqplFUg6+ymVJp2rnBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBSKGPyP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBSKGPyP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD729C19421;
	Fri, 10 Apr 2026 16:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775838521;
	bh=osnLMVmDFnwHE+le2JetnpP1rDIKNK8VoMDGuRUbSkQ=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=SBSKGPyPzmGKQV/LPkTTrX4Wzsb/pXU3HGU5yRXBVHjmEQOeIdBpFtwfCUctVP/+n
	 I6q3Iqvpw0u/RR2FW0TjkmFWABT/+NJoZitoLyGeHDovSxoio1o28JGKuJUuHNCf7A
	 JJmGz/nfc4/F+CRJzJ0Weu2tAqUx6Fi5s3X68IwxG1ohEWMqr82C5JG81vAsocKum5
	 f3Iz3mlVW3MfBZfkIKqbu8en+ncQKZS8AldyP/rkAYMZw6dccC0THYz9MFrH7Cf+wH
	 7AzS4xz39CuT7UMi4bQOUybx7ibVCY4QCF03+PEGOvq9fFInNdOwmpIBnGx6u7VDj6
	 mEwnGcADPUqNg==
From: Mark Brown <broonie@kernel.org>
To: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <20263f885f1a9c9d559f95275298cd6de4b11ed5.1775546401.git.xiaopei01@kylinos.cn>
References: <20263f885f1a9c9d559f95275298cd6de4b11ed5.1775546401.git.xiaopei01@kylinos.cn>
Subject: Re: [PATCH V2] spi: mtk-snfi: unregister ECC engine on probe
 failure and remove() callback
Message-Id: <177582518300.1175120.4251320554598514411.b4-ty@b4>
Date: Fri, 10 Apr 2026 13:46:23 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1160; i=broonie@kernel.org;
 h=from:subject:message-id; bh=osnLMVmDFnwHE+le2JetnpP1rDIKNK8VoMDGuRUbSkQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp2SU2RitBbmkr8ekYufID3Vy04zsNcEbuqOtOz
 +A98eHez3eJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCadklNgAKCRAk1otyXVSH
 0A34B/4vClavqfgu41Z3rhEFRB53rXHsRwu4oH0nExrZ3ppSyOO7D81I5wYge7HBJ7ew14LxO3D
 D7zQ2c6ujCwAo/Z7ALYVtrQJAlXrebXMEGwCBPWphtEoOv/3Rapazu3KqoXDupzQRXU+e41ZpKq
 Ru1LAi3tRel7/VvAwqeWdLwJ67yTmjO/lkRmbYs2VuWhTX9tIrmQHEXgEvky23G/pKPwrcW/46y
 K/Sh2hapWlAN3OZ6wDBdMLmQypCA8buxp6mEOULQIVYY5LUQPQuzjPSUUZaxsP3UW6Hiw/m+R2d
 RXp0785TpsfiKldsT36xgClIFNtcy2lDHtK7lBYGloMztQyA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 07 Apr 2026 15:26:59 +0800, Pei Xiao wrote:
> spi: mtk-snfi: unregister ECC engine on probe failure and remove() callback

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: mtk-snfi: unregister ECC engine on probe failure and remove() callback
      https://git.kernel.org/broonie/spi/c/ab00febad191

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

