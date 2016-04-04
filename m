From: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Subject: 4.6-rc1 regression in SPI core -- deadlock
Date: Sun, 3 Apr 2016 21:20:13 -0400
Message-ID: <20160404012013.GA5735@brightrain.aerifal.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

I've spent several days trying to debug a deadlock using our local
(not yet ready for upstream) driver for the J-Core SPI device and it
seems to be a new deadlock in the SPI core caused by commit
556351f14e74 and unrelated to the particular driver. Commit
49023d2e4ead tried to solve a related deadlock problem, but there
still seems to be a lock order issue and it's affecting SPI use even
without the spi_flash_read optimization. The deadlock I'm observing
has a kworker thread stuck in wait_for_completion called from
spi_sync_locked (ultimately from mmc_rescan) and the completion is
never finishing because this kworker thread has the bus locked while
the spi master task has already started processing the queue but can't
proceed because the bus lock is taken.

Anyone else seen this? Ideas for a proper fix? I've got it working for
me by disabling the bus locking in __spi_pump_messages entirely (like
before commit 556351f14e74) but I'm pretty sure this breaks the new
feature that was added.

Rich
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
