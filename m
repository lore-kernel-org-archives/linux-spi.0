Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126873DC4A2;
	Fri, 10 Apr 2026 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775838527; cv=none; b=XHB3E0t77E67ce+fwAMB5JrbhHAk3855A1+gaRhaTUDZ918wmqVr44A4pprWAxywJfNWk8u74jQEtu2zufZiGLWrBgah42kfB8oMZoofpo1WfKqpMnlASNgwm7xB5yOOiNRa9hjas7O6Bw3A80+J/4hO1nahNonkHftyjqt+JBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775838527; c=relaxed/simple;
	bh=rc3W/HiyxgR5C5XDOExOTvxFcAENf+46f3esVwJomaU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QSzgq1sNn3/VzeKynLXfVRfiJQy1p2CwJ1b57Ur+sasiJcbskR869g4L3uZ5WyEVOKNCzVd2PR0Q6dlzOo5lN1T4q7S2fY96+HAQFSmnzWBBGImJOvueMbdC2CECF7dOQ+WPteYAj+d8GkF0GblJaLJPuvdGuY73ie59NCPOlKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qodl49ST; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qodl49ST"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00D0C19421;
	Fri, 10 Apr 2026 16:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775838526;
	bh=rc3W/HiyxgR5C5XDOExOTvxFcAENf+46f3esVwJomaU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Qodl49STcgYCfAADNEOh/lpW+DZTghN3gNRv4ej9hk0TwxqgYtm1Wd9/xg+3HqJ/d
	 qASjLnvdH2uoD/a6NTQIEYBBPyTwTSoXIuwkxQ6tlPpwbJVbOC3QBv0Re7Bk5+AZW/
	 a7wK5LSMvf8pd9A5WHr27kVRhivK1kOT8N5vJWJGXgls9CIYJvP1N1HTq0HVzxXeRc
	 9zyVkGXwIe77k4W1i1wa885XjeXai/GSXFqnq4gReiSVNuAFPNYC84luTi+qK2EbWe
	 ZhClvwPZi+USYPCWWbW2h/MpHVlbaOnz2P55sxV4Tv0l+SMvMnQl9VEARw1yxXXPlX
	 Qaa9vTNKoo+jw==
From: Mark Brown <broonie@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Laxman Dewangan <ldewangan@nvidia.com>, Breno Leitao <leitao@debian.org>
Cc: linux-tegra@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, song@kernel.org, kernel-team@meta.com
In-Reply-To: <20260408-tegra_warn-v1-1-669a3bc74d77@debian.org>
References: <20260408-tegra_warn-v1-1-669a3bc74d77@debian.org>
Subject: Re: [PATCH] spi: tegra210-quad: Fix false positive WARN on
 interrupt timeout with transfer complete
Message-Id: <177582363192.1175120.78978701937069451.b4-ty@b4>
Date: Fri, 10 Apr 2026 13:20:31 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1188; i=broonie@kernel.org;
 h=from:subject:message-id; bh=rc3W/HiyxgR5C5XDOExOTvxFcAENf+46f3esVwJomaU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp2SU72LxXv7UmMiO3BYh0GPpG8sAZS5ZLj6sbF
 4zfkJOBHIOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCadklOwAKCRAk1otyXVSH
 0LZECACCg4M1z1HL4an5V362t7NrSwfR5p0RVtaYi/yo+ZGbR7FxNeG80vnv9dQACcJyqSLyJKU
 b26hUmoz98vupyV2yI83cXvqkAcYlZtaZSSlqhijrYFnXLWS3/3/KgK46wVIMggUjks9m3fzOly
 iB0CXS1XirwwLUNQSwiFGWi+EhFa5nQoEanbCxzvLu2dmN9SGNlaABaPFMoi1d7Wk9EQxU3kZKC
 Ci2p6ihe49H/146401LkYym4EjinTaZ4fAa9p9ycyNKilQ7TQK/cWwUMM1MQbLWsa8qUKspwiTR
 kx/DlJpSxiYrOIS575ytXV/NiUqAZsYEW1ET6nYBbnpnUODH
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 08 Apr 2026 06:45:43 -0700, Breno Leitao wrote:
> spi: tegra210-quad: Fix false positive WARN on interrupt timeout with transfer complete

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: tegra210-quad: Fix false positive WARN on interrupt timeout with transfer complete
      https://git.kernel.org/broonie/spi/c/5b94c94caafc

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

