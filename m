Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794618318;
	b=zNI5BgpqolIuEcnbiX+iHmZQCsitbhe8EJBzkZ/p9vYLHhx+dOSXTzwdSZVkiq29KVZO
	 FKuJHSDOWj5q3aqLsC6OprpqerME5fRM10Q609Up1IrLiO/4rLvwSTEtaxF4UxflLlHIa
	 F+e1v5o4PT61MRBDbJt6KTyWr9xjAhUfb9aMU2vtIsBA5bBfSegxlmxVySK6/K3qq9rV/
	 DYZ1x7QM9BWcXxORgPt7si8TVpGZDHKu7kNK7tr0Y/JPHuH3W7l36FpP4YzWvUbJ1x6cO
	 h3aVIqsclFFpISptvAtSdW8tD0Zgemhws3+Yui6+tlOe46VtsiownROnujnxOwZkAAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794618318;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Eg1aWZgHvhHXiees9Lk2jDCP70jKX8ALjN7+QJls73Y=;
	b=1wtD7VziKa/QnjeSwBX2efjVHUkRGZN2aMBsQv7/Zj7gcPZHYweUdv6+xxwV0PFi5lF1
	 AKG2M1QOPiQ3Ljn41rOeQAcydvb9E/RL+UZFpEaA5Nq1k2xHPT10yN/EH+dMwkcHbaRNW
	 VaDSf8vzZJuS8g7HXeO/2t3qYTZhwQcMOj40v5677eGe0BnKPFoH2KvapB73zwzImf4tG
	 2UNQKYpfqh8ed9fy5JQBToVjmHKDf5vzZAf3t40ZhwdJ9mc9z2D8OGe3i5GB82kH+OW97
	 8+Y0hdDvO8m2h2uJ28l5X6wXPEYFL9qx2k14FdxoDkYWlVaAwUlEqSzIoRMKnyUPELA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=wI5jNPdm;
	arc=none smtp.remote-ip=203.205.221.192
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA58606A32D;
	Sat, 14 Nov 2026 01:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECA58606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=wI5jNPdm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794618307; bh=Eg1aWZgHvhHXiees9Lk2jDCP70jKX8ALjN7+QJls73Y=;
	h=From:To:Cc:Subject:Date;
	b=wI5jNPdmWIkNmLo2oIa8g4NmR1hS9q2f99kar2pFfrKbUdL+DAKBn2O1LUJJbe/Kd
	 20Ez/IpgVHaM9atVhCINn3W78NW5Iur2N0/VLQ0lnjqSrM7sQcoRFWUBXEVrhrzfDg
	 eAGkPZJ8BH32qAHfHoPO/iUcAlcljGw3Z8IuEsdU=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.199])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 14537450; Sat, 14 Nov 2026 09:05:05 +0800
X-QQ-mid: xmsmtpt1794618305t09ygcrex
Message-ID: <tencent_5FBF490F375F4C66A2C8DD421A8E8542FE05@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XbXZ2D+oNSNEDFiFEBNtznPWKIx1ZWVpKJrivKl0LSRXCHyk1VB
	 pk33VVrkhL5ua1yOnw3ZuhdxLSA7WyuejaXnkI+iUn7rhLvro6OnoHdwXk0WDhTGTduUDMtLwxp0
	 o/vHBCcFhEwTMlodL+XsvFzQVq8Q1VL9cY9urKg2YHAgNrAtv7yawKDT3vce4hzhP+5zLUwQwHrH
	 ABZ8KeyLMMKR4br1sWWWOXa8KG7I0qJatqCaDpDLRuOaHu2l7k/xOqA6fB79X21scLURSz7se/6I
	 1BmSxhdu0dwIG1PrNPXyOCawjLBNcaf3PHX5Z9myyWZgWWtL19j0CJ7SnHh4MzfA3HiLPp9HfGRx
	 Dzm1I71arlDqol3MM0PtBjo4rioE+lffjKmebEFNH3gwStp9QZ2Uquqg3hPb3x2enqfBeJ02tyzz
	 Ze3qrWJBzTYvwi6fzJRB7cauYEoNhCHCesIey9GAx2Vs89tsHsVpJFxGrHMpUqoRdNthLMrlcdeX
	 mZfJgIhhOSDtknuq9el470VoGXrrL6nSUkuxh67OWtC+o4Cd+pX7iJVG4pl8RlQneQQhjrEG6REw
	 caKwmloI0pxfoIFQS4cBbAP4tC4vPUmkWO1gUNOYBSaxoPKLQ3CWyc2gbEm/PjVh+mBry12jdUYT
	 q1S+dF7JQ91r5HRBIIpTX2n4x6rSD1RlhdC9yGIExlli3HsfKH/p4cuaR1VLidx13AqKUkSBrMQU
	 pHq+cFwpLlfu1RpWzR2mN8hFY0ajbH6pft1hL5nn1JqhRX0424t+i1GxbKYJqkXWddhVRtgQJYI9
	 ox9NW6qemPDbjUUAiStRhMWStlZet7tre4YXVmFkNLpNkvte7rO/hhyM+RnpZWgO7wF3sD/fhoEL
	 r+VjJsaFGMU12eAJF0506kvVPVDj5m9UV3VS8EZjHMKlIx4tmLbLpYv43XQ3QOG/qoQAIl8oHisB
	 UXtXVHoqkjf4w03jv8OSjMcIi4F3mKTzfPo9sRl5eX/39pdE3YY+tu2Uk3ZOhjtirZRInHLEom7N
	 OrD6zasPq3M8ek8WCbwcupH6QzA5pLMLu/OW4xv8OJInYAFpEIAw2B2hpT18J+GgCajwfi5g==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	847807867@qq.com
Subject: [PATCH v8 0/3] rust: spi: add SPI driver abstractions
Date: Sat, 14 Nov 2026 09:05:04 +0800
X-OQ-MSGID: <20261114010505.81436-1-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Rust abstractions for the SPI driver subsystem, allowing SPI
drivers to be written in Rust.

Changes in v8:
- Rebase onto linux-next (next-20261113); the v7 patches no longer
  applied, per Mark Brown's review.
- Send as a fresh thread rather than as a reply to the previous series,
  per Mark Brown's review.

Changes in v7:
- Rework device I/O around a `transfer()` primitive that maps onto
  spi_sync(), per Mark Brown's review.
- Drop the spi_write()/spi_read() helpers; add
  spi_message_init()/spi_message_add_tail() helpers instead.

Shuai Liu (3):
  rust: helpers: add SPI helpers
  rust: spi: add SPI driver abstractions
  samples: rust: add SPI driver sample

 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/spi.c              |  26 ++
 rust/kernel/Kconfig.test        |  11 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/spi.rs              | 673 ++++++++++++++++++++++++++++++++
 samples/rust/Kconfig            |  11 +
 samples/rust/Makefile           |   1 +
 samples/rust/rust_driver_spi.rs |  66 ++++
 9 files changed, 792 insertions(+)
 create mode 100644 rust/helpers/spi.c
 create mode 100644 rust/kernel/spi.rs
 create mode 100644 samples/rust/rust_driver_spi.rs


Base-commit: 84abb955b1015f216d794566ed3c4fdd4bbd0f14
-- 
2.43.0

