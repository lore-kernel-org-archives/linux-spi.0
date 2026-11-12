Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466203;
	b=JeUlws2mgtQudtEsNci39nGoplFE3MNAWMoYaY/GF7uQoAg1PR7c/SIbDKZISvQ65abj
	 l9lsg5OHh7Q1uPwmnWJC9Vcwazm8dpXwMtIddfK44IkneyQeDlxFt48MD0PhsDgGeaser
	 l56tzVr+D9Vgfbb++/AE+haVdtKP30UZRr3vHYU/aMJkuTOfVbQK+hnU/thuFSgfQZ89W
	 BxgO1sql3Do9/mAaQ16f36g5JA5GqIWkwNljY0ZPWFfQA5q5qYKUby21FsYrWXPMj6dUD
	 9glg0NTR5GH+fTLltbYPqkTkNEUor92VW3fk5d1Qwfr7aCpTPnCtR0NP6LAm8t9DbGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466203;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=h1v3GwTQW47LQ5TJOhvyv2Mw5v+tziCrMDZBrKab9Q0=;
	b=JDjVQXl0h9mgy9ZRxXDssd/CHUTdGPDAbOENcgqhatqUGnZmMqVCsmbvQlrjnJNj0GCz
	 Yqcz66RavI3jhwgka7sszWf1n867nXpZH72Xy+N6igwLtyodgBuAE/Aw+xNoH9a6bsdBJ
	 IvBWOTKXZUnxXDyt/bqicGC/2cVpcirvYHBH7iY6wQcBvNwmMD5o9TtUaObTfR6cRIVbu
	 sP28ZnhvbGDMnplGtSWgFltGPQAJoAz3mHOo0gnZygSs8m1Kt3iMejG1chfYiYco4CPa7
	 cNb6JGPbzNicQi9pbfj/X0LUJyJDg16bWrcGsTr0UYH0XCnhJQWbODdrESCpwr7wVfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e4DC2Jg1;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8103B606A886
	for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 06:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8103B606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e4DC2Jg1
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so7177769eec.0
        for <linux-spi@vger.kernel.org>; Wed, 11 Nov 2026 22:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466203; x=1795071003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h1v3GwTQW47LQ5TJOhvyv2Mw5v+tziCrMDZBrKab9Q0=;
        b=e4DC2Jg1DGduI4t0xDJwc64Byyii//Fx6ciVlfdglJcqMUA841Oj3nOl8HyZASERwt
         DNTMeTpKk4g5v82wQZt3M0dIqMs9ty+rKOK7nyIcIz8hFLyNOSx69MjkeXBemrllxKp1
         A7hqhgRP/mpIvT4XjdeUSIaC1rwzdCbPfYndsWGPfLJiw83XBK7EFoc1g9+kKPL4+u1f
         +E9dVlWhQOqQMHnpc+71MUmQo7zMI5tX25K/yx07SB5NfVShc6A+a8GjshuM66RooyKH
         sVo6sxPhebfNQ/Q1HeWO1i9JUHAF3jP2oAe7eJpJvxlKAISt+yk8Xw3bY5cd3ipgZpdT
         LUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466203; x=1795071003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h1v3GwTQW47LQ5TJOhvyv2Mw5v+tziCrMDZBrKab9Q0=;
        b=xmTc+S913R7xCGwVp14DIpuscSVINb2xNJb+NuRWf6orSpffBOPvxc/UCyAjlOh4e1
         BnFUMim+BImvDF2hDGEvijF/t7QmuEHlAtjEKVt6dmOFf1GCuwoZib0+coZZLl9742Aa
         bfftJJxuDkZwSYoASDFhg6HjO8wKn195qso3J/VNqTSewBMGSMfT757rfP4P0S44o3MC
         6HOAAljlmUfM+E1CcQYgch81ecF8oM4AArfiKuLG9dbUVYxnBGrI3k1ceGTQLcvm1gXc
         E9fYlqgJUkw3peVCnXGdeYDGO5Q7ENcJgdt70KUPiZc6Tb2AfeSUfpK6aEKv+6Cg45Ea
         90Eg==
X-Forwarded-Encrypted: i=1; AL+hErHLPQ/1HfllaTLQPjNNcBfwkSda0dQZSRKg7dIgdDDW4Re1R2vgcz9Vdx2jX7NCuCGyyLbOlP/IxIA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9//zMqlgK/JOjnmqmVxQ0w0CIPhA6Z2ddZtV9f4BdLWsY4ZMzr
	mEMijLt0NR93WmbdWNYdTp4RINDlzpgUbzmAm0QdYMpmiadXHNBWeQPH
X-Gm-Gg: AYBFou2i0p8def9Zuo0VUz7Mxea1HFB5kZoasV70n/vP5IKz9UuTGiAMgONt521j3Uv
	UjQzNJO+mTFgvZ5dIBujzC2b1nSgF2ZGzP3VMZyT3eq9vWYyvzPp1JRYKvRXSKNoOseDUSpFtkn
	4Dx2lWEtzbl8w9mVqNZNJM8T99HwGGimdPWpsi/1vZC0JB3wAygCY3eBobVsXUdbxbBl+bhRCw7
	mw18IYFmz2EjrPXH2W1pUfCPr8lDV5ttjfXctm4luo5aaATyUapnY4puDYg8FKSlskRwc9M9qQf
	5h+eMySQlFYzz7yJRTdF1XTdBWvATxJOFqkI6nJqsMBP1A11NkmLQD2QMM0jmJaGi+l+UxI0QL5
	Qu1uqq5XP4mHMdO+bDhO+nIVaBIGVuavfcdFw5mimpv4sCPzi0wKb9R1LTxKnOaCCwUCYwqtE6c
	USTiIb8rP0K0AH198EGZphTGYBwwjCueTSO+aYdqLmmu8EYPCl6uvDwNkFvRV+tHzzMEQhlIico
	/zM9teiTqy4GlVcRxgsumu3LJBpb+U0iO17qKGH2LyL5jOZIzEVWwvQ8b8Zjml8HJyoEgcNZQWb
	Qj5qwb/vPx9AGLWz7Hcyc6zYLbp6iw/Fj6DcFl66fNfGtLA4c9eCsUw2PvbO6khw/KIr7KO2P0U
	R3J5X7Yoxk6B51aFe
X-Received: by 2002:a05:693c:8852:b0:371:ede8:3e9b with SMTP id 5a478bee46e88-3768721116amr4902164eec.36.1794466202380;
        Wed, 11 Nov 2026 22:50:02 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfadsm27190961eec.19.2026.11.11.22.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 22:50:01 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Kris Bahnsen <kris@embeddedTS.com>,
	Mark Featherston <mark@embeddedTS.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	linux-input@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] Input: ads7846 - drop platform data support and cleanups
Date: Wed, 11 Nov 2026 22:49:52 -0800
Message-ID: <20261112064957.1796975-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
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

Now that all in-tree boards using ads7846 have been converted to Device
Tree or software nodes, this series drops legacy platform data support
and its header file, simplifies sample filtering by calling
ads7846_debounce_filter() directly instead of through function pointers,
removes redundant memory barriers, deletes dead code, and cleans up
minor coding style issues.

Thanks.

Dmitry Torokhov (5):
  Input: ads7846 - drop platform data support
  Input: ads7846 - simplify sample filtering
  Input: ads7846 - remove unneeded memory barriers
  Input: ads7846 - remove unused code
  Input: ads7846 - fix minor coding style issues

 arch/arm/mach-pxa/spitz.c           |   1 -
 drivers/input/touchscreen/ads7846.c | 434 +++++++++++-----------------
 include/linux/spi/ads7846.h         |  45 ---
 3 files changed, 171 insertions(+), 309 deletions(-)
 delete mode 100644 include/linux/spi/ads7846.h

-- 
2.56.0.567.gdb80ae8cd5-goog

