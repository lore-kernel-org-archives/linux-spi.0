Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794808527;
	b=5rMXZ4LRPllpFjsbkmnDmLJq7Phe/8dW6l2dzxSqM1q6FpP7kZa7a2lauUCKJeZP8R+M
	 jwjeuaZLsaGdWzcR+jXg0N1XuNY6RtDR678WyzK6h5iCKNnGS34LBSuns6alLQrEzkm8+
	 W9SgSEQAR6ZRSVbsCDfbpFwSp5Aa2NMC6sHQI9amnyLo1uuY7Qoq68AjpTNqzlhpEp6E/
	 l8b0UpBRKLSEFBeRBm0QJ65VVQ+NwK0SXYcsvBhE+2Un9KMQQKlzz3WCZytSn11L9LIJ4
	 OpXjisccRiOmH//QQlsK/9OK2QzrpdhWXpQoz7paw8RGAtlS1bHqZ/5Km1SKbcZKyoQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808527;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DHaice+Ti0PzU+k5QwVlqcyysO8IwelYCih66aFmNyQ=;
	b=XOhRQcGoNomndmcpmHJFqFj4q839+Nuggk9Mx6ygomTTO1IWOZVXV8vkltgXiYWXS5g1
	 u6QL0vuZo3lC3kBc8JZFW+AOKs1Rn5zQQvj8C3GH+WJjsehScGYQoOroWK5C9hDg8+E4G
	 uObSwO7OQ7nqUGNtazgz424v9DVfChcscFhGQpHPGJtsBRs9jjh8221PDS9HK+gi8AOjN
	 UkYXqxbVtDeE8Azqcu+94tji5WpoBzZsQ07xQgS586mDZ9D/z5srdNnf/7bArWe8OKNj9
	 hl5WW4WijYdypL9Ar5NhgGT6GghfFhJj0CWawdv9wBGQX7k/7QxOGYKHQp0ihnGEbVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXmWvjsc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB70606A31C;
	Mon, 16 Nov 2026 05:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MXmWvjsc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794808526;
	b=qcKHtJn/1EX9mHC16gV2qxiTnH/MXxYdZA4JiekQYMXhpjmAf0JbmP4nUd20rlOrP5o6
	 qrOpeKPr17AFa2QOLN5fQOa9yXkuzlwB6qld7NGOm+Yz9YoYSTb0bbrBu0sMFeAcuJxLz
	 qJaE6fsSMJuuTcNCUVpByqJ1nc5hxfml2ucCYnATHzb/6l5D3rrorlNl/5FZSXDIMMQxE
	 kF2KzfKAQvW7TlrUn2wSXomGikwQRCQR9Z4MpNWUvl+vVBsxIoAKWhX3doZySKwk9OUG9
	 uXUdrbQK3SBlufMzyaUPGhKEfL4lkXcVCxwD07RwCwY3ws8hDVO8OXHn9W0YQB+UT3Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794808526;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DHaice+Ti0PzU+k5QwVlqcyysO8IwelYCih66aFmNyQ=;
	b=m3BSxy5gxNk1ax5I5HiRJ3efae11czCLU7FHGVHLMP5077aSmQUjM6U9YB3r2tS8OTVJ
	 /wBaMmi/kethX9URAUjzbdYE1PUUUiUr4hrVR+1QMVgP6e8toESpEldjl4KleVeygP/kl
	 OjU/vRP1+w8NSL0cVtz8HicjlnOZhSsE7Sj89cZzUBqjTkUE7VeHIANgb5X6uGBRGkX3H
	 Xn0LpTEyrgoc8ypswCaONtAGoTLR5GI9XGu0eRdlmQcbeLGaU5zbiW5Wdfnwefk/khHQm
	 6QfXFeqb9dH3kdA77yApJ12Iz/ibTXrB/ojsoawrW2Ld02qFBfNwfy7h1fDNqyRtn3A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EDA7C1F000C5;
	Mon, 16 Nov 2026 05:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794808526;
	bh=DHaice+Ti0PzU+k5QwVlqcyysO8IwelYCih66aFmNyQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=MXmWvjsch/N61Bche8WqkZvQqF8C4SXdCcEb0kpbQrYlp8HO4ZL7wOrcWLUmPQIbx
	 WL/G0bJzUp5sW56VUObbZxdHIakkSaOXVy53vBvmYfoPw5QIgYGg7H37Zu8NXgDQzB
	 Yn4lDn26vAIABjxTfipukXFmlUxIGtSBbJBp6yrMrlqgdJjcjJJxdq1YMURSeIktn7
	 EcVnIsQDXS6ZDZjed9++AaeBCKM51Mpx09N1mDr3/OVpE8yw+W+zcpIqG1UoC7FnLT
	 llsU1nuHQnA952fr76mZrKc0OM2FrtP8BLowye0ASqrIIvNNhMNlVh/lTKSJXLfj+s
	 T3NI5lYT4qmww==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 69AE24A318;
	Mon, 16 Nov 2026 05:55:25 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Mon, 16 Nov 2026 05:55:25 +0000
Subject: [PATCH v2 1/2] spi: dt-bindings: sun6i: Allow Dual SPI and Quad
 SPI for the H616
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
Message-Id: <20261116-spi-sun6i-h616-dual-read-v2-1-e0c66eb71e20@gmail.com>
References: <20261116-spi-sun6i-h616-dual-read-v2-0-e0c66eb71e20@gmail.com>
In-Reply-To: <20261116-spi-sun6i-h616-dual-read-v2-0-e0c66eb71e20@gmail.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Arun Iyengar <aiyengar1990@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794808525; l=1092;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=J5fWkwwhvbIRdi/tKkf4w+0nyQr1DVDQbXeDAzQuqPQ=;
 b=svyeGoIzmzcktMV1ZQt0EBtPZ6VDtsuLr/LDWTdESX9RzfCqsv0ugB5a52NxpTCv0RN59pdrH
 kdVg5xaYFd5DVGcPPYnBEvgqoHqeay4U895LmnUpQLlsnD5UdBf0pjG
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

The H616 SPI controllers support dual and quad transfers (H616 user
manual, SPI_BCC DRM and Quad_EN bits; only SPI0 has the WP/HOLD pins
for quad). Allow them, as commit 743956bb9990 ("spi: dt-bindings:
sun6i: Allow Dual SPI and Quad SPI for newer SoCs") did for the R329
and A523. The H616 keeps the H3 fallback.

Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
index 14c2f318dd04..116c5868415a 100644
--- a/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/allwinner,sun6i-a31-spi.yaml
@@ -106,6 +106,7 @@ allOf:
           compatible:
             contains:
               enum:
+                - allwinner,sun50i-h616-spi
                 - allwinner,sun50i-r329-spi
                 - allwinner,sun55i-a523-spi
     then:

-- 
2.55.0


