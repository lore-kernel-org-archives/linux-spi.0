Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A9A3F1066;
	Sun,  4 Oct 2026 22:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791152353; cv=none; b=UNuimlRehvLNv+utrzvNBHORsbm+rhKv1SXaRww/hHDH3oEU2jdsA7TursUFhKlH2nBDgV+IG7Pc9kKy2uOt/pDiZW+NXblh/XKhtyjQ2zpYRPkWhKdyVXQDRWcsbCedIYgV8EYvQfxTMkSTfJxrdhrviWhnompz5mS6R2rFD0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791152353; c=relaxed/simple;
	bh=XlGIPoAXEO9fjPtx0LhsyKfaPRUKS5rXxUL/Holj0o0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TXqynPkuzuozUHAvP5x03n1LXNXsUm9NE3igQMZ8dP0G1JFo8OfnaOgepJbZtLNGDQArBGaLLwjPvLD/R/NmovgcNfAVzU2+BS1RSrKFDEYiiTcLFIZHyMiirJk2N5PlhSbnxXgVfCC6UWoHJWFDOsGWpjvIN9p7fv/7rV0h1oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FbVgIJzj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FbVgIJzj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C9FA1F000FF;
	Sun,  4 Oct 2026 22:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791152351;
	bh=v7utYs8GKLOLmpJcKqQrbGujNEcC6K0fiJPD8OpUtoQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=FbVgIJzjvKUT5FvFXK/KnAfArSedJ+Ppno4+en9aqqRr5/tIRd8jii+B/v2fktvJE
	 3XRP6ChtkRHAxlriTZp3fEqIYRTS68abbalItR/EXgeVbYec+Obi5qOqPZP27IbDYw
	 decG20oWPI3nVSjxuGgB7KKuTyVta4QYwTLJP7O7dEWvxHHb56X9+iwf/uTOUZSokh
	 9QOJdTBlecKASCGf6on4LwOjokkKHUlYnQcHLooKx/iFH+Sw8zSJa8QKmaYJLos6pR
	 Rsz/5v5Z0iGt9pueorQl8+EpHAK8ALtJEuTY5f9HImbTTrloqNGZXuMRRXbOCY++Yd
	 5GBIgRKpyZRPw==
From: Mark Brown <broonie@kernel.org>
To: linux-spi@vger.kernel.org, Saad Anjum <saadanjum239@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20261002155527.24845-1-saadanjum239@gmail.com>
References: <20261002155527.24845-1-saadanjum239@gmail.com>
Subject: Re: [PATCH v2] spi: bitbang: Drop duplicated word in file header
 comment
Message-Id: <179113124302.150114.2592344991601426908.b4-ty@b4>
Date: Sun, 04 Oct 2026 18:27:23 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1126; i=broonie@kernel.org;
 h=from:subject:message-id; bh=XlGIPoAXEO9fjPtx0LhsyKfaPRUKS5rXxUL/Holj0o0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqwtDcpr8Y56HA//UA3yTcHETz1eRnJ1SSw229E
 cfxr+8o5+yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCasLQ3AAKCRAk1otyXVSH
 0Df3B/9FDT8f4PcQA3YiM96KcCAkSZ44VFkWj/wC++gaCir61oU4hGG+SekwWxRaWzdR8j9f58B
 YlJp9IuC6mh7Fp8yj3ichflBrkm3aA/H3WzFoiIFoxQKYed7pTG0M65JUnzO81t8uY9ZfB7XWAX
 vtu1JpG9qEW7Xvmlkp39W5iUokL3PcvTFMkGxG5+7+TmF4qZiew/SDgQYAPv5odr6loLtPnKJni
 ZysCtHnrari1UUxQxUstkKe8wvnfQnhibHjDTWHHoh5J37/sf18t34jBzSj8V1+huPKzLLRA3G8
 O2eMefmfvcxDZh56eHJ5w0ORldbJtRIcfbX7ONVMyZ7p78l7
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 02 Oct 2026 20:55:27 +0500, Saad Anjum wrote:
> spi: bitbang: Drop duplicated word in file header comment

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: bitbang: Drop duplicated word in file header comment
      https://git.kernel.org/broonie/spi/c/65766f75dce3

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

