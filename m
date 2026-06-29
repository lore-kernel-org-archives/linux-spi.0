Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794923537DE;
	Tue, 30 Jun 2026 11:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818195; cv=none; b=X0ZVhIxi5/C1Xf+LrpqDoZcTS1ES9Wvapj+rN9lULviAg1nCtkc28THwlziU9soEXI7tU05j3BdjfXuHHjysED4wHo8z9BOlBUKwp+jqNuClxhROOMhjkrmlne4ljKMCcd+F2LkVeL2/6miL6LZYLVKUEy+y6FOF9m6/jobrIWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818195; c=relaxed/simple;
	bh=+/JESTVsFDcoGuMP/FgRRyUeBmA9JLzIgr4Vp6EzN6M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HWu9zpegYHCSTufqhhfXpdFcm5W3BeJsmFz4+vr9t25EXjFpLFflh81vTDtO9uIbKSmHB5CK1m5S+yQTWplWDMfvXrPHW7W/w43hAf1+VHmC/55Z52X3rJscnd+CBgap3v2mH/TL32C5ytlKsZGrrUicBAPkq1fbl5qGobQUJiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhOHaHXd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhOHaHXd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9BE1F000E9;
	Tue, 30 Jun 2026 11:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782818194;
	bh=gW8Bndv8QKhGjBf6SmFc2HG7s+OzjKpn0rdNZPfQmiE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=lhOHaHXdwAOtzMatMbWXvAMmH/VRdCeXIYozgkjUCTcJ5LUVIiYp6TpeA7N6nZRZC
	 xN7bCU7e6yvghuleLbKTQcy1FCH9hKutrJou/ycDbCQFX5CeuNT7OWlkotCXl+wx/W
	 eR+GQJArUZ1S7+Rbv8Us8rCnDgG0r+0t0a9wOi1MY79NVAMwoX7RflFgEBLjO5HHmu
	 yR65q57af+0tItc+Cq4v1l5EsG0K7tMAK8GgHa3m5kN+uIW7mWEaPHUIFNbsXOCVLd
	 V+tkynqWTtd91xXsMAQDn4g15zmB/jfeS0WUx6xYIltpxhr5zuoPrmZgos2gGfJQ0Q
	 cCxDQpdK69sWQ==
From: Mark Brown <broonie@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 david.daney@cavium.com, Ninad Naik <ninadnaik07@gmail.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, me@brighamcampbell.com, 
 linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org
In-Reply-To: <20260618180149.475658-1-ninadnaik07@gmail.com>
References: <20260618180149.475658-1-ninadnaik07@gmail.com>
Subject: Re: [PATCH v3] spi: dt-bindings: octeon: Convert to DT schema
Message-Id: <178275394462.47562.15525184882513666560.b4-ty@b4>
Date: Mon, 29 Jun 2026 18:25:44 +0100
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1104; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+/JESTVsFDcoGuMP/FgRRyUeBmA9JLzIgr4Vp6EzN6M=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqQ6WP7aX+WmRfwVyfJ8p/6OJonHaNEPMoxTTFN
 9er12Q4w5GJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCakOljwAKCRAk1otyXVSH
 0AgnB/9R1ftlqt+yfnfefzrGR9DVNQvDxSL4yL6muRaOrN4HzRHSkgHnNrPpnF7rtrpjzcAKwOr
 WWtFJ4WvJQH1z7ahK078iL38SowkEF9vvM1yhDAzanHaZRZRNb7jDXeSc6JWRAKXnpU7+ft48xJ
 rnP0qO/nSC9u9eU+RS1k90GgmAwjl0hrdsY2T7zQv5u2W7cWQXQkwZUx7TrCcpBa1QN3yDp4IU8
 ZLTOvSq+9lag5stqH/RBUBm7sALYiA1HsesqM5H/Z8KIm3llxDhScDEAdbPmt6s7a65fir5REcd
 nt/WSY18EaHL3AJqT2gFNbaAx7yLqXW49Ckd0qm7d1jIamSr
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 18 Jun 2026 23:31:49 +0530, Ninad Naik wrote:
> spi: dt-bindings: octeon: Convert to DT schema

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: dt-bindings: octeon: Convert to DT schema
      https://git.kernel.org/broonie/spi/c/cb8c374a632b

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

