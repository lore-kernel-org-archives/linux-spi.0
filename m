Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E4E3CD8B8;
	Tue,  7 Apr 2026 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775580272; cv=none; b=GfOtibtLO2rR/69cUh58jDXpYNivs67+z8so3h/W11gO+fGM6jitOE7xUm6S3A0uRbA+mar4xnRHWT2USSnsWa7IQ+ZQEvmu6QVUaEpHs+DrbiFDPqLP1cW61V8hZYf/2QOjnqyYiPb9QqNf8cgGictaFHvnZ7KuZ46xywn0+YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775580272; c=relaxed/simple;
	bh=66I77DD+WytDeh9AjfSnO+ZsYGkQ6+hIC2mvN5YxyAM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=K9dZg8aGFxBDfY1LQNwoEhiEZl4wTxQdO0DRh9smfmwx0tLk6x1v5lnOzrfviFVy8Uf1Km97Ouv4Gc2ZFyRF7l8FvjYQrOgumai3FdTeCO1/V3qR5rY9LcSe3XEi3fewWc4ZfB3FhmkwIuuxO6N5ZF5lF2sDzLGLk88h1QZrzXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjnWSs88; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjnWSs88"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C985FC19424;
	Tue,  7 Apr 2026 16:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775580272;
	bh=66I77DD+WytDeh9AjfSnO+ZsYGkQ6+hIC2mvN5YxyAM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=jjnWSs889V7kt+xaxcrZzPiI6fKzEKoc1RYbCsLizHENxXInEeACy7tewBx0/nl1/
	 Ul/KDVOiFwQO/usb84l/NJ54E7+Kkz9X0GD4n8Oz+LJ5pcDSv5PKCXtbHv4Ka5zcNI
	 djAXrcn7uH3KzBlqdH9EJe3zenXq5gZfbqOeqHRwUkgEIQeDWGDTnlx5VZopWeqp8r
	 3Am0mrAwpZkgRippu8hEqTQ62kEWzxer/9EnbXRuJrPaBeWs3DxhGZFHWkoa9keJtg
	 khcdVMJ8RTPWo8uCNxqsIMUHrNSGWaWXshpykKKeg9Dum3/Hw0ipyo3QczMHEtqj+a
	 ARE6rBY+R1ZTA==
From: Mark Brown <broonie@kernel.org>
To: hayashi.kunihiko@socionext.com, mhiramat@kernel.org, 
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <b2deeefd4ef1a4bce71116aabfcb7e81400f6d37.1775546948.git.xiaopei01@kylinos.cn>
References: <b2deeefd4ef1a4bce71116aabfcb7e81400f6d37.1775546948.git.xiaopei01@kylinos.cn>
Subject: Re: [PATCH] spi: uniphier: Simplify clock handling with
 devm_clk_get_enabled()
Message-Id: <177556396963.37897.1195757316005441316.b4-ty@b4>
Date: Tue, 07 Apr 2026 13:12:49 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev-7a3e7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1144; i=broonie@kernel.org;
 h=from:subject:message-id; bh=66I77DD+WytDeh9AjfSnO+ZsYGkQ6+hIC2mvN5YxyAM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBp1TRtbfHYaVyeZGshk4QPL5GAixQqfgbNbCGdo
 FLljBM6Mq2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCadU0bQAKCRAk1otyXVSH
 0Fc2B/9VcjmkYZARxUL1PvF4DXiw7cDO6txyR+8Ba3cmRA4qNJYElm0uR5kXKSa1XAh8u+q3ubI
 puVsF1pkkdIOfQFTLfjcUQu5B4Wcuzh5vz86OyEITG5ROMzVDzbgx6i8DJ0shGDzg8KZHCafiFH
 WGxyg2MhRozIPNg4vDcU1JWP+Y1KZ6Y73UQMlKzAXasW4S8YUazTcFKnHjrcF4RAiV6WPmsk7FC
 dTV8uQjDwa0E+gW8sIbdCjHgTE5Ha6db1vKDQLKIOKkIUpglE++fwcw+51duRu0o/Igl+ylT+cb
 s/zJKjkxqG9XNLOgbGdJpsblRVACU7Xg21P8OqXxb+NSxwMy
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 07 Apr 2026 15:30:28 +0800, Pei Xiao wrote:
> spi: uniphier: Simplify clock handling with devm_clk_get_enabled()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.1

Thanks!

[1/1] spi: uniphier: Simplify clock handling with devm_clk_get_enabled()
      https://git.kernel.org/broonie/sound/c/fdca270f8f87

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

