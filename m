Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5241C3DF015
	for <linux-spi@vger.kernel.org>; Wed, 11 Mar 2026 12:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232066; cv=none; b=Ai+GccKoq5ZPH+p0R2I1oYM51SlBULkyyPuFMJ5BVRBrjs612HB/vIgRveiuKpPVYujG9u/HObpXYr4To5C7DZsfLmpRNSaIX4CUr+bwBFtCK5iKSDVu0F3cGm4Y3FhMcFDSpOU+gn47BZlGZKaWmPjiRVLM/sA3+wdEenKBuqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232066; c=relaxed/simple;
	bh=mfhkxsjmBeSJ4HS58+gXzwez8JwxInYbuUEkE7wBk48=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k/03bzBZIBywhFUxF2FeMag6wX6yQemTQICAQXVZTy+EbYDr/mTi34KnGWTnMe8A01bswIi6+fIdDEhkio33lt+ZcyiSqRRuSFtdIEQnEB0dAXiYA3HJlfmkyomTNU5QBoqB9mKk5WBWC70hFVqsIpmuVhQeAKGpiubwji9NzJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1w0Iez-0002PX-Rt; Wed, 11 Mar 2026 13:27:33 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Wed, 11 Mar 2026 13:27:01 +0100
Subject: [PATCH v2 1/2] led: lp5860: expose fault state via sysfs
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260311-v6-19-topic-ti-lp5860-fault-v2-1-f9454910f009@pengutronix.de>
References: <20260311-v6-19-topic-ti-lp5860-fault-v2-0-f9454910f009@pengutronix.de>
In-Reply-To: <20260311-v6-19-topic-ti-lp5860-fault-v2-0-f9454910f009@pengutronix.de>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
 Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
X-Mailer: b4 0.14.3
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-spi@vger.kernel.org

Return the fault state to the userspase via sysfs and allow to reset it.

The LP5860 has a global fault state, that just indicates that a short or
open fault was detected on any LED. This is exposed via 'fault_state'.

The 'fault_state_open' exposes the LED name and channel where an open
condition was detected.

The 'fault_state_short' exposes the LED name and channel where a short
condition was detected.

To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 Documentation/ABI/testing/sysfs-class-spi-lp5860 | 49 ++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-spi-lp5860 b/Documentation/ABI/testing/sysfs-class-spi-lp5860
new file mode 100644
index 0000000000000..31082bd78f51e
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-class-spi-lp5860
@@ -0,0 +1,49 @@
+What:           /sys/class/spi_master/spi<bus>/spi<bus>.<dev>/fault_state
+Date:           March 2026
+KernelVersion:  7.0
+Contact:        Steffen Trumtrar <kernel@pengutronix.de>
+Description:
+	Contains and sets the global fault state:
+
+	* 3: Open and short detected
+	* 2: Open detected
+	* 1: Short detected
+
+	Can be cleared by writing the corresponding value back to fault_state.
+
+	Example usage::
+
+		## Read
+		# cat /sys/class/spi_master/spi<bus>/spi<bus>.<dev>/fault_state
+		2
+
+		## Write
+		# echo 2 > /sys/class/spi_master/spi<bus>/spi<bus>.<dev>/fault_state
+
+What:           /sys/class/spi_master/spi<bus>/spi<bus>.<dev>/fault_state_open
+Date:           March 2026
+KernelVersion:  7.0
+Contact:        Steffen Trumtrar <kernel@pengutronix.de>
+Description:
+	Contains all LEDs and channels where an open condition was detected.
+	The format is ledname:channel.
+
+	Example usage::
+
+		## Read
+		# cat /sys/class/spi_master/spi<bus>/spi<bus>.<dev>/fault_state_open
+		rgb1:0 rgb2:4
+
+What:           /sys/class/spi_master/spi<bus>/spi<bus>.<dev>/fault_state_short
+Date:           March 2026
+KernelVersion:  7.0
+Contact:        Steffen Trumtrar <kernel@pengutronix.de>
+Description:
+	Contains all LEDs and channels where a short condition was detected.
+	The format is ledname:channel.
+
+	Example usage::
+
+		## Read
+		# cat /sys/class/spi_master/spi<bus>/spi<bus>.<dev>/fault_state_short
+		rgb1:0 rgb2:4

-- 
2.51.0

