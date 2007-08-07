From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: [patch 2.6.22-git5 4/4] mmc_spi host driver
Date: Tue, 7 Aug 2007 14:35:00 +0200
Message-ID: <20070807143500.203f353c@poseidon.drzeus.cx>
References: <200707141504.51950.david-b@pacbell.net>
	<200708011117.24664.david-b@pacbell.net>
	<20070802150615.36e073c6@poseidon.drzeus.cx>
	<200708021334.50670.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_hera.drzeus.cx-2949-1186490099-0001-2"
Cc: Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200708021334.50670.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hera.drzeus.cx-2949-1186490099-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 2 Aug 2007 13:34:49 -0700
David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:

> 
> The intended design of an MMC/SD host driver has never
> been all that clear.  It's becoming more clear with your
> recent work ... but it's not there yet, and there aren't
> even test scripts or suites for de-facto requirements
> (and to facilitate regression testing).
> 

I got annoyed by the olpc xo and wrote some tests. Enjoy.

(Not SPI enabled, but I'm sure you can make some additions ;))

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

--=_hera.drzeus.cx-2949-1186490099-0001-2
Content-Type: text/x-patch; name="mmc-test.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=mmc-test.patch

commit e966ae990cd2ef3be48ece8cde0f97f04a0d6024
Author: Pierre Ossman <drzeus-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Date:   Tue Aug 7 14:27:17 2007 +0200

    mmc: mmc host test driver
    
    A dummy driver that performs a series of requests that are often mis-
    handled by host drivers.
    
    Signed-off-by: Pierre Ossman <drzeus-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>

diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig
index aa8a4e4..28db50d 100644
--- a/drivers/mmc/card/Kconfig
+++ b/drivers/mmc/card/Kconfig
@@ -32,6 +32,12 @@ config MMC_BLOCK_BOUNCE
 
 	  If unsure, say Y here.
 
+config MMC_TEST
+	tristate "MMC host test driver"
+	default n
+	help
+	  Dummy driver that tests that a host performs as it should.
+
 config SDIO_UART
 	tristate "SDIO UART/GPS class support"
 	depends on MMC
diff --git a/drivers/mmc/card/Makefile b/drivers/mmc/card/Makefile
index fc5a784..944447d 100644
--- a/drivers/mmc/card/Makefile
+++ b/drivers/mmc/card/Makefile
@@ -9,5 +9,6 @@ endif
 obj-$(CONFIG_MMC_BLOCK)		+= mmc_block.o
 mmc_block-objs			:= block.o queue.o
 
+obj-$(CONFIG_MMC_TEST)		+= mmc_test.o
 obj-$(CONFIG_SDIO_UART)		+= sdio_uart.o
 
diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
new file mode 100644
index 0000000..06c9ef2
--- /dev/null
+++ b/drivers/mmc/card/mmc_test.c
@@ -0,0 +1,520 @@
+/*
+ *  linux/drivers/mmc/card/mmc_test.c
+ *
+ *  Copyright 2007 Pierre Ossman
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ */
+
+#include <linux/mmc/core.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+
+#include <linux/scatterlist.h>
+
+static int set_blksize(struct mmc_card *card, unsigned size)
+{
+	struct mmc_command cmd;
+	int ret;
+
+	cmd.opcode = MMC_SET_BLOCKLEN;
+	cmd.arg = size;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_AC;
+	ret = mmc_wait_for_cmd(card->host, &cmd, 5);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int do_transfer(struct mmc_card *card, struct mmc_request *mrq,
+		int write, unsigned blocks, unsigned blksz)
+{
+	int ret, i;
+	u8 *buffer;
+
+	struct scatterlist sg;
+
+	buffer = kzalloc((blocks + 1) * blksz, GFP_KERNEL);
+	if (!buffer) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (!write)
+		memset(buffer, 0xDF, blocks * blksz);
+
+	memset(mrq->data, 0, sizeof(struct mmc_data));
+
+	mrq->data->blksz = blksz;
+	mrq->data->blocks = blocks;
+	mrq->data->flags = write ? MMC_DATA_WRITE : MMC_DATA_READ;
+	mrq->data->sg = &sg;
+	mrq->data->sg_len = 1;
+
+	sg_init_one(&sg, buffer, blocks * blksz);
+
+	mmc_set_data_timeout(mrq->data, card, write);
+
+	mmc_wait_for_req(card->host, mrq);
+
+	if (!write) {
+		for (i = 0;i < blocks * blksz;i++) {
+			if (buffer[i] == 0xDF) {
+				ret = -EIO;
+				break;
+			}
+		}
+
+		for (i = 0;i < blksz;i++) {
+			if (buffer[blocks * blksz + i] != 0x00) {
+				ret = -EIO;
+				break;
+			}
+		}
+	}
+
+	ret = 0;
+
+out:
+	kfree(buffer);
+	return ret;
+}
+
+static int do_valid_transfer(struct mmc_card *card, struct mmc_request *mrq,
+		int write, unsigned blocks, unsigned blksz)
+{
+	int ret;
+
+	ret = set_blksize(card, blksz);
+	if (ret)
+		return ret;
+
+	memset(mrq->cmd, 0, sizeof(struct mmc_command));
+
+	if (blocks > 1)
+		mrq->cmd->opcode = write ? MMC_WRITE_MULTIPLE_BLOCK : MMC_READ_MULTIPLE_BLOCK;
+	else
+		mrq->cmd->opcode = write ? MMC_WRITE_BLOCK : MMC_READ_SINGLE_BLOCK;
+
+	mrq->cmd->arg = 0;
+	mrq->cmd->flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+
+	memset(mrq->stop, 0, sizeof(struct mmc_command));
+
+	if (blocks > 1) {
+		mrq->stop->opcode = MMC_STOP_TRANSMISSION;
+		mrq->stop->arg = 0;
+		mrq->stop->flags = MMC_RSP_R1B | MMC_CMD_AC;
+	} else {
+		mrq->stop->opcode = MMC_SEND_STATUS;
+		mrq->stop->arg = card->rca << 16;
+		mrq->stop->flags = MMC_RSP_R1 | MMC_CMD_AC;
+	}
+
+	return do_transfer(card, mrq, write, blocks, blksz);
+}
+
+static int do_invalid_transfer(struct mmc_card *card, struct mmc_request *mrq,
+		int write, unsigned blocks, unsigned blksz)
+{
+	memset(mrq->cmd, 0, sizeof(struct mmc_command));
+
+	mrq->cmd->opcode = MMC_SEND_STATUS;
+	mrq->cmd->arg = card->rca << 16;
+	mrq->cmd->flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+
+	memset(mrq->stop, 0, sizeof(struct mmc_command));
+
+	mrq->stop->opcode = MMC_SEND_STATUS;
+	mrq->stop->arg = card->rca << 16;
+	mrq->stop->flags = MMC_RSP_R1 | MMC_CMD_AC;
+
+	return do_transfer(card, mrq, write, blocks, blksz);
+}
+
+static int test_pow2_reads(struct mmc_card *card)
+{
+	int ret, i;
+
+	struct mmc_request mrq;
+	struct mmc_command cmd;
+	struct mmc_command stop;
+	struct mmc_data data;
+
+	printk(KERN_INFO "%s: Testing reading power of two block sizes...\n",
+		mmc_hostname(card->host));
+
+	for (i = 1;i <= 512;i <<= 1) {
+		memset(&mrq, 0, sizeof(struct mmc_request));
+
+		mrq.cmd = &cmd;
+		mrq.data = &data;
+		mrq.stop = &stop;
+
+		ret = do_valid_transfer(card, &mrq, 0, 1, i);
+		if (ret)
+			goto out;
+
+		ret = 0;
+
+		if (!ret && cmd.error)
+			ret = cmd.error;
+		if (!ret && data.error)
+			ret = data.error;
+		if (!ret && stop.error)
+			ret = stop.error;
+		if (!ret && data.bytes_xfered != i)
+			ret = -EIO;
+
+		if (ret)
+			break;
+	}
+
+out:
+	printk(KERN_INFO "%s: Result: %s\n", mmc_hostname(card->host),
+		ret ? "FAIL" : "OK");
+
+	return ret;
+}
+
+static int test_pow2_writes(struct mmc_card *card)
+{
+	int ret, i;
+
+	struct mmc_request mrq;
+	struct mmc_command cmd;
+	struct mmc_command stop;
+	struct mmc_data data;
+
+	printk(KERN_INFO "%s: Testing writing power of two block sizes...\n",
+		mmc_hostname(card->host));
+
+	for (i = 1;i <= 512;i <<= 1) {
+		memset(&mrq, 0, sizeof(struct mmc_request));
+
+		mrq.cmd = &cmd;
+		mrq.data = &data;
+		mrq.stop = &stop;
+
+		ret = do_valid_transfer(card, &mrq, 1, 1, i);
+		if (ret)
+			goto out;
+
+		ret = 0;
+
+		if (!ret && cmd.error)
+			ret = cmd.error;
+		if (!ret && data.error)
+			ret = data.error;
+		if (!ret && stop.error)
+			ret = stop.error;
+		if (!ret && data.bytes_xfered != i)
+			ret = -EIO;
+
+		if (ret)
+			break;
+	}
+
+out:
+	printk(KERN_INFO "%s: Result: %s\n", mmc_hostname(card->host),
+		ret ? "FAIL" : "OK");
+
+	return ret;
+}
+
+static int test_weird_reads(struct mmc_card *card)
+{
+	int ret, i;
+
+	struct mmc_request mrq;
+	struct mmc_command cmd;
+	struct mmc_command stop;
+	struct mmc_data data;
+
+	printk(KERN_INFO "%s: Testing reading unusual block sizes...\n",
+		mmc_hostname(card->host));
+
+	for (i = 3;i <= 512;i += 7) {
+		memset(&mrq, 0, sizeof(struct mmc_request));
+
+		mrq.cmd = &cmd;
+		mrq.data = &data;
+		mrq.stop = &stop;
+
+		ret = do_valid_transfer(card, &mrq, 0, 1, i);
+		if (ret)
+			goto out;
+
+		ret = 0;
+
+		if (!ret && cmd.error)
+			ret = cmd.error;
+		if (!ret && data.error)
+			ret = data.error;
+		if (!ret && stop.error)
+			ret = stop.error;
+		if (!ret && data.bytes_xfered != i)
+			ret = -EIO;
+
+		if (ret)
+			break;
+	}
+
+out:
+	printk(KERN_INFO "%s: Result: %s\n", mmc_hostname(card->host),
+		ret ? "FAIL" : "OK");
+
+	return ret;
+}
+
+static int test_weird_writes(struct mmc_card *card)
+{
+	int ret, i;
+
+	struct mmc_request mrq;
+	struct mmc_command cmd;
+	struct mmc_command stop;
+	struct mmc_data data;
+
+	printk(KERN_INFO "%s: Testing writing unusual block sizes...\n",
+		mmc_hostname(card->host));
+
+	for (i = 3;i <= 512;i += 7) {
+		memset(&mrq, 0, sizeof(struct mmc_request));
+
+		mrq.cmd = &cmd;
+		mrq.data = &data;
+		mrq.stop = &stop;
+
+		ret = do_valid_transfer(card, &mrq, 1, 1, i);
+		if (ret)
+			goto out;
+
+		ret = 0;
+
+		if (!ret && cmd.error)
+			ret = cmd.error;
+		if (!ret && data.error)
+			ret = data.error;
+		if (!ret && stop.error)
+			ret = stop.error;
+		if (!ret && data.bytes_xfered != i)
+			ret = -EIO;
+
+		if (ret)
+			break;
+	}
+
+out:
+	printk(KERN_INFO "%s: Result: %s\n", mmc_hostname(card->host),
+		ret ? "FAIL" : "OK");
+
+	return ret;
+}
+
+static int test_bytes_xfer_single(struct mmc_card *card)
+{
+	int ret;
+
+	struct mmc_request mrq;
+	struct mmc_command cmd;
+	struct mmc_command stop;
+	struct mmc_data data;
+
+	printk(KERN_INFO "%s: Testing correct bytes_xfered for a single block...\n",
+		mmc_hostname(card->host));
+
+	if (!(card->host->caps & MMC_CAP_MULTIWRITE)) {
+		printk(KERN_INFO "%s: Result: UNSUPPORTED\n",
+			mmc_hostname(card->host));
+		return -EINVAL;
+	}
+
+	memset(&mrq, 0, sizeof(struct mmc_request));
+
+	mrq.cmd = &cmd;
+	mrq.data = &data;
+	mrq.stop = &stop;
+
+	ret = do_invalid_transfer(card, &mrq, 1, 1, 512);
+	if (ret)
+		goto out;
+
+	ret = 0;
+
+	if (!ret && cmd.error)
+		ret = cmd.error;
+	if (!ret && data.error != -ETIMEDOUT)
+		ret = data.error;
+	if (!ret && stop.error)
+		ret = stop.error;
+	if (!ret && data.bytes_xfered != 0)
+		ret = -EINVAL;
+
+out:
+	printk(KERN_INFO "%s: Result: %s\n", mmc_hostname(card->host),
+		ret ? "FAIL" : "OK");
+
+	return ret;
+}
+
+static int test_bytes_xfer_multi(struct mmc_card *card)
+{
+	int ret;
+
+	struct mmc_request mrq;
+	struct mmc_command cmd;
+	struct mmc_command stop;
+	struct mmc_data data;
+
+	printk(KERN_INFO "%s: Testing correct bytes_xfered for multiple blocks...\n",
+		mmc_hostname(card->host));
+
+	if (!(card->host->caps & MMC_CAP_MULTIWRITE) ||
+			(card->host->max_blk_count < 2) ||
+			(card->host->max_req_size < 1024) ||
+			(card->host->max_seg_size < 1024)) {
+		printk(KERN_INFO "%s: Result: UNSUPPORTED\n",
+			mmc_hostname(card->host));
+		return -EINVAL;
+	}
+
+	memset(&mrq, 0, sizeof(struct mmc_request));
+
+	mrq.cmd = &cmd;
+	mrq.data = &data;
+	mrq.stop = &stop;
+
+	ret = do_invalid_transfer(card, &mrq, 1, 2, 512);
+	if (ret)
+		goto out;
+
+	ret = 0;
+
+	if (!ret && cmd.error)
+		ret = cmd.error;
+	if (!ret && data.error != -ETIMEDOUT)
+		ret = data.error;
+	if (!ret && stop.error)
+		ret = stop.error;
+	if (!ret && data.bytes_xfered != 0)
+		ret = -EINVAL;
+
+out:
+	printk(KERN_INFO "%s: Result: %s\n", mmc_hostname(card->host),
+		ret ? "FAIL" : "OK");
+
+	return ret;
+}
+
+static int test_busy_wait(struct mmc_card *card)
+{
+	int ret;
+
+	struct mmc_request mrq;
+	struct mmc_command cmd;
+	struct mmc_command stop;
+	struct mmc_data data;
+
+	printk(KERN_INFO "%s: Testing that host waits for busy...\n",
+		mmc_hostname(card->host));
+
+	memset(&mrq, 0, sizeof(struct mmc_request));
+
+	mrq.cmd = &cmd;
+	mrq.data = &data;
+	mrq.stop = &stop;
+
+	ret = do_valid_transfer(card, &mrq, 1, 10, 512);
+	if (ret)
+		goto out;
+
+	ret = 0;
+
+	if (!ret && cmd.error)
+		ret = cmd.error;
+	if (!ret && data.error)
+		ret = data.error;
+	if (!ret && stop.error)
+		ret = stop.error;
+	if (!ret && data.bytes_xfered != 10 * 512)
+		ret = -EIO;
+
+	if (ret)
+		goto out;
+
+	memset(&cmd, 0, sizeof(struct mmc_command));
+
+	cmd.opcode = MMC_SEND_STATUS;
+	cmd.arg = card->rca << 16;
+	cmd.flags = MMC_RSP_R1 | MMC_CMD_ADTC;
+
+	ret = mmc_wait_for_cmd(card->host, &cmd, 0);
+	if (ret)
+		goto out;
+
+	if (!(cmd.resp[0] & R1_READY_FOR_DATA))
+		ret = -EIO;
+
+out:
+	printk(KERN_INFO "%s: Result: %s\n", mmc_hostname(card->host),
+		ret ? "FAIL" : "OK (uncertain, test multiple cards)");
+
+	return ret;
+}
+
+static int mmc_test_probe(struct mmc_card *card)
+{
+	mmc_claim_host(card->host);
+
+	test_pow2_writes(card);
+	test_pow2_reads(card);
+
+	test_weird_writes(card);
+	test_weird_reads(card);
+
+	test_bytes_xfer_single(card);
+	test_bytes_xfer_multi(card);
+
+	test_busy_wait(card);
+
+	mmc_release_host(card->host);
+
+	return -ENODEV;
+}
+
+static void mmc_test_remove(struct mmc_card *card)
+{
+}
+
+static struct mmc_driver mmc_driver = {
+	.drv		= {
+		.name	= "mmc_test",
+	},
+	.probe		= mmc_test_probe,
+	.remove		= mmc_test_remove,
+};
+
+static int __init mmc_test_init(void)
+{
+	return mmc_register_driver(&mmc_driver);
+}
+
+static void __exit mmc_test_exit(void)
+{
+	mmc_unregister_driver(&mmc_driver);
+}
+
+module_init(mmc_test_init);
+module_exit(mmc_test_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Multimedia Card (MMC) host test driver");
+MODULE_AUTHOR("Pierre Ossman");
+
+

--=_hera.drzeus.cx-2949-1186490099-0001-2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
--=_hera.drzeus.cx-2949-1186490099-0001-2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--=_hera.drzeus.cx-2949-1186490099-0001-2--
