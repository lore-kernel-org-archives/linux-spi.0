Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=57.103.76.244
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795027090;
	b=3iiNbKbGdcYdHTUdXZFkqwxZcbUE+0ekTZCU+bpNuExwEe5dPKulspvVsHEWcTrekJur
	 Lwz+FQvtC1OoVAuaRvN1kNYwUmaIpFwHJQLflp8T5hnIr+5Ksh9nkEwIm/kCjQtOExMMV
	 5fPtfN/UpFcIj0eHsLT0FmbzmCYJBfc5TpFpjhzsG3sa5eIcRj9ctHpgZ3pxxkUasYAVP
	 cgJ4LDcZR4CLmci5WzOkaUpFFOHTbqGokKJXxcd2rM/vjqDUU9xHnWf75BMVyZiTt4aBF
	 XzDdnvS5NkeMbECsm4IhS0AgXEtyDHwwo6UyCnn9T9y56cWrU3KDAZV6FvTgaxveBfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795027090;
	h=DMARC-Filter:Received:X-ICL-RepId:Dkim-Signature:
	 mail-alias-created-date:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Info-Out:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-JNJ;
	bh=G/lIww7et98viW/5VX21jdn8thD7SKB2sXXE7AmwGI0=;
	b=SPTzGrQJatFCW7TourkM9+rivpbDClJY7mugwyWwtW3JNY9lHNG7muIZkSfo/wTjmoLD
	 7A5C+7Fl61hBzvAkSqMgtDDgbcMm+lhEP6aAIOucuGkfIh9dWudXFfVT2THnxhWFPUGtE
	 /6I6KauHmZxeNvipEEu0Mq5iTQJTxgiTk4jbOcP4lG/vxMg0hdgRUmU+/UWIZi3cnpXHp
	 5zpAT5rRXGxAJ7saWzDjaMKS9yOrMhTdIlZ5g3LZqV7475LJYII4p/LchZ07xurws9fPS
	 dnAG5UGg9NLAjdoeQtMAZRHEf5wfwD8pCvY3qWZ2/+VzO/lbNXs3ezjU3/Buylgs2/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=putintsev.com;
	spf=pass smtp.mailfrom=putintsev.com;
	dkim=pass header.d=putintsev.com header.i=@putintsev.com header.a=rsa-sha256 header.s=sig1 header.b=PiJ91MqF;
	arc=none smtp.remote-ip=57.103.76.244
Received: from outbound.st.icloud.com (st-2006l-snip4-3.eps.apple.com [57.103.76.244])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C907606A330
	for <linux-spi@vger.kernel.org>; Wed, 18 Nov 2026 18:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C907606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=putintsev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=putintsev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=putintsev.com header.i=@putintsev.com header.a=rsa-sha256 header.s=sig1 header.b=PiJ91MqF
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPS id E1BA918000B7;
	Wed, 18 Nov 2026 18:38:07 +0000 (UTC)
X-ICL-RepId: 01a1eff3-b201-73db-8d19-b6c5140059aa
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=putintsev.com; s=sig1; t=1795027088; x=1826563088; bh=G/lIww7et98viW/5VX21jdn8thD7SKB2sXXE7AmwGI0=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=PiJ91MqFpdxmQyWy79KVTkWt/mrrLM/gylkSMC25V30MFSGkmqm1uhpYxXzPQE0KYRu7MVP68XxlmwyOlNQURvtF5zIWKM266T7XLIckPfQmbPVt7et5+hW9c21GmJtM3KtZTgd3RVO8gNqIw8UMN9C9CBXOqmDEt5m8W9Sh4iV9dcHX1vmxyRjLSeeutR+6CpZgHVA7oe+PCpY7NSanUlq3yzVr4D2Bl8V+6krsiDlrXMGw/xIQwJD29jTEDA3161UUhz73OexXt1ddHRwwGGQ6jsXr2Ge7I4kl9wqrRcT45K3pXoDwWqFyKny8pSJTjPsg+uMDHbZpQX3Ws/NnhQ==
mail-alias-created-date: 1771854267065
Received: from macbookpro.lan (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-11 (Postfix) with ESMTPSA id 331A91800108;
	Wed, 18 Nov 2026 18:38:07 +0000 (UTC)
From: Roman Putintsev <roman@putintsev.com>
To: ldewangan@nvidia.com,
	broonie@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thierry.reding@kernel.org,
	jonathanh@nvidia.com,
	skomatineni@nvidia.com,
	Roman Putintsev <roman@putintsev.com>
Subject: [PATCH] spi: tegra114: re-assert CS after a mid-message cs_change
Date: Wed, 18 Nov 2026 13:38:05 -0500
Message-ID: <20261118183805.25461-1-roman@putintsev.com>
X-Mailer: git-send-email 2.50.1
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA3NCBTYWx0ZWRfX44dALubhyGVm
 W02cJJuiIXnbLrDttWSgCnCg5bRrsSaGr6US77TUqddKUQphDPeazfVJhc7X6f649mLouoxH7B4
 h2dbB9fdR569BSUBX9G6y0ATmCc22YphpMyi2BsK6hluw/PJxjeOpvSUr30inNAQHlM8jcnuW3C
 wsL81wepCe6MwCxd2qgd0Hj0EXUOEzqLnGTPc+SAQlEuXP3elKfIy5AtS7gSfq4grLkgGiv8RgU
 cocz52tq7Hk/Rshra3L6GN8NVCSptaL++6+TXEGufwOdTR3xL7r7MM+VrebB64fJJBu2XUkuJmc
 w0yAu1keHCezxdjjP2GLZkmw0zutdTQknbcBREKAXscnMN1mrH6NuerVZn0g3c=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA3NCBTYWx0ZWRfX6sbyOs6a/9i9
 w/4XLjucXN8Br2it7Ez/QC7wdDJGnuu1X7xPO9J/LBUBSv7yAwhBRqVBSgoYyEqCT5WlrHtLw28
 qACMK9nKRca69m/Mjzwjn+GX3Onp6Jo=
X-Authority-Info-Out: v=2.4 cv=UsH2pOwB c=1 sm=1 tr=0 ts=6afdf090
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=51JdnUhQRHFq8RItG6ly:22 a=XqUgTU364RIWfhS-Fj-h:22 a=VwQbUJbxAAAA:8
 a=gNxGhvmwAAAA:8 a=7g2LsxMrY8pxi2ky23YA:9 a=O8hF6Hzn-FEA:10
 a=yjIKAdwAKDrTRT0yDhyo:22
X-Proofpoint-ORIG-GUID: R_gCKmEIytyiTga0pDaPDDNPFjQVL90U
X-Proofpoint-GUID: R_gCKmEIytyiTga0pDaPDDNPFjQVL90U
X-JNJ: AAAAAAABpmt4HQEMGo56imYTeWQrIr/RKOhydgnHkeT3ryUCLVqrdya/8vXldJaF0JddAX
 Zz5JvYZpkxq4RGhpAbM+XKQKHTBTDjh88xxJYJMVWb0LYzdOsfJuj/RGpa1QRqD66pLIZ6
 iYBU2ag67GNaL7rzbP8owmmz7zX+685T37oQPWp6/awJNjwZgAr28X5YyvBRQTey+T0IiM
 qYs5UpepKx3wr//USxdbeOcxsnxNjbVkITtL9pi1yfJl5aAt+Ne0ZrE7hFiDe/TfBzC7lj
 t0SfRl0h1gKMdtc5XlUf06LDXjID+HFGJ5UucdEI+1wMft9KAQwdxnkzAYkXYHIiyQwaJJ
 xr1cmQpSQaAKCgP6YmZ/FHAgzFX5Bqng43BSRMKVQpoZARXzZFWuUmG/R52c//dC8AFGky
 5KTbd+xYdQMWT3TslUg4oVMMzgOrqnx6kRx8mdzSdAEJWzmOgy9iNGTPiiAs/1lBjZ8ovF
 b55K0/if7TjgGs6UNUddEHQmOMcQA9On+u2wr70koRIY0ASAO/H5fWoXYV+eByPybNSS3v
 JcfCsBlc7jh86XdcuOLmmpgsBanIFk9qqiWwDOI5w4DguDLn/XpvTzW/eC/P6KXhHpLAj9
 phqWLWLUdmqpsovdPGeAnHgqVB86NkAOAQSOcqWE/Qdq6VmzQl7zYVJY1q6yleolZGYsZi
 lu78CdQqWa6+cnzRcJcFq1mxzpCErT69iZABVGQ/xQjBTd2+MIDyTcK3PwKSlZ6U5eTxSv
 CS/imZyMoFibOkezHDfC4GoQkDi6Lf4bjP4G6svu8b7vXGUKKycQf5tvpyvTcB/LPmYY3J
 mTpk/3kTr8mCb70SWSyelRKgrLgSMaZViwVzHOodHxuAoPLAtJmIgQwgcDjS7weyfuyC/v
 0GVY3vN/66uK/aaC+LOiMMRdUetpl/KVrwouX3vJtthIz6FfoC18w96oHWY+UQ2d1crr2j
 c4IG/fqY4Qx2jPCzRa8ExCxah/iml6djrzmml7LfYUzv9cs0HIFcxkwvsLmAW99HltfTzT
 JfzOR8c4b0FkCeGfHxmYSiTwKcqvbbo5CjXwR299obuUQcpG2/nkRM3nqvi+Qxq4YyoQxi
 v9XL9bWH93kMc2mSOxvMstW6lwEM9TwUlqiYSpzfmZ1Gj6Egn2LXmRp8VERAaqScxlItTt
 IrsZPoUDXXe3pJHRdNozifPVISU7xJhAqay7lw0bxDXLTdkwLYSVykW723/Ni8Gja2SUUB
 VtnjIF34x6LO7Kv6NyXCSfJQoxuhiQuXpNu5+55NKy2lQQ1SANLn1C7jmHWweQ==

When a transfer has cs_change set and is not the last one of a message,
tegra_spi_transfer_one_message() ends it with tegra_spi_transfer_end().
That function deasserts CS and stores the deasserted state in
tspi->command1_reg (SPI_CS_SW_VAL). The next transfer is not the first one
of the message, so tegra_spi_setup_transfer_one() reuses command1_reg
unchanged: the controller clocks that transfer out with CS inactive. The
slave never sees the data and no error is reported.

Every driver that splits a message into "write payload, toggle CS, write
trigger" hits this. mcp251xfd does it for every CAN frame, so an MCP2518FD
never transmits: the frame reaches the chip's RAM, but the write that sets
UINC|TXREQ in the TX FIFO control register is lost. Reception uses
single-transfer messages and still works.

Before commit f3e182c33e53 ("spi: tegra114: de-assert CS before SPI mode
change") the deassertion did not touch command1_reg and the next transfer
asserted CS on its own. Mark the following transfer as the first one of a
message again, so that it takes the setup path that asserts CS.

Tested on a reComputer Orin J40 Mini with an MCP2518FD on spi1.0. No frame
was transmitted before this change; with it CAN traffic runs in both
directions with no errors.

Fixes: f3e182c33e53 ("spi: tegra114: de-assert CS before SPI mode change")
Cc: stable@vger.kernel.org
Signed-off-by: Roman Putintsev <roman@putintsev.com>
---
 drivers/spi/spi-tegra114.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index f43f2df..d2fda21 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -1116,6 +1116,8 @@ complete_xfer:
 		} else if (xfer->cs_change) {
 			tegra_spi_transfer_end(spi);
 			spi_transfer_delay_exec(xfer);
+			/* CS was deasserted, assert it for the next transfer */
+			is_first_msg = true;
 		}
 
 	}

base-commit: 20eef29b7c8465ac98d7dd6d6f2ac07a8d8056ca
