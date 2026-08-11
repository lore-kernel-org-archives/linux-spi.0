Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C29D38D686;
	Tue, 11 Aug 2026 16:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786466816; cv=none; b=Q4ADW1yEIqU+iBOXDEkZne6RpGQ6sl4oMLOyuI05Zhk/Z/94hkAHMnW/dtD38JoWrfc2mliaRpbfP9A8iAWclCSh12nXiMnyMBTb/WVqwhPpsymimW6qrkP7b7Avyx0nTrvseI35HRprLrlNLSk7lVE0JtZ7BnOeN5K7eowAmkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786466816; c=relaxed/simple;
	bh=+JK/qtzYidYxvmfvEm32GTzCLRscEza11mb/ChBDu38=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rFB35AhP8S6nA9wwjAJ9El8ypjksFUoLclaYdobVC7xhN60m51ulp2RC16HU/EXF7C++XNmatDBW57/7p6W2pyIPBsAt/iAo1MvrZb9xBp8hpMmDo5PH+Jd2Z9ce0vz8e2UmXV967bUtqA7m2nd2qp6TyF6SR0L3X+07SfnIXC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJtX+m3f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJtX+m3f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94631F000E9;
	Tue, 11 Aug 2026 16:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786466814;
	bh=35SLMVPx0u6ayMN4r4D0tKX7Ejde+ZgmUYJJPjitprw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=aJtX+m3fc3xxLA0Q9AKc5S4DEtALmtAq/9rYx74j4YQPC4RzgCSSG3ohIF39znldg
	 Pum0I8zL6uP47KPy4e6QUTQAtKIcraPNBWEm9y1tmlM6/Q0Rwt6IBmxNL3IqrmMLz/
	 cNsX8eSRmFZqSG4DRazhqiQLU+AwQ/m6yB91/VzRp+QSRpSWwQxVEYFYNC0v0jAMs3
	 70TCxVvbhP0BNiA5xIXCipydo5wPVsAf5LlutPz9sssh/dF+tR3+G+XMGPZENwdhUM
	 XklYzbMwWoFgV472FKFA/128xuP9Smcf9raiDDnvex/n86oJQgJp+/d1tj5yttQFK8
	 DP4hWh8KFFQYw==
From: Mark Brown <broonie@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Felix Gu <ustc.gu@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260802-spifc-v2-1-46e9d06a3217@gmail.com>
References: <20260802-spifc-v2-1-46e9d06a3217@gmail.com>
Subject: Re: [PATCH v2] spi: meson-spifc: use
 devm_pm_runtime_set_active_enabled
Message-Id: <178645712491.119683.11333152337040642121.b4-ty@b4>
Date: Tue, 11 Aug 2026 15:05:24 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1122; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+JK/qtzYidYxvmfvEm32GTzCLRscEza11mb/ChBDu38=;
 b=owEBbAGT/pANAwAKASTWi3JdVIfQAcsmYgBqe1H71ff9HUK4skCti6zzMXrFYRGaDkU1jVyo2
 ZgPr9DwTgqJATIEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCantR+wAKCRAk1otyXVSH
 0GxWB/Yj7AZhfrU7mudjhSzbAMFpUyuh/nfPqyLT7oFAz+x6qCq72kUL+F8+5XiqNNj0Jp9jQXw
 RMMtuyzrg9aRl5/OKN6AKGWUOHrxYJbaxIdbcML+d95Mw31rvhfFiE76VIHLcMuIUM1lXi/wcl6
 S5dvnlGG8rL7PS+HlAzHm2AQfO/z+eHjz+ReNpPryC1jxkA9FIoRNu2QKBerOtsQOzeYfNNbKmg
 aq4ORFpuWxcPKxnrguNc+pieO7XlbVf1QZ0vLxOeWj07sr6L8hmvji703eqOEZrEYLL7op2bw7M
 pUfI5Pzw3KNwkUxt5QTczJS9szeWZL17JrgqOtUrONs8IBo=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 02 Aug 2026 01:51:24 +0800, Felix Gu wrote:
> spi: meson-spifc: use devm_pm_runtime_set_active_enabled

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: meson-spifc: use devm_pm_runtime_set_active_enabled
      https://git.kernel.org/broonie/spi/c/c10b7f5e0cb1

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

