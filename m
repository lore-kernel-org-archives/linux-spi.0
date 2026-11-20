Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795188495;
	b=XMvR8JS3YHCfehEcYzWoldY/jUftXfhav4zMGokYZuG7/Lbrjv1Xda2kPBglbk/Nly38
	 mgovf5/etN9cMccgnbge2XnqVI3j+d8SK/eXI+oDfUxU81SeaYXJjKPLKBSdtZGr7Wcw2
	 P9owDdU8kakAFRwcWL1Xm/m3tq5ijtMG70IrDslO0jlMYrGyUI7UVvE4e83QIpIg7ok4P
	 BeBHcOpVUqb/xI7qppkqmQkQ22D0++1PISbhh6rl3oWqcl/s+ebKTlWsuQv410EP64qiE
	 TE+N7APs3YD9O731sObkCd5H2ltG+LRIsyxAV0aDWxvj0lasa+GzdS/sFl7BGsTtsyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188495;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=WhaebfWiS1VXN82KLOZz1WCfzqv1TpGJKn70SfWk5W0=;
	b=MfdWbXYCWWRKcgnTLEplaFUXxze4/e/7w/0KW0BbfEpRq6bgPOELS12qaB3DpwnWa8A5
	 aO21z2MRYaH8Oei0jZyC/NrZzmS+p5j9V/EN11TvIZcWH8lScSA91yXK+FouZKm1NRCah
	 In2Dn/IzvNYFz/d5Of78o3j2CQn06eG4IiTpFI9yrwcpu2O3oMfe7sRddYI4VHV+QM2Of
	 6RXn6TAai/dSdEo0vG25IZbyp9CGChFNk4lfAXmYK0B+zQA14Xwb/t0EJnLrxhaLRF/86
	 cwddAT59tCYhsRCKXfa0PGNI4ChY/EKsNvm7T6pjPbU1FqJdedhE02KICtpYFZKzNDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AOgRSLhJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C16606A32C;
	Fri, 20 Nov 2026 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AOgRSLhJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC141F000D2;
	Fri, 20 Nov 2026 15:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795188495;
	bh=WhaebfWiS1VXN82KLOZz1WCfzqv1TpGJKn70SfWk5W0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=AOgRSLhJCbYeK6jNnplfLl2Kq5M6XrwmKNN8elkW6waXsIj4Ns+APjITnuDSHz1f6
	 MneXC1ecOi0p8jjYAEUytXuGhLCXhhWYXIszLzRJbz9XoJquQN4WCXFB2qq0ukwS7r
	 ONMUGW5gL7ytJVNJi1U7ss+sUo5Psq1cU1QZaJ1bY0bxv4GmNHEm53kUgECFSSgryy
	 U8UGB/BqCgsHVJ4m/G34c98P6/WNUkwJoNSSFNmYpT+i/08ymOQJRWKc2uwhyau5Nz
	 WOHIbv/5DDV556chd+EKs03BijdnbtRnyej7Lg1F3mVxWzmrntalhSPSq5/D9XlPGm
	 JufJ+bFjoMTKA==
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 19/24] dt-bindings: spi: Add ZTE ZX family SPI flash
 controller binding
From: Mark Brown <broonie@kernel.org>
To: Navid Ghahremani <ghahramani.navid@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, arnd@arndb.de, 
 stefandoesinger@gmail.com, krzk@kernel.org, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261014072109.1759502-20-ghahramani.navid@gmail.com>
References: <20261014072109.1759502-1-ghahramani.navid@gmail.com>
 <20261014072109.1759502-20-ghahramani.navid@gmail.com>
Date: Fri, 20 Nov 2026 15:28:09 +0000
Message-Id: <179518848943.6016.16140133614242447239.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=639; i=broonie@kernel.org;
 h=from:subject:message-id; bh=IYVVL1WQpODtUTYbvZYUESLycirYOu+mnnmWexmbyOA=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIZ0rlY9Wcybbq5QPAnY8wKptu/A6w+HGxp3W+b75qjy
 r7uXvOOjlIWBjEuBlkxRZa4LO6X9SWv1/AdXNgGM4eVCWQIAxenAExkWjnDP91f0bu//Y8I2iPl
 F1cb9PuZ2t0Jp/zrX13co9q9k5khKIzhf5B6jljiedXMq76cz6f7/Jjs2sZ5OEjxirVwQOn0aP+
 7jAA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

> Add Device Tree binding for the ZTE ZX family SPI flash controller,
> supporting both ZX29 and ZX279128S SoCs.


Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

> +properties:
> +  compatible:
> +    enum:
> +      - zte,zx29-qspi

This looks like a wildcard binding which we don't normally allow.

-- 
Mark Brown <broonie@kernel.org>
