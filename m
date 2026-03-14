Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C744315F;
	Sat, 14 Mar 2026 01:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773453075; cv=none; b=SiqyKmDXOboVPvwDc80hXfoKH1gStzI1D8AAG+VKraWI4iIaYT5C63CUPSNcPmrNmitFKNUW4ju/TI9LosdyqZsObQ/zZSZUMpQf9Mp2h1I9h46r8bik+Ge6voNi6xUjJXEtCXe5yLLmbhrhMdWS4qSeushnFz543uYGftwknfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773453075; c=relaxed/simple;
	bh=cpVrVzt8vQlp4zt6OgvL8swXdh5uXFGDsSmGTijUevQ=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Eu0hCfr6lvBLIygmvaohQNKzXTPFGO0SW4mHsVqWSoDFUfWf0/Z2z58Z7UdBfCbKPGN9iYhJ9D2b79e6ozQ1qVA2f3oQoyES7ep5Jq/ohLruorTnt07wLglOeoLWMw9xnrF/RqI/V1ul8kJ9QDJ5ZDPOooedWUDvrC1/6vwIiJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iq/yVHNw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iq/yVHNw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8D7C19421;
	Sat, 14 Mar 2026 01:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773453074;
	bh=cpVrVzt8vQlp4zt6OgvL8swXdh5uXFGDsSmGTijUevQ=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=Iq/yVHNwD1Mmoqiug1CJEadZQHJ9Svs2liFTXk4wPeK94rC6ky+e5m9SGXh/LaSIS
	 gEk++QsSkksTQvsYu1Klsm1g0aAbdmMdwQlYZR5zxM6pi3Ny0m6f/eUDrDlY9J9NDp
	 iMX2X/32uCUeegbqBxwQ13RXVHs0Tpgf+bc3j40Wqq4t6UEmQf2LBV1ngh3LWifOUq
	 CSEXfudPSwDvZjL/yEzHJS+QQwdlMSbE/OIQMLiAF3DOYLDe00d3e95PD8vpOTgvFF
	 JwvXRN5gm9cUv/Deepc9AigUGJVuxL+4iq2D52xO5Ed0vWMYzwHSkvhOdXBvvMyQik
	 nkMfD3+5kO2Xg==
From: Mark Brown <broonie@kernel.org>
To: cl634@andestech.com, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <15a71241affc25108a97d40d9d3dd1bc3d2d69ed.1773282905.git.xiaopei01@kylinos.cn>
References: <15a71241affc25108a97d40d9d3dd1bc3d2d69ed.1773282905.git.xiaopei01@kylinos.cn>
Subject: Re: [PATCH v3] spi: atcspi200: fix mutex initialization order
Message-Id: <177345303954.139979.11258013600538771788.b4-ty@kernel.org>
Date: Sat, 14 Mar 2026 01:50:39 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-046bd
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103; i=broonie@kernel.org;
 h=from:subject:message-id; bh=cpVrVzt8vQlp4zt6OgvL8swXdh5uXFGDsSmGTijUevQ=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBptL8QMHOd/8W2c4v4jR8cM9Rl1NVJEz76A7X8b
 eDWmuVcRWCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCabS/EAAKCRAk1otyXVSH
 0FaEB/449zCbdbooTM8wxK88+jZQIp+26FKP53rpybDjB8c+RcVmhMMVmwDQ7ORmfoPg0+wM1Eg
 75uqRFuDB087JIMhoeAKkAATaXenm+/0NhYWwAhLi5eaCFbFMdQVZxw7hyARPiPjsSQy4ZpmuiN
 7dcuW9dzSbY73X97PAVKyZdMNrkhmW11pUXcvJ8hhQKfkfRb8ALKUQvU+OTj2PID336KWv0KD7v
 9KuhELl6A5uWUD6XUOSIJJBvUq0rQsIV2Ay/erFQEel7G474gC+ithcB+U6kCtWo8u5rpJAhRzN
 oLsxsla0LlFR9hS2n9Jimh2uqnvQmq0Ia/izDKwvmXd8S5QV
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 12 Mar 2026 10:47:55 +0800, Pei Xiao wrote:
> spi: atcspi200: fix mutex initialization order

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: atcspi200: fix mutex initialization order
      https://git.kernel.org/broonie/misc/c/869d5b4b2a80

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

