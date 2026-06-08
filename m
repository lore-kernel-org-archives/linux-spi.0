Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632703CEBB1;
	Mon,  8 Jun 2026 10:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780912969; cv=none; b=eR4ySx0ZpAalvP34yCDbEKzqpV1CTHFM/D7IMIyD2BgPR4Vp8cp4tGXsZHKW1Q+/lqLJRyCQJ2/YabthpcZDoiboJNuEqf38ZlKWtnPoS41bh39dwTR1xhPQDPP+VquHxjvYkFh8vaxgpml1si7GtWw9FweLdIiS75VvViCtyaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780912969; c=relaxed/simple;
	bh=MUKQxpU1GyX8Kgu+s1JauJtCAVW9yNQ84LQZT0+Fnxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNY80J0uBIiaHdOkqe5/PZVV9kd16YnrIf1LtH8vuOVFDa4GjS5h7rZPlkgVX2Rj64oXbgAEowWxrOi7jB9EegDlP9RNSZI4VWykXuQIFN4nlqAGNisMOOPg0bXwOedm3NM7pay0F8d4Cs2Zp3b64HRslJf3ZFEcw0hXzPozuuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbdbmTSI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbdbmTSI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D587E1F00898;
	Mon,  8 Jun 2026 10:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780912968;
	bh=1hOv2WR62QjnJEbsw0u0ks8guZvL8FT8c/MaXSI+xMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fbdbmTSIUZrRIhyXG1SnbJ0wvlg/SOyLtdjkpdcwnrkYYTPq/Asd7IlReWZ05xy0o
	 ClZLxGFdwoc2lqnxRMItKhmcOwidesuMV71raM88b6IAbXFEGp5CucpS3WA4O9uZ8y
	 uT6pqfoWVjFIFIz57Zqv6lvMzWYeBwTMxVALU3sQ0ujCOFLBj8/jB/JlYmYbN63WKU
	 OjITsjSW9xiwdwGcI53Vsc/IF+yvkExpcAnMUbQfmIqzP39FenRBFUL5C1FWC7U7fT
	 nqenmYK7arSNLrn4KaQDtvD0ckdyL0+ZCfJl1sk/HbGWkNekEpWH8BERULXnb+13Ty
	 +Mv0N6yRoQDuA==
Date: Mon, 8 Jun 2026 12:02:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: broonie@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, cwweng@nuvoton.com
Subject: Re: [PATCH v2 1/2] dt-bindings: spi: nuvoton,ma35d1-qspi: Add
 Nuvoton MA35D1 QSPI
Message-ID: <20260608-aquatic-alluring-asp-b5fcb6@quoll>
References: <20260608025009.1504971-1-cwweng@nuvoton.com>
 <20260608025009.1504971-2-cwweng@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260608025009.1504971-2-cwweng@nuvoton.com>

On Mon, Jun 08, 2026 at 10:50:08AM +0800, Chi-Wen Weng wrote:
> Add a devicetree binding for the Quad SPI controller found in
> Nuvoton MA35D1 SoCs.
> 
> The controller supports SPI memory devices such as SPI NOR and SPI NAND
> flashes. It has one register range, one clock input and one reset line,
> and supports up to two chip selects.
> 
> Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>

DCO mismatch.

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

Best regards,
Krzysztof

