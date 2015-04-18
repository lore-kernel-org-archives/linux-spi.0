From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH V2] spi: bcm2835: enabling polling mode for transfers shorter than 30us
Date: Sat, 18 Apr 2015 15:31:13 +0200
Message-ID: <2DB27253-8254-4098-ADE3-9AA22D52BE9D@martin.sperl.org>
References: <1428340592-3196-1-git-send-email-kernel@martin.sperl.org> <20150410185132.GU6023@sirena.org.uk> <F35B7C71-1917-40AE-BA42-CB3E63B877EF@martin.sperl.org> <20150415185824.GU6023@sirena.org.uk> <262B0C8C-7728-458E-8748-06F79251BE0C@martin.sperl.org> <20150418104202.GA26185@sirena.org.uk> <54169601-55F7-464C-8A0E-ABF833C0F3BA@martin.sperl.org> <20150418115343.GI26185@sirena.org.uk> <EB2DE44C-29CA-422D-A89C-4173E02A2CEF@martin.sperl.org> <20150418122748.GO26185@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150418122748.GO26185-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 18.04.2015, at 14:27, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> That's probably fine, though the 40ms is a bit on the long side.  The
> 30s timeout could use pulling in too, that's going to fail very badly if
> anything does go wronng.

Anything below 2 jiffies will give enough false positives during a kernel
recompile - the original code has had 2 jiffies as the effective minimum,
because the calculated delivery-time of max 30us is still orders of magnitudes
smaller than a single jiffy, but a reschedule can happen, which would be the
main reason why we have had triggered timeouts before.

SO IMO anything shorter than 2-3 jifies would need to use a new framework to
get access to high-resolution timers - and I do not know how to do that.

We can implement it as 3 jiffies or 30ms if that seems more acceptable.

Would look something like this:
diff --git a/drivers/spi/spi-bcm2835.c b/drivers/spi/spi-bcm2835.c
index 37875cf..1bbfccd 100644
--- a/drivers/spi/spi-bcm2835.c
+++ b/drivers/spi/spi-bcm2835.c
@@ -68,8 +68,7 @@
 #define BCM2835_SPI_CS_CS_10		0x00000002
 #define BCM2835_SPI_CS_CS_01		0x00000001
 
-#define BCM2835_SPI_POLLING_LIMIT_US	30
-#define BCM2835_SPI_TIMEOUT_MS		30000
+#define BCM2835_SPI_POLLING_LIMIT_MS	30
 #define BCM2835_SPI_MODE_BITS	(SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
 				| SPI_NO_CS | SPI_3WIRE)
 
@@ -164,8 +163,9 @@ static int bcm2835_spi_transfer_one_poll(struct spi_master *master,
 					 unsigned long xfer_time_us)
 {
 	struct bcm2835_spi *bs = spi_master_get_devdata(master);
-	/* set timeout to 1 second of maximum polling */
-	unsigned long timeout = jiffies + HZ;
+	/* set timeout and then fall back to interrupts */
+	unsigned long timeout = jiffies +
+		HZ * BCM2835_SPI_POLLING_LIMIT_MS / 1000;
 
 	/* enable HW block without interrupts */
 	bcm2835_wr(bs, BCM2835_SPI_CS, cs | BCM2835_SPI_CS_TA);
@@ -177,13 +177,12 @@ static int bcm2835_spi_transfer_one_poll(struct spi_master *master,
 		/* fill in tx fifo as much as possible */
 		bcm2835_wr_fifo(bs);
 		/* if we still expect some data after the read,
-		 * check for a possible timeout
+		 * check for a possible timeout and if we reach that
+		 * then fallback to interrupt mode...
 		 */
 		if (bs->rx_len && time_after(jiffies, timeout)) {
-			/* Transfer complete - reset SPI HW */
-			bcm2835_spi_reset_hw(master);
-			/* and return timeout */
-			return -ETIMEDOUT;
+			return bcm2835_spi_transfer_one_irq(master, spi,
+							    tfr,cs);
 		}
 	}
 

I will need to test it and then I will submit it as a patch against
the 1s timeout patch (so what is already in for-next).

Martin--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
