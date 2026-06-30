Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1EC3822A1;
	Tue, 30 Jun 2026 06:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782802072; cv=none; b=gHwuPfXiYaAXwU7dIMCy7l2AGo9TfZBTJdCX/mEQaxgkRoD1NwomZW7t0keYvlgX+X4AcrDjXE4r48NeLbl36EEWQlNPW6rNwlZV34aKgophRduFCYFaYfC83SERLzNyGySZ4ZXW/WJBEclIBM9SytpOkd+vDA369lp173WtDvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782802072; c=relaxed/simple;
	bh=rAfjYDmFjO334SlGnUD4ll1Qtgt5OdlU1pHochTedL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1q4MzvKyRClCnmXUchpn7N4YQbiw9zuEN8AWsUQJlNZHndJ5IvxmZO5eJu9z4oRSQ0zMSng7IyPgiTXQeVHerhNDd9Rzh6/6ZhMh3Fi3zyUGUwCVioZobnyYMEmd7schinHkzOGjdPE69QmOljp/z5hTNqbcnzMqam6aSw4yL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKjhXOj0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKjhXOj0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DBA1F000E9;
	Tue, 30 Jun 2026 06:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782802069;
	bh=rAfjYDmFjO334SlGnUD4ll1Qtgt5OdlU1pHochTedL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FKjhXOj0vpBtzMvc0YE/njE02NLXZE7znhdXGVcvUHGnluCcGoG2ha65kXBMA7F50
	 MOPzQzrmNHTH9hXQEx/xDPyRECDN1v99ESbs3XamPNxsehSEQUfbcQKimYJBfW7eoQ
	 +XG133SnxThuzDZCSanH/Bqa7K0jrZp9Nz+41jeDyllTqxiO/0U8wiSY+R6iySNj73
	 TcILpA5qxNErPZ1LTDhKOfzRrTqgUSJuQen1bmRJOsvUg6lFKXLW/lw5/ZzNzsTHWo
	 EEWMbM9wQqLeILsyO1EQPXXFQxl9depht3LpRBlcZHn1A98bgeRFEmtLNEy9fISb2a
	 Alfj9NnubPoVw==
Date: Tue, 30 Jun 2026 08:47:45 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/4] spi: dt-bindings: snps,dw-apb-ssi: drop
 superfluous RZ/N1 entry
Message-ID: <20260630-dazzling-intrepid-lobster-c83db6@quoll>
References: <20260626180326.9593-1-wsa+renesas@sang-engineering.com>
 <20260626180326.9593-2-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260626180326.9593-2-wsa+renesas@sang-engineering.com>

On Fri, Jun 26, 2026 at 08:03:22PM +0200, Wolfram Sang wrote:
> Commit 164c05f03ffa ("spi: Convert DW SPI binding to DT schema") added
> an RZ/N1 entry which was not in the original txt-file. It doesn't follow
> the usual "<soc entry>, <soc family entry>" style for Renesas SoCs which
> was properly added later with commit 029d32a892a8 ("spi: dw-apb-ssi:

Does not matter really. It was added apparently to match the compatibles
used.

> Integrate Renesas RZ/N1 SPI controller"). In that commit, removing the
> bogus entry was overlooked and is finally done now.

You introduce undocumented ABI or your patchset is non-bisectable. Past
commit is past history, so not really a reason to introduce new errors
(and undocumented ABI is considered such).

Please drop the patch or fix it.

Best regards,
Krzysztof

