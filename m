Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE545632A4;
	Tue, 22 Sep 2026 15:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092431; cv=none; b=Sd7QHKbOzfOvtWSUX45rHlX3k3d02W97pRUmv+U3hHKNhWd9gUeIS8Ds7FsUkhFu8S8XkQMJymT+vF91OszMU7/DW4p0EEXzOpJBZziZQg4Vf/o/8Qmva/IkKEw4/rUzozy0dHnuO39tQBTO5343LQ8/kQAogvLb1F3I9nNyp98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092431; c=relaxed/simple;
	bh=uy4WH0w/V8fjO5KV1dH4paOiSlECTwqiGH2t8k7HDZ8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BrlWc7cvRVuay1A9SOntqLVNwnEIf99NhyzVEPWvrlLM+OjdB/Bv1xKjgOhSATDB5cryt9xv9Q5EhBRwgLIqZScsflHOH79Y4PhpeL2REm1zHsl7hWBgBTJpVePwgWqSCpXtqoqi9f1Q5Qn52oE64hC0fXznOPF6Mc3AXDvn1/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhEm0OPu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhEm0OPu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0451F00893;
	Tue, 22 Sep 2026 15:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790092430;
	bh=mLP7ngSOOjFnQa/m4wcizjk0PfUojtkYKtIjNhEq640=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=AhEm0OPubyvBPwd/4JPSIPlUyyyOhl/9qByucpJ/RwDNZyJ5euY4HHbYVek06QflC
	 qZKcZ/ixu0Wsl0kI8+Up28yCGJayUs9zS2lKvc0dyZiqHrSf1zccEl2/AaKaojY+F8
	 cEt/B3/QoGyPkljOWj/2CCdNjqLUFTGUZ5WYFj0/lNqx/I/axS0ft0X57EaQJY4dIG
	 Q1kNLbNF/3B28C41TsBjoKlufCNznaMqaDQYXH65fgHqXcrRps9iIxD6HMorbFp1J5
	 KnaFQLDhqKUd2JTp/txiJweq/kUrG19FechWTnQFfbAPlzpRoDiRE0q1KGLTpkxje9
	 Ip5OYjZhBCXgA==
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org
In-Reply-To: <cover.1790065451.git.geert+renesas@glider.be>
References: <cover.1790065451.git.geert+renesas@glider.be>
Subject: Re: [PATCH 0/2] spi: sh-msiof: Add support for R-Car X5H
Message-Id: <179008178775.322763.16248581785473182715.b4-ty@b4>
Date: Tue, 22 Sep 2026 14:56:27 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1456; i=broonie@kernel.org;
 h=from:subject:message-id; bh=uy4WH0w/V8fjO5KV1dH4paOiSlECTwqiGH2t8k7HDZ8=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqsqSJGplXnfIZhDDsHPhQbn2HWMTa0MHSL6KVi
 D4GGNdxfguJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarKkiQAKCRAk1otyXVSH
 0GcxB/9hAnAH6q/Vczro0N+1aBnFhwe7vi56Jk9AMar9oxUFqLlmKKDTBfol3BOGrVFsatX6T2S
 C/LC/2fd04jsxPmPKF2FhYK5IrkIGYU5QMrQjJ1Dm1uJrGcY3TlUYP5U98+q2qKIog/y9kKVjGw
 z4N6ctXXSHT5+t0SJAlniopeS8vBkgZlWudF4rl5dm7nbm6yaF/q43Bz4vFXynK+RpEoTX5+6oh
 v28a0amadGMYOocrIONp+9UTe0C4yab/bCw5K9D7XBVFvfLfREWXlFNQ9enDLxsABMvVLoG4vuB
 w4M3uEhmJI1y7CVzBC0JvlSbd8kZ+n1v8+GFnCiP6uRRA4Ej
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 22 Sep 2026 10:26:59 +0200, Geert Uytterhoeven wrote:
> spi: sh-msiof: Add support for R-Car X5H
> 
> 	Hi all,
> 
> This patch series adds support for the Clock-Synchronized Serial
> Interfaces with FIFO (MSIOF) in the Renesas R-Car X5H (R8A78000) SoC,
> which is the first member of the R-Car Gen5 family.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/2] dt-bindings: spi: renesas,sh-msiof: Add support for R-Car X5H
      https://git.kernel.org/broonie/spi/c/51e04054e299
[2/2] spi: sh-msiof: Add support for R-Car Gen5
      https://git.kernel.org/broonie/spi/c/8157bb8232a4

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

