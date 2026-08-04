Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F49C30ACF6;
	Tue,  4 Aug 2026 21:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878365; cv=none; b=n/DYLy4B3ndMnAnO9oKdGDk3X3jxUXFQjnTC0/TXYlWWvlYD3yXimPYH4UYFzF88vwaazEUvooVzB6/Sygs2KrUa+k0T96UQY0uNZBMMK85HE7M2o1zkj9GEx7zA4Jl01SeYw8OhO5XM5r+pi/ZDsJnKbXU/u+xLacB7DMEcWzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878365; c=relaxed/simple;
	bh=pLt/cU+TnyqtlnI5xON5SLbuyKMa5di2C9UmmlL2O8c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gJz8lfF2sIok2m3Kf5CtNUGSNhUTutLIMK+wLpyJcypqYeUQyCRp1VYTr77k7FzUEIAS/f4OsDKjugeMSdk1fs2ZqPCx7ocuMzbiiSsv2KSF7yujYL4dIAAEWj32KjedBxSO/7v0rHRt26FviFnxIeRPRH8QkGfJS6jS079tu/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIJoUCcw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIJoUCcw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008AC1F000E9;
	Tue,  4 Aug 2026 21:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785878363;
	bh=TBycfkJw5I/ng54OHAnOW8sWPT0mi9f8UR2eLGlndbc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=jIJoUCcwm8Tp3eupSw3jTlPGD2RGQHuM+UFQSS77odS0q0ZUxRY6MlT/XFKQ/xtaf
	 azR+gN64IRiBGdDI32cNQwswHuCEzSOrFaZS8Ujgbbk+Y2PG/LyDomx4wIqcGh2U7R
	 oag8gUnezF0gRijEbcmqMZSeK6byN9ecBU+5sFCGD0A+r3iVCMbNj7TIA6jE7+gp6L
	 qf0KVoc7deMvpHqcOApvSWu7BipzwOS/VwwDMAK1lrlurX7a7C9FoqpSqWv5vtrzbX
	 LsT2Q0RrwiH702KayiY2Ofb+CAu2YxymlCWbHyp+svmdGyLB7Xxd0loBHDuwW2l6+l
	 H0gsFsSFnhfTw==
From: Mark Brown <broonie@kernel.org>
To: CL Wang <cl634@andestech.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kousik Sanagavarapu <five231003@gmail.com>, 
 Vladimir Moravcevic <vmoravcevic@axiado.com>, Tzu-Hao Wei <twei@axiado.com>, 
 Swark Yang <syang@axiado.com>, Prasad Bolisetty <pbolisetty@axiado.com>, 
 Karthikeyan Mitran <kmitran@axiado.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20260804-spi-num-cs-v1-0-4ccb13dcc7b0@oss.qualcomm.com>
References: <20260804-spi-num-cs-v1-0-4ccb13dcc7b0@oss.qualcomm.com>
Subject: Re: [PATCH 0/5] spi: Few cleanups while looking at num-cs
Message-Id: <178586591185.111355.14637687266555996787.b4-ty@b4>
Date: Tue, 04 Aug 2026 18:51:51 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1777; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pLt/cU+TnyqtlnI5xON5SLbuyKMa5di2C9UmmlL2O8c=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqcldY1DeS9mNj2yy1OE2P4KfiH21c9R+Pvn/L7
 /yLsmGB9ZqJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCanJXWAAKCRAk1otyXVSH
 0NbEB/0SYx3PdmLpeMU3PawZ31PrGosiVxngXQhyelNrGQ3m3g3dPn0j+nrDV2gGTSp98/6a//d
 kdWDwdJFXeCFwr5H0ghvXXBWvq95DotaZl0durAgcWbK/rmmFZtPhjrlWR1v+surxqTur9CkfrD
 CLJdqdF+OKooavAsnHqHn/iWI1f0vV9mihsZ3iiVuOB321w3GXGs4hQ8a1vuwZDw2/KQusHW3y1
 wkG/z3G0fqDLjMVOI7apxvh0Z9eFiJTeGazTneVF3nkDZ0cK/fNCb93IvZgAAz3vHdUMlw7Ua10
 Td7BmAwAaKl8hYxd8qfCr/2JnzUm34yvtju1Gm5WGvrf8ST5
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 04 Aug 2026 09:16:56 +0200, Krzysztof Kozlowski wrote:
> spi: Few cleanups while looking at num-cs
> 
> Few minor cleanups for DT bindings and Andes driver.
> 
> Patches do not have inter-dependencies.
> 
> Best regards,
> Krzysztof
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/5] spi: dt-bindings: andestech,ae350-spi: Drop redundant num-cs
      https://git.kernel.org/broonie/spi/c/82024a7ae057
[2/5] spi: dt-bindings: marvell,armada-3700-spi: Drop redundant num-cs
      https://git.kernel.org/broonie/spi/c/9ec27e118da7
[3/5] spi: dt-bindings: axiado,ax3000-spi: Drop duplicated type/ref
      https://git.kernel.org/broonie/spi/c/577ada5875dc
[4/5] spi: dt-bindings: spi-cadence: Drop duplicated type/ref
      https://git.kernel.org/broonie/spi/c/ad0dcba3ab9c
[5/5] spi: atcspi200: Drop redundant andestech,qilai-spi compatible
      https://git.kernel.org/broonie/spi/c/463c840f54f8

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

