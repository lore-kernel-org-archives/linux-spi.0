Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1BC7082D;
	Sun, 12 Apr 2026 18:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776019055; cv=none; b=VaBLvMNoKHl1bwpWcRq/bhU3+1g9s8aKhGfsj1+HBBc4CI/Qo8Pz/iVUP/kMONTOSBFoTIwlEOfHyLgA4d3Xz5OrLHtYtRfeOl5WFf7Fp5AhHKD2uolTT/JVC5++FJDS/76wiYnru6PF02O0grgYzBEEPD83M+3dodrhkxBTxoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776019055; c=relaxed/simple;
	bh=yFGfQcZXXdhpLJeFLmZXr5Lvb2xDL2k6+mxutLvAqeY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZrKmEf1sogDX1MXnuUgMojFMWe/C4xmI3W2G+bg2FYNEigB9sGlaB9zq9A90ZvnIg86k9pH4m5iLufjMBbmC8LyjsF73wbEjroCMeGmrJ9hJ7W1VcQr+6ouQBh6cu94EPKd8xO8Rf0jmYBKlQVNV392+vO3Qqu77wmAWN/N/wIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zu5pO56O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zu5pO56O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308A0C19425;
	Sun, 12 Apr 2026 18:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776019054;
	bh=yFGfQcZXXdhpLJeFLmZXr5Lvb2xDL2k6+mxutLvAqeY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Zu5pO56OmjAICt4wpF7bTq7EIzUIZT+Wjq5O+gE8m+Y00rnbjkNR4B9encmbCJKu4
	 7xmjIrKHbeKxV4Oy6zygKaSIMLc06o1mzY6v4pNp85wmPEa/m1arQ8bZdtMXn6iGmZ
	 Olq3Ny9qHaubTSfnCaHgzX2woemjSn+wPAkkQ0GnsuU8jx7I8pfcNZTLXrsP9wLIu4
	 xKa4pzmGZHhC3csCTe6O9xd09sRZB2SZ5T8M0MiLV+IYrZQuRE6LdYxEKiA2i6R8yL
	 HtlqoI/mjvJO9zY+L5mfc/Nj+jCwX+2iOQnUu04aEMfXW17yGLJsJ4dBwhWe8F7pa8
	 kQCHwHLMubbfg==
From: Mark Brown <broonie@kernel.org>
To: Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260411-ispi-v1-1-af384e81c4c8@gmail.com>
References: <20260411-ispi-v1-1-af384e81c4c8@gmail.com>
Subject: Re: [PATCH] spi: sn-f-ospi: fix incorrect return code for invalid
 num-cs
Message-Id: <177590870028.1378436.3304383271213205976.b4-ty@b4>
Date: Sat, 11 Apr 2026 12:58:20 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130; i=broonie@kernel.org;
 h=from:subject:message-id; bh=yFGfQcZXXdhpLJeFLmZXr5Lvb2xDL2k6+mxutLvAqeY=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhszbz3KluyRuuzOWl4V86TESmvZy9YtvruWZUpFT23mWa
 Wh3lz7qZDRmYWDkYpAVU2RZ+yxjVXq4xNb5j+a/ghnEygQyhYGLUwAmMtOG/Z9atU+MIufjuOXe
 rz0aNjK6eHWmhXK5XbrCzuL/aU37gfbXrxOXd57V8Z2Tki9sXqd1oj/3SPIrJ4lpf93M/3Zli96
 TFhc4y/PntkX5y8szqrzz7OQkX67S+bumSE66eFIl68ezuq9V7t4OOZQjF3Ms/sxEnZ9PLnYYWr
 zQLlgstk/6XaSYQr2K8uvXR5q6erd8rd4SMT/n6MqaxmV66hpzltTe1JblF47a1XQtJbD6Pr/4n
 RKND503f+yMZ5WdtOFAesdt+8bVXTEB+/wfX92b9Lrx19TF8sdnlcRzK8dO1UxxyXSTV/732tzH
 T5JrQd1yLT3rIi8fYZ/GeT8C1rrsCfXctne26kOhy5wKAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 11 Apr 2026 19:49:38 +0800, Felix Gu wrote:
> spi: sn-f-ospi: fix incorrect return code for invalid num-cs

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: sn-f-ospi: fix incorrect return code for invalid num-cs
      https://git.kernel.org/broonie/spi/c/c4c3fc872d2a

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

