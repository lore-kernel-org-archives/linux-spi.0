Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE097480DD8;
	Wed,  7 Oct 2026 10:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791368715; cv=none; b=KcPNr7P97MsnXjCzAO9EsTHLkK9bTMZjbzdESOuIGkl2TvkEREM7SgW7irRO/uKLU/wxRXa7nSm3skQYFnwDa0ykL5StHspt13Gu36xi/+s53LoY8S+q5Z+vZwk0h1Pj9dSDIXnZvuTqDDM99P1wUvlXSsNbuWohzmn6Zv1YuvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791368715; c=relaxed/simple;
	bh=FEmwUBDcBGQL9iiPxzMr4lPkRI/RrXqtCEB1d2RtwqM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NJ7Qz9jehZrFlP+mkTuEkAFculLPkDNowrN+mgD8I+t9RQ0VRPJPs5pUSFr45bltVWd9SHq+MqFcyAmxHAGmUOSRdGL87rC3Lnuc5ooH//xrJ25rPOUUtMAUp02l1bECdYUeSOhWafaG8q8CJaxhiSU+0tHucKWryP4LBptr44Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddGUB+Pv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddGUB+Pv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C8D1F0089D;
	Wed,  7 Oct 2026 10:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791368704;
	bh=7oup34LMQK44s5+r/PArwLKN+1YdH0CvlQSNY8m4+Yg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ddGUB+PvBp/6ASSKJJLfA1NyxKGXNPcgBSh5J2NtpCIZx7OFuMYpTRt2uZtl2Qjhr
	 jjx1vr14soDI9JoWs1yx+BCDjpw96/7qMwMhcb1bZSZX1Z+gPk7f4a7DnpzMsFgl3a
	 AUo/EUuVQcfttuH3vayzdQBmq7mQlY/4DOXZIVVwu1VhKA3u5D7nCIHX4Eq456+SI6
	 OT03AJbHh6UsUU5dvEYbQF9AVVoxLv1AVk4eBU6ypF/OEr90hE0TbnmwBKP2tq9lca
	 cEtbLP3EsQYvGd7UxQmkV6HiuaCIHIGhFHV/yS1y9607Z34FgA2h36YspFv/NdsVoo
	 iVR99KNebMstw==
From: Mark Brown <broonie@kernel.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 cwweng@nuvoton.com
In-Reply-To: <20261006063643.198830-1-cwweng.linux@gmail.com>
References: <20261006063643.198830-1-cwweng.linux@gmail.com>
Subject: Re: [PATCH] spi: dt-bindings: nuvoton,ma35d1-qspi: Drop redundant
 SPI example
Message-Id: <179129615225.150114.3085056544164822355.b4-ty@b4>
Date: Tue, 06 Oct 2026 16:15:52 +0200
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1144; i=broonie@kernel.org;
 h=from:subject:message-id; bh=FEmwUBDcBGQL9iiPxzMr4lPkRI/RrXqtCEB1d2RtwqM=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhqxjsj9bj4RvlmLNui4hb5Lnqmn2dnZKfvRG9mNdj28Lf
 3zMVlHTyWjMwsDIxSArpsiy9lnGqvRwia3zH81/BTOIlQlkCgMXpwBMpOkN+z/rGPf6XRuF3HPk
 8i6sDU8QsznKpmLTJH1iw5QzUyU4DzT2NTOvYvD+4mh7Wa8kZrrHCls5y8Ju6ZpZspmqFaUMH93
 2bPC8k9WZf43/8V+NsxELjDKOLJn7b+m9YhuL1rjC08EM6bnGPxVeNfR98jjAESU/g/vikyksTP
 9+tG+w4NyVIxhtsuGO9hXNvdFlU7NfaT1TUpSvFvaKvGbf25gkrvXorLY7q6Yw20/fqJj+HwdD2
 +qP14UyFhz2Eq5/e/xZ3aNrITEHG/P+/Mx6F7FxSfmqrd/Tll53Ox1gafLR7iBn+d/V2V7JzTsV
 HjGdTVjL/jPW/KSVi1+SWJSWyIKG91sYlSR1a8UVD1sAAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 06 Oct 2026 14:36:43 +0800, Chi-Wen Weng wrote:
> spi: dt-bindings: nuvoton,ma35d1-qspi: Drop redundant SPI example

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.4

Thanks!

[1/1] spi: dt-bindings: nuvoton,ma35d1-qspi: Drop redundant SPI example
      https://git.kernel.org/broonie/spi/c/921ecc459d4f

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

