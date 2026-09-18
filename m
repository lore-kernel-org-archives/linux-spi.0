Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217ED2C21FD;
	Fri, 18 Sep 2026 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761637; cv=none; b=R8b+0P+cTcaU5eW4cVvmpZb/pKuleLB17alYLrMYHKUrEu7m7izM3XIHKtW1mSv/+I21p9GWqCrjq+TFOI71iaC8b4uK+M6YoRvq0ysJxRzuU5awALAKN1BEyh5WTHdgHKtqmIE+UEkxmSg4yvQf2ptV5GiWbTZqdV0HKC8RRmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761637; c=relaxed/simple;
	bh=4TzoEpfHRdH7xCT//qpK8wJr7qb0NkkYV7wvZfAGVO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVdSCl+gv6SjmF+OMitqX6SHQ4rOCydusnrM6N3oA8RBe2o1mpVUdhue0FBJcddoWokK7K2IigfsclXaUE5uhsO2yCBeoHguHrQ1D3VrsSeQ2dbvp5F1PUN99t/XAvyyP5C5PoNtrBS7mwOeZyW3ri2h6Mr5nwwS/sXTNvTSwWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpn5n0zi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpn5n0zi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844491F00898;
	Fri, 18 Sep 2026 20:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789761635;
	bh=OsEpDB9UCJuLpaU3+bqZ1MTcVZYu+7Pxx8NDDG4f60Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jpn5n0zi7D/eHOm0AMqqerqvuIxBgyPrCcGty/49OY9O+kJLzGV1WKcxvAAT42mzv
	 69Cb1NQfGn6RW2MhgaJoKePHUOhjoKIlupzn58+FvrxmVwOiH0zi3+Ot2j1B2jOqUd
	 YBLsDfpodoqPUYqXXekWL+ZBUESnwubHyLvKsiueJNVqEtlogz/Rr8zvTVuqU8+/bP
	 cPWD7Z42W7q0Y4OSiFIXA4V8CnQycALYuu8V+juyYaKzZeqSo64O76MkJ3PMbwEXM7
	 6vEPD+HcnAA1ICD/jFhLxgwLOTdgIEn1DpAlwwonoKAFRP5sDm453v6rkyFwki2SOu
	 1jtST1+Kpq2cw==
Date: Fri, 18 Sep 2026 15:00:33 -0500
From: Rob Herring <robh@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] spi: dt-bindings: Relax node name suffixes again
Message-ID: <20260918200033.GA1667835-robh@kernel.org>
References: <60988ce9c4913014e255ecbe127e93374f6a2295.1789570538.git.geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60988ce9c4913014e255ecbe127e93374f6a2295.1789570538.git.geert@linux-m68k.org>

On Wed, Sep 16, 2026 at 05:18:27PM +0200, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> An SPI bus node name can have either a unit address, or a suffix.
> Commit c4fb6880edc15866 ("spi: dt-bindings: restrict node name
> suffixes") restricted these suffixes to decimal numbers.
> However, SPI bus node names with suffixes are typically used for
> board-level bit-banged SPI busses ("spi-gpio"), which live at the root
> of the device tree.  Limiting their node names to numbers is prone to
> conflicts, and may cause silent overwrites, especially when a stack of
> sub-boards or expansion boards is involved.

How is that commit an issue 3 years later?

I've commented on the case which I guess prompted this patch.

BTW, "spi-gpio" or "i2c-gpio" are not good names because you can have 
more than 1 instance.

> 
> Hence relax node name suffixes to alphanumerical characters, so users
> can write more descriptive SPI bus names, which are less prone to
> conflicts.
> 
> While at it, reject empty unit addresses.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202609150228.Nh4nZzbQ-lkp@intel.com
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Other subsystems (regulator, i2c) had similar issues, and numbered
> regulators caused conflicts before, see e.g. commit 45f5d5a9e34d3fe4
> ("arm64: dts: renesas: r8a77995: draak: Fix backlight regulator name").

I2C was a case of "too many to fix". Maybe time to revisit that. 
Regulator binding is a unicorn and not a bus. I really want standard 
names for buses given that's the only way to identify them generically.

Rob
