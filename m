Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ou/7GHgS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SCXzl3uy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13161B8;
	Mon, 11 Dec 2023 04:49:25 -0800 (PST)
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702298963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KqyDGuj/w90Sx5xoRurtUb6bEnCDz+4edCPtCIkEmrY=;
	b=Ou/7GHgSj9OC6v5cZHEAucYkp8ZgWC7PIRySJJUMuuB0QxMY6kRftjmpGRCaweTVMs6aZM
	HRhNSBNBj4RgtbKvda4SmmHBuKIbKMtk9xR+8VmA3w+RhMEfH3TLLjH0yUk3sL8JECjOXd
	U5k6hDtWXwO+ubt3F8V2F75SmBiOei1gN2WBPAMyq+FbvpCZeSHkiOtOplP43JseLDA8is
	OmTDrSYj5Vu11n3q4hyb5e7EmUxx0kGpXWzAE1OqTx1nazQd6hb2Xuj0SRgS7qAnxa+NK9
	p07QLbnuEOpvLDgNqb/g1SnYVgXBDym4iEMM0cu0IHHxkA8PS/whGpMfcAJlbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702298963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KqyDGuj/w90Sx5xoRurtUb6bEnCDz+4edCPtCIkEmrY=;
	b=SCXzl3uy5iPrX9/PncfXnfqjDYhldsZUhj+dasLW8ugUN8aZRFX4zSHW6mscyoQQNExx7d
	ok0rkCJbEzWw31CA==
To: linus.walleij@linaro.org,
	broonie@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH 0/2] spi: pl022: clean up some unused variables
Date: Mon, 11 Dec 2023 13:49:13 +0100
Message-Id: <cover.1702298527.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The driver was refactored in 9b2ef250b31d ("spi: spl022: switch to use
default spi_transfer_one_message()"), and some variables are now unused
because of that. Clean them up.

Nam Cao (2):
  spi: pl022: delete unused cur_gpiod in struct pl022
  spi: pl022: delete unused next_msg_cs_active in struct pl022

 drivers/spi/spi-pl022.c | 9 ---------
 1 file changed, 9 deletions(-)

--=20
2.39.2

