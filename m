Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8F228A3F8;
	Fri, 10 Apr 2026 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775810077; cv=none; b=Noj1i7eWqDMsvboFyRBrpjLFbclsT8kG7qUBcOOZ69oaSCAwvPzwW6t/WxXahqufxXX/CzP35enuGchfF0AXvsiAg4xXhvuN6Ar2WGV4jCHiwwKH//9VwhaMhcFhskI9UdeV08i3BjlvXKCG7qddAqWFaAdV8GwaB2M/smDQI6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775810077; c=relaxed/simple;
	bh=HnWWKCqau30WsF6PM5/l0MvsbWjZClippP0FuQZbhfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0rLPchKWIDmlhNGQqtqlCFY78VxMkQCULQYnssni1m1s6WNaPVqW8F6ntwBF50m8c3gC3GYoMFzTjhLoPQZLdggi4IrnVXWAQz37ShlBTdxwZvysWIkIxkICb1fAPk/UTO/v+q+PDA9mrWmAXrjcNEhmxYm6LHUGMeIAI7n0X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1nLeGqm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1nLeGqm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A42EC19424;
	Fri, 10 Apr 2026 08:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775810077;
	bh=HnWWKCqau30WsF6PM5/l0MvsbWjZClippP0FuQZbhfo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D1nLeGqmYdlENfLs7aN7GMx1EXGXPpsG1FeQUz4Xnz+nqJC40lRDF4gzScCqmVizs
	 5Bw6yfObOCaKSiPuD2y57XvWaeOEPOi9ja/S3ge67jAizv4ZMv82qWB1quv7hm0X7a
	 tjJteCDUf+UqgOBUpE70BGHIQQKvGktH8ZIEYyJQ69BvQUr4Y3jTg56eKw7HAHpU0D
	 KGwf/uJdqHifuz6hETVLKyeNz6r+uFtG+h7PuSvWWbPNCMAxIVmdOx8GCNbtDb7RWI
	 lAFcQfIZ7pEHxBqufXe2XRrMTTeBNCnbPhKsvEvjY1eimVya0gSiRUJwlQk4AQFMhB
	 JkhhOPcgUjy/g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wB7Jz-000000027Ig-0Dac;
	Fri, 10 Apr 2026 10:34:35 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Masahisa Kojima <kojima.masahisa@socionext.com>,
	Jassi Brar <jassisinghbrar@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] MAINTAINERS: update second Socionext SPI maintainer address
Date: Fri, 10 Apr 2026 10:34:23 +0200
Message-ID: <20260410083423.504695-3-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260410083423.504695-1-johan@kernel.org>
References: <20260410083423.504695-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Linaro address is bouncing so switch to Jassi's gmail address also
found in MAINTAINERS.

Cc: Jassi Brar <jassisinghbrar@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e22dcbeb7132..8e829c4b7801 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24466,7 +24466,7 @@ F:	drivers/net/ethernet/socionext/netsec.c
 
 SOCIONEXT (SNI) Synquacer SPI DRIVER
 M:	Masahisa Kojima <kojima.masahisa@socionext.com>
-M:	Jassi Brar <jaswinder.singh@linaro.org>
+M:	Jassi Brar <jassisinghbrar@gmail.com>
 L:	linux-spi@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/spi/socionext,synquacer-spi.yaml
-- 
2.52.0

