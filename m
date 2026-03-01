Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E8D2820A9;
	Sun,  1 Mar 2026 01:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329666; cv=none; b=kVDP/fK1XUvi1ebS4klrYshWE1+Ny7S6FnhExy1+2/UNLMHuP4SmuA7sCt7fJt3gqhtLfQt4ZczS83Q8vDH9jYWLsj+RxHK56FGA+j4NUDy64rw32A3T7MvAFrYckvDb6LIDRr8NXo+pPhurJUO8MCWJsObFoSIAXt1RQiIKRM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329666; c=relaxed/simple;
	bh=O9vsDruYfHebzjNzheHpKkJEJBdF1X0kQ/JrXbtXGNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MtxsY6dY1v+cfrBwNg+6hJcCLo1rGfMad/zEn1ah/xfuo5QzR5e8FqFO8/SdLQZIavZ+mNJ4fm5Q2anZSy4r0tD73rLp3IoeeHAjEOxsZyBbpQXVSmC1WPJrWG3zma/DMNbDVCDcVzeHnD0K96lzWGEkAFGN3T59saL39qvY3Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GkvEfBEF; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GkvEfBEF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=rw9ffD6UMobURwaxZzMbLNNCvWV7xCQaBWw/IH/6nHM=; b=GkvEfBEF1DVU1HJ19NLKha5gGm
	c3AKXqTlmav4DG3AV8A4aGU/BQlMYkjagwMR9E5FupHY6QqK2zl9ctAExikhX6SStWbd8RATJ/iFw
	hoFKS8tK4jtLsKVewXUmvNOJ3+s9JWObxwoiCIcP5NuHXuq0RVlXW/MOwiVsrbsvedPa9rrWzIeKV
	dsTxSjImcRZPyBdDOgqdTx+oSRSWJ+yrzk0f9KjqrWjmzrXC+tHF3aThyssDsIMR99YHQoYZHANcc
	66Vov3KkRLzY1fGE/Vx/0SjUhjTzk71xYgXzxhn93MR3V2NpJWPD7WP2s6shLneGTOhRJnQf2hKYB
	WUXyWWDQ==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwVuK-0000000AeMZ-0DgA;
	Sun, 01 Mar 2026 01:47:44 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org
Subject: [PATCH] spi: spi-mem: clean up kernel-doc in spi-mem.h
Date: Sat, 28 Feb 2026 17:47:43 -0800
Message-ID: <20260301014743.3133167-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eliminate all kernel-doc warnings in spi-mem.h:
- add missing struct member descriptions
- don't use "struct" for function descrptions

Warning: include/linux/spi/spi-mem.h:202 struct member 'cmd' not described
 in 'spi_mem_op'
Warning: include/linux/spi/spi-mem.h:202 struct member 'addr' not described
 in 'spi_mem_op'
Warning: include/linux/spi/spi-mem.h:202 struct member 'dummy' not
 described in 'spi_mem_op'
Warning: include/linux/spi/spi-mem.h:202 struct member 'data' not described
 in 'spi_mem_op'

Warning: include/linux/spi/spi-mem.h:286 Incorrect use of kernel-doc
 format: * struct spi_mem_get_drvdata() - get driver private data
 attached to a SPI mem
Warning: include/linux/spi/spi-mem.h:298 Incorrect use of kernel-doc
 format: * struct spi_controller_mem_ops - SPI memory operations
Warning: include/linux/spi/spi-mem.h:362 expecting prototype for struct
 spi_mem_set_drvdata. Prototype was for struct spi_controller_mem_ops instead

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org

 include/linux/spi/spi-mem.h |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- linux-next-20260227.orig/include/linux/spi/spi-mem.h
+++ linux-next-20260227/include/linux/spi/spi-mem.h
@@ -130,11 +130,13 @@ enum spi_mem_data_dir {
 
 /**
  * struct spi_mem_op - describes a SPI memory operation
+ * @cmd: the complete command
  * @cmd.nbytes: number of opcode bytes (only 1 or 2 are valid). The opcode is
  *		sent MSB-first.
  * @cmd.buswidth: number of IO lines used to transmit the command
  * @cmd.opcode: operation opcode
  * @cmd.dtr: whether the command opcode should be sent in DTR mode or not
+ * @addr: the address attributes
  * @addr.nbytes: number of address bytes to send. Can be zero if the operation
  *		 does not need to send an address
  * @addr.buswidth: number of IO lines used to transmit the address cycles
@@ -143,10 +145,12 @@ enum spi_mem_data_dir {
  *	      Note that only @addr.nbytes are taken into account in this
  *	      address value, so users should make sure the value fits in the
  *	      assigned number of bytes.
+ * @dummy: data for dummy operation
  * @dummy.nbytes: number of dummy bytes to send after an opcode or address. Can
  *		  be zero if the operation does not require dummy bytes
  * @dummy.buswidth: number of IO lanes used to transmit the dummy bytes
  * @dummy.dtr: whether the dummy bytes should be sent in DTR mode or not
+ * @data: the data attributes
  * @data.buswidth: number of IO lanes used to send/receive the data
  * @data.dtr: whether the data should be sent in DTR mode or not
  * @data.ecc: whether error correction is required or not
@@ -273,7 +277,7 @@ struct spi_mem {
 };
 
 /**
- * struct spi_mem_set_drvdata() - attach driver private data to a SPI mem
+ * spi_mem_set_drvdata() - attach driver private data to a SPI mem
  *				  device
  * @mem: memory device
  * @data: data to attach to the memory device
@@ -284,7 +288,7 @@ static inline void spi_mem_set_drvdata(s
 }
 
 /**
- * struct spi_mem_get_drvdata() - get driver private data attached to a SPI mem
+ * spi_mem_get_drvdata() - get driver private data attached to a SPI mem
  *				  device
  * @mem: memory device
  *
