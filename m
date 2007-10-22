From: Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Subject: Re: [patch 3/4 2.6.23-rc2 + mm2-git-mmc] MMC
 core learns about SPI
Date: Mon, 22 Oct 2007 20:34:28 +0200
Message-ID: <20071022203428.300117e4@poseidon.drzeus.cx>
References: <200708080906.18993.david-b@pacbell.net>
	<20070829092247.GA15021@pengutronix.de>
	<20070829165243.0236cc89@poseidon.drzeus.cx>
	<200708290943.59450.david-b@pacbell.net>
	<470A644A.8030405@gmail.com>
	<20071010203613.55676dba@poseidon.drzeus.cx>
	<c4bc83220710190240wd13bfd1r991ba9b1b1128f6c@mail.gmail.com>
	<c4bc83220710190250m6c3401end194917e2daa9104@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_hera.drzeus.cx-26373-1193078035-0001-2"
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mikael Starvik <mikael.starvik-VrBV9hrLPhE@public.gmane.org>,
	Hans-Peter Nilsson <hans-peter.nilsson-VrBV9hrLPhE@public.gmane.org>,
	Mike Lavender <mike-UTnDXsALFwNjMdQLN6DIHgC/G2K4zDHf@public.gmane.org>
To: "Jan Nikitenko" <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <c4bc83220710190250m6c3401end194917e2daa9104-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

--=_hera.drzeus.cx-26373-1193078035-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 19 Oct 2007 11:50:16 +0200
"Jan Nikitenko" <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> On 10/10/07, Pierre Ossman <drzeus-mmc-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org> wrote:
> >
> > Odd. Could you point to the byte swapping in the earlier version?
> 
> It was present in mmc-spi update patch posted here for example:
> http://sourceforge.net/mailarchive/message.php?msg_id=200706042025.18252.david-b%40pacbell.net
> Check the mmc_spi_read_cXd(), there are be32_to_cpus() calls present.
> 

Ah. I see what you mean now. The problem is in the data transfer, not a response field. So Sacha's patch was almost correct. Could you test if the included patch solves your issue?

> What do you mean by FTL on the card?
> 

The wear leveling and other voodoo that translates block commands to NAND storage. If we send a write multiple times and the card fails it partially, then we have no idea what it has actually committed to NAND. Hence we play it safe and let upper layers handle the policy of retrying.

> 
> Without the !blk_queue_stopped(q) check, the suspend waits until dd
> command finishes it's  job.

Not quite. It should just wait for the data dd has currently queued up (which should be 1 bs plus possible read-ahead).

> If the check is there, it's possible to suspend when dd command (or
> any other file copy command) is running and properly resume after.
> 

OTOH, letting them finish reduces the number of dirty pages that might have to be committed to disk for a hibernation.

Is this really a problem that plagues you, or just something you noticed in the code?

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

--=_hera.drzeus.cx-26373-1193078035-0001-2
Content-Type: text/x-patch; name="be32.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=be32.patch

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index bf4bc6a..8b20e55 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -267,15 +267,26 @@ mmc_send_cxd_data(struct mmc_card *card, struct mmc_host *host,
 
 int mmc_send_csd(struct mmc_card *card, u32 *csd)
 {
+	int ret, i;
+
 	if (!mmc_host_is_spi(card->host))
 		return mmc_send_cxd_native(card->host, card->rca << 16,
 				csd, MMC_SEND_CSD);
 
-	return mmc_send_cxd_data(card, card->host, MMC_SEND_CSD, csd, 16);
+	ret = mmc_send_cxd_data(card, card->host, MMC_SEND_CSD, csd, 16);
+	if (ret)
+		return ret;
+
+	for (i = 0;i < 4;i++)
+		csd[i] = be32_to_cpu(csd[i]);
+
+	return 0;
 }
 
 int mmc_send_cid(struct mmc_host *host, u32 *cid)
 {
+	int ret, i;
+
 	if (!mmc_host_is_spi(host)) {
 		if (!host->card)
 			return -EINVAL;
@@ -283,7 +294,14 @@ int mmc_send_cid(struct mmc_host *host, u32 *cid)
 				cid, MMC_SEND_CID);
 	}
 
-	return mmc_send_cxd_data(NULL, host, MMC_SEND_CID, cid, 16);
+	ret = mmc_send_cxd_data(NULL, host, MMC_SEND_CID, cid, 16);
+	if (ret)
+		return ret;
+
+	for (i = 0;i < 4;i++)
+		cid[i] = be32_to_cpu(cid[i]);
+
+	return 0;
 }
 
 int mmc_send_ext_csd(struct mmc_card *card, u8 *ext_csd)

--=_hera.drzeus.cx-26373-1193078035-0001-2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--=_hera.drzeus.cx-26373-1193078035-0001-2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--=_hera.drzeus.cx-26373-1193078035-0001-2--
