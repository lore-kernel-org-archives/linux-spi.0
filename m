Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE09941B8C6;
	Thu, 10 Sep 2026 10:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789037562; cv=none; b=bschKdmExXZ2GpaTnyKj8BgJP6hz4XvKa3gb38ay9vnpfXzB3i6dBMD/yliXgB+8FasgDjpo3P1MWi+ou4PfozfFRWtXwci/iw67v/EoRaoOECM+GHCy5OizxZiOcHx5EcbxFzOXB9zEIjO3thEUvDyCMPJClTx5baZ5CJ7IYAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789037562; c=relaxed/simple;
	bh=pPeQw5GJrm8q8CxIuWyDmg3UYRBKR/ClhW0kNpd0ArU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XzuLGVMJp2AtKqqLjD445+d1QfZW7QHz61yMbJUQ2uXj1WNo+mMk1t6HyPjXYqXntiaZa+Deh7j9gjE5n0ULqf2AWAZFqMutez0pJKSIF35rf+qDBTQABcdI9e34VFjWp2dWpKe7xonCYfYyIUs5Rw2G1yxS7u3Vl1uE3acLMdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLR1qojf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLR1qojf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEF21F00893;
	Thu, 10 Sep 2026 10:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789037561;
	bh=E+K4J1phzbwP8pGY0nygYKvijKwNf9+ocPucQm5gYFw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=SLR1qojfOwL5cAgFjOdotP/YmkLbwFLY8dyn1D7rUTwvZt8CuSAwp/D5UxkTZrkjJ
	 n54/mhrNVKO5sY7pk6slB8FlX6SbRjyuhVViFrXFkCHTBJd8ZkuhZH3oB0mmZmkqTL
	 WWjfvNz/Jl05TX7gXp0a3Zu5Lzk4WtcvmMB8Mr3KzDMIATDGQ76HDsaaKOcZcUmZpP
	 G3W6xQC9OO2sBWa+llQLSvRG12CmD9nm5SjfL11wloMtQX+9LOd3h3tIW4S8BibHMh
	 gS2tvdAqFFvWg1rSgPKBoxe7hMsPi0vIQrUv+5DlSn8kOwNP8jm4vEV7N3PW+nm5Ho
	 P2UUz6zEa3qbA==
From: Mark Brown <broonie@kernel.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260908-qpic-snand-drop-dev_data-var-v1-1-147d3fab6c48@gmail.com>
References: <20260908-qpic-snand-drop-dev_data-var-v1-1-147d3fab6c48@gmail.com>
Subject: Re: [PATCH] spi: spi-qpic-snand: remove interim 'dev_data'
 variable from qcom_spi_probe()
Message-Id: <178897509987.151853.13750167819950837847.b4-ty@b4>
Date: Wed, 09 Sep 2026 18:31:39 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1167; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pPeQw5GJrm8q8CxIuWyDmg3UYRBKR/ClhW0kNpd0ArU=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqoov2vKcTOkf8vIJD+G3M5PUTKbPHHHBdmjWCl
 lWZWMTg4oiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaqKL9gAKCRAk1otyXVSH
 0GSDB/wLuT6JNWww5H6bzGas94lM4JzlfyQ6JJQqoOzTMOAfqYOyKg9AAUM3mzG5fX26NCnuI9A
 JAZxR2fOK+x+kxGuJFjibZT0qZ+GVCaSdJo0rEgOdkG27BGPOvAGONMqPWPf6YFiRjnDzbjwdax
 p7l0OMKx4gkw9x3Zgij+P58fW/le5cRLZNrnwiIH1Yco64oFYILGzr9Enjb/M5ExdEKpIN+qTIS
 MhPnFsd0mxDehQgDQcoYVICCk692va03o7/DFVi07za9NPw7JMWXuYjAY7+TZTvkCx6kDL/2aDz
 qOf09LuGIfMQW3wGPjAZaAByL20CgfNdMnAF1RbdtMsk9YJj
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 08 Sep 2026 22:23:55 +0200, Gabor Juhos wrote:
> spi: spi-qpic-snand: remove interim 'dev_data' variable from qcom_spi_probe()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: spi-qpic-snand: remove interim 'dev_data' variable from qcom_spi_probe()
      https://git.kernel.org/broonie/spi/c/44d39535cd4f

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

