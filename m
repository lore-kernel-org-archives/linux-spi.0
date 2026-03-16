Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85B8369224;
	Mon, 16 Mar 2026 21:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773698120; cv=none; b=PhvLeSjkSZFeMPlIqcsMIdZK9wnRW7wN/pZ3//prkFFregfswyGWpUaR+FhFXtn1kH0VlhajXoJpirURGX3cC+kVtkg5IIkcyX49voU6eAsvs72WswzKwuFpLGtyUEY2L9rggd078JX19HKgwwWkWEDP8HShoFI3KEyEAd+e3GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773698120; c=relaxed/simple;
	bh=fXrS2qP78PC1NuWS+SY0vBIlZ1LAiBvGveSb0AyiSVM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=A3ziViEfrpQzaTy3D6ydXp4H+LTDGHOQZ2xrN/4kIvSqXX3/bi6iB44wNhiUoDB3mKw+gpPmTodHqpBjD8czbgOZQl4RmbjBFokEA4YdNxAPRogAZQZOntKP94FiEEOYGpqOTPEJUIjJSh9wAGrUbFFsIpkls3JSW6uWCXyZlq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3Qj8vWV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3Qj8vWV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1202C19424;
	Mon, 16 Mar 2026 21:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773698120;
	bh=fXrS2qP78PC1NuWS+SY0vBIlZ1LAiBvGveSb0AyiSVM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=K3Qj8vWVi3CptCedoa34UizbTuiNPvXDjHecEM+BePCemi0xRh0YtUjDuQ0ZXi/mc
	 7zIX5mnI9wEW8SVHS6UIhDX6YJrHiFsILWXPAQPAicWfctSxxTVubZZNFUlbt1Od2f
	 kjLobNu5LW+fvqHcZ2q2ExK9xC6O3a8UA3+2sRjf1DwGLrEwpgSjrQeSrRjGuyOfF+
	 6pYxujB4XZ79KNbDrW9mPMDdr5NL/mCEkr7Y6AnKLeLq6md0ss35aQ+ZmA14RKZ+NQ
	 Ye6fAla59m2dAl2iGDda0ekUYDd2OQGGB0rdvqvfvbkfRlTfyhW8NuPZXr9+4tnJS8
	 YSixdIjbMTbkg==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260312151817.32100-1-johan@kernel.org>
References: <20260312151817.32100-1-johan@kernel.org>
Subject: Re: [PATCH 0/5] spi: controller registration fixes
Message-Id: <177368638238.156281.277659246762433559.b4-ty@kernel.org>
Date: Mon, 16 Mar 2026 18:39:42 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-f420f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1679; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fXrS2qP78PC1NuWS+SY0vBIlZ1LAiBvGveSb0AyiSVM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBpuHxG0zUbJqmK76rty+13RpNR2xvjoL1CzwhFu
 RbATflc1muJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCabh8RgAKCRAk1otyXVSH
 0KKYB/wNQ0nHpRARyL7cO/uZDxHKtzWA8zMBZ271hpkYcSUykF5YAymvE2maVifWNk1a6raxk76
 coiy7jaVh72wJ0IzEYbquTv7JE3JoMqJWFY9p3yaiAjCxzIQHfXuaIASIaN2+y/1yeTZdIB1NxZ
 MaP0v0dQJyzXkt93vnqq7CzLRciN6P7W1hg/ZM0JfNLorakA57yvcH7QCKoAGPOPOQFRmJuJWSy
 9rfS7DJji+zFSANS6Z0FGCrraueRkjjM+7p722XRB2DOpc+La4Y9u3LzyvnrMlhRhs2i1DJCQ0s
 GywsrU3Ishy2Tc+6kttCFhgdoLMgAbF4mbHHQmLrenZ6BFa6
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 12 Mar 2026 16:18:12 +0100, Johan Hovold wrote:
> spi: controller registration fixes
> 
> This series fixes a few issues related to controller registration found
> through inspection.
> 
> Johan
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/5] spi: fix use-after-free on controller registration failure
      https://git.kernel.org/broonie/spi/c/8634e05b08ea
[2/5] spi: fix statistics allocation
      https://git.kernel.org/broonie/spi/c/dee0774bbb2a
[3/5] spi: drop unused devres statistics allocation
      https://git.kernel.org/broonie/spi/c/d5b4cb41b9a2
[4/5] spi: fix misleading controller registration kernel-doc
      https://git.kernel.org/broonie/spi/c/edc463d72d69
[5/5] spi: fix misleading controller deregistration kernel-doc
      https://git.kernel.org/broonie/spi/c/3f174274d224

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

