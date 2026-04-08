Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733423D7D76;
	Wed,  8 Apr 2026 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775671557; cv=none; b=aGeymVr3JZsrYt7I1zRCu+yl4SiVEdfaWPMvp5IuTJeU/An3RgksMHtAMfb+2zjemLL7TQJSgq3QRcfDm7FDWNmD60tszb5sitDZEiTQzXSKyONNTfYa8RGO4iG+xGS69K4YwcHYaK695BxYeh+JS/qDs2b5QKp4fBE0Nw67cPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775671557; c=relaxed/simple;
	bh=6XIKSxW3XIb9EDOz7FQf9RaoFgIy6eg+8nkLyJJ41X8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UGauL1QzxXtl7UUPttX2z13z9yeGz6qfxLo//aNjLA3tj5sfMU5OnffKTxqgnUA7VRoi3eXd4/ciWsK7fjBlpdw5ZdYReqOeBFZ6XF5rn9uJ5oATmIev6rGNBaclWGn5gHEM4UkAMyiU0aFPKaLgszXBu+b76ti46+5kkZrNtuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YA5yWRcc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YA5yWRcc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E15C19425;
	Wed,  8 Apr 2026 18:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775671557;
	bh=6XIKSxW3XIb9EDOz7FQf9RaoFgIy6eg+8nkLyJJ41X8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YA5yWRcc5oUdT/zHcdCsyLJuZ6T2JHIjbLV3MQx3IjbnpNYFbtrk359VNzgu+JHf9
	 i6Dei2SwXFEVrXy1pVD1ayjqx7cG0mbLvbfM5aqg5XhFTLEeyojMNl4+sLzbZ7kl8H
	 NJqGi4MElUDfyxi0hFhKXLqGbbenRuWOdxr93/IYtWd7B+xWqiKb2mFcxyUu53H+CW
	 H9iaHHBsWzm0FSxSycWfag1tRC7kza+KsNb/4oLrFvnQ/52HeLSm8MVEu8Vk01QmlG
	 8jURCN8RLTbTq8MQ+os626ImEUtVG91eNGKxy43v63ERUFgRlXBf403OeZgUtk3W8K
	 609EoJALS+5nw==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260408084407.107416-1-johan@kernel.org>
References: <20260408084407.107416-1-johan@kernel.org>
Subject: Re: [PATCH] spi: pl022: enable compile testing
Message-Id: <177566047186.101848.15433057915390510501.b4-ty@b4>
Date: Wed, 08 Apr 2026 16:01:11 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1082; i=broonie@kernel.org;
 h=from:subject:message-id; bh=6XIKSxW3XIb9EDOz7FQf9RaoFgIy6eg+8nkLyJJ41X8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp1pkDZjd2jYwrPjXHzsGgzqPMpSleU9ezgJRUr
 rdGU/pMVVCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCadaZAwAKCRAk1otyXVSH
 0Ci4B/oDH+5qE+GztwcvUf/eNS04J1IxYwANqw6dS+eZ6t3rkoJK1WruXpnea+dVi2yHD2nJMXo
 FGI3Uz7jrcM+AyRZTly9//LInJMCdd/oy6zBSp28nH4Irf4+hdc9d2ARa6HEzxF++yoWoin53Rg
 Zu+JWkPNQWdbpwQjGRQQpy+4pv+H0GrQOnWZDXLAQlRQfGOzYgnhgHKueLK6TlLnsIityJChi+g
 vZCfabjJHsLap3W3JXHNGB6ZpSqRwvOp9zd/0tAb6HrjPh0rtjGcDtzIqvVfsRySO+kbGn/GgBx
 QA1WnkAx/03syI36OTkguUQawhgL+Yi9eKq8Kuw2X24zuGzg
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 08 Apr 2026 10:44:07 +0200, Johan Hovold wrote:
> spi: pl022: enable compile testing

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: pl022: enable compile testing
      https://git.kernel.org/broonie/spi/c/484eb2c4cc7f

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

