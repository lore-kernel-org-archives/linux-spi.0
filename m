Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B654CA768;
	Mon, 28 Sep 2026 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602948; cv=none; b=J15mBjypS0M0m/O/6V0LVWYRrU14q5MpAmacD+l0jSK86Ml5+GMqouQItUx7QZ62FhsZX7lCm9W73lxUOQV478m9BDAQAqjNsEi81RrnNHYjXSu96fCnHf2MVilcnNFxWTajU4MKaET6Bf19L5XM1UNV06z0w3PdwjJqCgcr3mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602948; c=relaxed/simple;
	bh=aeGCqMUDP3oNAAQc9bTywwvL6D83v18n4o79xTDcXzs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Gz9CntQcoIpusoc6+l+z4/fdfjzRnmT7F19F02OfXZgAUUJn08f93bpyRK4s/BSkhkCgoNy024qqVrlZ89iPefptNPROMrzOovmlEuidzFxYNZY8K0b76LWtlGwYMo5L+Er04jWLlQEz6REJ+2lpnmJy7JWakhy+J9Q4hZVqe+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=clZ/kzEw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clZ/kzEw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C821F000FF;
	Mon, 28 Sep 2026 13:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790602947;
	bh=JdEW84ERB+bc3D3EIHSALQure5xXKlxtujZk9wWEbfo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=clZ/kzEwbE/b8TLTTq1RIKUACRkpNgUzHdesSwD1jR7ERrvw9Hs0EhmXWMDqPjW44
	 sF6LTS4klrqthuoPDhY6VQd+tonKRpXDpAARa7meXQwBq8zUAINscUgLXaID+aujAX
	 JSPJV7JscCfcq3Q9bdvqrQDnLD2R53NmmZexTbUXVxLWTQJFKCbIhhezxmVmDNu07t
	 vfXCRcbjAuTc9sqYgWFONiGi548zZypDmpFwECiwCQagX++m97+8VvZy/KAoUNcybd
	 ia4788TBNY1nagxsCFwMGuysrbqzvfR4CrBLwwUOiVN7I2YLOwQ9Tqq6SA08l7OxeN
	 OzP20ZaR8c6AQ==
From: Mark Brown <broonie@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Md Sadre Alam <md.alam@oss.qualcomm.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260927-qpic-snand-drop-ecceng_to_qspi-v1-1-993e9ec1c2d4@gmail.com>
References: <20260927-qpic-snand-drop-ecceng_to_qspi-v1-1-993e9ec1c2d4@gmail.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: drop ecceng_to_qspi() macro
Message-Id: <179059873581.139547.13768185687130659285.b4-ty@b4>
Date: Mon, 28 Sep 2026 13:32:15 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109; i=broonie@kernel.org;
 h=from:subject:message-id; bh=aeGCqMUDP3oNAAQc9bTywwvL6D83v18n4o79xTDcXzs=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqum6+erYzbYKe7AQ3v5A6jaiPJqYRXbn5HLr+Y
 Sp1qJ/m66OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarpuvgAKCRAk1otyXVSH
 0LnsB/4gL5GTZlU+lgkraiysmj1vzCX+8Jn4f5GPc2VxtrLfpIX6Vy694sz0Q24E+df0gqCCHEk
 OWEaaugUhzotcfkadWjJzKzS23TfOl/lVjUQplY00hE+tlo603hbyRVCMF92hXe++WX4Bucs+ck
 uSNwM3rUGTDC+LLFZCl1twpO52sPzYi2LNEW6Rp39W+dUAvtyah66ER5MDf4ytpFnnAbqKhqBsl
 hbh+lLnUTHTfQ2ewpeNESrLk6QLeaIXiLukptSkrxxrifo0xkaTI9Ef14MtL3JcujEq4TlUjg93
 yoFZ0wMD9T9zCr0JYu83mWzLuT0RGLucWkyXXVVcDwUMhJg6
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 27 Sep 2026 16:11:22 +0200, Gabor Juhos wrote:
> spi: spi-qpic-snand: drop ecceng_to_qspi() macro

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: spi-qpic-snand: drop ecceng_to_qspi() macro
      https://git.kernel.org/broonie/spi/c/7f7400bd60c3

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

