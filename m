Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D243F20FE;
	Wed, 22 Apr 2026 19:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776887891; cv=none; b=BPBwVEMBXfZZn/kuO6AH8uAy4JdfhngwYVnG1gFVn2TNBmxVKKNB56QscjoIj1Bfw8nwf5MCq4176RWwf5F9FkrLYBBzXsI+DjE2QTDa6SmDPfGtHoizlQSmo5g7yJIYx5c1wDVMwuakUqaIJsVfrQlJTvbyXxN+Q2du+cCTX28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776887891; c=relaxed/simple;
	bh=hYDMsvfMRVOzp14/oHaO8FiD62bdRzlPYwoHUWB8x9Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y5JAVwASEwZXiMoYdbU7zXvLBeCwK3QaqUm8UOMS1HII6Hi4AbTh9BQxTQOn6MCvtAJe4bObax1oQtyWkMmSvO/pFVdvz9h7mlzsKvlX5sxsJ6gTIIfvtXlE56GiKUI7owGJ7glnUnpNrTMscM/27V/rLiPVgyKPjAWEq0V1YC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rfAjheHQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rfAjheHQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C47B4C2BCB4;
	Wed, 22 Apr 2026 19:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776887890;
	bh=hYDMsvfMRVOzp14/oHaO8FiD62bdRzlPYwoHUWB8x9Q=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=rfAjheHQsbD1P1dpfIaxusieqaz4N0MP4DOW053sWiA2Q0HPCMh545AXKxtL6jrKc
	 VNI9PSjYzuniojmk3PdSBYGmpLp8fQSupVRiQ0RlNQFk+cTGIEnVUArwQFYVIToQ8k
	 3uyvZoTAX4hRaRQfr4YY99bHDqZoAygqNY8M1YWo53EbIudIWqj9x4pfqX17fQOPf0
	 vMjsVSvmFsQF6cgLhI2kzptdG4sKo+hzHI2JsaBFWrEHM3Ih0MPG35JfFo4biLkaqg
	 99JTvodD9X8wJRzXakS3ohp3vzUKHY7unN0jDuasZGyXxwBEuAPF/A/U8CZNhuUT74
	 QdqnvbkAJ1qqQ==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260421130211.1537628-1-johan@kernel.org>
References: <20260421130211.1537628-1-johan@kernel.org>
Subject: Re: [PATCH 0/3] spi: orion: runtime PM fixes
Message-Id: <177686241527.36226.11132811354534812868.b4-ty@b4>
Date: Wed, 22 Apr 2026 13:53:35 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1454; i=broonie@kernel.org;
 h=from:subject:message-id; bh=hYDMsvfMRVOzp14/oHaO8FiD62bdRzlPYwoHUWB8x9Q=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp6ShQT27J644t9heWxrbnGfouPURj7Gtg86wff
 Xc8grsiP0CJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaekoUAAKCRAk1otyXVSH
 0GseB/91Qd28K/zUxIe5qufEK26EnjJRH5bsymKeP7NhkYL+Y5KfqZ7bboQA77M77rYoAeWhNYx
 5RYtdT5zQxIwzZLK76Ddfiv844Bp1GoCkk3s0Rv7wxplHl9OtOCrfwoiybiZo6npuf7KMVU1sR8
 lffLm//Q8NM95ykf0lwejCO0ul5cnxMufjDGeOHqaNVwMl1YeZNPjnnw5hg2PPaUeTWwVAmYCTI
 fdpCWkTdq0GN22dpoOCCAWNxRwbnnucWRskI3jrWvywg+jNMTCLwXbxVxtGQGlJKqWHxcTBHmy3
 f307eL3c/Rh9rW6c25G0IXsjk2W4RwGWbEqawBrfWyeH6c1X
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 21 Apr 2026 15:02:08 +0200, Johan Hovold wrote:
> spi: orion: runtime PM fixes
> 
> This series fixes some runtime PM related issues in the orion driver.
> 
> Included is also a related clean up.
> 
> Johan
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/3] spi: orion: fix runtime pm leak on unbind
      https://git.kernel.org/broonie/spi/c/97b17dd8266d
[2/3] spi: orion: fix clock imbalance on registration failure
      https://git.kernel.org/broonie/spi/c/443cde0dc59c
[3/3] spi: orion: clean up probe return value
      https://git.kernel.org/broonie/spi/c/fa5061daffe8

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

