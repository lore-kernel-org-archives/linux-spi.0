Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2111748BD49
	for <linux-spi@vger.kernel.org>; Wed,  1 Jul 2026 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782911583; cv=none; b=A6Rf7M2S4OZ+fQAYfBHOfOX0bRN1uQ3w/mlBKqD7PNAMk/kF/fEPdy6xBwH+vXk3P9FRptvgDPh+omlMXHGVN/9vKLGwafiTMfsEEsovmAzmWWzpyPJ9ygOrKaEk+mhirouNG/DmA+CLWez5Y6KLPOoxAJ6DnOCs9So2aPL4Uo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782911583; c=relaxed/simple;
	bh=3yepFYZGWP7OCDCU1WhwbZCJftBue5NPWyqGLDZgBcI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nDlnLOPQbiQvAd9jzZLypsTn7hlMOGpVUkKdsCX2bBmiNpDf2SILofbBO42W2tTM1MmoJc6smTxUJdIyiarR1h+e1BsMs7Dgwx8Rc52cLqlx/+HJr05MXyE8yPKqppvyTywJXJmwIL8ijNgJVX/LDFEuRbWLitISuDDorSI0LGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=HtHvrBjE; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="HtHvrBjE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=vitzn9qdLoqkMt
	nHkttu4JwWU5DXcRVqxYSkJlcdvO8=; b=HtHvrBjEXkDcop8cACubCuhnhT+Bgq
	tBIna+QnVpAAi97qFkpFay3FLsrPQdbPG/X6Ul9vNneVeGF3UZqTnuizonS/vu/n
	xtAi+BBdEYlTN9vvFTKptN9wRNj+/MyDfA+suWAI4xNLWE5msgHPnujaHXp0y6MA
	wPGGJHupZrp67NTsukn6uI77yG0NUN3nbi2jfWXq7/JWSQnssox4CQ43qnOkQvEK
	y6T49qVMrW4ghOAoImHsy3ICDn+EJ/r8gROZm0Eg3hjsqQ0tcWi7VhhFiRDTmxwW
	r0d+mwZ7mFKYc/dq7J8cF+Clr4/HvTE63H9/TPXMX4QZVw3QO4QcXXPA==
Received: (qmail 712996 invoked from network); 1 Jul 2026 15:12:57 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Jul 2026 15:12:57 +0200
X-UD-Smtp-Session: l3s3148p1@Yboxc4xVVKxUhsc0
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-spi@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v5 0/2] spi: dt-bindings: snps,dw-apb-ssi: updates for RZ/N1D
Date: Wed,  1 Jul 2026 15:12:48 +0200
Message-ID: <20260701131248.4545-4-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the actual DT additions are in -next now, here are the remaining
DT binding updates for the Renesas RZ/N1D SoC. Changes since v4 are
described in the individual patches.

A branch is here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/n1d/enablement

Wolfram Sang (2):
  spi: dt-bindings: snps,dw-apb-ssi: drop duplicated RZ/N1 entry
  spi: dt-bindings: snps,dw-apb-ssi: add 'power-domains' property

 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.51.0

