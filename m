Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DFC480DF5;
	Thu, 24 Sep 2026 13:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257452; cv=pass; b=EDvsAf/Qi+Vrxg9Ce+CLD0ILuDP2m+lFFoTBe/bKWmRPb3IU8ro7pV6AeYX2HVO8FsqK7xTeV/JuXiU7d20NhZ030AWsPHc0Lbjit7iv8bsPV3AErdrTm0VkQXAfY13gFW6E/PfOdU0btfQ2uMtjtYAkb1ui+gt4box1eqTQZBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257452; c=relaxed/simple;
	bh=chUZ4H9gzohN8TLTDzyvec0pQbdQdjb/qaJ9OiRTHo4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aTzmwh/9FZEK406rOqVV36bdcQ/9jGUjI55zBYpQHrmP0TRjKGFiYDwxplbK1ur3seRdyVQGVLiAwkUqlB7089TRTwu4DxWQ6k0c1WoHrf0myZ19BYEJNkymAsN8Seo4dX6SlvNp1VmFgLOeBRLHmNjKMxF+jbiMd9O69DnT0ss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=RwVdj+6W; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="RwVdj+6W"
Received: from dude04.red.stw.pengutronix.de (dude04.red.stw.pengutronix.de [IPv6:2a0a:edc0:0:1101:1d::ac])
	(Authenticated sender: relay-from-dude04.red.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id BB7C920211C;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZySE/8lMcr5V7XmjatX6PTkFNjPZl8xDRvgIr/SfiA=;
	b=RwVdj+6W2hBpI2iZmdup377vMNVe2jBav3hX2SiuzT+biAjRqtTjzyqREm0KB7vFXQNXLF
	SfDVoMwhYfAXXWPb8ma0Gwig/jkzM14dkkD1zgzRL2pw49SGOvaqaKP8RVDik8U9dRNDAp
	4qPsIwM1ushqkobntSI5suVCS1URZiPREAQHtH7zXQibeNEkNS4EuLtERrgr6W90SWFqZO
	/W1V3y7qQeuVqF6cHJCDZnJ/sXtDaHwdmtMUrK4+CMrLJZpxVoMcs6CNy/5Rrklt11IWe3
	1BJhTEo1K/6i7u8G9HTWdcDdRHnLk72gF7gLjLJ3wnS0b1OyBamt/+rkFF9CwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790257447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TZySE/8lMcr5V7XmjatX6PTkFNjPZl8xDRvgIr/SfiA=;
	b=c+H9VSdQaM6J//BTL6wa7FqrbjxhmtOWADnfrV8sAOoj3rXEdZ1x+kdeZOOuNPgg+pYP/X
	rwZk4slI3rUFqJdXMq6W4U5gAWgHTJ+FUpOJdNMSyKEgouUp0TJ0lIEGd+qwB/NiyM5X2j
	2ZkNXlJywxM9PhJjb5TAwwbjhHM7szXkkTG1hWZW0wzpJkBffxptRILd6gBCdVxlcIe0TV
	Gr7/bhlmjmHshQwMaWGEtWSWH7DswIfVXR94a6/hlfs2LHXXtVqG9N/zZ9qiPFrn+AcMnj
	6qTxFb1JjFYMvM8sho3LyuZq5H8ZVWDyy4ZpUiacsnVQaZ0rhQ1u7jly76Ggpg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790257447; a=rsa-sha256;
	cv=none;
	b=a8D179TcHebeaq/sdtGRhmLxV8Ff9GcniXbD2EOLbl28eqXAHc/G9zrFw3TEaTbJErCUQV
	mlVS6SusrlgIw7bZudf3cBzySxhr/Wpl0pkgfo5q4ALRG9mbS6a5RwxcA9Df1ODpTdSEoi
	lcebnHefbRyz9btxvOBa1e4WrXSlM7U0Kb16rpVA2VRsuRakyf/jaluQMU2NhvT/pfMznO
	zxSxH+QFWlJhThC3LTG+nE4L4AhZQHZ0pTdgWeX+kgtozndyvhLwhcglPYPHMetktsohXx
	mVc0lHml+WRzeeUSrODtU//QCJYjravSKkaQbuSla1sbe9Blf2K4qvq9L7tklA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-dude04.red.stw.pengutronix.de smtp.mailfrom=jre@pengutronix.de
Received: from dude04.red.stw.pengutronix.de (localhost [IPv6:::1])
	by dude04.red.stw.pengutronix.de (Postfix) with ESMTP id 94B19380371;
	Thu, 24 Sep 2026 15:44:07 +0200 (CEST)
From: Jonas Rebmann <jre@pengutronix.de>
Date: Thu, 24 Sep 2026 15:43:53 +0200
Subject: [PATCH v7 03/13] spi: spidev_test: make size argument mandatory
 for --size
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-spi-sun4i-spidev_test-v7-3-126e31a07fdc@pengutronix.de>
References: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
In-Reply-To: <20260924-spi-sun4i-spidev_test-v7-0-126e31a07fdc@pengutronix.de>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, kernel@pengutronix.de, 
 Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1707; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=chUZ4H9gzohN8TLTDzyvec0pQbdQdjb/qaJ9OiRTHo4=;
 b=owGbwMvMwCV2ZcYT3onnbjcwnlZLYsjaqqmUb/7TO4TtDHvu4SkeFxQ3xC9Tze14Gd55f/W3K
 +uyIrYs7yhlYRDjYpAVU2SJVZNTEDL2v25WaRcLM4eVCWQIAxenAExkxXpGhu3rNI6t0lXe8u7w
 SaspNrUvJJiO31u28ZSe6HxGXb6TsmsZfjEtUNy4cN3x63MUKjfFnlF8VaU694+ynDj7x/TZ2W7
 rWxgB
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5

When the argument to --size is omitted, abort with a message instead of
transmitting default_tx[].

Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
 tools/spi/spidev_test.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/spi/spidev_test.c b/tools/spi/spidev_test.c
index 0bd6ae419cbf..36292d868d69 100644
--- a/tools/spi/spidev_test.c
+++ b/tools/spi/spidev_test.c
@@ -41,9 +41,10 @@ static uint32_t speed = 500000;
 static uint16_t delay;
 static uint16_t word_delay;
 static int verbose;
-static int transfer_size;
+static int transfer_size = -1;
 static int iterations;
 static int interval = 5; /* interval in seconds for showing transfer rate */
+static int random_input;
 static int input_choices;
 
 static uint8_t default_tx[] = {
@@ -319,6 +320,7 @@ static void parse_opts(int argc, char *argv[])
 			break;
 		case 'S':
 			transfer_size = atoi(optarg);
+			random_input = 1;
 			input_choices++;
 			break;
 		case 'I':
@@ -454,6 +456,9 @@ int main(int argc, char *argv[])
 		pabort("at most one of -S (--size), -p, -i (--input) may be selected, "
 		       "and each may be specified only once");
 
+	if (random_input && transfer_size < 0)
+		pabort("a size argument is mandatory for -S (--size)");
+
 	fd = open(device, O_RDWR);
 	if (fd < 0)
 		pabort("can't open device");
@@ -509,7 +514,7 @@ int main(int argc, char *argv[])
 		transfer_escaped_string(fd, input_tx);
 	else if (input_file)
 		transfer_file(fd, input_file);
-	else if (transfer_size) {
+	else if (transfer_size >= 0) {
 		struct timespec last_stat;
 
 		clock_gettime(CLOCK_MONOTONIC, &last_stat);

-- 
2.56.0.rc0.108.gf0ef1b96a0

