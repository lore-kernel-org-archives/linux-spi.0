Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AE1411A01;
	Mon,  3 Aug 2026 15:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785770027; cv=none; b=sDc4GhfYOwQg6DjqQJlpiGNmJuzoh2btctMwNIEa0f1BQqSiJEV8KgZdOm9LgtaO0JD+w/Z5L5uHEat3flmM7Vf30/C7FUdWOx/r9e35xcaQn3eQMKMIMscX7ak0ktwq+imtfHeMxPuiuo1YQ9cNLKvd7W0r6vklnDPK6XWvr1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785770027; c=relaxed/simple;
	bh=EvsCjDND4KToII21KzgteKvf6oyHL9oF9Jg4f2qW6ek=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FfM2rjs2TpblJGGyaHoLNmjeeIWu7pfC+8cRGL+RO8Gq+d0lbmsxx/Nf1TaafKEb+hGbphdWcSUA3IGnu8spkWowDpncv2hy8jm8XAtFYA2R5KvLztp6RK7Ok/8bmCkbbQveriVbQt6rroKV5IRj9bruNP4mUG+Q8DLipSHS4FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epAmlTIl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epAmlTIl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654191F000E9;
	Mon,  3 Aug 2026 15:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785770025;
	bh=r6elHsM+k0fJHkmcXKXPiXtargwTHI1n/sOu5RRNSh0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=epAmlTIlLcq1nOUFDl6NQWVWuZ7alkHfTaCKIDo/H2Kviv15iivBK5cnKfOCvmWqM
	 5hY5gon87EPypYiYh+iMLqNExUxXBZt0nwCLZJ1oAAkxGataJ315o6zebc9bHFTnbW
	 6S/3zs40zeow2fmjXxRYrdHjgBSq3OFbm55z/QdjtA310gGmytzml9n9+7bVgvwtgG
	 Tg7lFZR9s2AXSOlQppeJokLWs1rZBnxITZUtxSdXLafcjLMlefuQn75AJIxaEGKtAy
	 SB1SDKHQNgR9LNG1RMQPF0whJWyULgFFD9LHWkYG8hOQK/85Vx9kXXY0rNMbie4Z8m
	 prq1pUY0stUgw==
From: Mark Brown <broonie@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 cwweng@nuvoton.com
In-Reply-To: <20260803024048.1641756-1-cwweng.linux@gmail.com>
References: <20260803024048.1641756-1-cwweng.linux@gmail.com>
Subject: Re: [PATCH] dt-bindings: spi: nuvoton,ma35d1-qspi: Disallow GPIO
 chip selects
Message-Id: <178576412025.255647.11419362579660201794.b4-ty@b4>
Date: Mon, 03 Aug 2026 14:35:20 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145; i=broonie@kernel.org;
 h=from:subject:message-id; bh=EvsCjDND4KToII21KzgteKvf6oyHL9oF9Jg4f2qW6ek=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqcLAmmT8x6j1zIWkYjrGSdJOqHqDqElhO4oW1o
 mjDmLQaIA2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCanCwJgAKCRAk1otyXVSH
 0C22B/wK4YppaMFiuwwmFInCPX0vOTWV9wwYWec0d6ncqtDSJaVkYkpJKjbQlBjjwfcF6MWO7l4
 VFuQeWVlo0bGrhnGy+tRz1PAOvwDq+j6SWTGi3HWbLmj0Xu60xjXWdXzepJ2rwLKDc/4X/ugF4h
 W3NCCVq/eV4tDiGRYo8vE9e0siyDYWuoKdL4natENL1iqkoStzEowY9RYttbLRu9uFKqP6OCAn4
 E5RgRJPKKkr7Ia2QTfBRxgA3f0yqbtc004LAZD7YzsFQYya67FMQloOXCn20eJ3aVT21uRKxJCu
 8h2/keYYho6pqryaQ99OhZR1Y/CSyfKJipC4rS6FEg6ayjLD
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 03 Aug 2026 10:40:48 +0800, Chi-Wen Weng wrote:
> dt-bindings: spi: nuvoton,ma35d1-qspi: Disallow GPIO chip selects

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] dt-bindings: spi: nuvoton,ma35d1-qspi: Disallow GPIO chip selects
      https://git.kernel.org/broonie/misc/c/98e69afa6d57

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

