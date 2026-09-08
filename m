Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A0F355F49;
	Tue,  8 Sep 2026 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788884150; cv=none; b=tmqkMUr0FD7p0m3KonDvTZzsmCFBGluSJWwtqRLYMlNLL0eA2ElJneqAicJAkAEU9cIj7reGMbeexl2PI+s0VoEKBk3NYjZLcoEiVzvYkmg7zfbVRSejhPQzYb1IhUbyXxl61npheUKEQ9xIgNVw0stDUcJBMc9c1Znzpsg1SFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788884150; c=relaxed/simple;
	bh=rvVZYPYH7iKY+4YiJxF0YMxyOw1dv8LOBm6HtLVgRag=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EeTz9fKM5ZqHZQ0yKorjaU4jqOT07Uyv6jvCNvvMJ5D86/LpKkJoZptXULm3SmEjkPKm5O058vcGd2mBt/xx00aPqHRGhiUv7bbC8Wj0H2OeVLnSW0PKC3Gz7nlq8lNc7T18ybSQc7jA865IhGD/jwclsLpL4DOG9uwok+eTH/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EnFDK4bj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EnFDK4bj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D981F00A3A;
	Tue,  8 Sep 2026 16:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788884148;
	bh=2wuLOPQn3VUfQTPIEZYgXlZfyHe85AMIIidcauXH/uU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=EnFDK4bjGoQnF0tZW3+X4z90QC5uo5VTG+h78KHMq+6fNoEKf89q+3NzCJLCDsQtA
	 0dYKKnyXMxBfMkB4EgL7RH/NsfTeyXAZlCc7BVZ4nlZyCRv67YfZEjxpb5cpTeFusO
	 E4UDn5/ud+NJo1C6db9v1NZMAsM3k5LPVM9OC8vPZfIApiUS7/EY2nSh93Sz3qYvDN
	 ZyQ7iwGjivw6YaOR6Eq+GtX6+Efk39OQhcZz5f0U0kHbZ9e2rG/ZWRomz5k15gGcjQ
	 PhN2IvfMJ0ofz74PjeXEDsgaudgYdc0BqWZTOn3mQLCiUIfeUEWQsq7jcu3eB/rVrv
	 BQuHqjZNmxQYg==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Rosen Penev <rosenp@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
In-Reply-To: <20260907005750.230103-1-rosenp@gmail.com>
References: <20260907005750.230103-1-rosenp@gmail.com>
Subject: Re: [PATCH] spi: orion: yield to scheduler in transfer wait loop
Message-Id: <178886895967.78527.1214841053052376485.b4-ty@b4>
Date: Tue, 08 Sep 2026 13:02:39 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1117; i=broonie@kernel.org;
 h=from:subject:message-id; bh=rvVZYPYH7iKY+4YiJxF0YMxyOw1dv8LOBm6HtLVgRag=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqoDSwFqh9zajyJ/g6tH8vjbeAQRruYNvIew7bA
 HjXralD2V+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaqA0sAAKCRAk1otyXVSH
 0HkMB/4ikbDVn/KOhy4iYBRU3jEsGFkZeEJ2TPTRDO03iYbyrkAlWCRxrqePtSOqLS+Ea1lHOUg
 22aseQsDd6Iifqq4R0EdQDWJyXeSu7i2/x8PnUbK1/SLTUn5T4KcyQtCXOEGbHT22idN4sy1Msf
 EW7PdOpvoJTUQ3zplOSr25kCuFhwxdQJhnTIFP09AjMfnQ6hLIKfNo1ksZWcnNTfp7Vnf4X3xHb
 gu6GOjVZCNAyjH3kF518HgWlIrbaQHx4I0qc3Qy/5JObMhmgOO6vpQEwSMZ37wSebFa4JH8EF2i
 05PR0ZUje0HDBuBDUlyT90gUVKlf6V9cLzr65QMJjG/BulVo
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 06 Sep 2026 17:57:50 -0700, Rosen Penev wrote:
> spi: orion: yield to scheduler in transfer wait loop

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: orion: yield to scheduler in transfer wait loop
      https://git.kernel.org/broonie/spi/c/23ea08ca607c

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

