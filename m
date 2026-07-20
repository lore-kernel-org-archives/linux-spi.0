Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5E6373C10;
	Tue, 21 Jul 2026 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642086; cv=none; b=qkuOoAJNxF+2tT5/paFexZTtHB9P08B+LfwGkzfOW5Tn86kUy8o0hKHVvmCpT8nN3ocm5Yb/5w7O0/uv/0RZ7BsY5acWOU0X6DqdsPy5cmPHSvC0boN/lhy6h62s3ODjFP3oJQFj79R2xcnFS5QBEsk4nZJHjkOsla1xuY6XfoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642086; c=relaxed/simple;
	bh=ucM/8aLNkU6vHK0y9Z9NzD0923i+XMCxDNWORwdAAbk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gOp/x9Se1WiCFQf4KmYAhuMAt2oCYyv2CxVbsOy3H0e6CqwQh7T2DEa44x7+UQLeTdPf7j1Vz16CysTJerMcIT0piM3fGmc+iHslgo7JRh4Mvm2oewLaMB0LTTBGfb8JaKmIZ+tNZ12lK7aSKM5y6FmhHG1KEIfQSSE0Ftn3aGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afGA6/qD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afGA6/qD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C48751F00A3D;
	Tue, 21 Jul 2026 13:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784642085;
	bh=FI+AsYiNeSzQrDIATIKSDIkf2UISz2OwCoqHg53Ubc8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=afGA6/qDpM44mtCv62IP1Vj7TWWUrN5CKqzoybaRZN3n80ErExxOsIiREtEYJ9/fo
	 oPlG/DfNWLyqnJxpTyFJGeXM9zyQ3zy7TV5HWSqBzcjOpmHUtZhgD8rgeAuFNpUKjU
	 h1WVnwmKrYc1NlINQkDi62MjxM5E5frANUHHpz73ubtRhAv/Zzt+8kjtuxqto7Ugu3
	 WbZTVsgyme/4jdOGZRBBaSxYtzFfLoLCjo5mbVdl6WzHnnJWFk7OzHv6tUuK6GEPT0
	 +FOMdd4liTldoSRH621CPjs5ma4Xj+sol8sFiat35iwwSugNlrlO8b8rx1sSXJpZi6
	 aDvVLYlLzxUJA==
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Prabhakar <prabhakar.csengg+renesas@gmail.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>, 
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260715222417.2997712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260715222417.2997712-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: (subset) [PATCH 0/7] memory: renesas-rpc-if: Optimize transfer
 overhead and implement runtime PM autosuspend
Message-Id: <178455380089.8049.17726957653779366428.b4-ty@b4>
Date: Mon, 20 Jul 2026 14:23:20 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1588; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ucM/8aLNkU6vHK0y9Z9NzD0923i+XMCxDNWORwdAAbk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqX3oiVbKSM1PkDXaMEIgPgtzm3QDk+BFWvJP45
 NTu8Z8L2PyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCal96IgAKCRAk1otyXVSH
 0LOtCACGexykDD32VPZqtS7/ow4yhZX7lUG0df3DuL8OUcgqhJSqlPabRSKzk3r1dWKXyb56Y4U
 79cBuk61tu5CIrkyPgUUhW05P3olqBucpOieTniWFDhpO4fxmQb3La/c1CcAyNj3ZJTBkmscXfX
 +qkqGuzhjNQ9Is4QRv7DrS2aqN1tkyHaKoIQzCuW3fWwwWgLFiamZFbCC2gg0dErrBqHsSO/LUX
 Q3IdmJhC90Q+tqL8CFUI6qAAeqHtrrY2/m5CRtD7eAbTY7UhVAUhqhfYdqgRqUGKqzLsbyVi6ZL
 c43yyyhcMGwLKmhBDrDRbJdStaiCYzfdvjztSyLt2wB2oo4M
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 15 Jul 2026 23:24:10 +0100, Prabhakar wrote:
> memory: renesas-rpc-if: Optimize transfer overhead and implement runtime PM autosuspend
> 
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> Hi all,
> 
> This patch series optimizes the Renesas RPC-IF driver by significantly
> reducing software overhead in both the direct memory-mapped (dirmap) and
> manual transfer paths, maximizing transaction throughput, and introducing
> runtime PM autosuspend to prevent aggressive power gating during
> consecutive flash operations.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[6/7] spi: spi-rpc-if: Implement 200ms runtime PM autosuspend delay
      https://git.kernel.org/broonie/spi/c/af4b98e33d56

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

