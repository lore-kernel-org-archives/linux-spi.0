Received: from mta0.migadu.com (out-152.mta0.migadu.com [91.218.175.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4091248BD3B
	for <linux-spi@vger.kernel.org>; Wed, 16 Sep 2026 21:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789593882; cv=none; b=JVZTrTa3ropV079hqunZiaXHQ7SqioU/xCMySlnXCfbFty7FamvyU87kOPTsKLYIzq0SJcP2NLjLyyklnbOQCb27LbWtnEcUT08cxS01uOdjFcKIhYLp/t7zlCKpRDbfJA/KHclj9ikD1bjrrC1y4UxKLrVtu7JrxZmpcA6P0H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789593882; c=relaxed/simple;
	bh=Xs5HmIVrttwINsKb630tCSQ/nEHmOYxb9Ym6t3UCmkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSX/ynj76MADaY8yimGdG7VG/7rWzOjbNur9TG0XCEDdjtjTRTXO/dUwMW6vKANObr3WXS2Rbge2cx3JRZHhFC7hySHrOI/imvH8yAaslEnbMe34PDR96HGpaB7rkMu8kXxdaf0LaGba5i2JweetZdAyWCHLAyCL5abQWCzpvwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jimenezcarrero.com; spf=pass smtp.mailfrom=jimenezcarrero.com; dkim=pass (2048-bit key) header.d=jimenezcarrero.com header.i=@jimenezcarrero.com header.b=pEgeZtJ+; arc=none smtp.client-ip=91.218.175.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=jimenezcarrero.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jimenezcarrero.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jimenezcarrero.com header.i=@jimenezcarrero.com header.b="pEgeZtJ+"
X-Envelope-To: linux-spi@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Xs5HmIVrttwINsKb630tCSQ/nEHmOYxb9Ym6t3UCmkc=;
 c=simple/simple; d=jimenezcarrero.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789593867; v=1; x=1790198667;
 b=pEgeZtJ++qsCjNMTNLPZK8qZylaJ0iztpawzkDFqEEKlXPzVaz058lSpgvNUz6ffy4xPaGwU
 8Zy4G78hoPEMQJLdk9EwPesjc8H1979EVDcYOnivD5a06fV2JfFwlsNiwE/GRWw13unu2qDQEfw
 YH6xCOj9EVXSGYebioC9bFW3y5tPJe4o6OpLCUuEEgBHfWjIfS07z44eVYHNBDqsCwueY2KzF4i
 YbNaqaz5Dh+mr+7dkVrKzexyhCVsJddH5tT2c/v1BseSwPxnjA5V7VOhxsoVhva3Af4TsmKgwWs
 GPBy6bNf8DoyL/8Y9nxvqBcCbtFg4wXDsWdPo0vcBwZVg==
X-Envelope-To: linux-spi@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bde3667cbddf0f0b;
	Wed, 16 Sep 2026 21:24:27 +0000
X-Mizu-Trace-ID: bde3667cbddf0f0b
X-Migadu-Flow: FLOW_OUT
From: Juan Jimenez Carrero <juan@jimenezcarrero.com>
To: khalilst@gmail.com
Cc: khalil@rentman.nl,
	rf@opensource.cirrus.com,
	broonie@kernel.org,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	patches@opensource.cirrus.com,
	linux-spi@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	daniel@zonque.org,
	haojian.zhuang@gmail.com,
	robert.jarzmik@free.fr
Subject: Re: [PATCH v3 2/3] platform/x86: serial-multi-instantiate: Fix SPI chip select on platforms with incomplete ACPI cs-gpios
Date: Wed, 16 Sep 2026 23:24:09 +0200
Message-ID: <20260916212409.7255-1-juan@jimenezcarrero.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901192625.1497791-3-khalil@rentman.nl>
References: <20260901192625.1497791-3-khalil@rentman.nl>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 1 Sep 2026 21:26:24 +0200, Khalil wrote:
> Some HP laptops with Intel Lunar Lake and dual Cirrus Logic CS35L56

Tested on an HP EliteBook 8 G1i 14 inch (DMI board 8D8A) with 2x
CS35L54, together with 3/3 and without 1/3. Details in my reply to the
cover letter.

Tested-by: Juan Jimenez Carrero <juan@jimenezcarrero.com>
